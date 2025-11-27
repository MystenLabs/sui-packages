module 0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::version_control {
    public(friend) fun assert_object_version_is_compatible_with_package(arg0: 0x2::vec_set::VecSet<u64>) {
        let v0 = current_version();
        assert!(0x2::vec_set::contains<u64>(&arg0, &v0), 0);
    }

    public fun current_version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

