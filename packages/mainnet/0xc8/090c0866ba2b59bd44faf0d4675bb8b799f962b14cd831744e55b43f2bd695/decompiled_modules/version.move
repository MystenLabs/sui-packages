module 0xc8090c0866ba2b59bd44faf0d4675bb8b799f962b14cd831744e55b43f2bd695::version {
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
        0x2::transfer::public_transfer<VerAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = Version{
            id      : 0x2::object::new(arg1),
            version : 1,
            admin   : 0x2::object::id<VerAdminCap>(&v0),
        };
        0x2::transfer::public_share_object<Version>(v1);
        0xc8090c0866ba2b59bd44faf0d4675bb8b799f962b14cd831744e55b43f2bd695::cap_vault::createVault<VerAdminCap>(arg1);
    }

    public fun migrate(arg0: &VerAdminCap, arg1: &mut Version, arg2: u64) {
        assert!(0x2::object::id<VerAdminCap>(arg0) == arg1.admin, 2002);
        assert!(arg2 > arg1.version, 2001);
        arg1.version = arg2;
    }

    // decompiled from Move bytecode v6
}

