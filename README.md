## Deskripsi

Repository untuk belajar nginx dalam bahasa Indonesia dengan contoh (_maaf kalau bahasanya berantakan_). Disini akan menjadi playground nginx yang dapat dijalankan di local mesin kalian dengan sedikit sentuhan docker.

Kenapa docker ? dengan docker, kamu tidak perlu melakukan instalasi binary langsung ke mesin. Sehingga dapat dipastikan ini akan berjalan ke semua platform (macOS, Linux, Windows). Namun karena untuk mempermudah commands, repository ini akan dibungkus dengan `Makefile`. Sehingga mungkin tidak akan berjalan dengan lancar di Windows. Untuk pengguna windows mohon menggunakan command `docker compose` secara langsung.

## Sebelum Mulai

Sebelum mulai pastikan kamu sudah memiliki pengetahuan dasar tentang system operasi, Makefile dan docker. Silahkan belajar di [belajar-os](https://github.com/devetek/belajar-os), [belajar-makefile](https://github.com/devetek/belajar-makefile) dan [belajar-docker](https://github.com/devetek/belajar-docker).

Selanjutnya pastinya domain `devel.terpusat.com` sudah tertulis di `/etc/hosts` ke localhost untuk menikmati fitur SSL di local development.

Binary Details:

- Nginx: 1.21.1

## Bantuan

Untuk mempermudah proses development, di dalam repository ini terdapat beberapa command bantuan yang dapat dijalankan dengan `Makefile`:

```sh
 ____       _        _                 _   _       _
| __ )  ___| | __ _ (_) __ _ _ __     | \ | | __ _(_)_ __ __  __
|  _ \ / _ \ |/ _` || |/ _` | '__|____|  \| |/ _` | | '_ \ \/ /
| |_) |  __/ | (_| || | (_| | | |_____| |\  | (_| | | | | |>  <
|____/ \___|_|\__,_|/ |\__,_|_|       |_| \_|\__, |_|_| |_/_/\_\
                  |__/                       |___/

Copyright (c) 2023 Devetek Tech. https://devetek.com.
Repo: https://github.com/devetek/belajar-nginx

Use: make <target>

GENERIC
  help                                                Show available commands

DEVELOPMENT
  gencert                                             Generate SSL certificate manually
  run                                                 Run nginx playground
  ls                                                  Show containers
  log                                                 Show containers log
  enter                                               Enter nginx container
  restart                                             Restart nginx container
  down                                                Shutdown playground
```

## Daftar Isi

- Kenapa Nginx
- Cara Memulai

### Kenapa Nginx

### Cara Memulai

Untuk memulai menjalankan repository ini cukup dengan menjalankan perintah `make run`. Perintah tersebut akan melakukan beberapa hal:

- Menjalankan docker compose dari file `docker-compose.yml`
- Menjalankan sebuah container, berisi nginx dengan local SSL certificate supported by `mkcert`

Selanjutnya kamu dapat mulai melakukan modifikasi file nginx (upstream, location, variables, etc) yang ada di repository di dalam folder `nginx`. Untuk bagian ini, kita akan belajar di bagian selanjutnya details tentang nginx.
