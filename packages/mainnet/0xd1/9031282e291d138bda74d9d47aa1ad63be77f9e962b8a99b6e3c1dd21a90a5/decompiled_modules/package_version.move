module 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version {
    struct PackageMarker has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun assert_current(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig) {
        0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::assert_package_active<PackageMarker>(arg0, 3);
    }

    public(friend) fun assert_target_active(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: u64) {
        0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::assert_target_active<PackageMarker>(arg0, 3, arg1, arg2, arg3);
    }

    public fun current(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig) : u64 {
        assert_current(arg0);
        3
    }

    public fun version() : u64 {
        3
    }

    // decompiled from Move bytecode v7
}

