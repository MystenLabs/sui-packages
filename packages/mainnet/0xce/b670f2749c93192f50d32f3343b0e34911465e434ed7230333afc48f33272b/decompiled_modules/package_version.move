module 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::package_version {
    struct PackageMarker has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun current() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

