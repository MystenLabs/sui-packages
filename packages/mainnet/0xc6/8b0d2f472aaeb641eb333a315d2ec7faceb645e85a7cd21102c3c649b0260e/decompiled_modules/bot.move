module 0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::bot {
    struct ArbitrageOpportunityFound has copy, drop {
        usdc_price: u64,
        usdt_price: u64,
        profit_margin: u64,
        estimated_gas_cost: u64,
        net_profit_margin: u64,
        timestamp: u64,
    }

    struct TradeExecuted has copy, drop {
        trade_id: 0x2::object::ID,
        size: u64,
        usdc_price: u64,
        usdt_price: u64,
        profit_margin: u64,
        timestamp: u64,
    }

    struct FundsDeposited has copy, drop {
        amount: u64,
        is_usdc: bool,
        timestamp: u64,
    }

    struct PricePoint has store {
        usdc_price: u64,
        usdt_price: u64,
        timestamp: u64,
    }

    struct ArbitrageBot has key {
        id: 0x2::object::UID,
        owner: address,
        profit_threshold: u64,
        min_trade_size: u64,
        max_trade_size: u64,
        total_profit_usdc: 0x2::balance::Balance<0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::coins::USDC>,
        total_profit_usdt: 0x2::balance::Balance<0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::coins::USDT>,
        trading_balance_usdc: 0x2::balance::Balance<0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::coins::USDC>,
        trading_balance_usdt: 0x2::balance::Balance<0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::coins::USDT>,
        active: bool,
        price_history: 0x2::table::Table<u64, PricePoint>,
        last_price_index: u64,
        total_trades: u64,
        successful_trades: u64,
    }

    fun adjust_trade_size_for_volatility(arg0: &ArbitrageBot, arg1: u64) : u64 {
        if (calculate_volatility(arg0) > 100) {
            arg1 / 2
        } else {
            arg1
        }
    }

    fun calculate_profit_margin(arg0: u64, arg1: u64) : u64 {
        if (arg0 <= arg1) {
            return 0
        };
        let v0 = (arg0 - arg1) * 1000000 / 10000;
        let v1 = 100000 * 1000;
        let v2 = 1000000 * 25 / 10000;
        let v3 = if (v0 > v1 + v2) {
            v0 - v1 - v2
        } else {
            0
        };
        if (v3 > 0) {
            v3 * 10000 / 1000000 * arg1 / 10000
        } else {
            0
        }
    }

    fun calculate_volatility(arg0: &ArbitrageBot) : u64 {
        let v0 = 0;
        let v1 = 18446744073709551615;
        let v2 = 0;
        while (v2 < 10 && 0x2::table::contains<u64, PricePoint>(&arg0.price_history, v2)) {
            let v3 = 0x2::table::borrow<u64, PricePoint>(&arg0.price_history, v2);
            if (v3.usdc_price > v0) {
                v0 = v3.usdc_price;
            };
            if (v3.usdc_price < v1) {
                v1 = v3.usdc_price;
            };
            v2 = v2 + 1;
        };
        if (v1 == 18446744073709551615 || v0 == 0) {
            return 0
        };
        (v0 - v1) * 10000 / v1
    }

    public entry fun check_and_execute_arbitrage<T0, T1>(arg0: &mut ArbitrageBot, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = get_current_prices<T0, T1>(arg1, arg5);
        let v2 = calculate_profit_margin(v0, v1);
        if (v2 > arg0.profit_threshold) {
            let v3 = determine_trade_size(arg4, arg0.min_trade_size, arg0.max_trade_size);
            let (v4, v5) = execute_trade<T0, T1>(arg1, arg0, arg2, arg3, v0 > v1, v3, arg5, arg6);
            update_price_history(arg0, v0, v1, arg6);
            let v6 = TradeExecuted{
                trade_id      : 0x2::object::uid_to_inner(&arg0.id),
                size          : v3,
                usdc_price    : v0,
                usdt_price    : v1,
                profit_margin : v2,
                timestamp     : 0x2::clock::timestamp_ms(arg5),
            };
            0x2::event::emit<TradeExecuted>(v6);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg6));
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, 0x2::tx_context::sender(arg6));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg6));
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, 0x2::tx_context::sender(arg6));
        };
    }

    public entry fun deposit_usdc(arg0: &mut ArbitrageBot, arg1: 0x2::coin::Coin<0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::coins::USDC>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::coins::USDC>(&arg1);
        assert!(v0 >= 1000000, 5);
        0x2::balance::join<0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::coins::USDC>(&mut arg0.trading_balance_usdc, 0x2::coin::into_balance<0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::coins::USDC>(arg1));
        let v1 = FundsDeposited{
            amount    : v0,
            is_usdc   : true,
            timestamp : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<FundsDeposited>(v1);
    }

    public entry fun deposit_usdt(arg0: &mut ArbitrageBot, arg1: 0x2::coin::Coin<0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::coins::USDT>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::coins::USDT>(&arg1);
        assert!(v0 >= 1000000, 5);
        0x2::balance::join<0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::coins::USDT>(&mut arg0.trading_balance_usdt, 0x2::coin::into_balance<0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::coins::USDT>(arg1));
        let v1 = FundsDeposited{
            amount    : v0,
            is_usdc   : false,
            timestamp : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<FundsDeposited>(v1);
    }

    fun determine_trade_size(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 < arg1) {
            arg1
        } else if (arg0 > arg2) {
            arg2
        } else {
            arg0
        }
    }

    public fun execute_trade<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut ArbitrageBot, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (arg4) {
            let (v2, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, arg3, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg7), arg5, arg6, arg7);
            let v5 = v2;
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v4);
            0x2::coin::join<T0>(&mut v5, arg2);
            (v5, v3)
        } else {
            let (v6, v7, v8) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, arg2, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg7), arg5, arg6, arg7);
            let v9 = v7;
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v8);
            0x2::coin::join<T1>(&mut v9, arg3);
            (v6, v9)
        }
    }

    fun get_current_prices<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) : (u64, u64) {
        let (v0, _, v2, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg1);
        let v4 = v2;
        let v5 = v0;
        let v6 = if (0x1::vector::length<u64>(&v5) > 0) {
            *0x1::vector::borrow<u64>(&v5, 0)
        } else {
            0
        };
        let v7 = if (0x1::vector::length<u64>(&v4) > 0) {
            *0x1::vector::borrow<u64>(&v4, 0)
        } else {
            0
        };
        (v6, v7)
    }

    public fun get_statistics(arg0: &ArbitrageBot) : (u64, u64, u64) {
        let v0 = if (arg0.total_trades > 0) {
            arg0.successful_trades * 100 / arg0.total_trades
        } else {
            0
        };
        (arg0.total_trades, arg0.successful_trades, v0)
    }

    public fun get_total_profit_usdc(arg0: &ArbitrageBot) : u64 {
        0x2::balance::value<0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::coins::USDC>(&arg0.total_profit_usdc)
    }

    public fun get_total_profit_usdt(arg0: &ArbitrageBot) : u64 {
        0x2::balance::value<0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::coins::USDT>(&arg0.total_profit_usdt)
    }

    public fun get_trading_balance_usdc(arg0: &ArbitrageBot) : u64 {
        0x2::balance::value<0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::coins::USDC>(&arg0.trading_balance_usdc)
    }

    public fun get_trading_balance_usdt(arg0: &ArbitrageBot) : u64 {
        0x2::balance::value<0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::coins::USDT>(&arg0.trading_balance_usdt)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ArbitrageBot{
            id                   : 0x2::object::new(arg0),
            owner                : 0x2::tx_context::sender(arg0),
            profit_threshold     : 50,
            min_trade_size       : 1000000,
            max_trade_size       : 10000000000,
            total_profit_usdc    : 0x2::balance::zero<0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::coins::USDC>(),
            total_profit_usdt    : 0x2::balance::zero<0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::coins::USDT>(),
            trading_balance_usdc : 0x2::balance::zero<0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::coins::USDC>(),
            trading_balance_usdt : 0x2::balance::zero<0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::coins::USDT>(),
            active               : true,
            price_history        : 0x2::table::new<u64, PricePoint>(arg0),
            last_price_index     : 0,
            total_trades         : 0,
            successful_trades    : 0,
        };
        0x2::transfer::share_object<ArbitrageBot>(v0);
    }

    public fun is_active(arg0: &ArbitrageBot) : bool {
        arg0.active
    }

    public entry fun toggle_bot(arg0: &mut ArbitrageBot, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 3);
        arg0.active = !arg0.active;
    }

    public entry fun update_config(arg0: &mut ArbitrageBot, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 3);
        assert!(arg1 > 0, 1);
        assert!(arg2 >= 1000000 && arg3 <= 10000000000, 2);
        arg0.profit_threshold = arg1;
        arg0.min_trade_size = arg2;
        arg0.max_trade_size = arg3;
    }

    fun update_price_history(arg0: &mut ArbitrageBot, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = arg0.last_price_index % 10;
        if (0x2::table::contains<u64, PricePoint>(&arg0.price_history, v0)) {
            let PricePoint {
                usdc_price : _,
                usdt_price : _,
                timestamp  : _,
            } = 0x2::table::remove<u64, PricePoint>(&mut arg0.price_history, v0);
        };
        let v4 = PricePoint{
            usdc_price : arg1,
            usdt_price : arg2,
            timestamp  : 0x2::tx_context::epoch(arg3),
        };
        0x2::table::add<u64, PricePoint>(&mut arg0.price_history, v0, v4);
        arg0.last_price_index = arg0.last_price_index + 1;
    }

    public entry fun withdraw_profits(arg0: &mut ArbitrageBot, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 3);
        if (arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::coins::USDC>>(0x2::coin::from_balance<0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::coins::USDC>(0x2::balance::split<0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::coins::USDC>(&mut arg0.total_profit_usdc, arg1), arg3), arg0.owner);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::coins::USDT>>(0x2::coin::from_balance<0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::coins::USDT>(0x2::balance::split<0xc68b0d2f472aaeb641eb333a315d2ec7faceb645e85a7cd21102c3c649b0260e::coins::USDT>(&mut arg0.total_profit_usdt, arg1), arg3), arg0.owner);
        };
    }

    // decompiled from Move bytecode v6
}

