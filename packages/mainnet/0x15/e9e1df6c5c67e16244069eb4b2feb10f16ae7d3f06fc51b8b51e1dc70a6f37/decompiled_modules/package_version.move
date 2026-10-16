module 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version {
    struct PackageMarker has copy, drop, store {
        dummy_field: bool,
    }

    public fun assert_current(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig) {
        0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::assert_package_active<PackageMarker>(arg0, 1);
    }

    public fun assert_domain_enabled(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: u8) {
        0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::assert_domain_active<PackageMarker>(arg0, 1, arg1);
    }

    public(friend) fun assert_version(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig) {
        0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::assert_package_version<PackageMarker>(arg0, 1);
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

