module 0xbcbd0933e68a1af594d5f5338eaa43ca3653450d4acaf89843436c04e3f841db::package_version {
    struct PackageMarker has copy, drop, store {
        dummy_field: bool,
    }

    public fun version() : u64 {
        1
    }

    public(friend) fun assert_core_version(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig) {
        0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::assert_package_version<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::PackageMarker>(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::version());
    }

    public(friend) fun assert_current(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig) {
        0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::assert_package_active<PackageMarker>(arg0, 1);
    }

    public(friend) fun assert_current_version(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig) {
        0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::assert_package_version<PackageMarker>(arg0, 1);
    }

    public(friend) fun assert_market_state_active(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: 0x2::object::ID) {
        assert_current(arg0);
        0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::assert_target_active<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::PackageMarker>(arg0, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::version(), b"market", arg1, 3305);
    }

    public fun current(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig) : u64 {
        assert_current(arg0);
        1
    }

    // decompiled from Move bytecode v7
}

