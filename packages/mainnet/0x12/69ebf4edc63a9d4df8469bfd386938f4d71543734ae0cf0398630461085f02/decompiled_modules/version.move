module 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::version {
    struct Version has drop, store {
        value: u64,
    }

    struct VersionCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new() : Version {
        Version{value: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::current_version::current_version()}
    }

    public fun assert_current_version(arg0: &Version) {
        assert!(is_current_version(arg0), 1950);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VersionCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<VersionCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_current_version(arg0: &Version) : bool {
        arg0.value == 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::current_version::current_version()
    }

    public fun migrate_to_current_version(arg0: &mut Version, arg1: &VersionCap) {
        arg0.value = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::current_version::current_version();
    }

    public fun value(arg0: &Version) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

