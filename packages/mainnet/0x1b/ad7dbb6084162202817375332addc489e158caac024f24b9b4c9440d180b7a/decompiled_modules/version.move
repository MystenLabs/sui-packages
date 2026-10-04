module 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version {
    struct Migrated has copy, drop {
        version_object: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
    }

    struct Version has key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun check_is_valid(arg0: &Version) {
        assert!(arg0.version == 2, 0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id      : 0x2::object::new(arg0),
            version : 2,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public fun migrate(arg0: &0x2::package::Publisher, arg1: &mut Version) {
        assert!(0x2::package::from_package<Version>(arg0), 1);
        assert!(arg1.version < 2, 2);
        arg1.version = 2;
        let v0 = Migrated{
            version_object : 0x2::object::id<Version>(arg1),
            from_version   : arg1.version,
            to_version     : 2,
        };
        0x2::event::emit<Migrated>(v0);
    }

    // decompiled from Move bytecode v7
}

