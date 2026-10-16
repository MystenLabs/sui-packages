module 0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::package_version {
    struct PackageMarker has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun current() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

