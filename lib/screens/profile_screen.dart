import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/stat_card.dart';

// Notifier global untuk status login & data akun aktif
final ValueNotifier<bool> authNotifier = ValueNotifier<bool>(false);
final ValueNotifier<String> userNameNotifier = ValueNotifier<String>('Rina Siregar');
final ValueNotifier<String> userEmailNotifier = ValueNotifier<String>('rina.siregar@gmail.com');

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const _history = [
    ('Simulasi Rumah - Sep', '05 Sep 2026 | 4 perangkat', 'Rp 161.300'),
    ('Simulasi Kost - Agu', '18 Agu 2026 | 3 perangkat', 'Rp 89.400'),
    ('Simulasi Rumah - Agu', '02 Agu 2026 | 5 perangkat', 'Rp 172.900'),
  ];

  // Modal Sheet Form Login
  void _showLoginSheet(BuildContext context) {
    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          top: 24,
          left: 24,
          right: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Masuk Ke Akun', style: Theme.of(ctx).textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Masukkan email dan kata sandi Anda untuk melanjutkan.',
              style: TextStyle(color: Theme.of(ctx).colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Kata Sandi',
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton(
              onPressed: () {
                if (emailCtrl.text.isNotEmpty) {
                  userEmailNotifier.value = emailCtrl.text.trim();
                }
                authNotifier.value = true;
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Berhasil masuk ke akun!')),
                );
              },
              child: const Text('Masuk'),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                _showRegisterSheet(context);
              },
              child: const Text('Belum punya akun? Daftar sekarang'),
            ),
          ],
        ),
      ),
    );
  }

  // Modal Sheet Form Registrasi
  void _showRegisterSheet(BuildContext context) {
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          top: 24,
          left: 24,
          right: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Registrasi Akun Baru', style: Theme.of(ctx).textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Lengkapi data di bawah ini untuk membuat akun baru.',
              style: TextStyle(color: Theme.of(ctx).colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Kata Sandi',
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton(
              onPressed: () {
                if (nameCtrl.text.isNotEmpty) {
                  userNameNotifier.value = nameCtrl.text.trim();
                }
                if (emailCtrl.text.isNotEmpty) {
                  userEmailNotifier.value = emailCtrl.text.trim();
                }
                authNotifier.value = true;
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Akun berhasil didaftarkan!')),
                );
              },
              child: const Text('Daftar Sekarang'),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                _showLoginSheet(context);
              },
              child: const Text('Sudah punya akun? Masuk di sini'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return ValueListenableBuilder<bool>(
      valueListenable: authNotifier,
      builder: (context, isLoggedIn, _) {
        // ====================================================
        // 1. TAMPILAN JIKA BELUM LOGIN (OPSI LOGIN / REGISTRASI)
        // ====================================================
        if (!isLoggedIn) {
          return ResponsiveBody(
            maxWidth: 500,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      decoration: BoxDecoration(
                        color: scheme.primaryContainer.withAlpha(100),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.person_outline, size: 72, color: scheme.primary),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text('Belum Masuk Akun', style: text.headlineSmall),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Silakan masuk atau buat akun baru untuk menyimpan riwayat simulasi dan menikmati fitur lengkap.',
                      textAlign: TextAlign.center,
                      style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Tombol Buka Form Login
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () => _showLoginSheet(context),
                        icon: const Icon(Icons.login),
                        label: const Text('Masuk ke Akun'),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Tombol Buka Form Registrasi
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () => _showRegisterSheet(context),
                        icon: const Icon(Icons.person_add_outlined),
                        label: const Text('Daftar Akun Baru'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // ====================================================
        // 2. TAMPILAN PROFIL JIKA SUDAH LOGIN / TERDAPAT AKUN
        // ====================================================
        return ValueListenableBuilder<String>(
          valueListenable: userNameNotifier,
          builder: (context, currentName, _) {
            return ValueListenableBuilder<String>(
              valueListenable: userEmailNotifier,
              builder: (context, currentEmail, _) {
                final initial = currentName.isNotEmpty ? currentName[0].toUpperCase() : 'U';

                return ResponsiveBody(
                  maxWidth: 800,
                  child: ListView(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 140,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [scheme.primary, scheme.tertiary],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -44,
                            child: CircleAvatar(
                              radius: 48,
                              backgroundColor: scheme.surface,
                              child: CircleAvatar(
                                radius: 42,
                                child: Text(initial, style: text.headlineMedium),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 56),
                      Center(child: Text(currentName, style: text.titleLarge)),
                      Center(
                        child: Text(
                          currentEmail,
                          style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                        child: Row(
                          children: [
                            Expanded(
                              child: StatCard(icon: Icons.history, label: 'Simulasi', value: '3'),
                            ),
                            SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: StatCard(icon: Icons.savings_outlined, label: 'Hemat/bulan', value: 'Rp 30 rb'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            AppSpacing.md, AppSpacing.lg, AppSpacing.md, AppSpacing.sm),
                        child: Text('Riwayat Simulasi', style: text.titleLarge),
                      ),
                      SizedBox(
                        height: 140,
                        child: CarouselView(
                          itemExtent: 280,
                          shrinkExtent: 200,
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                          backgroundColor: scheme.primaryContainer,
                          children: [
                            for (final h in _history)
                              Padding(
                                padding: const EdgeInsets.all(AppSpacing.md),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(h.$1, style: text.titleMedium, maxLines: 1, overflow: TextOverflow.clip),
                                    Text(h.$2, style: text.bodyMedium, maxLines: 1, overflow: TextOverflow.clip),
                                    const SizedBox(height: AppSpacing.sm),
                                    Text(h.$3, style: text.titleLarge, maxLines: 1),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      const ListTile(leading: Icon(Icons.tune), title: Text('Pengaturan Tarif'), trailing: Icon(Icons.chevron_right)),
                      const ListTile(leading: Icon(Icons.notifications_outlined), title: Text('Notifikasi'), trailing: Icon(Icons.chevron_right)),
                      const ListTile(leading: Icon(Icons.help_outline), title: Text('Bantuan'), trailing: Icon(Icons.chevron_right)),
                      
                      // Tombol Logout / Keluar
                      ListTile(
                        leading: Icon(Icons.logout, color: scheme.error),
                        title: Text('Keluar Akun', style: TextStyle(color: scheme.error, fontWeight: FontWeight.bold)),
                        onTap: () {
                          authNotifier.value = false;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Berhasil keluar akun.')),
                          );
                        },
                      ),
                      const SizedBox(height: AppSpacing.lg),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}