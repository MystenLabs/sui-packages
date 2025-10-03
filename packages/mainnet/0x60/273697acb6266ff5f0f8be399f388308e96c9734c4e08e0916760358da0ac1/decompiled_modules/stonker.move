module 0x60273697acb6266ff5f0f8be399f388308e96c9734c4e08e0916760358da0ac1::stonker {
    struct StonkerParameters has store {
        trigger_bps_times_1k: u64,
        order_size_base: u64,
        single_base: u64,
    }

    struct Stonker has store, key {
        id: 0x2::object::UID,
        admin: address,
        parameters: StonkerParameters,
        next_signal_index: u64,
        current_quantised_valuation: u64,
        current_quantised_valuation_index: u64,
        ordered_delta_indices: vector<u8>,
        last_received_delta_index_timestamp_ms: u64,
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
        from_delta: bool,
    }

    struct OutOfBalanceEvent has copy, drop {
        is_buy: bool,
        balance_required: u64,
        balance: u64,
    }

    struct PositionLimitEvent has copy, drop {
        order_quantity_quote: u64,
        balance_quote: u64,
    }

    struct PriceLimitEvent has copy, drop {
        is_buy: bool,
        price: u64,
    }

    struct WithinCooldownEvent has copy, drop {
        is_buy: bool,
        price: u64,
    }

    fun abs_diff(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    fun check_sender(arg0: &Stonker, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 13906835033336840191);
    }

    fun convert_to_quote_at_price(arg0: &Stonker, arg1: u64, arg2: u64) : u64 {
        (((arg1 as u128) * (arg2 as u128) / (arg0.parameters.single_base as u128)) as u64)
    }

    public fun create_balance_manager(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg0));
    }

    public fun create_local_deepbook_pool(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::registry::Registry, arg1: &mut 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::create_permissionless_pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, 1000, 1000, 1000, 0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::pool_creation_fee(), arg2), arg2);
    }

    public fun create_stonker(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = StonkerParameters{
            trigger_bps_times_1k : arg0,
            order_size_base      : arg1,
            single_base          : arg2,
        };
        let v1 = Stonker{
            id                                     : 0x2::object::new(arg3),
            admin                                  : 0x2::tx_context::sender(arg3),
            parameters                             : v0,
            next_signal_index                      : 0,
            current_quantised_valuation            : 0,
            current_quantised_valuation_index      : 1,
            ordered_delta_indices                  : b"",
            last_received_delta_index_timestamp_ms : 0,
            last_trade_time_ms                     : 0,
        };
        0x2::transfer::share_object<Stonker>(v1);
    }

    public fun deposit_base_asset(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg0, 0x2::coin::split<0x2::sui::SUI>(arg1, arg2, arg3), arg3);
    }

    public fun deposit_quote_asset(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, 0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, arg3), arg3);
    }

    fun encode_lehmer_permutation(arg0: &vector<u8>) : u64 {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<u64>(&mut v1, 0);
            v2 = v2 + 1;
        };
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0;
            let v5 = v3 + 1;
            while (v5 < v0) {
                if (*0x1::vector::borrow<u8>(arg0, v5) < *0x1::vector::borrow<u8>(arg0, v3)) {
                    v4 = v4 + 1;
                };
                v5 = v5 + 1;
            };
            *0x1::vector::borrow_mut<u64>(&mut v1, v3) = v4;
            v3 = v3 + 1;
        };
        let v6 = 0;
        let v7 = 0;
        while (v7 < v0) {
            v6 = v6 + *0x1::vector::borrow<u64>(&v1, v7) * factorial(v0 - 1 - v7);
            v7 = v7 + 1;
        };
        v6
    }

    public fun even_out_portfolio(arg0: &Stonker, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &0x2::clock::Clock, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v0);
        let (v1, v2) = get_asset_balances(arg1, arg2);
        let v3 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg3) as u128);
        let v4 = (v1 as u128) * v3 / arg4 + (v2 as u128);
        let v5 = v4 / 2;
        if (v4 > v5 - v5 / 10 && v4 < v5 + v5 / 10) {
            return
        };
        let (_, v7, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
        if (v5 > (v2 as u128)) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v0, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), ((rounded_division((((v5 - (v2 as u128)) * arg4 / v3) as u64), v7) * v7) as u64), false, false, arg3, arg5);
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v0, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), ((rounded_division(((((v2 as u128) - v5) * arg4 / v3) as u64), v7) * v7) as u64), false, false, arg3, arg5);
        };
    }

    fun factorial(arg0: u64) : u64 {
        let v0 = 1;
        let v1 = 1;
        while (v1 <= arg0) {
            v0 = v0 * v1;
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_asset_balances(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) : (u64, u64) {
        let (v0, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::locked_balance<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg0);
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg0) + v0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0) + v1)
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

    public fun input_signal(arg0: &mut Stonker, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &0x2::clock::Clock, arg4: u64, arg5: bool, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        if (0x2::clock::timestamp_ms(arg3) >= arg6) {
            return
        };
        input_signal_internal(arg0, arg1, arg2, arg3, arg4, arg5, false, arg7);
    }

    fun input_signal_internal(arg0: &mut Stonker, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &0x2::clock::Clock, arg4: u64, arg5: bool, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        check_sender(arg0, arg7);
        let (v0, v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, 10, arg3);
        let v4 = v2;
        let v5 = v0;
        let v6 = *0x1::vector::borrow<u64>(&v5, 0);
        let v7 = *0x1::vector::borrow<u64>(&v4, 0);
        let v8 = arg4 * arg0.parameters.trigger_bps_times_1k / 1000 / 10000;
        let v9 = InputSignalEvent{
            estimated_valuation     : arg4,
            timestamp_ms            : 0x2::clock::timestamp_ms(arg3),
            signal_index            : arg0.next_signal_index,
            is_buy_movement         : arg5,
            best_dex_bids           : v5,
            best_dex_bid_quantities : v1,
            best_dex_asks           : v4,
            best_dex_ask_quantities : v3,
            dex_spread              : v7 - v6,
            from_delta              : arg6,
        };
        0x2::event::emit<InputSignalEvent>(v9);
        arg0.next_signal_index = arg0.next_signal_index + 1;
        if (arg5 && v7 + v8 < arg4) {
            let (v10, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
            let v13 = (arg4 - v8) / v10 * v10;
            let v14 = arg0.parameters.order_size_base;
            let v15 = convert_to_quote_at_price(arg0, v14, v13);
            let v16 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1);
            if (v16 < v15) {
                let v17 = OutOfBalanceEvent{
                    is_buy           : true,
                    balance_required : v15,
                    balance          : v16,
                };
                0x2::event::emit<OutOfBalanceEvent>(v17);
                return
            };
            if (convert_to_quote_at_price(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg1) + v14, v13) > 8000000000) {
                let v18 = PositionLimitEvent{
                    order_quantity_quote : v15,
                    balance_quote        : v16,
                };
                0x2::event::emit<PositionLimitEvent>(v18);
                return
            };
            if (v13 > 3800000) {
                let v19 = PriceLimitEvent{
                    is_buy : true,
                    price  : v13,
                };
                0x2::event::emit<PriceLimitEvent>(v19);
                return
            };
            if (0x2::clock::timestamp_ms(arg3) < arg0.last_trade_time_ms + 1000) {
                let v20 = WithinCooldownEvent{
                    is_buy : true,
                    price  : v13,
                };
                0x2::event::emit<WithinCooldownEvent>(v20);
                return
            };
            let v21 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg7);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v21, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v13, arg0.parameters.order_size_base, true, false, 0x2::clock::timestamp_ms(arg3) + 1000, arg3, arg7);
            arg0.last_trade_time_ms = 0x2::clock::timestamp_ms(arg3);
            return
        };
        if (!arg5 && arg4 + v8 < v6) {
            let (v22, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
            let v25 = (arg4 + v8 + v22 - 1) / v22 * v22;
            let v26 = arg0.parameters.order_size_base;
            let v27 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg1);
            if (v27 < v26) {
                let v28 = OutOfBalanceEvent{
                    is_buy           : false,
                    balance_required : v26,
                    balance          : v27,
                };
                0x2::event::emit<OutOfBalanceEvent>(v28);
                return
            };
            if (v25 < 2800000) {
                let v29 = PriceLimitEvent{
                    is_buy : false,
                    price  : v25,
                };
                0x2::event::emit<PriceLimitEvent>(v29);
                return
            };
            if (0x2::clock::timestamp_ms(arg3) < arg0.last_trade_time_ms + 1000) {
                let v30 = WithinCooldownEvent{
                    is_buy : true,
                    price  : v7,
                };
                0x2::event::emit<WithinCooldownEvent>(v30);
                return
            };
            let v31 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg7);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v31, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v25, v26, false, false, 0x2::clock::timestamp_ms(arg3) + 1000, arg3, arg7);
            arg0.last_trade_time_ms = 0x2::clock::timestamp_ms(arg3);
            return
        };
    }

    public fun make_limit_sell(arg0: &Stonker, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_sender(arg0, arg6);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v0, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg4, arg3, false, false, 0x2::clock::timestamp_ms(arg5) + 1000, arg5, arg6);
    }

    public fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun rounded_division(arg0: u64, arg1: u64) : u64 {
        (arg0 + arg1 / 2) / arg1
    }

    public fun run_delta_transaction(arg0: &mut Stonker, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        if (0x2::clock::timestamp_ms(arg3) >= arg6) {
            return
        };
        if (0x2::clock::timestamp_ms(arg3) != arg0.last_received_delta_index_timestamp_ms) {
            arg0.ordered_delta_indices = b"";
        };
        if (0x1::vector::length<u8>(&arg0.ordered_delta_indices) >= 5) {
            arg0.ordered_delta_indices = b"";
        };
        0x1::vector::push_back<u8>(&mut arg0.ordered_delta_indices, (arg4 as u8));
        arg0.last_received_delta_index_timestamp_ms = 0x2::clock::timestamp_ms(arg3);
        if (0x1::vector::length<u8>(&arg0.ordered_delta_indices) < 5) {
            return
        };
        let v0 = encode_lehmer_permutation(&arg0.ordered_delta_indices);
        arg0.current_quantised_valuation = arg0.current_quantised_valuation + (v0 % 60 + 1000 - 30) * arg5 - 1000 * arg5;
        arg0.current_quantised_valuation_index = arg0.current_quantised_valuation_index + 1;
        let v1 = arg0.current_quantised_valuation;
        input_signal_internal(arg0, arg1, arg2, arg3, v1, v0 < 60, true, arg7);
    }

    public fun run_direct_set_transaction(arg0: &mut Stonker, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64) {
        if (0x2::clock::timestamp_ms(arg1) >= arg3) {
            return
        };
        arg0.current_quantised_valuation = arg2;
        arg0.current_quantised_valuation_index = arg0.current_quantised_valuation_index + 1;
    }

    public fun setup_test_local_deepbook_pool(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(&mut v0, 0x2::coin::split<0x2::sui::SUI>(arg2, 10000000000000, arg4), arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v0, 0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, 10000000000000, arg4), arg4);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(&mut v0, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, &mut v0, &v1, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::no_restriction(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), 100000000, 1000000000000, true, false, 0x2::clock::timestamp_ms(arg1) + 10000000, arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, &mut v0, &v1, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::no_restriction(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), 101000000, 1000000000000, false, false, 0x2::clock::timestamp_ms(arg1) + 10000000, arg1, arg4);
        0x2::transfer::public_transfer<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun withdraw_base_asset(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun withdraw_quote_asset(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

