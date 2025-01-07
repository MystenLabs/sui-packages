module 0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::version {
    struct VERSION has drop {
        dummy_field: bool,
    }

    struct VAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Version has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: 0x2::object::ID,
    }

    struct VTransporterVault has store, key {
        id: 0x2::object::UID,
        admin_cap: 0x1::option::Option<VAdminCap>,
        new_owner: 0x1::option::Option<address>,
        og_owner: 0x1::option::Option<address>,
    }

    public fun checkVersion(arg0: &Version, arg1: u64) {
        assert!(arg1 == arg0.version, 1001);
    }

    public fun claim_admin(arg0: &mut VTransporterVault, arg1: &0x2::tx_context::TxContext) : VAdminCap {
        assert!(0x1::option::is_some<address>(&arg0.new_owner) && *0x1::option::borrow<address>(&arg0.new_owner) == 0x2::tx_context::sender(arg1), 1002);
        0x1::option::extract<address>(&mut arg0.og_owner);
        0x1::option::extract<address>(&mut arg0.new_owner);
        0x1::option::extract<VAdminCap>(&mut arg0.admin_cap)
    }

    fun init(arg0: VERSION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<VAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = Version{
            id      : 0x2::object::new(arg1),
            version : 1,
            admin   : 0x2::object::id<VAdminCap>(&v0),
        };
        0x2::transfer::share_object<Version>(v1);
    }

    public entry fun migrate(arg0: &VAdminCap, arg1: &mut Version, arg2: u64) {
        assert!(0x2::object::id<VAdminCap>(arg0) == arg1.admin, 1002);
        assert!(arg2 > arg1.version, 1001);
        arg1.version = arg2;
    }

    public fun revoke_admin(arg0: &mut VTransporterVault, arg1: &0x2::tx_context::TxContext) : VAdminCap {
        assert!(0x1::option::is_some<address>(&arg0.og_owner) && *0x1::option::borrow<address>(&arg0.og_owner) == 0x2::tx_context::sender(arg1), 1002);
        0x1::option::extract<address>(&mut arg0.og_owner);
        0x1::option::extract<address>(&mut arg0.new_owner);
        0x1::option::extract<VAdminCap>(&mut arg0.admin_cap)
    }

    public fun transfer_admin(arg0: VAdminCap, arg1: address, arg2: &mut VTransporterVault, arg3: &0x2::tx_context::TxContext) {
        0x1::option::fill<VAdminCap>(&mut arg2.admin_cap, arg0);
        0x1::option::fill<address>(&mut arg2.new_owner, arg1);
        0x1::option::fill<address>(&mut arg2.og_owner, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

