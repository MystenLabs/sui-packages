module 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::limits {
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

    struct GraduatedFill<phantom T0> {
        order_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        owner: address,
        cranker: address,
        is_buy: bool,
        min_out: u64,
        referrer: 0x1::option::Option<address>,
        price_scaled: u128,
        at_ms: u64,
    }

    public fun above<T0>(arg0: &LimitOrder<T0>) : bool {
        arg0.above
    }

    public fun begin_graduated_fill<T0, T1: drop>(arg0: LimitOrder<T0>, arg1: T1, arg2: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::Curve<T0>, arg3: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::migration::MigrationVault<T0>, arg4: 0x2::object::ID, arg5: u128, arg6: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg7: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg8: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T0>, GraduatedFill<T0>) {
        assert!(0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::is_graduated_filler<T1>(arg6), 8);
        assert!(0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::is_graduated<T0>(arg2), 9);
        assert!(arg0.curve_id == 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::id<T0>(arg2), 0);
        assert!(0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::migration::curve_id<T0>(arg3) == 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::id<T0>(arg2), 0);
        let v0 = 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::migration::pool_id<T0>(arg3);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0) && *0x1::option::borrow<0x2::object::ID>(&v0) == arg4, 10);
        let v1 = 0x2::clock::timestamp_ms(arg9);
        assert!(arg0.expires_at_ms == 0 || v1 < arg0.expires_at_ms, 4);
        assert!(is_ready<T0>(&arg0, arg5), 2);
        let LimitOrder {
            id            : v2,
            owner         : v3,
            curve_id      : v4,
            coin_type     : _,
            is_buy        : v6,
            sui           : v7,
            tokens        : v8,
            trigger_price : _,
            above         : _,
            min_out       : v11,
            referrer      : v12,
            expires_at_ms : _,
            created_at_ms : _,
        } = arg0;
        let v15 = v7;
        let v16 = v2;
        0x2::object::delete(v16);
        let v17 = if (0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::has_referrer(arg8, v3)) {
            0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::referrer_of(arg8, v3)
        } else {
            v12
        };
        if (v6) {
            let v18 = &mut v15;
            take_fee(arg6, arg7, v4, v18, v17);
        };
        let v19 = GraduatedFill<T0>{
            order_id     : 0x2::object::uid_to_inner(&v16),
            curve_id     : v4,
            owner        : v3,
            cranker      : 0x2::tx_context::sender(arg10),
            is_buy       : v6,
            min_out      : v11,
            referrer     : v17,
            price_scaled : arg5,
            at_ms        : v1,
        };
        (v15, v8, v19)
    }

    public fun cancel<T0>(arg0: LimitOrder<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        refund<T0>(arg0, false, arg1, arg2);
    }

    public fun curve_id<T0>(arg0: &LimitOrder<T0>) : 0x2::object::ID {
        arg0.curve_id
    }

    fun emit_resized<T0>(arg0: &LimitOrder<T0>, arg1: &0x2::clock::Clock) {
        0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::events::limit_resized(0x2::object::id<LimitOrder<T0>>(arg0), arg0.curve_id, arg0.owner, 0x2::balance::value<T0>(&arg0.tokens), arg0.min_out, 0x2::clock::timestamp_ms(arg1));
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

    public fun fill<T0>(arg0: LimitOrder<T0>, arg1: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::Curve<T0>, arg2: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg3: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg4: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral::ReferralRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.curve_id == 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::id<T0>(arg1), 0);
        assert!(!0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::is_graduated<T0>(arg1), 6);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg0.expires_at_ms == 0 || v0 < arg0.expires_at_ms, 4);
        assert!(is_ready<T0>(&arg0, 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::price_scaled<T0>(arg1)), 2);
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
            let (v16, v17) = 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::buy_for<T0>(arg1, arg2, arg3, arg4, v2, 0x2::coin::from_balance<0x2::sui::SUI>(v6, arg6), v10, v11, arg5, arg6);
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
            let v20 = 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::sell_for<T0>(arg1, arg2, arg3, arg4, v2, 0x2::coin::from_balance<T0>(v7, arg6), v10, v11, arg5, arg6);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v20, v2);
            0x2::coin::value<0x2::sui::SUI>(&v20)
        };
        0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::events::limit_filled(0x2::object::uid_to_inner(&v14), v3, v2, 0x2::tx_context::sender(arg6), v5, v15, 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::price_scaled<T0>(arg1), v0);
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

    fun pay<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun place_buy<T0>(arg0: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::Curve<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u128, arg3: u64, arg4: u64, arg5: 0x1::option::Option<address>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 3);
        assert!(arg2 > 0, 5);
        assert!(!0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::is_graduated<T0>(arg0), 6);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = arg2 > 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::price_scaled<T0>(arg0);
        let v2 = LimitOrder<T0>{
            id            : 0x2::object::new(arg7),
            owner         : v0,
            curve_id      : 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::id<T0>(arg0),
            coin_type     : 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::coin_type<T0>(arg0),
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
        0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::events::limit_placed(0x2::object::uid_to_inner(&v2.id), v2.curve_id, v2.coin_type, v0, true, 0x2::coin::value<0x2::sui::SUI>(&arg1), arg2, v1, arg3, arg4, 0x2::clock::timestamp_ms(arg6));
        0x2::transfer::share_object<LimitOrder<T0>>(v2);
    }

    public fun place_sell<T0>(arg0: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::Curve<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u128, arg3: u64, arg4: u64, arg5: 0x1::option::Option<address>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 3);
        assert!(arg2 > 0, 5);
        assert!(!0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::is_graduated<T0>(arg0), 6);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = arg2 > 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::price_scaled<T0>(arg0);
        let v2 = LimitOrder<T0>{
            id            : 0x2::object::new(arg7),
            owner         : v0,
            curve_id      : 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::id<T0>(arg0),
            coin_type     : 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::curve::coin_type<T0>(arg0),
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
        0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::events::limit_placed(0x2::object::uid_to_inner(&v2.id), v2.curve_id, v2.coin_type, v0, false, 0x2::coin::value<T0>(&arg1), arg2, v1, arg3, arg4, 0x2::clock::timestamp_ms(arg6));
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
        0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::events::limit_cancelled(0x2::object::uid_to_inner(&v15), v2, v1, arg1, v16, 0x2::clock::timestamp_ms(arg2));
    }

    fun resize_floor<T0>(arg0: &mut LimitOrder<T0>, arg1: u64, arg2: u64) {
        arg0.min_out = (((arg0.min_out as u128) * (arg2 as u128) / (arg1 as u128)) as u64);
    }

    public fun settle_graduated_fill<T0>(arg0: GraduatedFill<T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: 0x2::balance::Balance<T0>, arg3: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg4: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg5: &mut 0x2::tx_context::TxContext) {
        let GraduatedFill {
            order_id     : v0,
            curve_id     : v1,
            owner        : v2,
            cranker      : v3,
            is_buy       : v4,
            min_out      : v5,
            referrer     : v6,
            price_scaled : v7,
            at_ms        : v8,
        } = arg0;
        let v9 = if (v4) {
            assert!(0x2::balance::value<T0>(&arg2) > 0, 12);
            0x2::balance::value<T0>(&arg2)
        } else {
            let v10 = &mut arg1;
            take_fee(arg3, arg4, v1, v10, v6);
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg1) > 0, 12);
            0x2::balance::value<0x2::sui::SUI>(&arg1)
        };
        assert!(v9 >= v5, 11);
        pay<0x2::sui::SUI>(arg1, v2, arg5);
        pay<T0>(arg2, v2, arg5);
        0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::events::limit_filled(v0, v1, v2, v3, v4, v9, v7, v8);
    }

    fun take_fee(arg0: &0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::Config, arg1: &mut 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::FeeVault, arg2: 0x2::object::ID, arg3: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg4: 0x1::option::Option<address>) {
        assert!(0x2::balance::value<0x2::sui::SUI>(arg3) > 0, 3);
        let v0 = 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::math::mul_bps(0x2::balance::value<0x2::sui::SUI>(arg3), 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::config::fee_bps(arg0));
        if (v0 > 0) {
            0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::fees::deposit_external(arg1, arg2, 0x2::balance::split<0x2::sui::SUI>(arg3, v0), arg4);
        };
    }

    public fun top_up<T0>(arg0: &mut LimitOrder<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1);
        assert!(!arg0.is_buy, 14);
        assert!(arg0.expires_at_ms == 0 || 0x2::clock::timestamp_ms(arg2) < arg0.expires_at_ms, 4);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 13);
        let v1 = 0x2::balance::value<T0>(&arg0.tokens);
        resize_floor<T0>(arg0, v1, v1 + v0);
        0x2::coin::put<T0>(&mut arg0.tokens, arg1);
        emit_resized<T0>(arg0, arg2);
    }

    public fun trigger_price<T0>(arg0: &LimitOrder<T0>) : u128 {
        arg0.trigger_price
    }

    public fun withdraw_part<T0>(arg0: &mut LimitOrder<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1);
        assert!(!arg0.is_buy, 14);
        let v0 = 0x2::balance::value<T0>(&arg0.tokens);
        assert!(arg1 > 0 && arg1 < v0, 13);
        resize_floor<T0>(arg0, v0, v0 - arg1);
        emit_resized<T0>(arg0, arg2);
        0x2::coin::take<T0>(&mut arg0.tokens, arg1, arg3)
    }

    // decompiled from Move bytecode v7
}

