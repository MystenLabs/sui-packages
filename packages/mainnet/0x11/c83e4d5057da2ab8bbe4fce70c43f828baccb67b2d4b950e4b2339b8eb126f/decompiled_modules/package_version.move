module 0x11c83e4d5057da2ab8bbe4fce70c43f828baccb67b2d4b950e4b2339b8eb126f::package_version {
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

