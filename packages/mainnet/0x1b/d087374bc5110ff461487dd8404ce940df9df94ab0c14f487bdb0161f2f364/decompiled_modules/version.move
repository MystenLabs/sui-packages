module 0xf419fd18fdef72a8ce7514a576f0904537fbfd149cb9e9f7b5247382b78d9f0::version {
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
        assert!(arg1 >= arg0.version, 2001);
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
        0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::cap_vault::createVault<VerAdminCap>(arg1);
    }

    public fun migrate(arg0: &VerAdminCap, arg1: &mut Version, arg2: u64) {
        assert!(0x2::object::id<VerAdminCap>(arg0) == arg1.admin, 2002);
        assert!(arg2 > arg1.version, 2001);
        arg1.version = arg2;
    }

    // decompiled from Move bytecode v6
}

