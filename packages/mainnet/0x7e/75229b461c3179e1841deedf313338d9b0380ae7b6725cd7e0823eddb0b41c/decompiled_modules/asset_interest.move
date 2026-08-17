module 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::asset_interest {
    struct UpdateInterestModelWish<phantom T0, phantom T1> has copy, drop, store {
        protocol_app_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        interest_model: 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::interest::InterestModel,
    }

    public fun fulfill_update_interest_model_wish<T0, T1>(arg0: &mut 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::DragonBallCollector, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_functional(arg0);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::take_locked_update<0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::TimeLock<UpdateInterestModelWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<UpdateInterestModelWish<T0, T1>>());
        assert!(0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::is_active<UpdateInterestModelWish<T0, T1>>(&v0, arg3), 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::errors::time_locked_not_active());
        let v1 = 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::into_inner<UpdateInterestModelWish<T0, T1>>(v0);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_market_match<T0>(arg2, &v1.market_id);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::wish_event::emit_fulfill_wish_event<UpdateInterestModelWish<T0, T1>>(v1);
        let UpdateInterestModelWish {
            protocol_app_id : _,
            market_id       : _,
            interest_model  : v4,
        } = v1;
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::asset_admin::update_market_asset_interest_model<T0, T1>(0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::lending_admin_cap(arg0), arg1, arg2, v4);
    }

    public fun wish_update_interest_model<T0, T1>(arg0: &mut 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::DragonBallCollector, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) {
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_functional(arg0);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg10));
        let v0 = UpdateInterestModelWish<T0, T1>{
            protocol_app_id : 0x2::object::id<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp>(arg1),
            market_id       : 0x2::object::id<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>>(arg2),
            interest_model  : 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::asset_admin::create_interest_model(0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::lending_admin_cap(arg0), arg1, arg3, arg4, arg5, arg6, arg7, arg8),
        };
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::wish_event::emit_new_wish_event<UpdateInterestModelWish<T0, T1>>(v0);
        0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::store_locked_update<0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::TimeLock<UpdateInterestModelWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<UpdateInterestModelWish<T0, T1>>(), 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::time_lock::new_time_locked<UpdateInterestModelWish<T0, T1>>(v0, arg9, 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::time_lock_duration_seconds(arg0), 0x6838d28171e2cd1bc8184b1a3c0f0a141eca60bed2ff927673dc3e0a94b6fbe8::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

