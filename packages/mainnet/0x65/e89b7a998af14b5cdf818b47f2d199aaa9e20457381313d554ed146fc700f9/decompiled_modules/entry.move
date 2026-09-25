module 0x65e89b7a998af14b5cdf818b47f2d199aaa9e20457381313d554ed146fc700f9::entry {
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

    struct FiredTri has copy, drop {
        pool_1: address,
        pool_2: address,
        pool_3: address,
        forward: bool,
        size_s: u64,
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

    fun bolt_buy_base<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = &mut arg2;
        if (0x2::balance::value<T1>(&arg2) == 0) {
            0x2::balance::destroy_zero<T1>(arg2);
            return (0x2::balance::zero<T0>(), split_over_cap<T1>(v0, bolt_buy_cap<T0, T1>(arg0, arg1, arg3)))
        };
        let (v1, v2) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_buy<T0, T1>(arg0, arg1, arg3, arg2, 0x1::option::none<u64>(), arg4);
        0x2::balance::destroy_zero<T1>(v2);
        (v1, split_over_cap<T1>(v0, bolt_buy_cap<T0, T1>(arg0, arg1, arg3)))
    }

    fun bolt_buy_cap<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock) : u64 {
        let (v0, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_base_liquidity_inner<T0>(arg0);
        let (v2, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_price<T0, T1>(arg1, arg2);
        bolt_cap_units(v0, v2)
    }

    fun bolt_cap_units(arg0: u64, arg1: u128) : u64 {
        let v0 = (arg0 as u256) * 9950 * (arg1 as u256) / 10000 * (0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_precision() as u256);
        if (v0 > (18446744073709551615 as u256)) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    fun bolt_sell_base<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let v0 = &mut arg2;
        if (0x2::balance::value<T0>(&arg2) == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return (0x2::balance::zero<T1>(), split_over_cap<T0>(v0, bolt_sell_cap<T0, T1>(arg0, arg1, arg3)))
        };
        let (v1, v2) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_sell<T0, T1>(arg0, arg1, arg3, arg2, 0x1::option::none<u64>(), arg4);
        0x2::balance::destroy_zero<T0>(v1);
        (v2, split_over_cap<T0>(v0, bolt_sell_cap<T0, T1>(arg0, arg1, arg3)))
    }

    fun bolt_sell_cap<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock) : u64 {
        let (v0, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_price<T1, T0>(arg1, arg2);
        bolt_cap_units(0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_balance<T0, T1>(arg0), v0)
    }

    fun cetus_price_in_db_frame_flip(arg0: u128) : u128 {
        let v0 = (arg0 as u256) * (arg0 as u256);
        if (v0 == 0) {
            return 0
        };
        ((340282366920938463463374607431768211456000000000 / v0) as u128)
    }

    fun dbx_buy_base<T0, T1>(arg0: &mut 0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::Store, arg1: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury::Treasury, arg2: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::trade_id_tracker::TradeIdTracker, arg3: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::partner_manager::PartnerRegistry, arg4: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg6: 0x2::balance::Balance<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::coin::from_balance<T1>(arg6, arg8);
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, 0x2::coin::value<T1>(&v0));
        let v2 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::build<T1, T0>(arg1, arg2, arg3, v0, 18446744073709551615, 1000000, 18446744073709551615, v1, 0x1::option::none<0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::commission::Commission>(), arg4, arg8);
        let v3 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::start_routing<T1, T0, T0>(&mut v2, arg4, arg8);
        0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::swap_exact_y_to_x<T0, T1>(arg0, &mut v3, arg5, 0, arg7, arg8);
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::finish_routing<T1, T0, T1>(&mut v2, v3, arg4);
        0x2::coin::into_balance<T0>(0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::settle<T1, T0>(arg1, arg3, v2, arg4, arg7, arg8))
    }

    fun dbx_sell_base<T0, T1>(arg0: &mut 0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::Store, arg1: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury::Treasury, arg2: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::trade_id_tracker::TradeIdTracker, arg3: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::partner_manager::PartnerRegistry, arg4: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg6: 0x2::balance::Balance<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::coin::from_balance<T0>(arg6, arg8);
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, 0x2::coin::value<T0>(&v0));
        let v2 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::build<T0, T1>(arg1, arg2, arg3, v0, 18446744073709551615, 1000000, 18446744073709551615, v1, 0x1::option::none<0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::commission::Commission>(), arg4, arg8);
        let v3 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::start_routing<T0, T1, T1>(&mut v2, arg4, arg8);
        0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::swap_exact_x_to_y<T0, T1>(arg0, &mut v3, arg5, 0, arg7, arg8);
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::finish_routing<T0, T1, T0>(&mut v2, v3, arg4);
        0x2::coin::into_balance<T1>(0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::settle<T0, T1>(arg1, arg3, v2, arg4, arg7, arg8))
    }

    fun dbx_sell_base_into<T0, T1>(arg0: &mut 0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::Store, arg1: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury::Treasury, arg2: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::trade_id_tracker::TradeIdTracker, arg3: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::partner_manager::PartnerRegistry, arg4: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg6: 0x2::balance::Balance<T0>, arg7: &mut 0x2::balance::Balance<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg6) == 0) {
            0x2::balance::destroy_zero<T0>(arg6);
            return
        };
        0x2::balance::join<T1>(arg7, dbx_sell_base<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9));
    }

    fun join_leftover<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
        } else {
            0x2::balance::join<T0>(arg0, arg1);
        };
    }

    fun payout<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        };
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

    public fun run_bolt_deepbook_flash_flip_fx<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::Store, arg4: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury::Treasury, arg5: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::trade_id_tracker::TradeIdTracker, arg6: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::partner_manager::PartnerRegistry, arg7: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg8: bool, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg9 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg2, arg9, arg12);
        let v2 = if (arg8) {
            let (v3, v4) = bolt_sell_base<T1, T0>(arg0, arg1, 0x2::coin::into_balance<T1>(v0), arg11, arg12);
            let v5 = 0x2::balance::zero<T1>();
            let v6 = &mut v5;
            dbx_sell_base_into<T0, T1>(arg3, arg4, arg5, arg6, arg7, arg2, v3, v6, arg11, arg12);
            let v7 = &mut v5;
            join_leftover<T1>(v7, v4);
            v5
        } else {
            let v8 = dbx_buy_base<T0, T1>(arg3, arg4, arg5, arg6, arg7, arg2, 0x2::coin::into_balance<T1>(v0), arg11, arg12);
            let (v9, v10) = bolt_buy_base<T1, T0>(arg0, arg1, v8, arg11, arg12);
            let v11 = v9;
            let v12 = &mut v11;
            dbx_sell_base_into<T0, T1>(arg3, arg4, arg5, arg6, arg7, arg2, v10, v12, arg11, arg12);
            v11
        };
        let v13 = v2;
        assert!(0x2::balance::value<T1>(&v13) >= arg9 + arg10, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg2, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v13, arg9), arg12), v1);
        let v14 = 0x2::balance::value<T1>(&v13);
        payout<T1>(v13, arg12);
        let v15 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>>(arg0),
            pair_bluefin : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2),
            buy_on_cetus : arg8,
            spread_bps   : 0,
            size_b       : arg9,
            profit_b     : v14,
        };
        0x2::event::emit<FiredFlash>(v15);
        v14
    }

    public fun run_bolt_deepbook_flash_fx<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::Store, arg4: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury::Treasury, arg5: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::trade_id_tracker::TradeIdTracker, arg6: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::partner_manager::PartnerRegistry, arg7: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg8: bool, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg9 == 0) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg2, arg9, arg12);
        let v2 = if (arg8) {
            let (v3, v4) = bolt_buy_base<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T1>(v0), arg11, arg12);
            let v5 = 0x2::balance::zero<T1>();
            let v6 = &mut v5;
            dbx_sell_base_into<T0, T1>(arg3, arg4, arg5, arg6, arg7, arg2, v3, v6, arg11, arg12);
            let v7 = &mut v5;
            join_leftover<T1>(v7, v4);
            v5
        } else {
            let v8 = dbx_buy_base<T0, T1>(arg3, arg4, arg5, arg6, arg7, arg2, 0x2::coin::into_balance<T1>(v0), arg11, arg12);
            let (v9, v10) = bolt_sell_base<T0, T1>(arg0, arg1, v8, arg11, arg12);
            let v11 = v9;
            let v12 = &mut v11;
            dbx_sell_base_into<T0, T1>(arg3, arg4, arg5, arg6, arg7, arg2, v10, v12, arg11, arg12);
            v11
        };
        let v13 = v2;
        assert!(0x2::balance::value<T1>(&v13) >= arg9 + arg10, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg2, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v13, arg9), arg12), v1);
        let v14 = 0x2::balance::value<T1>(&v13);
        payout<T1>(v13, arg12);
        let v15 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg0),
            pair_bluefin : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2),
            buy_on_cetus : arg8,
            spread_bps   : 0,
            size_b       : arg9,
            profit_b     : v14,
        };
        0x2::event::emit<FiredFlash>(v15);
        v14
    }

    public fun run_cetus_deepbook_flash_flip_fx<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &mut 0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::Store, arg4: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury::Treasury, arg5: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::trade_id_tracker::TradeIdTracker, arg6: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::partner_manager::PartnerRegistry, arg7: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg8 == 0) {
            return 0
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = cetus_price_in_db_frame_flip(v0);
        let v2 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T1, T0>(arg2, arg11) as u128);
        let v3 = price_spread_bps(v1, v2);
        if (v3 < arg9 || v2 == 0) {
            return 0
        };
        let v4 = v1 < v2;
        let v5 = if (v4) {
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, arg8, 4295048017, arg11);
            let v9 = v8;
            0x2::balance::destroy_zero<T0>(v6);
            let v10 = dbx_sell_base<T1, T0>(arg3, arg4, arg5, arg6, arg7, arg2, v7, arg11, arg12);
            let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9);
            assert!(0x2::balance::value<T0>(&v10) >= v11 + b_to_a_units(arg10, v0), 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v10, v11), 0x2::balance::zero<T1>(), v9);
            payout<T0>(v10, arg12);
            a_to_b_units(0x2::balance::value<T0>(&v10), v0)
        } else {
            let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg8, 79226673515401279992447579054, arg11);
            0x2::balance::destroy_zero<T1>(v13);
            let v15 = dbx_buy_base<T1, T0>(arg3, arg4, arg5, arg6, arg7, arg2, v12, arg11, arg12);
            assert!(0x2::balance::value<T1>(&v15) >= arg8 + arg10, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v15, arg8), v14);
            payout<T1>(v15, arg12);
            0x2::balance::value<T1>(&v15)
        };
        let v16 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>>(arg2),
            buy_on_cetus : v4,
            spread_bps   : v3,
            size_b       : arg8,
            profit_b     : v5,
        };
        0x2::event::emit<FiredFlash>(v16);
        v5
    }

    public fun run_cetus_deepbook_flash_fx<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::Store, arg4: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury::Treasury, arg5: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::trade_id_tracker::TradeIdTracker, arg6: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::partner_manager::PartnerRegistry, arg7: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg8 == 0) {
            return 0
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = (((v0 as u256) * (v0 as u256) * 1000000000 >> 128) as u128);
        let v2 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg2, arg11) as u128);
        let v3 = price_spread_bps(v1, v2);
        let v4 = if (v3 < arg9) {
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
            let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg8, 79226673515401279992447579054, arg11);
            0x2::balance::destroy_zero<T1>(v8);
            let v10 = dbx_sell_base<T0, T1>(arg3, arg4, arg5, arg6, arg7, arg2, v7, arg11, arg12);
            assert!(0x2::balance::value<T1>(&v10) >= arg8 + arg10, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v10, arg8), v9);
            payout<T1>(v10, arg12);
            0x2::balance::value<T1>(&v10)
        } else {
            let (v11, v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, arg8, 4295048017, arg11);
            let v14 = v13;
            0x2::balance::destroy_zero<T0>(v11);
            let v15 = dbx_buy_base<T0, T1>(arg3, arg4, arg5, arg6, arg7, arg2, v12, arg11, arg12);
            let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v14);
            assert!(0x2::balance::value<T0>(&v15) >= v16 + b_to_a_units(arg10, v0), 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v15, v16), 0x2::balance::zero<T1>(), v14);
            payout<T0>(v15, arg12);
            a_to_b_units(0x2::balance::value<T0>(&v15), v0)
        };
        let v17 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2),
            buy_on_cetus : v5,
            spread_bps   : v3,
            size_b       : arg8,
            profit_b     : v6,
        };
        0x2::event::emit<FiredFlash>(v17);
        v6
    }

    public fun run_deepbook_pqf_flash_env_fx<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::Store, arg2: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury::Treasury, arg3: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::trade_id_tracker::TradeIdTracker, arg4: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::partner_manager::PartnerRegistry, arg5: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg6: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg7: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg8: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg9: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg10: bool, arg11: u64, arg12: u64, arg13: vector<u8>, arg14: vector<u8>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : u64 {
        pqf1_push<T0, T1>(arg6, arg7, arg8, arg9, arg13, arg14, arg15, arg16);
        run_deepbook_pqf_flash_fx<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg15, arg16)
    }

    public fun run_deepbook_pqf_flash_fx<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::Store, arg2: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury::Treasury, arg3: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::trade_id_tracker::TradeIdTracker, arg4: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::partner_manager::PartnerRegistry, arg5: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg6: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg7: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg8: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg9: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg10: bool, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg11 == 0) {
            return 0
        };
        if (!pqf_side_fresh<T0, T1>(arg9, arg10, arg13)) {
            return 0
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg11, arg14);
        let v2 = if (arg10) {
            let v3 = dbx_buy_base<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg0, 0x2::coin::into_balance<T1>(v0), arg13, arg14);
            pqf_sell_base<T0, T1>(arg6, arg7, arg8, arg9, v3, arg13, arg14)
        } else {
            let v4 = pqf_buy_base<T0, T1>(arg6, arg7, arg8, arg9, 0x2::coin::into_balance<T1>(v0), arg13, arg14);
            dbx_sell_base<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg0, v4, arg13, arg14)
        };
        let v5 = v2;
        assert!(0x2::balance::value<T1>(&v5) >= arg11 + arg12, 910);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v5, arg11), arg14), v1);
        let v6 = 0x2::balance::value<T1>(&v5);
        payout<T1>(v5, arg14);
        let v7 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            pair_bluefin : 0x2::object::id_address<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>>(arg9),
            buy_on_cetus : arg10,
            spread_bps   : 0,
            size_b       : arg11,
            profit_b     : v6,
        };
        0x2::event::emit<FiredFlash>(v7);
        v6
    }

    public fun run_turbos_deepbook_flash_fx<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::Store, arg4: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury::Treasury, arg5: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::trade_id_tracker::TradeIdTracker, arg6: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::partner_manager::PartnerRegistry, arg7: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg8: bool, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg9 == 0) {
            return 0
        };
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0);
        let v1 = (((v0 as u256) * (v0 as u256) * 1000000000 >> 128) as u128);
        let v2 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg2, arg12) as u128);
        let v3 = price_spread_bps(v1, v2);
        if (v3 < arg10 || v2 == 0) {
            return 0
        };
        if (v1 < v2 != arg8 && v3 > 100) {
            return 0
        };
        let v4 = if (arg8) {
            let (v5, v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, false, (arg9 as u128), true, 79226673515401279992447579054, arg12, arg1, arg13);
            0x2::coin::destroy_zero<T1>(v6);
            let v8 = dbx_sell_base<T0, T1>(arg3, arg4, arg5, arg6, arg7, arg2, 0x2::coin::into_balance<T0>(v5), arg12, arg13);
            assert!(0x2::balance::value<T1>(&v8) >= arg9 + arg11, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg13), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v8, arg9), arg13), v7, arg1);
            payout<T1>(v8, arg13);
            0x2::balance::value<T1>(&v8)
        } else {
            let (v9, v10, v11) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, true, (arg9 as u128), true, 4295048017, arg12, arg1, arg13);
            0x2::coin::destroy_zero<T0>(v9);
            let v12 = dbx_buy_base<T0, T1>(arg3, arg4, arg5, arg6, arg7, arg2, 0x2::coin::into_balance<T1>(v10), arg12, arg13);
            assert!(0x2::balance::value<T0>(&v12) >= arg9 + arg11, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v12, arg9), arg13), 0x2::coin::zero<T1>(arg13), v11, arg1);
            payout<T0>(v12, arg13);
            0x2::balance::value<T0>(&v12)
        };
        let v13 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
            pair_bluefin : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2),
            buy_on_cetus : arg8,
            spread_bps   : v3,
            size_b       : arg9,
            profit_b     : v4,
        };
        0x2::event::emit<FiredFlash>(v13);
        v4
    }

    fun split_over_cap<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T0>(arg0);
        if (v0 > arg1) {
            0x2::balance::split<T0>(arg0, v0 - arg1)
        } else {
            0x2::balance::zero<T0>()
        }
    }

    // decompiled from Move bytecode v7
}

