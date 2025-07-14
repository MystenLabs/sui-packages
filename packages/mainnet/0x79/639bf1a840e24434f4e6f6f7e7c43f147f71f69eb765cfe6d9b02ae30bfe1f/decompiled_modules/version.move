module 0x79639bf1a840e24434f4e6f6f7e7c43f147f71f69eb765cfe6d9b02ae30bfe1f::version {
    public(friend) fun check_version(arg0: u64) {
        assert!(0 != current_version(), 0);
        assert!(arg0 == current_version(), 0);
    }

    public(friend) fun current_version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

