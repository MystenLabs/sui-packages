module 0xe9b4fddba6267dfb00ba6833aef51fd7b4e6b1fb7c39c54ea5966255427d7cdd::version {
    struct VERSION has drop {
        dummy_field: bool,
    }

    struct VersionAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Version has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: 0x2::object::ID,
    }

    public fun checkVersion(arg0: &Version, arg1: u64) {
        assert!(arg1 == arg0.version, 1001);
    }

    fun init(arg0: VERSION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VersionAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<VersionAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = Version{
            id      : 0x2::object::new(arg1),
            version : 1,
            admin   : 0x2::object::id<VersionAdminCap>(&v0),
        };
        0x2::transfer::share_object<Version>(v1);
    }

    public entry fun migrate(arg0: &VersionAdminCap, arg1: &mut Version, arg2: u64) {
        assert!(0x2::object::id<VersionAdminCap>(arg0) == arg1.admin, 1002);
        assert!(arg2 > arg1.version, 1001);
        arg1.version = arg2;
    }

    // decompiled from Move bytecode v6
}

