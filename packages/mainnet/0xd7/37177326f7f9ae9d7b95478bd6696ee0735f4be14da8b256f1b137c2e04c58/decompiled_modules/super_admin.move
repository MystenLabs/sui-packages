module 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::super_admin {
    struct SuperAdminRoleChanged has copy, drop {
        from: address,
        to: address,
    }

    struct TransferSuperAdminRoleWish has copy, drop, store {
        recipient: address,
    }

    public fun fulfill_transfer_super_admin_role(arg0: &mut 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::DragonBallCollector, arg1: 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::roles::SuperAdminRole, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_functional(arg0);
        let v0 = 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::take_locked_update<0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::time_lock::TimeLock<TransferSuperAdminRoleWish>>(arg0, 0x1::type_name::with_defining_ids<TransferSuperAdminRoleWish>());
        assert!(0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::time_lock::is_active<TransferSuperAdminRoleWish>(&v0, arg2), 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::errors::time_locked_not_active());
        let v1 = 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::time_lock::into_inner<TransferSuperAdminRoleWish>(v0);
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::wish_event::emit_fulfill_wish_event<TransferSuperAdminRoleWish>(v1);
        let TransferSuperAdminRoleWish { recipient: v2 } = v1;
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::roles::transfer_role(arg1, v2);
        let v3 = SuperAdminRoleChanged{
            from : 0x2::tx_context::sender(arg3),
            to   : v2,
        };
        0x2::event::emit<SuperAdminRoleChanged>(v3);
    }

    public fun wish_transfer_super_admin_role(arg0: &0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::roles::SuperAdminRole, arg1: &mut 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::DragonBallCollector, arg2: address, arg3: &0x2::clock::Clock) {
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_functional(arg1);
        let v0 = TransferSuperAdminRoleWish{recipient: arg2};
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::wish_event::emit_new_wish_event<TransferSuperAdminRoleWish>(v0);
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::store_locked_update<0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::time_lock::TimeLock<TransferSuperAdminRoleWish>>(arg1, 0x1::type_name::with_defining_ids<TransferSuperAdminRoleWish>(), 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::time_lock::new_time_locked<TransferSuperAdminRoleWish>(v0, arg3, 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::time_lock_duration_seconds(arg1), 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::time_lock_expriration_seconds(arg1)));
    }

    // decompiled from Move bytecode v6
}

