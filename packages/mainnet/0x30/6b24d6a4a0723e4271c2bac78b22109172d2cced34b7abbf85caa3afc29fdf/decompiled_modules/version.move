module 0x306b24d6a4a0723e4271c2bac78b22109172d2cced34b7abbf85caa3afc29fdf::version {
    public fun next_version() : u64 {
        1 + 1
    }

    public fun pre_check_version(arg0: u64, arg1: u64) {
        assert!(arg0 == 1, arg1);
    }

    public fun this_version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

