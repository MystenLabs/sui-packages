module 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::bridge_version_control {
    public(friend) fun assert_object_version_is_compatible_with_package(arg0: 0x2::vec_set::VecSet<u64>) {
        let v0 = current_version();
        assert!(0x2::vec_set::contains<u64>(&arg0, &v0), 0);
    }

    public fun current_version() : u64 {
        3
    }

    // decompiled from Move bytecode v7
}

