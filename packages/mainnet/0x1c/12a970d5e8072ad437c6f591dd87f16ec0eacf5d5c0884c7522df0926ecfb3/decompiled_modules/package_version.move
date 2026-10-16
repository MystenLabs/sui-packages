module 0x1c12a970d5e8072ad437c6f591dd87f16ec0eacf5d5c0884c7522df0926ecfb3::package_version {
    struct PackageMarker has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun assert_current(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig) {
        0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::assert_domain_active<PackageMarker>(arg0, 1, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::admin_domain());
    }

    public fun current(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig) : u64 {
        assert_current(arg0);
        1
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

