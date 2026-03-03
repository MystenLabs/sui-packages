module 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::asset_interest {
    struct UpdateInterestModelWish<phantom T0, phantom T1> has copy, drop, store {
        protocol_app_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        interest_model: 0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::interest::InterestModel,
    }

    public fun fulfill_update_interest_model_wish<T0, T1>(arg0: &mut 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::DragonBallCollector, arg1: &0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::ProtocolApp, arg2: &mut 0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_functional(arg0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::take_locked_update<0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::TimeLock<UpdateInterestModelWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<UpdateInterestModelWish<T0, T1>>());
        assert!(0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::is_active<UpdateInterestModelWish<T0, T1>>(&v0, arg3), 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::errors::time_locked_not_active());
        let v1 = 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::into_inner<UpdateInterestModelWish<T0, T1>>(v0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_market_match<T0>(arg2, &v1.market_id);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::wish_event::emit_fulfill_wish_event<UpdateInterestModelWish<T0, T1>>(v1);
        let UpdateInterestModelWish {
            protocol_app_id : _,
            market_id       : _,
            interest_model  : v4,
        } = v1;
        0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::asset_admin::update_market_asset_interest_model<T0, T1>(0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::lending_admin_cap(arg0), arg1, arg2, v4);
    }

    public fun wish_update_interest_model<T0, T1>(arg0: &mut 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::DragonBallCollector, arg1: &0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::ProtocolApp, arg2: &0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::market::Market<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) {
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_functional(arg0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg10));
        let v0 = UpdateInterestModelWish<T0, T1>{
            protocol_app_id : 0x2::object::id<0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::ProtocolApp>(arg1),
            market_id       : 0x2::object::id<0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::market::Market<T0>>(arg2),
            interest_model  : 0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::asset_admin::create_interest_model(0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::lending_admin_cap(arg0), arg1, arg3, arg4, arg5, arg6, arg7, arg8),
        };
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::wish_event::emit_new_wish_event<UpdateInterestModelWish<T0, T1>>(v0);
        0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::store_locked_update<0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::TimeLock<UpdateInterestModelWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<UpdateInterestModelWish<T0, T1>>(), 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::time_lock::new_time_locked<UpdateInterestModelWish<T0, T1>>(v0, arg9, 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::time_lock_duration_seconds(arg0), 0xfa5531cf5650e5027b507eb9a678f028b8bf16b80535f86399bc6b6a82d9109::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

