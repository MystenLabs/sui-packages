module 0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::version {
    public(friend) fun check_version(arg0: u64) {
        assert!(0 != current_version(), 0);
        assert!(arg0 == current_version(), 0);
    }

    public(friend) fun current_version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

