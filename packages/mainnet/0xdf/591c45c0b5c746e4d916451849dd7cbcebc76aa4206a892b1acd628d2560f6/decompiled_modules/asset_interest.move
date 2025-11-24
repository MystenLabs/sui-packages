module 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::asset_interest {
    struct UpdateInterestModelWish<phantom T0, phantom T1> has copy, drop, store {
        interest_model: 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::interest::InterestModel,
    }

    public fun fulfill_update_interest_model_wish<T0, T1>(arg0: &mut 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::DragonBallCollector, arg1: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::ProtocolApp, arg2: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::ensure_can_summon_shenron(arg0);
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::take_locked_update<0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::time_lock::TimeLock<UpdateInterestModelWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<UpdateInterestModelWish<T0, T1>>());
        assert!(0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::time_lock::is_active<UpdateInterestModelWish<T0, T1>>(&v0, arg3), 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::errors::time_locked_not_active());
        let v1 = 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::time_lock::into_inner<UpdateInterestModelWish<T0, T1>>(v0);
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::wish_event::emit_fulfill_wish_event<UpdateInterestModelWish<T0, T1>>(v1);
        let UpdateInterestModelWish { interest_model: v2 } = v1;
        0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::asset_admin::update_market_asset_interest_model<T0, T1>(0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::lending_admin_cap(arg0), arg1, arg2, v2);
    }

    public fun wish_update_interest_model<T0, T1>(arg0: &mut 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::DragonBallCollector, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::ensure_can_summon_shenron(arg0);
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg8));
        let v0 = UpdateInterestModelWish<T0, T1>{interest_model: 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::asset_admin::create_interest_model(0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4, arg5, arg6)};
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::wish_event::emit_new_wish_event<UpdateInterestModelWish<T0, T1>>(v0);
        0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::store_locked_update<0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::time_lock::TimeLock<UpdateInterestModelWish<T0, T1>>>(arg0, 0x1::type_name::with_defining_ids<UpdateInterestModelWish<T0, T1>>(), 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::time_lock::new_time_locked<UpdateInterestModelWish<T0, T1>>(v0, arg7, 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::time_lock_duration_seconds(arg0), 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

