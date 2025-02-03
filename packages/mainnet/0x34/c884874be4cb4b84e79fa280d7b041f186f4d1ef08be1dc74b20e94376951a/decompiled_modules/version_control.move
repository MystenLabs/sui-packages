module 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::version_control {
    public(friend) fun assert_object_version_is_compatible_with_package(arg0: &0x2::vec_set::VecSet<u64>) {
        let v0 = current_version();
        assert!(0x2::vec_set::contains<u64>(arg0, &v0), 0);
    }

    public fun current_version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

