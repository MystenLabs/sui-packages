module 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::asset_interest {
    struct UpdateInterestModelWish<phantom T0, phantom T1> has copy, drop, store {
        protocol_app_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        interest_model: 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::interest::InterestModel,
    }

    public fun fulfill_update_interest_model_wish<T0, T1>(arg0: &mut 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::DragonBallCollector, arg1: &0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::app::ProtocolApp, arg2: &mut 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::ensure_functional(arg0);
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::take_locked_update<0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::time_lock::TimeLock<UpdateInterestModelWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<UpdateInterestModelWish<T0, T1>>());
        assert!(0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::time_lock::is_active<UpdateInterestModelWish<T0, T1>>(&v0, arg3), 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::errors::time_locked_not_active());
        let v1 = 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::time_lock::into_inner<UpdateInterestModelWish<T0, T1>>(v0);
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::ensure_protocol_app_match(arg1, &v1.protocol_app_id);
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::ensure_market_match<T0>(arg2, &v1.market_id);
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::wish_event::emit_fulfill_wish_event<UpdateInterestModelWish<T0, T1>>(v1);
        let UpdateInterestModelWish {
            protocol_app_id : _,
            market_id       : _,
            interest_model  : v4,
        } = v1;
        0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::asset_admin::update_market_asset_interest_model<T0, T1>(0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::lending_admin_cap(arg0), arg1, arg2, v4);
    }

    public fun wish_update_interest_model<T0, T1>(arg0: &mut 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::DragonBallCollector, arg1: &0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::app::ProtocolApp, arg2: &0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::market::Market<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) {
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::ensure_functional(arg0);
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg10));
        let v0 = UpdateInterestModelWish<T0, T1>{
            protocol_app_id : 0x2::object::id<0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::app::ProtocolApp>(arg1),
            market_id       : 0x2::object::id<0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::market::Market<T0>>(arg2),
            interest_model  : 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::asset_admin::create_interest_model(0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::lending_admin_cap(arg0), arg1, arg3, arg4, arg5, arg6, arg7, arg8),
        };
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::wish_event::emit_new_wish_event<UpdateInterestModelWish<T0, T1>>(v0);
        0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::store_locked_update<0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::time_lock::TimeLock<UpdateInterestModelWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<UpdateInterestModelWish<T0, T1>>(), 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::time_lock::new_time_locked<UpdateInterestModelWish<T0, T1>>(v0, arg9, 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::time_lock_duration_seconds(arg0), 0x643057d4e32bdd8035a7c681d04293f2bde919de59b80b63f192daeafec31629::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

