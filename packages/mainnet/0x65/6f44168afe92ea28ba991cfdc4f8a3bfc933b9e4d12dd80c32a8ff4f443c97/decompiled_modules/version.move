module 0x656f44168afe92ea28ba991cfdc4f8a3bfc933b9e4d12dd80c32a8ff4f443c97::version {
    public(friend) fun check_version(arg0: u64) {
        assert!(0 != current_version(), 0);
        assert!(arg0 == current_version(), 0);
    }

    public(friend) fun current_version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

