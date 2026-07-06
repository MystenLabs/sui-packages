module 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::asset_revenue {
    struct SetTreasuryAddressWish has copy, drop, store {
        who: address,
    }

    struct SetTreasuryAddressEvent has copy, drop, store {
        treasury: address,
        setter: address,
    }

    public fun fullfill_set_treasury_address(arg0: &mut 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_functional(arg0);
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::take_locked_update<0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::time_lock::TimeLock<SetTreasuryAddressWish>>(arg0, 0x1::type_name::with_defining_ids<SetTreasuryAddressWish>());
        assert!(0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::time_lock::is_active<SetTreasuryAddressWish>(&v0, arg1), 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::errors::time_locked_not_active());
        let v1 = 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::time_lock::into_inner<SetTreasuryAddressWish>(v0);
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::wish_event::emit_fulfill_wish_event<SetTreasuryAddressWish>(v1);
        let SetTreasuryAddressWish { who: v2 } = v1;
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::set_treasury_address(arg0, v2);
        let v3 = SetTreasuryAddressEvent{
            treasury : v2,
            setter   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<SetTreasuryAddressEvent>(v3);
    }

    public fun take_revenue<T0, T1>(arg0: &0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::DragonBallCollector, arg1: &0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::app::ProtocolApp, arg2: &mut 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::market::Market<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_functional(arg0);
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::revenue_admin::take_revenue<T0, T1>(0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::lending_admin_cap(arg0), arg1, arg2, arg3, 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::get_treasury_address(arg0), arg4, arg5);
    }

    public fun wish_set_treasury_address(arg0: &mut 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::DragonBallCollector, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_functional(arg0);
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = SetTreasuryAddressWish{who: arg1};
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::wish_event::emit_new_wish_event<SetTreasuryAddressWish>(v0);
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::store_locked_update<0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::time_lock::TimeLock<SetTreasuryAddressWish>>(arg0, 0x1::type_name::with_defining_ids<SetTreasuryAddressWish>(), 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::time_lock::new_time_locked<SetTreasuryAddressWish>(v0, arg2, 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::time_lock_duration_seconds(arg0), 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v7
}

