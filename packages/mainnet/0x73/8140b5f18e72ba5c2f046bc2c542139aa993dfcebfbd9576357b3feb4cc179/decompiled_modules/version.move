module 0xfac379d68d055e1e0f7019f3f4e3f2cf5a155a2943a54cbfc40ec03090d46a5::version {
    public fun check_version(arg0: u64) {
        assert!(1 == arg0, 1001);
    }

    public fun get_version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

