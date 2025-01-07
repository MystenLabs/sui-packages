module 0x8b6ea5efa5f614028e916595c6a15aacb2a1a4f609490aecec54270dbf8ee311::role {
    struct SetCollectorEvent has copy, drop {
        address: address,
    }

    struct TransferAdminEvent has copy, drop {
        address: address,
    }

    struct AcceptAdminEvent has copy, drop {
        address: address,
    }

    struct Role has key {
        id: 0x2::object::UID,
        collector: address,
        admin: address,
        pending_admin: address,
    }

    public entry fun accept_admin(arg0: &mut Role, arg1: &0x2::tx_context::TxContext) {
        only_pending_admin(arg0, arg1);
        arg0.admin = arg0.pending_admin;
        arg0.pending_admin = @0x0;
        let v0 = AcceptAdminEvent{address: arg0.admin};
        0x2::event::emit<AcceptAdminEvent>(v0);
    }

    public fun get_admin(arg0: &Role) : address {
        arg0.admin
    }

    public fun get_collector(arg0: &Role) : address {
        arg0.collector
    }

    public fun get_pending_admin(arg0: &Role) : address {
        arg0.pending_admin
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Role{
            id            : 0x2::object::new(arg0),
            collector     : v0,
            admin         : v0,
            pending_admin : @0x0,
        };
        0x2::transfer::share_object<Role>(v1);
    }

    public fun only_admin(arg0: &Role, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
    }

    public fun only_collector(arg0: &Role, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == get_collector(arg0), 2);
    }

    fun only_pending_admin(arg0: &Role, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.pending_admin, 3);
    }

    public entry fun set_collector(arg0: &mut Role, arg1: address, arg2: &0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        arg0.collector = arg1;
        let v0 = SetCollectorEvent{address: arg1};
        0x2::event::emit<SetCollectorEvent>(v0);
    }

    public entry fun transfer_admin(arg0: &mut Role, arg1: address, arg2: &0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        arg0.pending_admin = arg1;
        let v0 = TransferAdminEvent{address: arg1};
        0x2::event::emit<TransferAdminEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

