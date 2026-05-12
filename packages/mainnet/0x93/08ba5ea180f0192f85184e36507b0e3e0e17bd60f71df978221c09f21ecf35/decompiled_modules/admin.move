module 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct KeeperCap has store, key {
        id: 0x2::object::UID,
    }

    struct AuditFirmCap has store, key {
        id: 0x2::object::UID,
        firm_name: vector<u8>,
        firm_index: u8,
    }

    struct KeeperRegistry has key {
        id: 0x2::object::UID,
        active_cap_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct KeeperCapMintedEvent has copy, drop {
        cap_id: 0x2::object::ID,
        holder: address,
    }

    struct KeeperCapRevokedEvent has copy, drop {
        cap_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct AdminCapInitEvent has copy, drop {
        cap_id: 0x2::object::ID,
        deployer: address,
    }

    public fun active_cap_id(arg0: &KeeperRegistry) : 0x1::option::Option<0x2::object::ID> {
        arg0.active_cap_id
    }

    public fun assert_active(arg0: &KeeperRegistry, arg1: &KeeperCap) {
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.active_cap_id, &v0), 1);
    }

    public fun burn_keeper_cap(arg0: KeeperCap) {
        let KeeperCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun create_keeper_registry(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = KeeperRegistry{
            id            : 0x2::object::new(arg1),
            active_cap_id : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<KeeperRegistry>(v0);
    }

    public fun firm_index(arg0: &AuditFirmCap) : u8 {
        arg0.firm_index
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = 0x2::tx_context::sender(arg0);
        let v2 = AdminCapInitEvent{
            cap_id   : 0x2::object::uid_to_inner(&v0.id),
            deployer : v1,
        };
        0x2::event::emit<AdminCapInitEvent>(v2);
        0x2::transfer::public_transfer<AdminCap>(v0, v1);
    }

    public fun mint_audit_firm_caps(arg0: &AdminCap, arg1: address, arg2: address, arg3: address, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = AuditFirmCap{
            id         : 0x2::object::new(arg5),
            firm_name  : b"MoveBit",
            firm_index : 0,
        };
        0x2::transfer::public_transfer<AuditFirmCap>(v0, arg1);
        let v1 = AuditFirmCap{
            id         : 0x2::object::new(arg5),
            firm_name  : b"OtterSec",
            firm_index : 1,
        };
        0x2::transfer::public_transfer<AuditFirmCap>(v1, arg2);
        let v2 = AuditFirmCap{
            id         : 0x2::object::new(arg5),
            firm_name  : b"Zellic",
            firm_index : 2,
        };
        0x2::transfer::public_transfer<AuditFirmCap>(v2, arg3);
        let v3 = AuditFirmCap{
            id         : 0x2::object::new(arg5),
            firm_name  : b"AsymmetricResearch",
            firm_index : 3,
        };
        0x2::transfer::public_transfer<AuditFirmCap>(v3, arg4);
    }

    public fun mint_keeper_cap(arg0: &AdminCap, arg1: &mut KeeperRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg1.active_cap_id), 2);
        let v0 = KeeperCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::uid_to_inner(&v0.id);
        arg1.active_cap_id = 0x1::option::some<0x2::object::ID>(v1);
        let v2 = KeeperCapMintedEvent{
            cap_id : v1,
            holder : arg2,
        };
        0x2::event::emit<KeeperCapMintedEvent>(v2);
        0x2::transfer::public_transfer<KeeperCap>(v0, arg2);
    }

    public fun mint_keeper_cap_replacing(arg0: &AdminCap, arg1: &mut KeeperRegistry, arg2: KeeperCap, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let KeeperCap { id: v0 } = arg2;
        0x2::object::delete(v0);
        let v1 = KeeperCap{id: 0x2::object::new(arg4)};
        let v2 = 0x2::object::uid_to_inner(&v1.id);
        arg1.active_cap_id = 0x1::option::some<0x2::object::ID>(v2);
        let v3 = KeeperCapMintedEvent{
            cap_id : v2,
            holder : arg3,
        };
        0x2::event::emit<KeeperCapMintedEvent>(v3);
        0x2::transfer::public_transfer<KeeperCap>(v1, arg3);
    }

    public fun revoke_keeper_cap(arg0: &AdminCap, arg1: &mut KeeperRegistry) {
        arg1.active_cap_id = 0x1::option::none<0x2::object::ID>();
        let v0 = KeeperCapRevokedEvent{cap_id: arg1.active_cap_id};
        0x2::event::emit<KeeperCapRevokedEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

