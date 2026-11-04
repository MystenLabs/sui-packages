module 0x344c6e7fd74ca56a61c863bca50496a52fbe09c20222f3999d2f26ec285f516e::entry {
    struct FiredFlash has copy, drop {
        pair_cetus: address,
        pair_bluefin: address,
        buy_on_cetus: bool,
        spread_bps: u64,
        size_b: u64,
        profit_b: u64,
    }

    struct DbmFee has copy, drop {
        pool: address,
        manager: address,
        is_bid: bool,
        deep_paid: u64,
        kept: u64,
    }

    struct CheapFee has copy, drop {
        is_bid: bool,
        deep_paid: u64,
        kept: u64,
        kept_is_quote: bool,
    }

    fun a_to_b_units(arg0: u64, arg1: u128) : u64 {
        ((((arg0 as u256) * (arg1 as u256) >> 64) * (arg1 as u256) >> 64) as u64)
    }

    fun b_to_a_units(arg0: u64, arg1: u128) : u64 {
        let v0 = (arg1 as u256) * (arg1 as u256);
        if (v0 == 0) {
            return 18446744073709551615
        };
        (((((arg0 as u256) << 128) + v0 - 1) / v0) as u64)
    }

    fun bluefin_buy_a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg3, arg0, arg1, 0x2::balance::zero<T0>(), arg2, false, true, 0x2::balance::value<T1>(&arg2), 0, 79226673515401279992447579054);
        0x2::balance::destroy_zero<T1>(v1);
        v0
    }

    fun bluefin_sell_a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg3, arg0, arg1, arg2, 0x2::balance::zero<T1>(), true, true, 0x2::balance::value<T0>(&arg2), 0, 4295048017);
        0x2::balance::destroy_zero<T0>(v0);
        v1
    }

    fun cetus_price_in_db_frame_flip(arg0: u128) : u128 {
        let v0 = (arg0 as u256) * (arg0 as u256);
        if (v0 == 0) {
            return 0
        };
        ((340282366920938463463374607431768211456000000000 / v0) as u128)
    }

    public fun cheap_buy_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1);
        let (v3, v4) = cheap_size<T0, T1>(arg0, 0x2::coin::value<T1>(&arg2), true, arg4, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg1, arg2, arg6);
        let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg6);
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg0, arg1, &v5, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v3, true, true, arg5, arg6);
        cheap_finish<T0, T1>(arg1, &v6, v0, v1, v2, v4, true, arg3, arg4, arg6)
    }

    fun cheap_finish<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::fee_is_deep(arg1), 924);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(arg1);
        assert!(v0 <= arg7, 922);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_deep_price(arg1);
        let v2 = !0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::asset_is_base(&v1);
        let v3 = cheap_keep(v0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::deep_per_asset(&v1), arg8);
        if (arg6 == v2) {
            assert!(arg5 >= v3, 923);
        };
        let v4 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg0);
        let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg0);
        let v6 = if (v2) {
            0
        } else {
            v3
        };
        let v7 = if (v2) {
            v3
        } else {
            0
        };
        assert!(v4 >= arg2 && v4 - arg2 >= v6, 925);
        assert!(v5 >= arg3 && v5 - arg3 >= v7, 925);
        assert!(arg4 >= v0 && 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0) == arg4 - v0, 925);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg0) == arg2 + v6, 925);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg0) == arg3 + v7, 925);
        let v8 = CheapFee{
            is_bid        : arg6,
            deep_paid     : v0,
            kept          : v3,
            kept_is_quote : v2,
        };
        0x2::event::emit<CheapFee>(v8);
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg0, v4 - arg2 - v6, arg9), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg0, v5 - arg3 - v7, arg9))
    }

    fun cheap_keep(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 >= 1000000, 920);
        assert!(arg1 > 0, 926);
        let v0 = (arg0 as u128) * 1000000000 * (arg2 as u128);
        let v1 = (arg1 as u128) * 1000000;
        let v2 = if (v0 % v1 > 0) {
            1
        } else {
            0
        };
        ((v0 / v1 + v2) as u64)
    }

    public fun cheap_plain_buy_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1);
        let (_, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let (v6, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, 0, 0x2::coin::value<T1>(&arg2), arg3);
        let v9 = v6 - v6 % v4;
        assert!(v9 >= v5 && v9 > 0, 921);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg1, arg2, arg4);
        let v10 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        let v11 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg0, arg1, &v10, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v9, true, false, arg3, arg4);
        let (v12, v13) = cheap_plain_finish<T0, T1>(arg1, &v11, v0, v1, arg4);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1) == v2, 925);
        (v12, v13)
    }

    fun cheap_plain_finish<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(arg1) == 0, 927);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg0);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg0);
        assert!(v0 >= arg2 && v1 >= arg3, 925);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg0) == arg2 && 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg0) == arg3, 925);
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg0, v0 - arg2, arg4), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg0, v1 - arg3, arg4))
    }

    public fun cheap_plain_sell_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1);
        let (_, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v6 = 0x2::coin::value<T0>(&arg2);
        let v7 = v6 - v6 % v4;
        assert!(v7 >= v5 && v7 > 0, 921);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg1, arg2, arg4);
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg0, arg1, &v8, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v7, false, false, arg3, arg4);
        let (v10, v11) = cheap_plain_finish<T0, T1>(arg1, &v9, v0, v1, arg4);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1) == v2, 925);
        (v11, v10)
    }

    public fun cheap_sell_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1);
        let (v3, v4) = cheap_size<T0, T1>(arg0, 0x2::coin::value<T0>(&arg2), false, arg4, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg1, arg2, arg6);
        let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg6);
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg0, arg1, &v5, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v3, false, true, arg5, arg6);
        let (v7, v8) = cheap_finish<T0, T1>(arg1, &v6, v0, v1, v2, v4, false, arg3, arg4, arg6);
        (v8, v7)
    }

    public fun cheap_settle_refund<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::balance::send_funds<T0>(0x2::coin::into_balance<T0>(arg0), arg1);
        };
    }

    fun cheap_size<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) : (u64, u64) {
        assert!(arg3 >= 1000000, 920);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order_deep_price<T0, T1>(arg0);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::deep_per_asset(&v0);
        assert!(v1 > 0, 926);
        let (_, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v5 = 0;
        if (arg2 == !0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::asset_is_base(&v0)) {
            let v6 = if (arg2) {
                0
            } else {
                arg1 - arg1 % v3
            };
            let v7 = if (arg2) {
                arg1
            } else {
                0
            };
            let (_, _, v10) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, v6, v7, arg4);
            let v11 = cheap_keep(v10, v1, arg3);
            v5 = v11;
            assert!(arg1 >= v11, 923);
        };
        let v12 = arg1 - v5;
        let v13 = if (arg2) {
            let (v14, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, 0, v12, arg4);
            v14 - v14 % v3
        } else {
            v12 - v12 % v3
        };
        assert!(v13 >= v4 && v13 > 0, 921);
        (v13, v5)
    }

    fun db_buy_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, 0x2::coin::from_balance<T1>(arg1, arg3), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0, arg2, arg3);
        payout<T1>(0x2::coin::into_balance<T1>(v1), arg3);
        payout<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2), arg3);
        0x2::coin::into_balance<T0>(v0)
    }

    fun db_sell_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, 0x2::coin::from_balance<T0>(arg1, arg3), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0, arg2, arg3);
        payout<T0>(0x2::coin::into_balance<T0>(v0), arg3);
        payout<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2), arg3);
        0x2::coin::into_balance<T1>(v1)
    }

    fun dbm_buy_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg2);
        let (v1, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        let (_, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let (v7, v8, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out_input_fee<T0, T1>(arg0, 0, v0, arg3);
        let v10 = v7 - v7 % v5;
        let v11 = if (v1 == 0) {
            true
        } else if (!fee_is_plain<T0, T1>(arg0, v1, v3)) {
            true
        } else if (v10 < v6) {
            true
        } else if (v8 < 128) {
            true
        } else if (!manager_funded<T0, T1>(arg0, arg1, v10, v0)) {
            true
        } else {
            !fee_proves_rate<T0, T1>(arg0, v10, v0 - v8)
        };
        if (v11) {
            return db_buy_base<T0, T1>(arg0, arg2, arg3, arg4)
        };
        let v12 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg1, 0x2::coin::from_balance<T1>(arg2, arg4), arg4);
        let v13 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        let v14 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg0, arg1, &v13, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v10, true, true, arg3, arg4);
        assert!(plain_fee<T0, T1>(arg0, arg1, &v14, v1, v3), 911);
        let v15 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::cumulative_quote_quantity(&v14);
        let v16 = input_fee(v1, v15);
        let v17 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1);
        let v18 = v0 - v15 - v16;
        let v19 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1);
        let v20 = if (v17 > 0) {
            0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg1, v17, arg4))
        } else {
            0x2::balance::zero<T0>()
        };
        if (v18 > 0) {
            let v21 = 0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg1, v18, arg4));
            payout<T1>(v21, arg4);
        };
        let v22 = if (v12 > v19) {
            v12 - v19
        } else {
            0
        };
        let v23 = DbmFee{
            pool      : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            manager   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg1),
            is_bid    : true,
            deep_paid : v22,
            kept      : v16,
        };
        0x2::event::emit<DbmFee>(v23);
        v20
    }

    fun dbm_sell_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let (v1, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        let (_, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v7 = div(v0, 1000000000 + mul(v1, 1250000000));
        let v8 = v7 - v7 % v5;
        let v9 = if (v1 == 0) {
            true
        } else if (!fee_is_plain<T0, T1>(arg0, v1, v3)) {
            true
        } else if (v8 < v6) {
            true
        } else if (v0 < v8 + input_fee(v1, v8)) {
            true
        } else if (!manager_funded<T0, T1>(arg0, arg1, v8, arg3)) {
            true
        } else {
            !fee_proves_rate<T0, T1>(arg0, v8, arg3)
        };
        if (v9) {
            return db_sell_base<T0, T1>(arg0, arg2, arg4, arg5)
        };
        let v10 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg1, 0x2::coin::from_balance<T0>(arg2, arg5), arg5);
        let v11 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        let v12 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg0, arg1, &v11, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v8, false, true, arg4, arg5);
        assert!(plain_fee<T0, T1>(arg0, arg1, &v12, v1, v3), 911);
        let v13 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v12);
        let v14 = input_fee(v1, v13);
        let v15 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1);
        let v16 = v0 - v13 - v14;
        let v17 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1);
        let v18 = if (v15 > 0) {
            0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg1, v15, arg5))
        } else {
            0x2::balance::zero<T1>()
        };
        if (v16 > 0) {
            let v19 = 0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg1, v16, arg5));
            payout<T0>(v19, arg5);
        };
        let v20 = if (v10 > v17) {
            v10 - v17
        } else {
            0
        };
        let v21 = DbmFee{
            pool      : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            manager   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg1),
            is_bid    : false,
            deep_paid : v20,
            kept      : v14,
        };
        0x2::event::emit<DbmFee>(v21);
        v18
    }

    fun div(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * 1000000000 / (arg1 as u128)) as u64)
    }

    fun entry_cheap_buy_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        let v3 = 0x2::coin::from_balance<T1>(arg2, arg6);
        let (v4, v5) = if (v0 == 0) {
            cheap_plain_buy_base<T0, T1>(arg0, arg1, v3, arg5, arg6)
        } else {
            cheap_buy_base<T0, T1>(arg0, arg1, v3, arg3, arg4, arg5, arg6)
        };
        payout<T1>(0x2::coin::into_balance<T1>(v5), arg6);
        0x2::coin::into_balance<T0>(v4)
    }

    fun entry_cheap_sell_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        let v3 = 0x2::coin::from_balance<T0>(arg2, arg6);
        let (v4, v5) = if (v0 == 0) {
            cheap_plain_sell_base<T0, T1>(arg0, arg1, v3, arg5, arg6)
        } else {
            cheap_sell_base<T0, T1>(arg0, arg1, v3, arg3, arg4, arg5, arg6)
        };
        payout<T0>(0x2::coin::into_balance<T0>(v5), arg6);
        0x2::coin::into_balance<T1>(v4)
    }

    fun fee_is_plain<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : bool {
        let (v0, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params_next<T0, T1>(arg0);
        if (v0 == arg1) {
            if (arg2 > 0) {
                v2 > 0
            } else {
                false
            }
        } else {
            false
        }
    }

    fun fee_proves_rate<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : bool {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order_deep_price<T0, T1>(arg0);
        let v1 = if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::asset_is_base(&v0)) {
            arg1
        } else {
            arg2
        };
        mul(v1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::deep_per_asset(&v0)) >= 2 * 1000000000
    }

    fun input_fee(arg0: u64, arg1: u64) : u64 {
        mul(arg0, mul(arg1, 1250000000))
    }

    fun manager_funded<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: u64) : bool {
        let v0 = (arg3 as u128) * 1000000000 / (arg2 as u128);
        if (v0 == 0 || v0 > 18446744073709551615) {
            return false
        };
        let (v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order_deep_required<T0, T1>(arg0, arg2, (v0 as u64));
        v1 > 0 && 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1) / 8 >= v1
    }

    fun mul(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000) as u64)
    }

    fun mul128(arg0: u128, arg1: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) / (1000000000 as u256)) as u128)
    }

    fun payout<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        };
    }

    fun plain_fee<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo, arg3: u64, arg4: u64) : bool {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_deep_price(arg2);
        let v1 = if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::asset_is_base(&v0)) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(arg2)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::cumulative_quote_quantity(arg2)
        };
        let v2 = mul(v1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::deep_per_asset(&v0));
        let v3 = if (staked_tier<T0, T1>(arg0, arg1, arg2, arg4)) {
            arg3 / 2
        } else {
            arg3
        };
        if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::fee_is_deep(arg2)) {
            if (v2 >= 1000000000) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(arg2) == mul(v2, v3)
            } else {
                false
            }
        } else {
            false
        }
    }

    fun pqf1_push<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        if (0x1::vector::length<u8>(&arg4) > 0) {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::update_quote_envelope<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        };
    }

    fun pqf_buy_base<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::vector::empty<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>();
        0x1::vector::push_back<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>(&mut v0, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::new_quote_fill(x"0000000000000000000000000000000000000000000000000000000000000000", 0x2::balance::value<T1>(&arg4)));
        let (v1, v2) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::swap_exact_quote_for_base<T0, T1>(arg0, arg1, arg2, arg3, v0, arg4, x"0000000000000000000000000000000000000000000000000000000000000000", arg5, arg6);
        payout<T1>(v2, arg6);
        v1
    }

    fun pqf_sell_base<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg4: 0x2::balance::Balance<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x1::vector::empty<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>();
        0x1::vector::push_back<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>(&mut v0, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::new_quote_fill(x"0000000000000000000000000000000000000000000000000000000000000000", 0x2::balance::value<T0>(&arg4)));
        let (v1, v2) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::swap_exact_base_for_quote<T0, T1>(arg0, arg1, arg2, arg3, v0, arg4, x"0000000000000000000000000000000000000000000000000000000000000000", arg5, arg6);
        payout<T0>(v2, arg6);
        v1
    }

    fun pqf_side_fresh<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg1: bool, arg2: &0x2::clock::Clock) : bool {
        if (arg1) {
            if (!0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_has_bid<T0, T1>(arg0)) {
                return false
            };
            0x2::clock::timestamp_ms(arg2) < 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::quote_sig_expiry_ms(0x1::option::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteEntry>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_bid<T0, T1>(arg0)))
        } else {
            if (!0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_has_ask<T0, T1>(arg0)) {
                return false
            };
            0x2::clock::timestamp_ms(arg2) < 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::quote_sig_expiry_ms(0x1::option::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteEntry>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_ask<T0, T1>(arg0)))
        }
    }

    fun price_spread_bps(arg0: u128, arg1: u128) : u64 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        let v1 = arg0 / 2 + arg1 / 2;
        if (v1 == 0) {
            return 0
        };
        ((v0 * 10000 / v1) as u64)
    }

    public fun run_bluefin_deepbook_flash_bm<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg4 == 0) {
            return 0
        };
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2);
        let v1 = (((v0 as u256) * (v0 as u256) * 1000000000 >> 128) as u128);
        let v2 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg3, arg7) as u128);
        let v3 = price_spread_bps(v1, v2);
        let v4 = if (v3 < arg5) {
            true
        } else if (v2 == 0) {
            true
        } else {
            v1 == 0
        };
        if (v4) {
            return 0
        };
        let v5 = v1 < v2;
        let (v6, v7) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg3, arg4, arg8);
        let v8 = if (v5) {
            let v9 = bluefin_buy_a<T0, T1>(arg0, arg2, 0x2::coin::into_balance<T1>(v6), arg7);
            dbm_sell_base<T0, T1>(arg3, arg1, v9, arg4, arg7, arg8)
        } else {
            let v10 = dbm_buy_base<T0, T1>(arg3, arg1, 0x2::coin::into_balance<T1>(v6), arg7, arg8);
            bluefin_sell_a<T0, T1>(arg0, arg2, v10, arg7)
        };
        let v11 = v8;
        assert!(0x2::balance::value<T1>(&v11) >= arg4 + arg6, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg3, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v11, arg4), arg8), v7);
        let v12 = 0x2::balance::value<T1>(&v11);
        payout<T1>(v11, arg8);
        let v13 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2),
            pair_bluefin : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3),
            buy_on_cetus : v5,
            spread_bps   : v3,
            size_b       : arg4,
            profit_b     : v12,
        };
        0x2::event::emit<FiredFlash>(v13);
        v12
    }

    public fun run_bluefin_deepbook_flash_cheap<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg4 == 0) {
            return 0
        };
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2);
        let v1 = (((v0 as u256) * (v0 as u256) * 1000000000 >> 128) as u128);
        let v2 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg3, arg9) as u128);
        let v3 = price_spread_bps(v1, v2);
        let v4 = if (v3 < arg5) {
            true
        } else if (v2 == 0) {
            true
        } else {
            v1 == 0
        };
        if (v4) {
            return 0
        };
        let v5 = v1 < v2;
        let (v6, v7) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg3, arg4, arg10);
        let v8 = if (v5) {
            let v9 = bluefin_buy_a<T0, T1>(arg0, arg2, 0x2::coin::into_balance<T1>(v6), arg9);
            entry_cheap_sell_base<T0, T1>(arg3, arg1, v9, arg7, arg8, arg9, arg10)
        } else {
            let v10 = entry_cheap_buy_base<T0, T1>(arg3, arg1, 0x2::coin::into_balance<T1>(v6), arg7, arg8, arg9, arg10);
            bluefin_sell_a<T0, T1>(arg0, arg2, v10, arg9)
        };
        let v11 = v8;
        assert!(0x2::balance::value<T1>(&v11) >= arg4 + arg6, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg3, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v11, arg4), arg10), v7);
        let v12 = 0x2::balance::value<T1>(&v11);
        payout<T1>(v11, arg10);
        let v13 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2),
            pair_bluefin : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3),
            buy_on_cetus : v5,
            spread_bps   : v3,
            size_b       : arg4,
            profit_b     : v12,
        };
        0x2::event::emit<FiredFlash>(v13);
        v12
    }

    public fun run_cetus_deepbook_flash_bm<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg4 == 0) {
            return 0
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2);
        let v1 = (((v0 as u256) * (v0 as u256) * 1000000000 >> 128) as u128);
        let v2 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg3, arg7) as u128);
        let v3 = price_spread_bps(v1, v2);
        let v4 = if (v3 < arg5) {
            true
        } else if (v2 == 0) {
            true
        } else {
            v1 == 0
        };
        if (v4) {
            return 0
        };
        let v5 = v1 < v2;
        let v6 = if (v5) {
            let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, arg4, 79226673515401279992447579054, arg7);
            0x2::balance::destroy_zero<T1>(v8);
            let v10 = dbm_sell_base<T0, T1>(arg3, arg1, v7, arg4, arg7, arg8);
            assert!(0x2::balance::value<T1>(&v10) >= arg4 + arg6, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v10, arg4), v9);
            payout<T1>(v10, arg8);
            0x2::balance::value<T1>(&v10)
        } else {
            let (v11, v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, false, arg4, 4295048017, arg7);
            let v14 = v13;
            0x2::balance::destroy_zero<T0>(v11);
            let v15 = dbm_buy_base<T0, T1>(arg3, arg1, v12, arg7, arg8);
            let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v14);
            assert!(0x2::balance::value<T0>(&v15) >= v16 + b_to_a_units(arg6, v0), 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::split<T0>(&mut v15, v16), 0x2::balance::zero<T1>(), v14);
            payout<T0>(v15, arg8);
            a_to_b_units(0x2::balance::value<T0>(&v15), v0)
        };
        let v17 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            pair_bluefin : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3),
            buy_on_cetus : v5,
            spread_bps   : v3,
            size_b       : arg4,
            profit_b     : v6,
        };
        0x2::event::emit<FiredFlash>(v17);
        v6
    }

    public fun run_cetus_deepbook_flash_cheap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg4 == 0) {
            return 0
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2);
        let v1 = (((v0 as u256) * (v0 as u256) * 1000000000 >> 128) as u128);
        let v2 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg3, arg9) as u128);
        let v3 = price_spread_bps(v1, v2);
        let v4 = if (v3 < arg5) {
            true
        } else if (v2 == 0) {
            true
        } else {
            v1 == 0
        };
        if (v4) {
            return 0
        };
        let v5 = v1 < v2;
        let v6 = if (v5) {
            let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, arg4, 79226673515401279992447579054, arg9);
            0x2::balance::destroy_zero<T1>(v8);
            let v10 = entry_cheap_sell_base<T0, T1>(arg3, arg1, v7, arg7, arg8, arg9, arg10);
            assert!(0x2::balance::value<T1>(&v10) >= arg4 + arg6, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v10, arg4), v9);
            payout<T1>(v10, arg10);
            0x2::balance::value<T1>(&v10)
        } else {
            let (v11, v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, false, arg4, 4295048017, arg9);
            let v14 = v13;
            0x2::balance::destroy_zero<T0>(v11);
            let v15 = entry_cheap_buy_base<T0, T1>(arg3, arg1, v12, arg7, arg8, arg9, arg10);
            let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v14);
            assert!(0x2::balance::value<T0>(&v15) >= v16 + b_to_a_units(arg6, v0), 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::split<T0>(&mut v15, v16), 0x2::balance::zero<T1>(), v14);
            payout<T0>(v15, arg10);
            a_to_b_units(0x2::balance::value<T0>(&v15), v0)
        };
        let v17 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            pair_bluefin : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3),
            buy_on_cetus : v5,
            spread_bps   : v3,
            size_b       : arg4,
            profit_b     : v6,
        };
        0x2::event::emit<FiredFlash>(v17);
        v6
    }

    public fun run_cetus_deepbook_flash_flip_bm<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg4 == 0) {
            return 0
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2);
        let v1 = cetus_price_in_db_frame_flip(v0);
        let v2 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T1, T0>(arg3, arg7) as u128);
        let v3 = price_spread_bps(v1, v2);
        if (v3 < arg5 || v2 == 0) {
            return 0
        };
        let v4 = v1 < v2;
        let v5 = if (v4) {
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, false, arg4, 4295048017, arg7);
            let v9 = v8;
            0x2::balance::destroy_zero<T0>(v6);
            let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9);
            let v11 = dbm_sell_base<T1, T0>(arg3, arg1, v7, v10, arg7, arg8);
            assert!(0x2::balance::value<T0>(&v11) >= v10 + b_to_a_units(arg6, v0), 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::split<T0>(&mut v11, v10), 0x2::balance::zero<T1>(), v9);
            payout<T0>(v11, arg8);
            a_to_b_units(0x2::balance::value<T0>(&v11), v0)
        } else {
            let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, arg4, 79226673515401279992447579054, arg7);
            0x2::balance::destroy_zero<T1>(v13);
            let v15 = dbm_buy_base<T1, T0>(arg3, arg1, v12, arg7, arg8);
            assert!(0x2::balance::value<T1>(&v15) >= arg4 + arg6, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v15, arg4), v14);
            payout<T1>(v15, arg8);
            0x2::balance::value<T1>(&v15)
        };
        let v16 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            pair_bluefin : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>>(arg3),
            buy_on_cetus : v4,
            spread_bps   : v3,
            size_b       : arg4,
            profit_b     : v5,
        };
        0x2::event::emit<FiredFlash>(v16);
        v5
    }

    public fun run_cetus_deepbook_flash_flip_cheap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg4 == 0) {
            return 0
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2);
        let v1 = cetus_price_in_db_frame_flip(v0);
        let v2 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T1, T0>(arg3, arg9) as u128);
        let v3 = price_spread_bps(v1, v2);
        if (v3 < arg5 || v2 == 0) {
            return 0
        };
        let v4 = v1 < v2;
        let v5 = if (v4) {
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, false, arg4, 4295048017, arg9);
            let v9 = v8;
            0x2::balance::destroy_zero<T0>(v6);
            let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9);
            let v11 = entry_cheap_sell_base<T1, T0>(arg3, arg1, v7, arg7, arg8, arg9, arg10);
            assert!(0x2::balance::value<T0>(&v11) >= v10 + b_to_a_units(arg6, v0), 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::split<T0>(&mut v11, v10), 0x2::balance::zero<T1>(), v9);
            payout<T0>(v11, arg10);
            a_to_b_units(0x2::balance::value<T0>(&v11), v0)
        } else {
            let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, arg4, 79226673515401279992447579054, arg9);
            0x2::balance::destroy_zero<T1>(v13);
            let v15 = entry_cheap_buy_base<T1, T0>(arg3, arg1, v12, arg7, arg8, arg9, arg10);
            assert!(0x2::balance::value<T1>(&v15) >= arg4 + arg6, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v15, arg4), v14);
            payout<T1>(v15, arg10);
            0x2::balance::value<T1>(&v15)
        };
        let v16 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            pair_bluefin : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>>(arg3),
            buy_on_cetus : v4,
            spread_bps   : v3,
            size_b       : arg4,
            profit_b     : v5,
        };
        0x2::event::emit<FiredFlash>(v16);
        v5
    }

    public fun run_deepbook_pqf_flash_bm<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg5: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg6: bool, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg7 == 0) {
            return 0
        };
        if (!pqf_side_fresh<T0, T1>(arg5, arg6, arg9)) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg7, arg10);
        let v2 = if (arg6) {
            let v3 = dbm_buy_base<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T1>(v0), arg9, arg10);
            pqf_sell_base<T0, T1>(arg2, arg3, arg4, arg5, v3, arg9, arg10)
        } else {
            let v4 = pqf_buy_base<T0, T1>(arg2, arg3, arg4, arg5, 0x2::coin::into_balance<T1>(v0), arg9, arg10);
            dbm_sell_base<T0, T1>(arg0, arg1, v4, arg7, arg9, arg10)
        };
        let v5 = v2;
        assert!(0x2::balance::value<T1>(&v5) >= arg7 + arg8, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v5, arg7), arg10), v1);
        let v6 = 0x2::balance::value<T1>(&v5);
        payout<T1>(v5, arg10);
        let v7 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            pair_bluefin : 0x2::object::id_address<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>>(arg5),
            buy_on_cetus : arg6,
            spread_bps   : 0,
            size_b       : arg7,
            profit_b     : v6,
        };
        0x2::event::emit<FiredFlash>(v7);
        v6
    }

    public fun run_deepbook_pqf_flash_env_bm<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg5: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg6: bool, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: vector<u8>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : u64 {
        pqf1_push<T0, T1>(arg2, arg3, arg4, arg5, arg9, arg10, arg11, arg12);
        run_deepbook_pqf_flash_bm<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11, arg12)
    }

    public fun run_turbos_deepbook_flash_bm<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg5 == 0) {
            return 0
        };
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0);
        let v1 = (((v0 as u256) * (v0 as u256) * 1000000000 >> 128) as u128);
        let v2 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg3, arg8) as u128);
        let v3 = price_spread_bps(v1, v2);
        if (v3 < arg6 || v2 == 0) {
            return 0
        };
        if (v1 < v2 != arg4 && v3 > 100) {
            return 0
        };
        let v4 = if (arg4) {
            let (v5, v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, false, (arg5 as u128), true, 79226673515401279992447579054, arg8, arg2, arg9);
            0x2::coin::destroy_zero<T1>(v6);
            let v8 = dbm_sell_base<T0, T1>(arg3, arg1, 0x2::coin::into_balance<T0>(v5), arg5, arg8, arg9);
            assert!(0x2::balance::value<T1>(&v8) >= arg5 + arg7, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg9), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v8, arg5), arg9), v7, arg2);
            payout<T1>(v8, arg9);
            0x2::balance::value<T1>(&v8)
        } else {
            let (v9, v10, v11) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, true, (arg5 as u128), true, 4295048017, arg8, arg2, arg9);
            0x2::coin::destroy_zero<T0>(v9);
            let v12 = dbm_buy_base<T0, T1>(arg3, arg1, 0x2::coin::into_balance<T1>(v10), arg8, arg9);
            assert!(0x2::balance::value<T0>(&v12) >= arg5 + arg7, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v12, arg5), arg9), 0x2::coin::zero<T1>(arg9), v11, arg2);
            payout<T0>(v12, arg9);
            0x2::balance::value<T0>(&v12)
        };
        let v13 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
            pair_bluefin : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3),
            buy_on_cetus : arg4,
            spread_bps   : v3,
            size_b       : arg5,
            profit_b     : v4,
        };
        0x2::event::emit<FiredFlash>(v13);
        v4
    }

    public fun run_turbos_deepbook_flash_cheap<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg5 == 0) {
            return 0
        };
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0);
        let v1 = (((v0 as u256) * (v0 as u256) * 1000000000 >> 128) as u128);
        let v2 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg3, arg10) as u128);
        let v3 = price_spread_bps(v1, v2);
        if (v3 < arg6 || v2 == 0) {
            return 0
        };
        if (v1 < v2 != arg4 && v3 > 100) {
            return 0
        };
        let v4 = if (arg4) {
            let (v5, v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, false, (arg5 as u128), true, 79226673515401279992447579054, arg10, arg2, arg11);
            0x2::coin::destroy_zero<T1>(v6);
            let v8 = entry_cheap_sell_base<T0, T1>(arg3, arg1, 0x2::coin::into_balance<T0>(v5), arg8, arg9, arg10, arg11);
            assert!(0x2::balance::value<T1>(&v8) >= arg5 + arg7, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg11), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v8, arg5), arg11), v7, arg2);
            payout<T1>(v8, arg11);
            0x2::balance::value<T1>(&v8)
        } else {
            let (v9, v10, v11) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, true, (arg5 as u128), true, 4295048017, arg10, arg2, arg11);
            0x2::coin::destroy_zero<T0>(v9);
            let v12 = entry_cheap_buy_base<T0, T1>(arg3, arg1, 0x2::coin::into_balance<T1>(v10), arg8, arg9, arg10, arg11);
            assert!(0x2::balance::value<T0>(&v12) >= arg5 + arg7, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v12, arg5), arg11), 0x2::coin::zero<T1>(arg11), v11, arg2);
            payout<T0>(v12, arg11);
            0x2::balance::value<T0>(&v12)
        };
        let v13 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
            pair_bluefin : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3),
            buy_on_cetus : arg4,
            spread_bps   : v3,
            size_b       : arg5,
            profit_b     : v4,
        };
        0x2::event::emit<FiredFlash>(v13);
        v4
    }

    fun staked_tier<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo, arg3: u64) : bool {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account<T0, T1>(arg0, arg1);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(arg2);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::account::total_volume(&v0);
        let v3 = if (v2 > (v1 as u128)) {
            v2 - (v1 as u128)
        } else {
            0
        };
        let v4 = if (v1 > 0) {
            div(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::cumulative_quote_quantity(arg2), v1)
        } else {
            0
        };
        let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_deep_price(arg2);
        let v6 = if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::asset_is_base(&v5)) {
            mul128(v3, (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::deep_per_asset(&v5) as u128))
        } else {
            mul128(mul128(v3, (v4 as u128)), (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::deep_per_asset(&v5) as u128))
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::account::active_stake(&v0) >= arg3 && v6 >= (arg3 as u128)
    }

    // decompiled from Move bytecode v7
}

