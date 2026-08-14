module 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::asset_interest {
    struct UpdateInterestModelWish<phantom T0, phantom T1> has copy, drop, store {
        protocol_app_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        interest_model: 0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::interest::InterestModel,
    }

    public fun fulfill_update_interest_model_wish<T0, T1>(arg0: &mut 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::DragonBallCollector, arg1: &0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::app::ProtocolApp, arg2: &mut 0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::ensure_functional(arg0);
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::take_locked_update<0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::time_lock::TimeLock<UpdateInterestModelWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<UpdateInterestModelWish<T0, T1>>());
        assert!(0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::time_lock::is_active<UpdateInterestModelWish<T0, T1>>(&v0, arg3), 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::errors::time_locked_not_active());
        let v1 = 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::time_lock::into_inner<UpdateInterestModelWish<T0, T1>>(v0);
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::ensure_market_match<T0>(arg2, &v1.market_id);
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::wish_event::emit_fulfill_wish_event<UpdateInterestModelWish<T0, T1>>(v1);
        let UpdateInterestModelWish {
            protocol_app_id : _,
            market_id       : _,
            interest_model  : v4,
        } = v1;
        0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::asset_admin::update_market_asset_interest_model<T0, T1>(0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::lending_admin_cap(arg0), arg1, arg2, v4);
    }

    public fun wish_update_interest_model<T0, T1>(arg0: &mut 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::DragonBallCollector, arg1: &0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::app::ProtocolApp, arg2: &0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::market::Market<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) {
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::ensure_functional(arg0);
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg10));
        let v0 = UpdateInterestModelWish<T0, T1>{
            protocol_app_id : 0x2::object::id<0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::app::ProtocolApp>(arg1),
            market_id       : 0x2::object::id<0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::market::Market<T0>>(arg2),
            interest_model  : 0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::asset_admin::create_interest_model(0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::lending_admin_cap(arg0), arg1, arg3, arg4, arg5, arg6, arg7, arg8),
        };
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::wish_event::emit_new_wish_event<UpdateInterestModelWish<T0, T1>>(v0);
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::store_locked_update<0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::time_lock::TimeLock<UpdateInterestModelWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<UpdateInterestModelWish<T0, T1>>(), 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::time_lock::new_time_locked<UpdateInterestModelWish<T0, T1>>(v0, arg9, 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::time_lock_duration_seconds(arg0), 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

