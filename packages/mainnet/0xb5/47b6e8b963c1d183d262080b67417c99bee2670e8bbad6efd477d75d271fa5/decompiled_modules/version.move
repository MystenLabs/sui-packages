module 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::version {
    public(friend) fun assert_interacting_with_most_up_to_date_package(arg0: u64) {
        assert!(arg0 == 1, 0);
    }

    public(friend) fun current_version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

