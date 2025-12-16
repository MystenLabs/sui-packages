module 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct VersionCap has store, key {
        id: 0x2::object::UID,
    }

    public fun assert_current_version(arg0: &Version) {
        assert!(is_current_version(arg0), 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::error::version_mismatch_error());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id    : 0x2::object::new(arg0),
            value : 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::current_version::current_version(),
        };
        let v1 = VersionCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Version>(v0);
        0x2::transfer::transfer<VersionCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_current_version(arg0: &Version) : bool {
        arg0.value == 0xd8c7ad9b5ff01e83ba14d9087f67d3a03f49d815844777fbf51ac1e004d1458d::current_version::current_version()
    }

    public fun upgrade(arg0: &mut Version, arg1: &VersionCap) {
        arg0.value = arg0.value + 1;
    }

    public fun value(arg0: &Version) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

