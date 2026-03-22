module 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::asset_revenue {
    struct SetTreasuryAddressWish has copy, drop, store {
        who: address,
    }

    struct SetTreasuryAddressEvent has copy, drop, store {
        treasury: address,
        setter: address,
    }

    public fun take_revenue<T0, T1>(arg0: &0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::DragonBallCollector, arg1: &0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::app::ProtocolApp, arg2: &mut 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::market::Market<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::ensure_functional(arg0);
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::revenue_admin::take_revenue<T0, T1>(0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::lending_admin_cap(arg0), arg1, arg2, arg3, 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::get_treasury_address(arg0), arg4, arg5);
    }

    public fun fullfill_set_treasury_address(arg0: &mut 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::ensure_functional(arg0);
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::take_locked_update<0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::time_lock::TimeLock<SetTreasuryAddressWish>>(arg0, 0x1::type_name::with_defining_ids<SetTreasuryAddressWish>());
        assert!(0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::time_lock::is_active<SetTreasuryAddressWish>(&v0, arg1), 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::errors::time_locked_not_active());
        let v1 = 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::time_lock::into_inner<SetTreasuryAddressWish>(v0);
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::wish_event::emit_fulfill_wish_event<SetTreasuryAddressWish>(v1);
        let SetTreasuryAddressWish { who: v2 } = v1;
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::set_treasury_address(arg0, v2);
        let v3 = SetTreasuryAddressEvent{
            treasury : v2,
            setter   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<SetTreasuryAddressEvent>(v3);
    }

    public fun wish_set_treasury_address(arg0: &mut 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::DragonBallCollector, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::ensure_functional(arg0);
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = SetTreasuryAddressWish{who: arg1};
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::wish_event::emit_new_wish_event<SetTreasuryAddressWish>(v0);
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::store_locked_update<0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::time_lock::TimeLock<SetTreasuryAddressWish>>(arg0, 0x1::type_name::with_defining_ids<SetTreasuryAddressWish>(), 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::time_lock::new_time_locked<SetTreasuryAddressWish>(v0, arg2, 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::time_lock_duration_seconds(arg0), 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

