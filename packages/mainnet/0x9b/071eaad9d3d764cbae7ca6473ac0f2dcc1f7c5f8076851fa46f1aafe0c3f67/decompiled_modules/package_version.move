module 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::package_version {
    struct PackageMarker has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun assert_current(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig) {
        0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::assert_package_active<PackageMarker>(arg0, 1);
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

