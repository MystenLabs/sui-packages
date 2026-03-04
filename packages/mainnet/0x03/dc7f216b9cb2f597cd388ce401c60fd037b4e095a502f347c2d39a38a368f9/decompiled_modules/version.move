module 0x3dc7f216b9cb2f597cd388ce401c60fd037b4e095a502f347c2d39a38a368f9::version {
    public fun next_version() : u64 {
        1 + 1
    }

    public fun pre_check_version(arg0: u64, arg1: u64) {
        assert!(arg0 == 1, arg1);
    }

    public fun this_version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

