module 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::version {
    struct VERSION has drop {
        dummy_field: bool,
    }

    struct Version has store, key {
        id: 0x2::object::UID,
        major_version: u64,
        minor_version: u64,
    }

    struct VersionCap has store, key {
        id: 0x2::object::UID,
    }

    public fun assert_supported_version(arg0: &Version) {
        assert!(is_supported_version(arg0), 1);
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : (Version, VersionCap) {
        let v0 = Version{
            id            : 0x2::object::new(arg0),
            major_version : 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::current_version::current_major_version(),
            minor_version : 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::current_version::current_minor_version(),
        };
        let v1 = VersionCap{id: 0x2::object::new(arg0)};
        (v0, v1)
    }

    public fun is_supported_version(arg0: &Version) : bool {
        let v0 = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::current_version::current_major_version();
        arg0.major_version == v0 && arg0.minor_version <= 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::current_version::current_minor_version() || arg0.major_version > v0 && false || true
    }

    public fun set_version(arg0: &mut Version, arg1: &VersionCap, arg2: u64, arg3: u64) {
        arg0.major_version = arg2;
        arg0.minor_version = arg3;
    }

    public fun value_major(arg0: &Version) : u64 {
        arg0.major_version
    }

    public fun value_minor(arg0: &Version) : u64 {
        arg0.minor_version
    }

    // decompiled from Move bytecode v6
}

