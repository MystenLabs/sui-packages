module 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::super_admin {
    struct SuperAdminRoleChanged has copy, drop {
        from: address,
        to: address,
    }

    struct TransferSuperAdminRoleWish has copy, drop, store {
        recipient: address,
    }

    public fun fulfill_transfer_super_admin_role(arg0: &mut 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::DragonBallCollector, arg1: 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::roles::SuperAdminRole, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::ensure_functional(arg0);
        let v0 = 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::take_locked_update<0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::time_lock::TimeLock<TransferSuperAdminRoleWish>>(arg0, 0x1::type_name::with_defining_ids<TransferSuperAdminRoleWish>());
        assert!(0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::time_lock::is_active<TransferSuperAdminRoleWish>(&v0, arg2), 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::errors::time_locked_not_active());
        let v1 = 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::time_lock::into_inner<TransferSuperAdminRoleWish>(v0);
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::wish_event::emit_fulfill_wish_event<TransferSuperAdminRoleWish>(v1);
        let TransferSuperAdminRoleWish { recipient: v2 } = v1;
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::roles::transfer_role(arg1, v2);
        let v3 = SuperAdminRoleChanged{
            from : 0x2::tx_context::sender(arg3),
            to   : v2,
        };
        0x2::event::emit<SuperAdminRoleChanged>(v3);
    }

    public fun wish_transfer_super_admin_role(arg0: &0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::roles::SuperAdminRole, arg1: &mut 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::DragonBallCollector, arg2: address, arg3: &0x2::clock::Clock) {
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::ensure_functional(arg1);
        let v0 = TransferSuperAdminRoleWish{recipient: arg2};
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::wish_event::emit_new_wish_event<TransferSuperAdminRoleWish>(v0);
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::store_locked_update<0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::time_lock::TimeLock<TransferSuperAdminRoleWish>>(arg1, 0x1::type_name::with_defining_ids<TransferSuperAdminRoleWish>(), 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::time_lock::new_time_locked<TransferSuperAdminRoleWish>(v0, arg3, 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::time_lock_duration_seconds(arg1), 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::time_lock_expriration_seconds(arg1)));
    }

    // decompiled from Move bytecode v6
}

