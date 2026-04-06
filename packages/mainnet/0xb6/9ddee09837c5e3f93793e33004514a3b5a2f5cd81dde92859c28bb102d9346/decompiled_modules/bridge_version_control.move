module 0xb69ddee09837c5e3f93793e33004514a3b5a2f5cd81dde92859c28bb102d9346::bridge_version_control {
    public(friend) fun assert_object_version_is_compatible_with_package(arg0: 0x2::vec_set::VecSet<u64>) {
        let v0 = current_version();
        assert!(0x2::vec_set::contains<u64>(&arg0, &v0), 0);
    }

    public fun current_version() : u64 {
        3
    }

    // decompiled from Move bytecode v7
}

