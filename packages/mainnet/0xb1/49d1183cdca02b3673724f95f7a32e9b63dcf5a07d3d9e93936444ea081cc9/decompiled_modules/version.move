module 0xb149d1183cdca02b3673724f95f7a32e9b63dcf5a07d3d9e93936444ea081cc9::version {
    public(friend) fun check_version(arg0: u64) {
        assert!(0 != current_version(), 0);
        assert!(arg0 == current_version(), 0);
    }

    public(friend) fun current_version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

