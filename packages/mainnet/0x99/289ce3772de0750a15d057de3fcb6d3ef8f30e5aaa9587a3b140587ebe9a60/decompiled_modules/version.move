module 0x5441ed00fa7b209ad951d31c6e3d4d48ad8666e6d2a5155e4f5e99dd74177288::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct VersionCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun assert_current_version(arg0: &Version) {
        assert!(is_current_version(arg0), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::version_mismatch_error());
    }

    public fun block(arg0: &mut Version, arg1: &VersionCap) {
        arg0.value = 0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id    : 0x2::object::new(arg0),
            value : 0x5441ed00fa7b209ad951d31c6e3d4d48ad8666e6d2a5155e4f5e99dd74177288::current_version::current_version(),
        };
        let v1 = VersionCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Version>(v0);
        0x2::transfer::transfer<VersionCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun is_current_version(arg0: &Version) : bool {
        arg0.value == 0x5441ed00fa7b209ad951d31c6e3d4d48ad8666e6d2a5155e4f5e99dd74177288::current_version::current_version()
    }

    public fun update(arg0: &mut Version, arg1: &VersionCap) {
        assert!(arg0.value < 0x5441ed00fa7b209ad951d31c6e3d4d48ad8666e6d2a5155e4f5e99dd74177288::current_version::current_version(), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::version_mismatch_error());
        arg0.value = 0x5441ed00fa7b209ad951d31c6e3d4d48ad8666e6d2a5155e4f5e99dd74177288::current_version::current_version();
    }

    public fun value(arg0: &Version) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

