module 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::version_control {
    public(friend) fun assert_object_version_is_compatible_with_package(arg0: &0x2::vec_set::VecSet<u64>) {
        let v0 = current_version();
        assert!(0x2::vec_set::contains<u64>(arg0, &v0), 0);
    }

    public fun current_version() : u64 {
        2
    }

    // decompiled from Move bytecode v6
}

