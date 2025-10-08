module 0xd17f8c3b239b32cfd6f38a95903aff679f4dfa0caa97656e059838fd9a9e0d9::stonker {
    struct StonkerParameters has store {
        trigger_bps_times_1k: u64,
        maker_shallow_place_bps_times_1k: u64,
        maker_deep_place_bps_times_1k: u64,
        maker_order_ttl_ms: u64,
        maker_max_shallow_quantity_base: u64,
        maker_max_deep_quantity_base: u64,
        maker_trades_enabled: bool,
        single_base: u64,
        position_limit_quote: u64,
        minimum_order_size_base: u64,
        order_size_step_base: u64,
        allowed_to_buy: bool,
        minimum_sell_price_quote: u64,
        maximum_buy_price_quote: u64,
        cooldown_ms: u64,
    }

    struct Stonker has store, key {
        id: 0x2::object::UID,
        admin: address,
        parameters: StonkerParameters,
        next_signal_index: u64,
        last_trade_time_ms: u64,
        last_input_signal_nonce: u64,
    }

    struct InputSignalEvent has copy, drop {
        estimated_valuation: u64,
        timestamp_ms: u64,
        signal_index: u64,
        input_signal_status: u8,
        best_dex_bids: vector<u64>,
        best_dex_bid_quantities: vector<u64>,
        best_dex_asks: vector<u64>,
        best_dex_ask_quantities: vector<u64>,
        dex_spread: u64,
        input_signal_nonce: u64,
    }

    struct CouldNotTradeEvent has copy, drop {
        reason: 0x1::string::String,
    }

    struct ToppedUpDeepEvent has copy, drop {
        quantity_deep: u64,
        quantity_usdc: u64,
    }

    fun adjust_maker_orders(arg0: &mut Stonker, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        if (!arg0.parameters.maker_trades_enabled) {
            return
        };
        let v0 = arg4 / 10000;
        let v1 = v0 * arg0.parameters.maker_shallow_place_bps_times_1k / 1000;
        let v2 = v1 / 4;
        let v3 = v0 * arg0.parameters.maker_deep_place_bps_times_1k / 1000;
        let v4 = v3 / 4;
        let v5 = 0x2::vec_set::into_keys<u128>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1));
        if (0x1::vector::length<u128>(&v5) > 4) {
            let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v6, arg3, arg5);
            v5 = 0x2::vec_set::into_keys<u128>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1));
        };
        let v7 = &mut v5;
        sort_vector(v7);
        let v8 = 0;
        let v9 = 0;
        let v10 = v9;
        let v11 = 0;
        let v12 = v11;
        let v13 = 0;
        let v14 = 0;
        while (v14 < 0x1::vector::length<u128>(&v5)) {
            let v15 = *0x1::vector::borrow<u128>(&v5, v14);
            v14 = v14 + 1;
            assert!(v15 != 0, 13906837344029245439);
            if (order_is_bid(v15)) {
                if (v11 == 0) {
                    v12 = v15;
                    continue
                };
                v8 = v15;
                continue
            };
            if (v9 == 0) {
                v10 = v15;
                continue
            };
            v13 = v15;
        };
        ensure_maker_order_is_correct(arg0, arg1, arg2, v8, arg4 - v1, v2, true, arg0.parameters.maker_max_shallow_quantity_base, arg3, arg5);
        ensure_maker_order_is_correct(arg0, arg1, arg2, v10, arg4 + v1, v2, false, arg0.parameters.maker_max_shallow_quantity_base, arg3, arg5);
        ensure_maker_order_is_correct(arg0, arg1, arg2, v12, arg4 - v3, v4, true, arg0.parameters.maker_max_deep_quantity_base, arg3, arg5);
        ensure_maker_order_is_correct(arg0, arg1, arg2, v13, arg4 + v3, v4, false, arg0.parameters.maker_max_deep_quantity_base, arg3, arg5);
    }

    fun check_sender(arg0: &Stonker, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 13906834612430045183);
    }

    fun convert_to_base_at_price(arg0: &Stonker, arg1: u64, arg2: u64) : u64 {
        (((arg1 as u128) * (arg0.parameters.single_base as u128) / (arg2 as u128)) as u64)
    }

    fun convert_to_quote_at_price(arg0: &Stonker, arg1: u64, arg2: u64) : u64 {
        (((arg1 as u128) * (arg2 as u128) / (arg0.parameters.single_base as u128)) as u64)
    }

    public fun create_balance_manager(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg0));
    }

    public fun create_stonker(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Stonker{
            id                      : 0x2::object::new(arg0),
            admin                   : 0x2::tx_context::sender(arg0),
            parameters              : default_stonker_parameters(),
            next_signal_index       : 0,
            last_trade_time_ms      : 0,
            last_input_signal_nonce : 0,
        };
        0x2::transfer::share_object<Stonker>(v0);
    }

    fun decode_order_id(arg0: u128) : (bool, u64, u64) {
        (arg0 >> 127 == 0, ((arg0 >> 64) as u64) & 9223372036854775807, ((arg0 & 18446744073709551615) as u64))
    }

    fun default_stonker_parameters() : StonkerParameters {
        let v0 = 1000000000;
        StonkerParameters{
            trigger_bps_times_1k             : 1000,
            maker_shallow_place_bps_times_1k : 4000,
            maker_deep_place_bps_times_1k    : 15000,
            maker_order_ttl_ms               : 60000,
            maker_max_shallow_quantity_base  : 1 * v0,
            maker_max_deep_quantity_base     : 2 * v0,
            maker_trades_enabled             : true,
            single_base                      : v0,
            position_limit_quote             : 15000 * 1000000,
            minimum_order_size_base          : 1 * v0,
            order_size_step_base             : 1 * v0,
            allowed_to_buy                   : true,
            minimum_sell_price_quote         : 240 * 10000,
            maximum_buy_price_quote          : 390 * 10000,
            cooldown_ms                      : 1,
        }
    }

    public fun deposit_base_asset(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg0, 0x2::coin::split<0x2::sui::SUI>(arg1, arg2, arg3), arg3);
    }

    public fun deposit_quote_asset(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, 0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, arg3), arg3);
    }

    fun emit_could_not_trade_event(arg0: vector<u8>) {
        let v0 = CouldNotTradeEvent{reason: 0x1::string::utf8(arg0)};
        0x2::event::emit<CouldNotTradeEvent>(v0);
    }

    fun ensure_deep_balance(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0);
        if (v0 >= arg3) {
            return
        };
        let v1 = (arg3 - v0) * 2;
        let v2 = v1;
        if (v1 < 10 * 1000000) {
            v2 = 10 * 1000000;
        };
        let (_, v4, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
        let v6 = v2 / v4 * v4;
        let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg0, arg1, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v6, true, false, arg4, arg5);
        let v8 = ToppedUpDeepEvent{
            quantity_deep : v6,
            quantity_usdc : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::cumulative_quote_quantity(&v7),
        };
        0x2::event::emit<ToppedUpDeepEvent>(v8);
    }

    fun ensure_maker_order_is_correct(arg0: &Stonker, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: u128, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        let v0 = order_price(arg3);
        let v1 = if (arg3 != 0) {
            if (v0 >= arg4 - arg5) {
                v0 <= arg4 + arg5
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            return
        };
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg9);
        if (arg3 != 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v2, arg3, arg8, arg9);
        };
        if (arg6) {
            let v3 = arg7;
            let v4 = convert_to_base_at_price(arg0, get_available_quote_balance(arg1), arg4);
            if (arg7 > v4) {
                v3 = v4;
            };
            let (v5, v6, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v2, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), arg4 / v5 * v5, v3 / v6 * v6, true, false, 0x2::clock::timestamp_ms(arg8) + arg0.parameters.maker_order_ttl_ms, arg8, arg9);
        } else {
            let v8 = arg7;
            let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg1);
            if (arg7 > v9) {
                v8 = v9;
            };
            let (v10, v11, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v2, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), (arg4 + v10 - 1) / v10 * v10, v8 / v11 * v11, true, false, 0x2::clock::timestamp_ms(arg8) + arg0.parameters.maker_order_ttl_ms, arg8, arg9);
        };
    }

    public fun get_asset_balances(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) : (u64, u64) {
        let (v0, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::locked_balance<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg0);
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg0) + v0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0) + v1)
    }

    fun get_available_quote_balance(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) : u64 {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0);
        if (v0 < 500 * 1000000) {
            0
        } else {
            v0 - 500 * 1000000
        }
    }

    public fun get_best_prices(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, _, v2, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, 1, arg1);
        let v4 = v2;
        let v5 = v0;
        (*0x1::vector::borrow<u64>(&v5, 0), *0x1::vector::borrow<u64>(&v4, 0), 0x2::clock::timestamp_ms(arg1))
    }

    public fun get_best_prices_and_qtys(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &0x2::clock::Clock) : (u64, u64, u64, u64, u64) {
        let (v0, v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, 1, arg1);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = v0;
        (*0x1::vector::borrow<u64>(&v7, 0), *0x1::vector::borrow<u64>(&v5, 0), *0x1::vector::borrow<u64>(&v6, 0), *0x1::vector::borrow<u64>(&v4, 0), 0x2::clock::timestamp_ms(arg1))
    }

    public fun get_pool_fees(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) : (u64, u64) {
        let (v0, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0);
        (v0, v1)
    }

    public fun input_signal(arg0: &mut Stonker, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg9);
        if (0x2::clock::timestamp_ms(arg4) >= arg8) {
            emit_could_not_trade_event(b"expired");
            return
        };
        if (arg7 <= arg0.last_input_signal_nonce) {
            emit_could_not_trade_event(b"previous_nonce");
            return
        };
        arg0.last_input_signal_nonce = arg7;
        let (v0, v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, 10, arg4);
        let v4 = v2;
        let v5 = v0;
        let v6 = *0x1::vector::borrow<u64>(&v5, 0);
        let v7 = *0x1::vector::borrow<u64>(&v4, 0);
        let v8 = InputSignalEvent{
            estimated_valuation     : arg5,
            timestamp_ms            : 0x2::clock::timestamp_ms(arg4),
            signal_index            : arg0.next_signal_index,
            input_signal_status     : arg6,
            best_dex_bids           : v5,
            best_dex_bid_quantities : v1,
            best_dex_asks           : v4,
            best_dex_ask_quantities : v3,
            dex_spread              : v7 - v6,
            input_signal_nonce      : arg7,
        };
        0x2::event::emit<InputSignalEvent>(v8);
        arg0.next_signal_index = arg0.next_signal_index + 1;
        if (arg6 == 0 || arg6 == 1) {
            try_make_taker_trade(arg0, arg1, arg2, arg3, arg4, arg5, arg6 == 0, v6, v7, arg9);
        };
        adjust_maker_orders(arg0, arg1, arg2, arg4, arg5, arg9);
    }

    public fun make_limit_sell(arg0: &Stonker, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_sender(arg0, arg6);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v0, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg4, arg3, false, false, 0x2::clock::timestamp_ms(arg5) + 1000, arg5, arg6);
    }

    fun order_is_bid(arg0: u128) : bool {
        let (v0, _, _) = decode_order_id(arg0);
        v0
    }

    fun order_price(arg0: u128) : u64 {
        let (_, v1, _) = decode_order_id(arg0);
        v1
    }

    public fun set_allowed_to_buy(arg0: &mut Stonker, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.parameters.allowed_to_buy = arg1;
    }

    public fun set_cooldown_ms(arg0: &mut Stonker, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.parameters.cooldown_ms = arg1;
    }

    public fun set_maker_trades_enabled(arg0: &mut Stonker, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg5);
        arg0.parameters.maker_trades_enabled = arg3;
        if (!arg3) {
            let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v0, arg4, arg5);
        };
    }

    public fun set_maximum_buy_price_quote(arg0: &mut Stonker, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.parameters.maximum_buy_price_quote = arg1;
    }

    public fun set_minimum_order_size_base(arg0: &mut Stonker, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.parameters.minimum_order_size_base = arg1;
    }

    public fun set_minimum_sell_price_quote(arg0: &mut Stonker, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.parameters.minimum_sell_price_quote = arg1;
    }

    public fun set_order_size_step_base(arg0: &mut Stonker, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.parameters.order_size_step_base = arg1;
    }

    public fun set_position_limit_quote(arg0: &mut Stonker, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.parameters.position_limit_quote = arg1;
    }

    public fun set_trigger_bps_times_1k(arg0: &mut Stonker, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.parameters.trigger_bps_times_1k = arg1;
    }

    fun should_repeat_order(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo) : bool {
        false
    }

    fun sort_vector(arg0: &mut vector<u128>) {
        let v0 = 0x1::vector::length<u128>(arg0);
        if (v0 <= 1) {
            return
        };
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0;
            let v3 = false;
            while (v2 < v0 - v1 - 1) {
                let v4 = 0x1::vector::borrow<u128>(arg0, v2);
                let v5 = 0x1::vector::borrow<u128>(arg0, v2 + 1);
                if (*v4 > *v5) {
                    *0x1::vector::borrow_mut<u128>(arg0, v2) = *v5;
                    *0x1::vector::borrow_mut<u128>(arg0, v2 + 1) = *v4;
                    v3 = true;
                };
                v2 = v2 + 1;
            };
            if (!v3) {
                break
            };
            v1 = v1 + 1;
        };
    }

    fun try_make_taker_trade(arg0: &mut Stonker, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2::clock::Clock, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: &0x2::tx_context::TxContext) {
        let v0 = arg5 * arg0.parameters.trigger_bps_times_1k / 1000 / 10000;
        if (arg6 && arg8 + v0 < arg5) {
            let (v1, v2, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
            let v4 = (arg5 - v0) / v1 * v1;
            let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg9);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v5, arg4, arg9);
            let v6 = convert_to_base_at_price(arg0, get_available_quote_balance(arg1), v4);
            let v7 = v6;
            let v8 = convert_to_base_at_price(arg0, arg0.parameters.position_limit_quote, v4);
            let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg1);
            if (v9 >= v8) {
                v7 = 0;
            } else {
                let v10 = v8 - v9;
                if (v6 > v10) {
                    v7 = v10;
                };
            };
            let v11 = arg0.parameters.minimum_order_size_base + 1000000 * (arg5 - arg8 - v0) / arg8 * arg0.parameters.order_size_step_base / 100;
            let v12 = v11;
            if (v11 > v7) {
                v12 = v7;
            };
            let v13 = v12 / v2 * v2;
            if (v13 < arg0.parameters.minimum_order_size_base) {
                emit_could_not_trade_event(b"at_limit");
                return
            };
            if (v4 > arg0.parameters.maximum_buy_price_quote) {
                emit_could_not_trade_event(b"price_limit");
                return
            };
            if (0x2::clock::timestamp_ms(arg4) < arg0.last_trade_time_ms + arg0.parameters.cooldown_ms) {
                emit_could_not_trade_event(b"within_cooldown");
                return
            };
            if (!arg0.parameters.allowed_to_buy) {
                emit_could_not_trade_event(b"not_allowed");
                return
            };
            let (v14, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order_deep_required<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, v13, v4);
            ensure_deep_balance(arg1, &v5, arg3, v14 * 2, arg4, arg9);
            let v16 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v5, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v4, v13, true, true, 0x2::clock::timestamp_ms(arg4) + 1000, arg4, arg9);
            if (should_repeat_order(&v16)) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v5, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v4, v13, true, true, 0x2::clock::timestamp_ms(arg4) + 1000, arg4, arg9);
            };
            arg0.last_trade_time_ms = 0x2::clock::timestamp_ms(arg4);
            return
        };
        if (!arg6 && arg5 + v0 < arg7) {
            let (v17, v18, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
            let v20 = (arg5 + v0 + v17 - 1) / v17 * v17;
            let v21 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg9);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v21, arg4, arg9);
            let v22 = arg0.parameters.minimum_order_size_base + 1000000 * (arg7 - v0 - arg5) / arg8 * arg0.parameters.order_size_step_base / 100;
            let v23 = v22;
            let v24 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg1);
            if (v22 > v24) {
                v23 = v24;
            };
            let v25 = v23 / v18 * v18;
            if (v25 < arg0.parameters.minimum_order_size_base) {
                emit_could_not_trade_event(b"at_limit");
                return
            };
            if (v20 < arg0.parameters.minimum_sell_price_quote) {
                emit_could_not_trade_event(b"price_limit");
                return
            };
            if (0x2::clock::timestamp_ms(arg4) < arg0.last_trade_time_ms + arg0.parameters.cooldown_ms) {
                emit_could_not_trade_event(b"within_cooldown");
                return
            };
            let (v26, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order_deep_required<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, v25, v20);
            ensure_deep_balance(arg1, &v21, arg3, v26, arg4, arg9);
            let v28 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v21, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v20, v25, false, true, 0x2::clock::timestamp_ms(arg4) + 1000, arg4, arg9);
            if (should_repeat_order(&v28)) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v21, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v20, v25, false, true, 0x2::clock::timestamp_ms(arg4) + 1000, arg4, arg9);
            };
            arg0.last_trade_time_ms = 0x2::clock::timestamp_ms(arg4);
            return
        };
    }

    public fun withdraw_base_asset(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun withdraw_quote_asset(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

