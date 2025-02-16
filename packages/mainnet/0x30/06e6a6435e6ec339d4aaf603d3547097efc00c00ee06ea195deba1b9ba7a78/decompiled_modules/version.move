module 0x3006e6a6435e6ec339d4aaf603d3547097efc00c00ee06ea195deba1b9ba7a78::version {
    public(friend) fun assert_interacting_with_most_up_to_date_package(arg0: u64) {
        assert!(arg0 == 1, 0);
    }

    public(friend) fun current_version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

