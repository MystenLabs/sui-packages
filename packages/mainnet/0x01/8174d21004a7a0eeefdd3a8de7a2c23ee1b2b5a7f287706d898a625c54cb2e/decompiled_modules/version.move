module 0x18174d21004a7a0eeefdd3a8de7a2c23ee1b2b5a7f287706d898a625c54cb2e::version {
    public(friend) fun check_version(arg0: u64) {
        assert!(0 != current_version(), 0);
        assert!(arg0 == current_version(), 0);
    }

    public(friend) fun current_version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

