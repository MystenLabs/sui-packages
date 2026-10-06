module 0x6bbe370f806dfb858423810bd663294e14d44755c1a4297c627d9a6ba7e07d5::version {
    public fun assert_is_current(arg0: u64) {
        assert!(arg0 == 1, 1);
    }

    public fun current() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

