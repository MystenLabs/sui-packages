module 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::asset_interest {
    struct UpdateInterestModelWish has copy, drop, store {
        interest_model: 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::interest::InterestModel,
        market_type: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
    }

    public fun fulfill_update_interest_model_wish<T0, T1>(arg0: &mut 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::DragonBallCollector, arg1: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::ProtocolApp, arg2: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_can_summon_shenron(arg0);
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::take_locked_update<0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::TimeLock<UpdateInterestModelWish>>(arg0, 0x1::type_name::with_defining_ids<UpdateInterestModelWish>());
        assert!(0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::is_active<UpdateInterestModelWish>(&v0, arg3), 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::errors::time_locked_not_active());
        let UpdateInterestModelWish {
            interest_model : v1,
            market_type    : v2,
            coin_type      : v3,
        } = 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::into_inner<UpdateInterestModelWish>(v0);
        assert!(v2 == 0x1::type_name::with_defining_ids<T0>(), 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::errors::invalid_market_type());
        assert!(v3 == 0x1::type_name::with_defining_ids<T1>(), 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::errors::invalid_coin_type());
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::asset_admin::update_market_asset_interest_model<T0, T1>(0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::lending_admin_cap(arg0), arg1, arg2, v1);
    }

    public fun wish_update_interest_model<T0, T1>(arg0: &mut 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::DragonBallCollector, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_can_summon_shenron(arg0);
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg8));
        let v0 = UpdateInterestModelWish{
            interest_model : 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::asset_admin::create_interest_model(0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4, arg5, arg6),
            market_type    : 0x1::type_name::with_defining_ids<T0>(),
            coin_type      : 0x1::type_name::with_defining_ids<T1>(),
        };
        0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::store_locked_update<0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::TimeLock<UpdateInterestModelWish>>(arg0, 0x1::type_name::with_defining_ids<UpdateInterestModelWish>(), 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::time_lock::new_time_locked<UpdateInterestModelWish>(v0, arg7, 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::time_lock_duration_seconds(arg0), 0xfb30368a735a023b686988dd37c354615796fe643942e1f3bb05cbd5a151724::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

