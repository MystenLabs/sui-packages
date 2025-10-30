module 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::version {
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
        assert!(is_supported_version(arg0), 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::error::e_invalid_version());
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : (Version, VersionCap) {
        let v0 = Version{
            id            : 0x2::object::new(arg0),
            major_version : 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::current_version::current_major_version(),
            minor_version : 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::current_version::current_minor_version(),
        };
        let v1 = VersionCap{id: 0x2::object::new(arg0)};
        (v0, v1)
    }

    public fun is_supported_version(arg0: &Version) : bool {
        let v0 = 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::current_version::current_major_version();
        arg0.major_version == v0 && arg0.minor_version <= 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::current_version::current_minor_version() || arg0.major_version < v0
    }

    public(friend) fun set_version(arg0: &mut Version, arg1: u64, arg2: u64) {
        assert!(arg1 >= arg0.major_version, 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::error::e_invalid_major_version());
        if (arg1 == arg0.major_version) {
            assert!(arg2 > arg0.minor_version, 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::error::e_invalid_minor_version());
        };
        arg0.major_version = arg1;
        arg0.minor_version = arg2;
    }

    public fun value_major(arg0: &Version) : u64 {
        arg0.major_version
    }

    public fun value_minor(arg0: &Version) : u64 {
        arg0.minor_version
    }

    // decompiled from Move bytecode v6
}

