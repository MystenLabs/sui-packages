module 0xc0268f9fdd722d235db09fc88b5a3b63a6d167d2a97e90b78e6ac4301e38661e::version {
    public(friend) fun assert_interacting_with_most_up_to_date_package(arg0: u64) {
        assert!(arg0 == 1, 0);
    }

    public(friend) fun current_version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

