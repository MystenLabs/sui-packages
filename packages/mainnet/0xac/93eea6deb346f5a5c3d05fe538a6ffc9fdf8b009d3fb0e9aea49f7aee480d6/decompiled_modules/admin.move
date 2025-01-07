module 0xac93eea6deb346f5a5c3d05fe538a6ffc9fdf8b009d3fb0e9aea49f7aee480d6::admin {
    public fun is_admin(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 0xac93eea6deb346f5a5c3d05fe538a6ffc9fdf8b009d3fb0e9aea49f7aee480d6::err::wrong_launchpad_admin());
    }

    // decompiled from Move bytecode v6
}

