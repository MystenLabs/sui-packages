module 0xf5f7029970718c094119acdfc9cbc3b8c981a6cd2aa077ae30b68e85e1e870f::entry {
    struct Fired has copy, drop {
        pair_cetus: address,
        pair_bluefin: address,
        buy_on_cetus: bool,
        spread_bps: u64,
        size_b: u64,
        profit_b: u64,
    }

    struct FiredFlash has copy, drop {
        pair_cetus: address,
        pair_bluefin: address,
        buy_on_cetus: bool,
        spread_bps: u64,
        size_b: u64,
        profit_b: u64,
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

    fun bluefin_buy_second<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg3, arg0, arg1, arg2, 0x2::balance::zero<T1>(), true, true, 0x2::balance::value<T0>(&arg2), 0, 4295048017);
        0x2::balance::destroy_zero<T0>(v0);
        v1
    }

    fun bluefin_sell_a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg3, arg0, arg1, arg2, 0x2::balance::zero<T1>(), true, true, 0x2::balance::value<T0>(&arg2), 0, 4295048017);
        0x2::balance::destroy_zero<T0>(v0);
        v1
    }

    fun bluefin_sell_second<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg3, arg0, arg1, 0x2::balance::zero<T0>(), arg2, false, true, 0x2::balance::value<T1>(&arg2), 0, 79226673515401279992447579054);
        0x2::balance::destroy_zero<T1>(v1);
        v0
    }

    fun cetus_buy_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&arg2), 79226673515401279992447579054, arg3);
        let v3 = v2;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), arg2, v3);
        0x2::balance::destroy_zero<T1>(v1);
        v0
    }

    fun cetus_sell_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&arg2), 4295048017, arg3);
        let v3 = v2;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T1>(), v3);
        0x2::balance::destroy_zero<T0>(v0);
        v1
    }

    fun payout<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        };
    }

    fun pqf_buy_base<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::vector::empty<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>();
        0x1::vector::push_back<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>(&mut v0, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::new_quote_fill(x"0000000000000000000000000000000000000000000000000000000000000000", 0x2::balance::value<T1>(&arg4)));
        let (v1, v2) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::swap_exact_quote_for_base<T0, T1>(arg0, arg1, arg2, arg3, v0, arg4, x"0000000000000000000000000000000000000000000000000000000000000000", arg5, arg6);
        0x2::balance::destroy_zero<T1>(v2);
        v1
    }

    fun pqf_sell_base<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg4: 0x2::balance::Balance<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x1::vector::empty<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>();
        0x1::vector::push_back<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>(&mut v0, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::new_quote_fill(x"0000000000000000000000000000000000000000000000000000000000000000", 0x2::balance::value<T0>(&arg4)));
        let (v1, v2) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::swap_exact_base_for_quote<T0, T1>(arg0, arg1, arg2, arg3, v0, arg4, x"0000000000000000000000000000000000000000000000000000000000000000", arg5, arg6);
        0x2::balance::destroy_zero<T0>(v2);
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

    public fun run_cetus_bluefin<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0xf5f7029970718c094119acdfc9cbc3b8c981a6cd2aa077ae30b68e85e1e870f::vault::Vault<T1>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3);
        let v2 = spread_bps(v0, v1);
        let v3 = if (v2 < arg6) {
            true
        } else if (0xf5f7029970718c094119acdfc9cbc3b8c981a6cd2aa077ae30b68e85e1e870f::vault::value<T1>(arg4) < arg5) {
            true
        } else {
            arg5 == 0
        };
        if (v3) {
            return 0
        };
        let v4 = 0xf5f7029970718c094119acdfc9cbc3b8c981a6cd2aa077ae30b68e85e1e870f::vault::borrow_mut<T1>(arg4);
        let v5 = v0 < v1;
        let v6 = if (v5) {
            let v7 = cetus_buy_a<T0, T1>(arg0, arg1, 0x2::balance::split<T1>(v4, arg5), arg8);
            bluefin_sell_a<T0, T1>(arg2, arg3, v7, arg8)
        } else {
            let v8 = bluefin_buy_a<T0, T1>(arg2, arg3, 0x2::balance::split<T1>(v4, arg5), arg8);
            cetus_sell_a<T0, T1>(arg0, arg1, v8, arg8)
        };
        let v9 = v6;
        let v10 = 0x2::balance::value<T1>(&v9);
        assert!(v10 >= arg5 + arg7, 910);
        0x2::balance::join<T1>(v4, v9);
        let v11 = Fired{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3),
            buy_on_cetus : v5,
            spread_bps   : v2,
            size_b       : arg5,
            profit_b     : v10 - arg5,
        };
        0x2::event::emit<Fired>(v11);
        v10 - arg5
    }

    public fun run_cetus_bluefin_flash<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3);
        let v2 = spread_bps(v0, v1);
        if (v2 < arg5 || arg4 == 0) {
            return 0
        };
        let v3 = v0 < v1;
        let v4 = if (v3) {
            let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg4, 79226673515401279992447579054, arg7);
            0x2::balance::destroy_zero<T1>(v6);
            let v8 = bluefin_sell_a<T0, T1>(arg2, arg3, v5, arg7);
            assert!(0x2::balance::value<T1>(&v8) >= arg4 + arg6, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v8, arg4), v7);
            payout<T1>(v8, arg8);
            0x2::balance::value<T1>(&v8)
        } else {
            let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, arg4, 4295048017, arg7);
            let v12 = v11;
            0x2::balance::destroy_zero<T0>(v9);
            let v13 = bluefin_buy_a<T0, T1>(arg2, arg3, v10, arg7);
            let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v12);
            assert!(0x2::balance::value<T0>(&v13) >= v14 + b_to_a_units(arg6, v0), 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v13, v14), 0x2::balance::zero<T1>(), v12);
            payout<T0>(v13, arg8);
            a_to_b_units(0x2::balance::value<T0>(&v13), v0)
        };
        let v15 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3),
            buy_on_cetus : v3,
            spread_bps   : v2,
            size_b       : arg4,
            profit_b     : v4,
        };
        0x2::event::emit<FiredFlash>(v15);
        v4
    }

    public fun run_cetus_bluefin_flash_flip<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T0>(arg3);
        let v2 = if (v1 == 0) {
            0
        } else {
            ((340282366920938463463374607431768211456 / (v1 as u256)) as u128)
        };
        let v3 = spread_bps(v0, v2);
        if (v3 < arg5 || arg4 == 0) {
            return 0
        };
        let v4 = v0 < v2;
        let v5 = if (v4) {
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg4, 79226673515401279992447579054, arg7);
            0x2::balance::destroy_zero<T1>(v7);
            let v9 = bluefin_sell_second<T1, T0>(arg2, arg3, v6, arg7);
            assert!(0x2::balance::value<T1>(&v9) >= arg4 + arg6, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v9, arg4), v8);
            payout<T1>(v9, arg8);
            0x2::balance::value<T1>(&v9)
        } else {
            let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, arg4, 4295048017, arg7);
            let v13 = v12;
            0x2::balance::destroy_zero<T0>(v10);
            let v14 = bluefin_buy_second<T1, T0>(arg2, arg3, v11, arg7);
            let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v13);
            assert!(0x2::balance::value<T0>(&v14) >= v15 + b_to_a_units(arg6, v0), 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v14, v15), 0x2::balance::zero<T1>(), v13);
            payout<T0>(v14, arg8);
            a_to_b_units(0x2::balance::value<T0>(&v14), v0)
        };
        let v16 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg3),
            buy_on_cetus : v4,
            spread_bps   : v3,
            size_b       : arg4,
            profit_b     : v5,
        };
        0x2::event::emit<FiredFlash>(v16);
        v5
    }

    public fun run_cetus_bluefin_flip<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &mut 0xf5f7029970718c094119acdfc9cbc3b8c981a6cd2aa077ae30b68e85e1e870f::vault::Vault<T1>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T0>(arg3);
        let v2 = if (v1 == 0) {
            0
        } else {
            ((340282366920938463463374607431768211456 / (v1 as u256)) as u128)
        };
        let v3 = spread_bps(v0, v2);
        let v4 = if (v3 < arg6) {
            true
        } else if (0xf5f7029970718c094119acdfc9cbc3b8c981a6cd2aa077ae30b68e85e1e870f::vault::value<T1>(arg4) < arg5) {
            true
        } else {
            arg5 == 0
        };
        if (v4) {
            return 0
        };
        let v5 = 0xf5f7029970718c094119acdfc9cbc3b8c981a6cd2aa077ae30b68e85e1e870f::vault::borrow_mut<T1>(arg4);
        let v6 = v0 < v2;
        let v7 = if (v6) {
            let v8 = cetus_buy_a<T0, T1>(arg0, arg1, 0x2::balance::split<T1>(v5, arg5), arg8);
            bluefin_sell_second<T1, T0>(arg2, arg3, v8, arg8)
        } else {
            let v9 = bluefin_buy_second<T1, T0>(arg2, arg3, 0x2::balance::split<T1>(v5, arg5), arg8);
            cetus_sell_a<T0, T1>(arg0, arg1, v9, arg8)
        };
        let v10 = v7;
        let v11 = 0x2::balance::value<T1>(&v10);
        assert!(v11 >= arg5 + arg7, 910);
        0x2::balance::join<T1>(v5, v10);
        let v12 = Fired{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg3),
            buy_on_cetus : v6,
            spread_bps   : v3,
            size_b       : arg5,
            profit_b     : v11 - arg5,
        };
        0x2::event::emit<Fired>(v12);
        v11 - arg5
    }

    public fun run_cetus_pqf_flash<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg5: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T1, T0>, arg6: bool, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg7 == 0) {
            return 0
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = if (arg6) {
            if (!pqf_side_fresh<T1, T0>(arg5, false, arg9)) {
                return 0
            };
            let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg7, 79226673515401279992447579054, arg9);
            0x2::balance::destroy_zero<T1>(v3);
            let v5 = pqf_buy_base<T1, T0>(arg2, arg3, arg4, arg5, v2, arg9, arg10);
            assert!(0x2::balance::value<T1>(&v5) >= arg7 + arg8, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v5, arg7), v4);
            payout<T1>(v5, arg10);
            0x2::balance::value<T1>(&v5)
        } else {
            if (!pqf_side_fresh<T1, T0>(arg5, true, arg9)) {
                return 0
            };
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, arg7, 4295048017, arg9);
            let v9 = v8;
            0x2::balance::destroy_zero<T0>(v6);
            let v10 = pqf_sell_base<T1, T0>(arg2, arg3, arg4, arg5, v7, arg9, arg10);
            let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9);
            assert!(0x2::balance::value<T0>(&v10) >= v11 + b_to_a_units(arg8, v0), 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v10, v11), 0x2::balance::zero<T1>(), v9);
            payout<T0>(v10, arg10);
            a_to_b_units(0x2::balance::value<T0>(&v10), v0)
        };
        let v12 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T1, T0>>(arg5),
            buy_on_cetus : arg6,
            spread_bps   : 0,
            size_b       : arg7,
            profit_b     : v1,
        };
        0x2::event::emit<FiredFlash>(v12);
        v1
    }

    public fun run_cetus_turbos_flash_flip<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T1, T0, T2>(arg2);
        let v2 = if (v1 == 0) {
            0
        } else {
            ((340282366920938463463374607431768211456 / (v1 as u256)) as u128)
        };
        let v3 = spread_bps(v0, v2);
        if (v3 < arg5 || arg4 == 0) {
            return 0
        };
        let v4 = v0 < v2;
        let v5 = if (v4) {
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg4, 79226673515401279992447579054, arg7);
            0x2::balance::destroy_zero<T1>(v7);
            let v9 = turbos_sell_second<T1, T0, T2>(arg2, arg3, v6, arg7, arg8);
            assert!(0x2::balance::value<T1>(&v9) >= arg4 + arg6, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v9, arg4), v8);
            payout<T1>(v9, arg8);
            0x2::balance::value<T1>(&v9)
        } else {
            let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, arg4, 4295048017, arg7);
            let v13 = v12;
            0x2::balance::destroy_zero<T0>(v10);
            let v14 = turbos_buy_second<T1, T0, T2>(arg2, arg3, v11, arg7, arg8);
            let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v13);
            assert!(0x2::balance::value<T0>(&v14) >= v15 + b_to_a_units(arg6, v0), 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v14, v15), 0x2::balance::zero<T1>(), v13);
            payout<T0>(v14, arg8);
            a_to_b_units(0x2::balance::value<T0>(&v14), v0)
        };
        let v16 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>>(arg2),
            buy_on_cetus : v4,
            spread_bps   : v3,
            size_b       : arg4,
            profit_b     : v5,
        };
        0x2::event::emit<FiredFlash>(v16);
        v5
    }

    public fun run_turbos_pqf_flash<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg5: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg6: bool, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg7 == 0) {
            return 0
        };
        let v0 = if (arg6) {
            if (!pqf_side_fresh<T0, T1>(arg5, true, arg9)) {
                return 0
            };
            let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, false, (arg7 as u128), true, 79226673515401279992447579054, arg9, arg1, arg10);
            0x2::coin::destroy_zero<T1>(v2);
            let v4 = pqf_sell_base<T0, T1>(arg2, arg3, arg4, arg5, 0x2::coin::into_balance<T0>(v1), arg9, arg10);
            assert!(0x2::balance::value<T1>(&v4) >= arg7 + arg8, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg10), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v4, arg7), arg10), v3, arg1);
            payout<T1>(v4, arg10);
            0x2::balance::value<T1>(&v4)
        } else {
            if (!pqf_side_fresh<T0, T1>(arg5, false, arg9)) {
                return 0
            };
            let (v5, v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, true, (arg7 as u128), true, 4295048017, arg9, arg1, arg10);
            0x2::coin::destroy_zero<T0>(v5);
            let v8 = pqf_buy_base<T0, T1>(arg2, arg3, arg4, arg5, 0x2::coin::into_balance<T1>(v6), arg9, arg10);
            assert!(0x2::balance::value<T0>(&v8) >= arg7 + arg8, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v8, arg7), arg10), 0x2::coin::zero<T1>(arg10), v7, arg1);
            payout<T0>(v8, arg10);
            0x2::balance::value<T0>(&v8)
        };
        let v9 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
            pair_bluefin : 0x2::object::id_address<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>>(arg5),
            buy_on_cetus : arg6,
            spread_bps   : 0,
            size_b       : arg7,
            profit_b     : v0,
        };
        0x2::event::emit<FiredFlash>(v9);
        v0
    }

    fun spread_bps(arg0: u128, arg1: u128) : u64 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        let v1 = arg0 / 2 + arg1 / 2;
        if (v1 == 0) {
            return 0
        };
        ((v0 * 20000 / v1) as u64)
    }

    fun turbos_buy_second<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::coin::from_balance<T0>(arg2, arg4);
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, true, (0x2::coin::value<T0>(&v0) as u128), true, 4295048017, arg3, arg1, arg4);
        0x2::coin::destroy_zero<T0>(v1);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, v0, 0x2::coin::zero<T1>(arg4), v3, arg1);
        0x2::coin::into_balance<T1>(v2)
    }

    fun turbos_sell_second<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::coin::from_balance<T1>(arg2, arg4);
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, false, (0x2::coin::value<T1>(&v0) as u128), true, 79226673515401279992447579054, arg3, arg1, arg4);
        0x2::coin::destroy_zero<T1>(v2);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg4), v0, v3, arg1);
        0x2::coin::into_balance<T0>(v1)
    }

    // decompiled from Move bytecode v7
}

