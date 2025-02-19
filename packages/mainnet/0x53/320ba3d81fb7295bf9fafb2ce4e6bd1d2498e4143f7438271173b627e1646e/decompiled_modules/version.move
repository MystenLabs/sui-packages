module 0x53320ba3d81fb7295bf9fafb2ce4e6bd1d2498e4143f7438271173b627e1646e::version {
    public(friend) fun assert_interacting_with_most_up_to_date_package(arg0: u64) {
        assert!(arg0 == 1, 0);
    }

    public(friend) fun current_version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

