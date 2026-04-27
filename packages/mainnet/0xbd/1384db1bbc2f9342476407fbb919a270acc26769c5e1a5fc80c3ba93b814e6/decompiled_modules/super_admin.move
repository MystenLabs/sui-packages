module 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::super_admin {
    struct SuperAdminRoleChanged has copy, drop {
        from: address,
        to: address,
    }

    struct TransferSuperAdminRoleWish has copy, drop, store {
        recipient: address,
    }

    public fun fulfill_transfer_super_admin_role(arg0: &mut 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::DragonBallCollector, arg1: 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::roles::SuperAdminRole, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_functional(arg0);
        let v0 = 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::take_locked_update<0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::TimeLock<TransferSuperAdminRoleWish>>(arg0, 0x1::type_name::with_defining_ids<TransferSuperAdminRoleWish>());
        assert!(0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::is_active<TransferSuperAdminRoleWish>(&v0, arg2), 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::errors::time_locked_not_active());
        let v1 = 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::into_inner<TransferSuperAdminRoleWish>(v0);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::wish_event::emit_fulfill_wish_event<TransferSuperAdminRoleWish>(v1);
        let TransferSuperAdminRoleWish { recipient: v2 } = v1;
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::roles::transfer_role(arg1, v2);
        let v3 = SuperAdminRoleChanged{
            from : 0x2::tx_context::sender(arg3),
            to   : v2,
        };
        0x2::event::emit<SuperAdminRoleChanged>(v3);
    }

    public fun wish_transfer_super_admin_role(arg0: &0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::roles::SuperAdminRole, arg1: &mut 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::DragonBallCollector, arg2: address, arg3: &0x2::clock::Clock) {
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::ensure_functional(arg1);
        let v0 = TransferSuperAdminRoleWish{recipient: arg2};
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::wish_event::emit_new_wish_event<TransferSuperAdminRoleWish>(v0);
        0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::store_locked_update<0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::TimeLock<TransferSuperAdminRoleWish>>(arg1, 0x1::type_name::with_defining_ids<TransferSuperAdminRoleWish>(), 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::time_lock::new_time_locked<TransferSuperAdminRoleWish>(v0, arg3, 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::time_lock_duration_seconds(arg1), 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::governance::time_lock_expriration_seconds(arg1)));
    }

    // decompiled from Move bytecode v6
}

