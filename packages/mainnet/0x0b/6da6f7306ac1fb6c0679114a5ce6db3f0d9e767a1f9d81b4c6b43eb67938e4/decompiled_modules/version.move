module 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version {
    struct VERSION has drop {
        dummy_field: bool,
    }

    struct VerAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Version has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: 0x2::object::ID,
    }

    public fun checkVersion(arg0: &Version, arg1: u64) {
        assert!(arg1 == arg0.version, 2001);
    }

    fun init(arg0: VERSION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VerAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<VerAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = Version{
            id      : 0x2::object::new(arg1),
            version : 1,
            admin   : 0x2::object::id<VerAdminCap>(&v0),
        };
        0x2::transfer::share_object<Version>(v1);
    }

    public entry fun migrate(arg0: &VerAdminCap, arg1: &mut Version, arg2: u64) {
        assert!(0x2::object::id<VerAdminCap>(arg0) == arg1.admin, 2002);
        assert!(arg2 > arg1.version, 2001);
        arg1.version = arg2;
    }

    // decompiled from Move bytecode v6
}

