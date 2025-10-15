module 0x969e6cbcc7f1780c7aca7398ebc7c903775db622dcd4ae61de7925d8a7f19d54::stonker {
    struct Stonker has store, key {
        id: 0x2::object::UID,
        parameters: 0x969e6cbcc7f1780c7aca7398ebc7c903775db622dcd4ae61de7925d8a7f19d54::parameters::Parameters,
        next_signal_index: u64,
        order_manager: 0x969e6cbcc7f1780c7aca7398ebc7c903775db622dcd4ae61de7925d8a7f19d54::order_manager::OrderManager,
        last_trade_time_ms: u64,
        latest_estimated_valuation: u64,
        latest_maker_volatility_bps_times_1k: u64,
        last_input_signal_nonce: u64,
        cannot_trade_until_ms: u64,
    }

    struct BalanceChangeEvent has copy, drop {
        amount: u64,
        is_base: bool,
        is_deposit: bool,
    }

    struct GasToppedUpEvent has copy, drop {
        max_can_withdraw: u64,
        top_up_amount: u64,
    }

    struct InputSignalEvent has copy, drop {
        estimated_valuation: u64,
        maker_volatility_bps_times_1k: u64,
        timestamp_ms: u64,
        signal_index: u64,
        input_signal_status: u8,
        best_dex_bids: vector<u64>,
        best_dex_bid_quantities: vector<u64>,
        best_dex_asks: vector<u64>,
        best_dex_ask_quantities: vector<u64>,
        dex_spread: u64,
        input_signal_nonce: u64,
        balance_manager_id: 0x2::object::ID,
    }

    struct KillAllOrdersEvent has copy, drop {
        duration_ms: u64,
    }

    public fun create_balance_manager(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg0));
    }

    public fun create_stonker(arg0: bool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg0) {
            0x969e6cbcc7f1780c7aca7398ebc7c903775db622dcd4ae61de7925d8a7f19d54::parameters::production_stonker_parameters(0x2::tx_context::sender(arg1))
        } else {
            0x969e6cbcc7f1780c7aca7398ebc7c903775db622dcd4ae61de7925d8a7f19d54::parameters::staging_stonker_parameters(0x2::tx_context::sender(arg1))
        };
        let v1 = Stonker{
            id                                   : 0x2::object::new(arg1),
            parameters                           : v0,
            next_signal_index                    : 0,
            order_manager                        : 0x969e6cbcc7f1780c7aca7398ebc7c903775db622dcd4ae61de7925d8a7f19d54::order_manager::new_order_manager(),
            last_trade_time_ms                   : 0,
            latest_estimated_valuation           : 0,
            latest_maker_volatility_bps_times_1k : 0,
            last_input_signal_nonce              : 0,
            cannot_trade_until_ms                : 0,
        };
        0x2::transfer::share_object<Stonker>(v1);
    }

    public fun deposit_base_asset(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg0, 0x2::coin::split<0x2::sui::SUI>(arg1, arg2, arg3), arg3);
        let v0 = BalanceChangeEvent{
            amount     : arg2,
            is_base    : true,
            is_deposit : true,
        };
        0x2::event::emit<BalanceChangeEvent>(v0);
    }

    public fun deposit_quote_asset(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, 0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, arg3), arg3);
        let v0 = BalanceChangeEvent{
            amount     : arg2,
            is_base    : false,
            is_deposit : true,
        };
        0x2::event::emit<BalanceChangeEvent>(v0);
    }

    fun ensure_gas_coin_is_funded(arg0: &Stonker, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<0x2::sui::SUI>(arg2) >= 0x969e6cbcc7f1780c7aca7398ebc7c903775db622dcd4ae61de7925d8a7f19d54::parameters::minimum_amount_in_gas_coin(&arg0.parameters)) {
            return
        };
        let v0 = 0x969e6cbcc7f1780c7aca7398ebc7c903775db622dcd4ae61de7925d8a7f19d54::parameters::target_amount_in_gas_coin(&arg0.parameters) - 0x2::coin::value<0x2::sui::SUI>(arg2);
        let v1 = v0;
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg1);
        if (v2 < v0) {
            v1 = v2;
        };
        let v3 = GasToppedUpEvent{
            max_can_withdraw : v2,
            top_up_amount    : v1,
        };
        0x2::event::emit<GasToppedUpEvent>(v3);
        if (v1 == 0) {
            return
        };
        0x2::coin::join<0x2::sui::SUI>(arg2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg1, v1, arg3));
    }

    public fun get_full_order_book(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &0x2::clock::Clock) : (vector<u64>, vector<u64>, vector<u64>, vector<u64>) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, 18446744073709551615, arg1)
    }

    public fun input_signal(arg0: &mut Stonker, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u8, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        0x969e6cbcc7f1780c7aca7398ebc7c903775db622dcd4ae61de7925d8a7f19d54::parameters::check_sender(&arg0.parameters, arg11);
        ensure_gas_coin_is_funded(arg0, arg2, arg1, arg11);
        if (0x2::clock::timestamp_ms(arg5) >= arg10) {
            0x969e6cbcc7f1780c7aca7398ebc7c903775db622dcd4ae61de7925d8a7f19d54::taker::emit_could_not_trade_event(b"expired");
            return
        };
        if (0x2::clock::timestamp_ms(arg5) < arg0.cannot_trade_until_ms) {
            0x969e6cbcc7f1780c7aca7398ebc7c903775db622dcd4ae61de7925d8a7f19d54::taker::emit_could_not_trade_event(b"cannot_trade");
            return
        };
        if (arg9 > arg0.last_input_signal_nonce) {
            arg0.latest_estimated_valuation = arg6;
            arg0.latest_maker_volatility_bps_times_1k = arg7;
            arg0.last_input_signal_nonce = arg9;
        };
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg11);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, &v0);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_account_order_details<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2);
        let v2 = 0x969e6cbcc7f1780c7aca7398ebc7c903775db622dcd4ae61de7925d8a7f19d54::order_book::get_order_book_without_our_orders(&arg0.parameters, arg3, &v1, 8, arg5);
        let v3 = InputSignalEvent{
            estimated_valuation           : arg0.latest_estimated_valuation,
            maker_volatility_bps_times_1k : arg0.latest_maker_volatility_bps_times_1k,
            timestamp_ms                  : 0x2::clock::timestamp_ms(arg5),
            signal_index                  : arg0.next_signal_index,
            input_signal_status           : arg8,
            best_dex_bids                 : *0x969e6cbcc7f1780c7aca7398ebc7c903775db622dcd4ae61de7925d8a7f19d54::order_book::bid_prices(&v2),
            best_dex_bid_quantities       : *0x969e6cbcc7f1780c7aca7398ebc7c903775db622dcd4ae61de7925d8a7f19d54::order_book::bid_quantities(&v2),
            best_dex_asks                 : *0x969e6cbcc7f1780c7aca7398ebc7c903775db622dcd4ae61de7925d8a7f19d54::order_book::ask_prices(&v2),
            best_dex_ask_quantities       : *0x969e6cbcc7f1780c7aca7398ebc7c903775db622dcd4ae61de7925d8a7f19d54::order_book::ask_quantities(&v2),
            dex_spread                    : 0x969e6cbcc7f1780c7aca7398ebc7c903775db622dcd4ae61de7925d8a7f19d54::order_book::best_ask(&v2) - 0x969e6cbcc7f1780c7aca7398ebc7c903775db622dcd4ae61de7925d8a7f19d54::order_book::best_bid(&v2),
            input_signal_nonce            : arg9,
            balance_manager_id            : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
        };
        0x2::event::emit<InputSignalEvent>(v3);
        arg0.next_signal_index = arg0.next_signal_index + 1;
        if (arg8 == 0 || arg8 == 1) {
            0x969e6cbcc7f1780c7aca7398ebc7c903775db622dcd4ae61de7925d8a7f19d54::taker::try_make_taker_trade(&arg0.parameters, &mut arg0.order_manager, arg2, arg3, &v0, arg4, arg5, arg0.latest_estimated_valuation, arg8 == 0, &v2, &mut arg0.last_trade_time_ms, arg11);
        };
        0x969e6cbcc7f1780c7aca7398ebc7c903775db622dcd4ae61de7925d8a7f19d54::order_manager::adjust_maker_orders(&mut arg0.order_manager, &arg0.parameters, arg2, &v0, arg3, arg5, arg0.latest_estimated_valuation, arg0.latest_maker_volatility_bps_times_1k, &v2, arg11);
    }

    public fun kill_all_orders(arg0: &mut Stonker, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x969e6cbcc7f1780c7aca7398ebc7c903775db622dcd4ae61de7925d8a7f19d54::parameters::check_sender(&arg0.parameters, arg7);
        ensure_gas_coin_is_funded(arg0, arg2, arg1, arg7);
        if (0x2::clock::timestamp_ms(arg4) >= arg6) {
            return
        };
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg7);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, &v0, arg4, arg7);
        arg0.cannot_trade_until_ms = 0x2::clock::timestamp_ms(arg4) + arg5;
        let v1 = KillAllOrdersEvent{duration_ms: arg5};
        0x2::event::emit<KillAllOrdersEvent>(v1);
    }

    public fun make_limit_buy(arg0: &Stonker, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x969e6cbcc7f1780c7aca7398ebc7c903775db622dcd4ae61de7925d8a7f19d54::parameters::check_sender(&arg0.parameters, arg6);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v0, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg4, arg3, true, false, 0x2::clock::timestamp_ms(arg5) + 1000, arg5, arg6);
    }

    public fun make_limit_maker_buy(arg0: &Stonker, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x969e6cbcc7f1780c7aca7398ebc7c903775db622dcd4ae61de7925d8a7f19d54::parameters::check_sender(&arg0.parameters, arg6);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v0, arg5, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v0, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), arg4, arg3, true, false, 0x2::clock::timestamp_ms(arg5) + 10000000000, arg5, arg6);
    }

    public fun make_limit_maker_sell(arg0: &Stonker, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x969e6cbcc7f1780c7aca7398ebc7c903775db622dcd4ae61de7925d8a7f19d54::parameters::check_sender(&arg0.parameters, arg6);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v0, arg5, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v0, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), arg4, arg3, false, false, 0x2::clock::timestamp_ms(arg5) + 10000000000, arg5, arg6);
    }

    public fun make_limit_sell(arg0: &Stonker, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x969e6cbcc7f1780c7aca7398ebc7c903775db622dcd4ae61de7925d8a7f19d54::parameters::check_sender(&arg0.parameters, arg6);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v0, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg4, arg3, false, false, 0x2::clock::timestamp_ms(arg5) + 1000, arg5, arg6);
    }

    public fun withdraw_base_asset(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
        let v0 = BalanceChangeEvent{
            amount     : arg1,
            is_base    : true,
            is_deposit : false,
        };
        0x2::event::emit<BalanceChangeEvent>(v0);
    }

    public fun withdraw_quote_asset(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
        let v0 = BalanceChangeEvent{
            amount     : arg1,
            is_base    : false,
            is_deposit : false,
        };
        0x2::event::emit<BalanceChangeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

