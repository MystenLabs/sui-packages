module 0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::version_control {
    public(friend) fun assert_object_version_is_compatible_with_package(arg0: 0x2::vec_set::VecSet<u64>) {
        let v0 = current_version();
        assert!(0x2::vec_set::contains<u64>(&arg0, &v0), 0);
    }

    public fun current_version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

