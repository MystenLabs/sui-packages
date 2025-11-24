module 0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::asset_interest {
    struct UpdateInterestModelWish<phantom T0, phantom T1> has copy, drop, store {
        interest_model: 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::interest::InterestModel,
    }

    public fun fulfill_update_interest_model_wish<T0, T1>(arg0: &mut 0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::DragonBallCollector, arg1: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::ProtocolApp, arg2: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::ensure_can_summon_shenron(arg0);
        0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::take_locked_update<0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::time_lock::TimeLock<UpdateInterestModelWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<UpdateInterestModelWish<T0, T1>>());
        assert!(0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::time_lock::is_active<UpdateInterestModelWish<T0, T1>>(&v0, arg3), 0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::errors::time_locked_not_active());
        let v1 = 0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::time_lock::into_inner<UpdateInterestModelWish<T0, T1>>(v0);
        0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::wish_event::emit_fulfill_wish_event<UpdateInterestModelWish<T0, T1>>(v1);
        let UpdateInterestModelWish { interest_model: v2 } = v1;
        0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::asset_admin::update_market_asset_interest_model<T0, T1>(0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::lending_admin_cap(arg0), arg1, arg2, v2);
    }

    public fun wish_update_interest_model<T0, T1>(arg0: &mut 0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::DragonBallCollector, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::ensure_can_summon_shenron(arg0);
        0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg8));
        let v0 = UpdateInterestModelWish<T0, T1>{interest_model: 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::asset_admin::create_interest_model(0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4, arg5, arg6)};
        0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::wish_event::emit_new_wish_event<UpdateInterestModelWish<T0, T1>>(v0);
        0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::store_locked_update<0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::time_lock::TimeLock<UpdateInterestModelWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<UpdateInterestModelWish<T0, T1>>(), 0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::time_lock::new_time_locked<UpdateInterestModelWish<T0, T1>>(v0, arg7, 0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::time_lock_duration_seconds(arg0), 0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

