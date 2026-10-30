module 0x4e4f6a5ee9504840a1bd5a9db589782fa44d6d1ce6f4fe45e93c6b664e161ca3::package_version {
    struct PackageMarker has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun assert_current(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig) {
        0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::assert_package_active<PackageMarker>(arg0, 1);
    }

    public(friend) fun assert_version(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig) {
        0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::assert_package_version<PackageMarker>(arg0, 1);
    }

    public fun current(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig) : u64 {
        assert_current(arg0);
        1
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

