module 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::version {
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

    struct SetVersionEvent has copy, drop, store {
        sender: address,
        major_version_old: u64,
        major_version_new: u64,
        minor_version_old: u64,
        minor_version_new: u64,
    }

    public fun assert_supported_version(arg0: &Version) {
        assert!(is_supported_version(arg0), 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::error::e_invalid_version());
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : (Version, VersionCap) {
        let v0 = Version{
            id            : 0x2::object::new(arg0),
            major_version : 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::current_version::current_major_version(),
            minor_version : 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::current_version::current_minor_version(),
        };
        let v1 = VersionCap{id: 0x2::object::new(arg0)};
        (v0, v1)
    }

    public fun is_supported_version(arg0: &Version) : bool {
        let v0 = 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::current_version::current_major_version();
        arg0.major_version == v0 && arg0.minor_version <= 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::current_version::current_minor_version() || arg0.major_version > v0 && false || true
    }

    public fun set_version(arg0: &mut Version, arg1: &VersionCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= arg0.major_version, 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::error::e_invalid_major_version());
        if (arg2 == arg0.major_version) {
            assert!(arg3 > arg0.minor_version, 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::error::e_invalid_minor_version());
        };
        arg0.major_version = arg2;
        arg0.minor_version = arg3;
        let v0 = SetVersionEvent{
            sender            : 0x2::tx_context::sender(arg4),
            major_version_old : arg0.major_version,
            major_version_new : arg2,
            minor_version_old : arg0.minor_version,
            minor_version_new : arg3,
        };
        0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::event::emit<SetVersionEvent>(v0);
    }

    public fun value_major(arg0: &Version) : u64 {
        arg0.major_version
    }

    public fun value_minor(arg0: &Version) : u64 {
        arg0.minor_version
    }

    // decompiled from Move bytecode v6
}

