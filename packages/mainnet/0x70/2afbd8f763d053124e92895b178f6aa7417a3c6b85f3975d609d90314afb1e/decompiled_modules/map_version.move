module 0x702afbd8f763d053124e92895b178f6aa7417a3c6b85f3975d609d90314afb1e::map_version {
    struct Version has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<Version>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Version, arg2: u64) {
        assert!(arg2 > arg1.version, 1003);
        arg1.version = arg2;
    }

    public fun validate_version(arg0: &Version) {
        assert!(1 == arg0.version, 1003);
    }

    // decompiled from Move bytecode v6
}

