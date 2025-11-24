module 0x91c628c8668d03dcd8cd7ac00bef8bd97ab87e10898877a137b1923bac4704c8::version_control {
    struct VAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Version has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: 0x2::object::ID,
    }

    public fun check(arg0: &Version, arg1: u64) {
        assert!(arg0.version == arg1, 2);
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : VAdminCap {
        VAdminCap{id: 0x2::object::new(arg0)}
    }

    public(friend) fun init_version(arg0: &VAdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id      : 0x2::object::new(arg2),
            version : arg1,
            admin   : 0x2::object::id<VAdminCap>(arg0),
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public fun migrate(arg0: &mut Version, arg1: &VAdminCap, arg2: u64) {
        assert!(arg0.admin == 0x2::object::id<VAdminCap>(arg1), 0);
        assert!(arg0.version < arg2, 1);
        arg0.version = arg2;
    }

    // decompiled from Move bytecode v6
}

