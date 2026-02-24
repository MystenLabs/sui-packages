module 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::asset_revenue {
    struct SetTreasuryAddressWish has copy, drop, store {
        who: address,
    }

    struct SetTreasuryAddressEvent has copy, drop, store {
        treasury: address,
        setter: address,
    }

    public fun take_revenue<T0, T1>(arg0: &0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::DragonBallCollector, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg2: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::ensure_functional(arg0);
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::revenue_admin::take_revenue<T0, T1>(0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::lending_admin_cap(arg0), arg1, arg2, arg3, 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::get_treasury_address(arg0), arg4, arg5);
    }

    public fun fullfill_set_treasury_address(arg0: &mut 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::ensure_functional(arg0);
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::take_locked_update<0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::time_lock::TimeLock<SetTreasuryAddressWish>>(arg0, 0x1::type_name::with_defining_ids<SetTreasuryAddressWish>());
        assert!(0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::time_lock::is_active<SetTreasuryAddressWish>(&v0, arg1), 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::errors::time_locked_not_active());
        let v1 = 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::time_lock::into_inner<SetTreasuryAddressWish>(v0);
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::wish_event::emit_fulfill_wish_event<SetTreasuryAddressWish>(v1);
        let SetTreasuryAddressWish { who: v2 } = v1;
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::set_treasury_address(arg0, v2);
        let v3 = SetTreasuryAddressEvent{
            treasury : v2,
            setter   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<SetTreasuryAddressEvent>(v3);
    }

    public fun wish_set_treasury_address(arg0: &mut 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::DragonBallCollector, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::ensure_functional(arg0);
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = SetTreasuryAddressWish{who: arg1};
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::wish_event::emit_new_wish_event<SetTreasuryAddressWish>(v0);
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::store_locked_update<0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::time_lock::TimeLock<SetTreasuryAddressWish>>(arg0, 0x1::type_name::with_defining_ids<SetTreasuryAddressWish>(), 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::time_lock::new_time_locked<SetTreasuryAddressWish>(v0, arg2, 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::time_lock_duration_seconds(arg0), 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

