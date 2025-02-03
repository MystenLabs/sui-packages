module 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::version_control {
    public(friend) fun assert_object_version_is_compatible_with_package(arg0: &0x2::vec_set::VecSet<u64>) {
        let v0 = current_version();
        assert!(0x2::vec_set::contains<u64>(arg0, &v0), 0);
    }

    public fun current_version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

