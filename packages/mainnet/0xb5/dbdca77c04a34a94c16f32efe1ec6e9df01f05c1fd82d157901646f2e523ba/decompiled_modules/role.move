module 0xb5dbdca77c04a34a94c16f32efe1ec6e9df01f05c1fd82d157901646f2e523ba::role {
    struct RoleConfig has key {
        id: 0x2::object::UID,
        version: u16,
        operator: address,
        admin: address,
        pending_admin: address,
    }

    struct ROLE has drop {
        dummy_field: bool,
    }

    struct SetOperatorEvent has copy, drop {
        prev: address,
        new: address,
    }

    struct AdminTransferEvent has copy, drop {
        prev: address,
        new: address,
    }

    public fun accept_admin(arg0: &mut RoleConfig, arg1: &0x2::tx_context::TxContext) {
        only_pending_admin(arg0, arg1);
        arg0.admin = arg0.pending_admin;
        arg0.pending_admin = @0x0;
        let v0 = AdminTransferEvent{
            prev : arg0.admin,
            new  : arg0.pending_admin,
        };
        0x2::event::emit<AdminTransferEvent>(v0);
    }

    fun assert_non_zero(arg0: address) {
        assert!(arg0 != @0x0, 4);
    }

    fun assert_version(arg0: &RoleConfig) {
        assert!(arg0.version == 0, 6);
    }

    public fun get_admin(arg0: &RoleConfig) : address {
        arg0.admin
    }

    public fun get_operator(arg0: &RoleConfig) : address {
        arg0.operator
    }

    public fun get_pending_admin(arg0: &RoleConfig) : address {
        arg0.pending_admin
    }

    public fun get_version(arg0: &RoleConfig) : u16 {
        arg0.version
    }

    fun init(arg0: ROLE, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<ROLE>(&arg0), 5);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = RoleConfig{
            id            : 0x2::object::new(arg1),
            version       : 0,
            operator      : v0,
            admin         : v0,
            pending_admin : @0x0,
        };
        0x2::transfer::share_object<RoleConfig>(v1);
    }

    public fun only_admin(arg0: &RoleConfig, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 2);
    }

    public fun only_operator(arg0: &RoleConfig, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg1) == arg0.operator, 1);
    }

    public fun only_pending_admin(arg0: &RoleConfig, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg1) == arg0.pending_admin, 3);
    }

    public fun set_operator(arg0: &mut RoleConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        assert_non_zero(arg1);
        arg0.operator = arg1;
        let v0 = SetOperatorEvent{
            prev : arg0.operator,
            new  : arg0.operator,
        };
        0x2::event::emit<SetOperatorEvent>(v0);
    }

    public fun transfer_admin(arg0: &mut RoleConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        assert_non_zero(arg1);
        arg0.pending_admin = arg1;
    }

    public fun transfer_admin_unsafe(arg0: &mut RoleConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        assert_non_zero(arg1);
        arg0.admin = arg1;
        let v0 = AdminTransferEvent{
            prev : arg0.admin,
            new  : arg1,
        };
        0x2::event::emit<AdminTransferEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

