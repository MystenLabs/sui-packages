module 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_version_control {
    public(friend) fun assert_object_version_is_compatible_with_package(arg0: 0x2::vec_set::VecSet<u64>) {
        let v0 = current_version();
        assert!(0x2::vec_set::contains<u64>(&arg0, &v0), 0);
    }

    public fun current_version() : u64 {
        3
    }

    // decompiled from Move bytecode v7
}

