module 0xe06475ba5e2e972f4256dc73080810cc86ac32e6f034826659e26e29986353c8::stonker {
    struct StonkerParameters has store {
        trigger_bps_times_1k: u64,
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
    }

    struct InputSignalEvent has copy, drop {
        estimated_valuation: u64,
        timestamp_ms: u64,
        signal_index: u64,
        is_buy_movement: bool,
        best_dex_bids: vector<u64>,
        best_dex_bid_quantities: vector<u64>,
        best_dex_asks: vector<u64>,
        best_dex_ask_quantities: vector<u64>,
        dex_spread: u64,
    }

    struct CouldNotTradeEvent has copy, drop {
        reason: 0x1::string::String,
    }

    struct ToppedUpDeepEvent has copy, drop {
        quantity_deep: u64,
    }

    fun check_sender(arg0: &Stonker, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 13906834522235731967);
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
            id                 : 0x2::object::new(arg0),
            admin              : 0x2::tx_context::sender(arg0),
            parameters         : default_stonker_parameters(),
            next_signal_index  : 0,
            last_trade_time_ms : 0,
        };
        0x2::transfer::share_object<Stonker>(v0);
    }

    fun default_stonker_parameters() : StonkerParameters {
        StonkerParameters{
            trigger_bps_times_1k     : 1000,
            single_base              : 1000000000,
            position_limit_quote     : 10000 * 1000000,
            minimum_order_size_base  : 2000000000,
            order_size_step_base     : 1000000000,
            allowed_to_buy           : true,
            minimum_sell_price_quote : 240 * 10000,
            maximum_buy_price_quote  : 390 * 10000,
            cooldown_ms              : 100,
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
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg0, arg1, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v6, true, false, arg4, arg5);
        let v7 = ToppedUpDeepEvent{quantity_deep: v6};
        0x2::event::emit<ToppedUpDeepEvent>(v7);
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

    public fun input_signal(arg0: &mut Stonker, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2::clock::Clock, arg5: u64, arg6: bool, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        check_sender(arg0, arg8);
        if (0x2::clock::timestamp_ms(arg4) >= arg7) {
            emit_could_not_trade_event(b"expired");
            return
        };
        let (v0, v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, 10, arg4);
        let v4 = v2;
        let v5 = v0;
        let v6 = *0x1::vector::borrow<u64>(&v5, 0);
        let v7 = *0x1::vector::borrow<u64>(&v4, 0);
        let v8 = arg5 * arg0.parameters.trigger_bps_times_1k / 1000 / 10000;
        let v9 = InputSignalEvent{
            estimated_valuation     : arg5,
            timestamp_ms            : 0x2::clock::timestamp_ms(arg4),
            signal_index            : arg0.next_signal_index,
            is_buy_movement         : arg6,
            best_dex_bids           : v5,
            best_dex_bid_quantities : v1,
            best_dex_asks           : v4,
            best_dex_ask_quantities : v3,
            dex_spread              : v7 - v6,
        };
        0x2::event::emit<InputSignalEvent>(v9);
        arg0.next_signal_index = arg0.next_signal_index + 1;
        if (arg6 && v7 + v8 < arg5) {
            let (v10, v11, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
            let v13 = (arg5 - v8) / v10 * v10;
            let v14 = convert_to_base_at_price(arg0, get_available_quote_balance(arg1), v13);
            let v15 = v14;
            let v16 = convert_to_base_at_price(arg0, arg0.parameters.position_limit_quote, v13);
            let v17 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg1);
            if (v17 >= v16) {
                v15 = 0;
            } else {
                let v18 = v16 - v17;
                if (v14 > v18) {
                    v15 = v18;
                };
            };
            let v19 = arg0.parameters.minimum_order_size_base + 1000000 * (arg5 - v7 - v8) / v7 * arg0.parameters.order_size_step_base / 100;
            let v20 = v19;
            if (v19 > v15) {
                v20 = v15;
            };
            let v21 = v20 / v11 * v11;
            if (v21 < 10 * arg0.parameters.single_base) {
                emit_could_not_trade_event(b"at_limit");
                return
            };
            if (v13 > arg0.parameters.maximum_buy_price_quote) {
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
            let v22 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg8);
            let (v23, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order_deep_required<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, v21, v13);
            ensure_deep_balance(arg1, &v22, arg3, v23, arg4, arg8);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v22, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v13, v21, true, true, 0x2::clock::timestamp_ms(arg4) + 1000, arg4, arg8);
            arg0.last_trade_time_ms = 0x2::clock::timestamp_ms(arg4);
            return
        };
        if (!arg6 && arg5 + v8 < v6) {
            let (v25, v26, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
            let v28 = (arg5 + v8 + v25 - 1) / v25 * v25;
            let v29 = arg0.parameters.minimum_order_size_base + 1000000 * (v6 - v8 - arg5) / v7 * arg0.parameters.order_size_step_base / 100;
            let v30 = v29;
            let v31 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg1);
            if (v29 > v31) {
                v30 = v31;
            };
            let v32 = v30 / v26 * v26;
            if (v32 < 10 * arg0.parameters.single_base) {
                emit_could_not_trade_event(b"at_limit");
                return
            };
            if (v28 < arg0.parameters.minimum_sell_price_quote) {
                emit_could_not_trade_event(b"price_limit");
                return
            };
            if (0x2::clock::timestamp_ms(arg4) < arg0.last_trade_time_ms + arg0.parameters.cooldown_ms) {
                emit_could_not_trade_event(b"within_cooldown");
                return
            };
            let v33 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg8);
            let (v34, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order_deep_required<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, v32, v28);
            ensure_deep_balance(arg1, &v33, arg3, v34, arg4, arg8);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v33, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v28, v32, false, true, 0x2::clock::timestamp_ms(arg4) + 1000, arg4, arg8);
            arg0.last_trade_time_ms = 0x2::clock::timestamp_ms(arg4);
            return
        };
    }

    public fun make_limit_sell(arg0: &Stonker, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_sender(arg0, arg6);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v0, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg4, arg3, false, false, 0x2::clock::timestamp_ms(arg5) + 1000, arg5, arg6);
    }

    public fun set_allowed_to_buy(arg0: &mut Stonker, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.parameters.allowed_to_buy = arg1;
    }

    public fun set_cooldown_ms(arg0: &mut Stonker, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.parameters.cooldown_ms = arg1;
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

    public fun withdraw_base_asset(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun withdraw_quote_asset(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

