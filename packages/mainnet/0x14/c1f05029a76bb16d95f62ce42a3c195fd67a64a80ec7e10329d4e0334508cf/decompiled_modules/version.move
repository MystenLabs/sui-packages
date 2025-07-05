module 0x14c1f05029a76bb16d95f62ce42a3c195fd67a64a80ec7e10329d4e0334508cf::version {
    public(friend) fun check_version(arg0: u64) {
        assert!(0 != current_version(), 0);
        assert!(arg0 == current_version(), 0);
    }

    public(friend) fun current_version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

