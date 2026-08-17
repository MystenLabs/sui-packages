module 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::asset_revenue {
    struct SetTreasuryAddressWish has copy, drop, store {
        who: address,
    }

    struct SetTreasuryAddressEvent has copy, drop, store {
        treasury: address,
        setter: address,
    }

    public fun fullfill_set_treasury_address(arg0: &mut 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_functional(arg0);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::take_locked_update<0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::TimeLock<SetTreasuryAddressWish>>(arg0, 0x1::type_name::with_defining_ids<SetTreasuryAddressWish>());
        assert!(0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::is_active<SetTreasuryAddressWish>(&v0, arg1), 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::errors::time_locked_not_active());
        let v1 = 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::into_inner<SetTreasuryAddressWish>(v0);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::wish_event::emit_fulfill_wish_event<SetTreasuryAddressWish>(v1);
        let SetTreasuryAddressWish { who: v2 } = v1;
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::set_treasury_address(arg0, v2);
        let v3 = SetTreasuryAddressEvent{
            treasury : v2,
            setter   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<SetTreasuryAddressEvent>(v3);
    }

    public fun take_revenue<T0, T1>(arg0: &0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::DragonBallCollector, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_functional(arg0);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::revenue_admin::take_revenue<T0, T1>(0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::lending_admin_cap(arg0), arg1, arg2, arg3, 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::get_treasury_address(arg0), arg4, arg5);
    }

    public fun wish_set_treasury_address(arg0: &mut 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::DragonBallCollector, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_functional(arg0);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = SetTreasuryAddressWish{who: arg1};
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::wish_event::emit_new_wish_event<SetTreasuryAddressWish>(v0);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::store_locked_update<0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::TimeLock<SetTreasuryAddressWish>>(arg0, 0x1::type_name::with_defining_ids<SetTreasuryAddressWish>(), 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::new_time_locked<SetTreasuryAddressWish>(v0, arg2, 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::time_lock_duration_seconds(arg0), 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

