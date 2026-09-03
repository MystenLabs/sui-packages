module 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::limits {
    struct LimitOrder<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        curve_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        is_buy: bool,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        tokens: 0x2::balance::Balance<T0>,
        trigger_price: u128,
        above: bool,
        min_out: u64,
        referrer: 0x1::option::Option<address>,
        expires_at_ms: u64,
        created_at_ms: u64,
    }

    public fun above<T0>(arg0: &LimitOrder<T0>) : bool {
        arg0.above
    }

    public fun cancel<T0>(arg0: LimitOrder<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        refund<T0>(arg0, false, arg1, arg2);
    }

    public fun curve_id<T0>(arg0: &LimitOrder<T0>) : 0x2::object::ID {
        arg0.curve_id
    }

    public fun escrowed<T0>(arg0: &LimitOrder<T0>) : u64 {
        if (arg0.is_buy) {
            0x2::balance::value<0x2::sui::SUI>(&arg0.sui)
        } else {
            0x2::balance::value<T0>(&arg0.tokens)
        }
    }

    public fun expires_at_ms<T0>(arg0: &LimitOrder<T0>) : u64 {
        arg0.expires_at_ms
    }

    public fun fill<T0>(arg0: LimitOrder<T0>, arg1: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::Curve<T0>, arg2: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::Config, arg3: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::FeeVault, arg4: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::referral::ReferralRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.curve_id == 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::id<T0>(arg1), 0);
        assert!(!0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::is_graduated<T0>(arg1), 6);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg0.expires_at_ms == 0 || v0 < arg0.expires_at_ms, 4);
        assert!(is_ready<T0>(&arg0, 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::price_scaled<T0>(arg1)), 2);
        let LimitOrder {
            id            : v1,
            owner         : v2,
            curve_id      : v3,
            coin_type     : _,
            is_buy        : v5,
            sui           : v6,
            tokens        : v7,
            trigger_price : _,
            above         : _,
            min_out       : v10,
            referrer      : v11,
            expires_at_ms : _,
            created_at_ms : _,
        } = arg0;
        let v14 = v1;
        0x2::object::delete(v14);
        let v15 = if (v5) {
            0x2::balance::destroy_zero<T0>(v7);
            let (v16, v17) = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::buy_for<T0>(arg1, arg2, arg3, arg4, v2, 0x2::coin::from_balance<0x2::sui::SUI>(v6, arg6), v10, v11, arg5, arg6);
            let v18 = v17;
            let v19 = v16;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v19, v2);
            if (0x2::coin::value<0x2::sui::SUI>(&v18) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v18, v2);
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(v18);
            };
            0x2::coin::value<T0>(&v19)
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v6);
            let v20 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::sell_for<T0>(arg1, arg2, arg3, arg4, v2, 0x2::coin::from_balance<T0>(v7, arg6), v10, v11, arg5, arg6);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v20, v2);
            0x2::coin::value<0x2::sui::SUI>(&v20)
        };
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::events::limit_filled(0x2::object::uid_to_inner(&v14), v3, v2, 0x2::tx_context::sender(arg6), v5, v15, 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::price_scaled<T0>(arg1), v0);
    }

    public fun is_buy<T0>(arg0: &LimitOrder<T0>) : bool {
        arg0.is_buy
    }

    public fun is_ready<T0>(arg0: &LimitOrder<T0>, arg1: u128) : bool {
        arg0.above && arg1 >= arg0.trigger_price || arg1 <= arg0.trigger_price
    }

    public fun min_out<T0>(arg0: &LimitOrder<T0>) : u64 {
        arg0.min_out
    }

    public fun owner<T0>(arg0: &LimitOrder<T0>) : address {
        arg0.owner
    }

    public fun place_buy<T0>(arg0: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::Curve<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u128, arg3: u64, arg4: u64, arg5: 0x1::option::Option<address>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 3);
        assert!(arg2 > 0, 5);
        assert!(!0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::is_graduated<T0>(arg0), 6);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = arg2 > 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::price_scaled<T0>(arg0);
        let v2 = LimitOrder<T0>{
            id            : 0x2::object::new(arg7),
            owner         : v0,
            curve_id      : 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::id<T0>(arg0),
            coin_type     : 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::coin_type<T0>(arg0),
            is_buy        : true,
            sui           : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            tokens        : 0x2::balance::zero<T0>(),
            trigger_price : arg2,
            above         : v1,
            min_out       : arg3,
            referrer      : arg5,
            expires_at_ms : arg4,
            created_at_ms : 0x2::clock::timestamp_ms(arg6),
        };
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::events::limit_placed(0x2::object::uid_to_inner(&v2.id), v2.curve_id, v2.coin_type, v0, true, 0x2::coin::value<0x2::sui::SUI>(&arg1), arg2, v1, arg3, arg4, 0x2::clock::timestamp_ms(arg6));
        0x2::transfer::share_object<LimitOrder<T0>>(v2);
    }

    public fun place_sell<T0>(arg0: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::Curve<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u128, arg3: u64, arg4: u64, arg5: 0x1::option::Option<address>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 3);
        assert!(arg2 > 0, 5);
        assert!(!0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::is_graduated<T0>(arg0), 6);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = arg2 > 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::price_scaled<T0>(arg0);
        let v2 = LimitOrder<T0>{
            id            : 0x2::object::new(arg7),
            owner         : v0,
            curve_id      : 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::id<T0>(arg0),
            coin_type     : 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve::coin_type<T0>(arg0),
            is_buy        : false,
            sui           : 0x2::balance::zero<0x2::sui::SUI>(),
            tokens        : 0x2::coin::into_balance<T0>(arg1),
            trigger_price : arg2,
            above         : v1,
            min_out       : arg3,
            referrer      : arg5,
            expires_at_ms : arg4,
            created_at_ms : 0x2::clock::timestamp_ms(arg6),
        };
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::events::limit_placed(0x2::object::uid_to_inner(&v2.id), v2.curve_id, v2.coin_type, v0, false, 0x2::coin::value<T0>(&arg1), arg2, v1, arg3, arg4, 0x2::clock::timestamp_ms(arg6));
        0x2::transfer::share_object<LimitOrder<T0>>(v2);
    }

    public fun reclaim_expired<T0>(arg0: LimitOrder<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.expires_at_ms > 0 && 0x2::clock::timestamp_ms(arg1) >= arg0.expires_at_ms, 7);
        refund<T0>(arg0, true, arg1, arg2);
    }

    fun refund<T0>(arg0: LimitOrder<T0>, arg1: bool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let LimitOrder {
            id            : v0,
            owner         : v1,
            curve_id      : v2,
            coin_type     : _,
            is_buy        : v4,
            sui           : v5,
            tokens        : v6,
            trigger_price : _,
            above         : _,
            min_out       : _,
            referrer      : _,
            expires_at_ms : _,
            created_at_ms : _,
        } = arg0;
        let v13 = v6;
        let v14 = v5;
        let v15 = v0;
        0x2::object::delete(v15);
        let v16 = if (v4) {
            0x2::balance::destroy_zero<T0>(v13);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v14, arg3), v1);
            0x2::balance::value<0x2::sui::SUI>(&v14)
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v14);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v13, arg3), v1);
            0x2::balance::value<T0>(&v13)
        };
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::events::limit_cancelled(0x2::object::uid_to_inner(&v15), v2, v1, arg1, v16, 0x2::clock::timestamp_ms(arg2));
    }

    public fun trigger_price<T0>(arg0: &LimitOrder<T0>) : u128 {
        arg0.trigger_price
    }

    // decompiled from Move bytecode v7
}

