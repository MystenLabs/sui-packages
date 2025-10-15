module 0xa639d916d50a2039660ed1ad59a4fea743cbe2df5db149a3757581bb1dba72a1::parameters {
    struct Parameters has store, key {
        id: 0x2::object::UID,
        admin: address,
        trigger_bps_times_1k: u64,
        maker_shallow_place_bps_times_1k: u64,
        maker_deep_place_bps_times_1k: u64,
        maker_order_ttl_ms: u64,
        maker_max_shallow_quantity_base: u64,
        maker_max_deep_sell_quantity_base: u64,
        maker_max_deep_buy_quantity_base: u64,
        maker_minimum_portfolio: u64,
        maker_trades_enabled: bool,
        maker_deep_trades_enabled: bool,
        maker_min_volatility_for_multiple_times_1k: u64,
        maker_max_volatility_for_multiple_times_1k: u64,
        single_base: u64,
        position_limit_quote: u64,
        minimum_order_size_base: u64,
        order_size_step_base: u64,
        allowed_to_buy: bool,
        minimum_sell_price_quote: u64,
        maximum_buy_price_quote: u64,
        cooldown_ms: u64,
        minimum_quote_in_balance_manager: u64,
        minimum_base_in_balance_manager: u64,
        minimum_amount_in_gas_coin: u64,
        target_amount_in_gas_coin: u64,
        minimum_considered_volume: u64,
    }

    public fun allowed_to_buy(arg0: &Parameters) : bool {
        arg0.allowed_to_buy
    }

    public fun check_sender(arg0: &Parameters, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 13906834672559587327);
    }

    public fun cooldown_ms(arg0: &Parameters) : u64 {
        arg0.cooldown_ms
    }

    public fun maker_deep_place_bps_times_1k(arg0: &Parameters) : u64 {
        arg0.maker_deep_place_bps_times_1k
    }

    public fun maker_deep_trades_enabled(arg0: &Parameters) : bool {
        arg0.maker_deep_trades_enabled
    }

    public fun maker_max_deep_buy_quantity_base(arg0: &Parameters) : u64 {
        arg0.maker_max_deep_buy_quantity_base
    }

    public fun maker_max_deep_sell_quantity_base(arg0: &Parameters) : u64 {
        arg0.maker_max_deep_sell_quantity_base
    }

    public fun maker_max_shallow_quantity_base(arg0: &Parameters) : u64 {
        arg0.maker_max_shallow_quantity_base
    }

    public fun maker_max_volatility_for_multiple_times_1k(arg0: &Parameters) : u64 {
        arg0.maker_max_volatility_for_multiple_times_1k
    }

    public fun maker_min_volatility_for_multiple_times_1k(arg0: &Parameters) : u64 {
        arg0.maker_min_volatility_for_multiple_times_1k
    }

    public fun maker_minimum_portfolio(arg0: &Parameters) : u64 {
        arg0.maker_minimum_portfolio
    }

    public fun maker_order_ttl_ms(arg0: &Parameters) : u64 {
        arg0.maker_order_ttl_ms
    }

    public fun maker_shallow_place_bps_times_1k(arg0: &Parameters) : u64 {
        arg0.maker_shallow_place_bps_times_1k
    }

    public fun maker_trades_enabled(arg0: &Parameters) : bool {
        arg0.maker_trades_enabled
    }

    public fun maximum_buy_price_quote(arg0: &Parameters) : u64 {
        arg0.maximum_buy_price_quote
    }

    public fun minimum_amount_in_gas_coin(arg0: &Parameters) : u64 {
        arg0.minimum_amount_in_gas_coin
    }

    public fun minimum_base_in_balance_manager(arg0: &Parameters) : u64 {
        arg0.minimum_base_in_balance_manager
    }

    public fun minimum_considered_volume(arg0: &Parameters) : u64 {
        arg0.minimum_considered_volume
    }

    public fun minimum_order_size_base(arg0: &Parameters) : u64 {
        arg0.minimum_order_size_base
    }

    public fun minimum_quote_in_balance_manager(arg0: &Parameters) : u64 {
        arg0.minimum_quote_in_balance_manager
    }

    public fun minimum_sell_price_quote(arg0: &Parameters) : u64 {
        arg0.minimum_sell_price_quote
    }

    public fun order_size_step_base(arg0: &Parameters) : u64 {
        arg0.order_size_step_base
    }

    public fun position_limit_quote(arg0: &Parameters) : u64 {
        arg0.position_limit_quote
    }

    public fun production_stonker_parameters(arg0: &mut 0x2::tx_context::TxContext) : Parameters {
        let v0 = 1000000000;
        Parameters{
            id                                         : 0x2::object::new(arg0),
            admin                                      : 0x2::tx_context::sender(arg0),
            trigger_bps_times_1k                       : 1000,
            maker_shallow_place_bps_times_1k           : 1000,
            maker_deep_place_bps_times_1k              : 15000,
            maker_order_ttl_ms                         : 10000,
            maker_max_shallow_quantity_base            : 1 * v0,
            maker_max_deep_sell_quantity_base          : 100000 * v0,
            maker_max_deep_buy_quantity_base           : 2000 * v0,
            maker_minimum_portfolio                    : 20000 * 1000000,
            maker_trades_enabled                       : true,
            maker_deep_trades_enabled                  : true,
            maker_min_volatility_for_multiple_times_1k : 2000,
            maker_max_volatility_for_multiple_times_1k : 5000,
            single_base                                : v0,
            position_limit_quote                       : 30000 * 1000000,
            minimum_order_size_base                    : 380 * v0,
            order_size_step_base                       : 500 * v0,
            allowed_to_buy                             : true,
            minimum_sell_price_quote                   : 200 * 10000,
            maximum_buy_price_quote                    : 390 * 10000,
            cooldown_ms                                : 1,
            minimum_quote_in_balance_manager           : 500 * 1000000,
            minimum_base_in_balance_manager            : 500 * v0,
            minimum_amount_in_gas_coin                 : 1000000000 / 4,
            target_amount_in_gas_coin                  : 1000000000 / 2,
            minimum_considered_volume                  : 10 * v0,
        }
    }

    public fun set_allowed_to_buy(arg0: &mut Parameters, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.allowed_to_buy = arg1;
    }

    public fun set_cooldown_ms(arg0: &mut Parameters, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.cooldown_ms = arg1;
    }

    public fun set_maker_deep_place_bps_times_1k(arg0: &mut Parameters, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.maker_deep_place_bps_times_1k = arg1;
    }

    public fun set_maker_deep_trades_enabled(arg0: &mut Parameters, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.maker_deep_trades_enabled = arg1;
    }

    public fun set_maker_max_deep_buy_quantity_base(arg0: &mut Parameters, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.maker_max_deep_buy_quantity_base = arg1;
    }

    public fun set_maker_max_deep_sell_quantity_base(arg0: &mut Parameters, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.maker_max_deep_sell_quantity_base = arg1;
    }

    public fun set_maker_max_shallow_quantity_base(arg0: &mut Parameters, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.maker_max_shallow_quantity_base = arg1;
    }

    public fun set_maker_max_volatility_for_multiple_times_1k(arg0: &mut Parameters, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.maker_max_volatility_for_multiple_times_1k = arg1;
    }

    public fun set_maker_min_volatility_for_multiple_times_1k(arg0: &mut Parameters, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.maker_min_volatility_for_multiple_times_1k = arg1;
    }

    public fun set_maker_minimum_portfolio(arg0: &mut Parameters, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.maker_minimum_portfolio = arg1;
    }

    public fun set_maker_order_ttl_ms(arg0: &mut Parameters, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.maker_order_ttl_ms = arg1;
    }

    public fun set_maker_shallow_place_bps_times_1k(arg0: &mut Parameters, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.maker_shallow_place_bps_times_1k = arg1;
    }

    public fun set_maker_trades_enabled(arg0: &mut Parameters, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg5);
        arg0.maker_trades_enabled = arg3;
        if (!arg3) {
            let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v0, arg4, arg5);
        };
    }

    public fun set_maximum_buy_price_quote(arg0: &mut Parameters, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.maximum_buy_price_quote = arg1;
    }

    public fun set_minimum_amount_in_gas_coin(arg0: &mut Parameters, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.minimum_amount_in_gas_coin = arg1;
    }

    public fun set_minimum_base_in_balance_manager(arg0: &mut Parameters, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.minimum_base_in_balance_manager = arg1;
    }

    public fun set_minimum_considered_volume(arg0: &mut Parameters, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.minimum_considered_volume = arg1;
    }

    public fun set_minimum_order_size_base(arg0: &mut Parameters, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.minimum_order_size_base = arg1;
    }

    public fun set_minimum_quote_in_balance_manager(arg0: &mut Parameters, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.minimum_quote_in_balance_manager = arg1;
    }

    public fun set_minimum_sell_price_quote(arg0: &mut Parameters, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.minimum_sell_price_quote = arg1;
    }

    public fun set_order_size_step_base(arg0: &mut Parameters, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.order_size_step_base = arg1;
    }

    public fun set_position_limit_quote(arg0: &mut Parameters, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.position_limit_quote = arg1;
    }

    public fun set_single_base(arg0: &mut Parameters, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.single_base = arg1;
    }

    public fun set_target_amount_in_gas_coin(arg0: &mut Parameters, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.target_amount_in_gas_coin = arg1;
    }

    public fun set_trigger_bps_times_1k(arg0: &mut Parameters, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        arg0.trigger_bps_times_1k = arg1;
    }

    public fun single_base(arg0: &Parameters) : u64 {
        arg0.single_base
    }

    public fun staging_stonker_parameters(arg0: &mut 0x2::tx_context::TxContext) : Parameters {
        let v0 = production_stonker_parameters(arg0);
        v0.minimum_order_size_base = 1 * 1000000000;
        v0.order_size_step_base = 0 * 1000000000;
        v0.minimum_quote_in_balance_manager = 10 * 1000000;
        v0.minimum_base_in_balance_manager = 10 * 1000000000;
        v0.maker_max_shallow_quantity_base = 1 * 1000000000;
        v0.maker_max_deep_sell_quantity_base = 1 * 1000000000;
        v0.maker_max_deep_buy_quantity_base = 1 * 1000000000;
        v0.maker_minimum_portfolio = 0;
        v0.maker_shallow_place_bps_times_1k = 100;
        v0.maker_min_volatility_for_multiple_times_1k = 100000;
        v0.maker_max_volatility_for_multiple_times_1k = 200000;
        v0
    }

    public fun target_amount_in_gas_coin(arg0: &Parameters) : u64 {
        arg0.target_amount_in_gas_coin
    }

    public fun trigger_bps_times_1k(arg0: &Parameters) : u64 {
        arg0.trigger_bps_times_1k
    }

    // decompiled from Move bytecode v6
}

