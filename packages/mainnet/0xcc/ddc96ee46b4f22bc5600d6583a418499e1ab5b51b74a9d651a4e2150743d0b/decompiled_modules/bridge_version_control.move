module 0xccddc96ee46b4f22bc5600d6583a418499e1ab5b51b74a9d651a4e2150743d0b::bridge_version_control {
    public(friend) fun assert_object_version_is_compatible_with_package(arg0: 0x2::vec_set::VecSet<u64>) {
        let v0 = current_version();
        assert!(0x2::vec_set::contains<u64>(&arg0, &v0), 0);
    }

    public fun current_version() : u64 {
        3
    }

    // decompiled from Move bytecode v7
}

