module 0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::version_control {
    public(friend) fun assert_object_version_is_compatible_with_package(arg0: 0x2::vec_set::VecSet<u64>) {
        let v0 = current_version();
        assert!(0x2::vec_set::contains<u64>(&arg0, &v0), 0);
    }

    public fun current_version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

