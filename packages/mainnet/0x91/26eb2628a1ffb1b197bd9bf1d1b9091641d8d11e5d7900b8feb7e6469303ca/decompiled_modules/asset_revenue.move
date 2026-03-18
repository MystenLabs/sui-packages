module 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::asset_revenue {
    struct SetTreasuryAddressWish has copy, drop, store {
        who: address,
    }

    struct SetTreasuryAddressEvent has copy, drop, store {
        treasury: address,
        setter: address,
    }

    public fun take_revenue<T0, T1>(arg0: &0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::DragonBallCollector, arg1: &0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::ProtocolApp, arg2: &mut 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::market::Market<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_functional(arg0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::revenue_admin::take_revenue<T0, T1>(0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::lending_admin_cap(arg0), arg1, arg2, arg3, 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::get_treasury_address(arg0), arg4, arg5);
    }

    public fun fullfill_set_treasury_address(arg0: &mut 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_functional(arg0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::take_locked_update<0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::TimeLock<SetTreasuryAddressWish>>(arg0, 0x1::type_name::with_defining_ids<SetTreasuryAddressWish>());
        assert!(0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::is_active<SetTreasuryAddressWish>(&v0, arg1), 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::errors::time_locked_not_active());
        let v1 = 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::into_inner<SetTreasuryAddressWish>(v0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::wish_event::emit_fulfill_wish_event<SetTreasuryAddressWish>(v1);
        let SetTreasuryAddressWish { who: v2 } = v1;
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::set_treasury_address(arg0, v2);
        let v3 = SetTreasuryAddressEvent{
            treasury : v2,
            setter   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<SetTreasuryAddressEvent>(v3);
    }

    public fun wish_set_treasury_address(arg0: &mut 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::DragonBallCollector, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_functional(arg0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = SetTreasuryAddressWish{who: arg1};
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::wish_event::emit_new_wish_event<SetTreasuryAddressWish>(v0);
        0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::store_locked_update<0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::TimeLock<SetTreasuryAddressWish>>(arg0, 0x1::type_name::with_defining_ids<SetTreasuryAddressWish>(), 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::time_lock::new_time_locked<SetTreasuryAddressWish>(v0, arg2, 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::time_lock_duration_seconds(arg0), 0x9126eb2628a1ffb1b197bd9bf1d1b9091641d8d11e5d7900b8feb7e6469303ca::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

