module 0xbb05e045c09593e2e8c9fdd0ebb901db273ac936e8cf494fd1ffa84788446ba9::role {
    struct Role has store {
        operator: address,
        transfer: 0x1::option::Option<AdminTransferContext>,
    }

    struct AdminTransferContext has store {
        prev: address,
        new: address,
        admin_cap: AdminCap,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun accept_admin(arg0: &mut Role, arg1: &0x2::tx_context::TxContext) : (address, AdminCap) {
        let AdminTransferContext {
            prev      : v0,
            new       : v1,
            admin_cap : v2,
        } = 0x1::option::extract<AdminTransferContext>(&mut arg0.transfer);
        assert!(v1 == 0x2::tx_context::sender(arg1), 2);
        (v0, v2)
    }

    fun assert_non_zero(arg0: address) {
        assert!(arg0 != @0x0, 3);
    }

    public(friend) fun get_operator(arg0: &Role) : address {
        arg0.operator
    }

    public(friend) fun get_pending_transfer(arg0: &Role) : (address, address) {
        if (!is_transfer_in_progress(arg0)) {
            (@0x0, @0x0)
        } else {
            let v2 = 0x1::option::borrow<AdminTransferContext>(&arg0.transfer);
            (v2.prev, v2.new)
        }
    }

    public(friend) fun init_role(arg0: &mut 0x2::tx_context::TxContext) : (Role, AdminCap) {
        let v0 = Role{
            operator : 0x2::tx_context::sender(arg0),
            transfer : 0x1::option::none<AdminTransferContext>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        (v0, v1)
    }

    public(friend) fun init_transfer_admin(arg0: &mut Role, arg1: AdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<AdminTransferContext>(&arg0.transfer), 4);
        assert_non_zero(arg2);
        let v0 = AdminTransferContext{
            prev      : 0x2::tx_context::sender(arg3),
            new       : arg2,
            admin_cap : arg1,
        };
        0x1::option::fill<AdminTransferContext>(&mut arg0.transfer, v0);
    }

    public(friend) fun is_transfer_in_progress(arg0: &Role) : bool {
        0x1::option::is_some<AdminTransferContext>(&arg0.transfer)
    }

    public(friend) fun only_operator(arg0: &Role, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.operator, 0);
    }

    public(friend) fun reclaim_admin(arg0: &mut Role, arg1: &0x2::tx_context::TxContext) : AdminCap {
        let AdminTransferContext {
            prev      : v0,
            new       : _,
            admin_cap : v2,
        } = 0x1::option::extract<AdminTransferContext>(&mut arg0.transfer);
        assert!(v0 == 0x2::tx_context::sender(arg1), 1);
        v2
    }

    public(friend) fun set_operator(arg0: &mut Role, arg1: &AdminCap, arg2: address) : address {
        assert_non_zero(arg2);
        arg0.operator = arg2;
        arg0.operator
    }

    // decompiled from Move bytecode v6
}

