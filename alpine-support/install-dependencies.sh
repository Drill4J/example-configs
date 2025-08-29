#!/bin/sh

# Install gcompat (glibc compatibility layer for musl)
su-exec root apk add gcompat

# Install libc6-compat (glibc compatibility libs)
su-exec root apk add libc6-compat

# Install libgcc (GCC runtime support)
su-exec root apk add libgcc

# Symlink libc to libresolv (workaround for missing resolv lib)
su-exec root ln -s /lib/libc.so.6 /lib/libresolv.so.2

# Use muslstack to increase Java stack size to 8MB (requires Go-based muslstack utility)
su-exec root apk add go
su-exec root go install github.com/yaegashi/muslstack@latest
su-exec root /root/go/bin/muslstack -s 0x800000 /usr/bin/java
