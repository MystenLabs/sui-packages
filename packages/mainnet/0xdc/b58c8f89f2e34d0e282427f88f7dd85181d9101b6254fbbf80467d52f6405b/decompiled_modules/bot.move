module 0xdcb58c8f89f2e34d0e282427f88f7dd85181d9101b6254fbbf80467d52f6405b::bot {
    struct ArbitrageExecuted has copy, drop {
        profit_usdc: u64,
        profit_wusdc: u64,
        usdc_to_wusdc_rate: u64,
        wusdc_to_usdc_rate: u64,
        timestamp: u64,
    }

    struct ArbitrageBot has key {
        id: 0x2::object::UID,
        owner: address,
        profit_threshold: u64,
        min_trade_size: u64,
        max_trade_size: u64,
        total_profit_usdc: 0x2::balance::Balance<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>,
        total_profit_wusdc: 0x2::balance::Balance<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>,
        trading_balance_usdc: 0x2::balance::Balance<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>,
        trading_balance_wusdc: 0x2::balance::Balance<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>,
        active: bool,
        total_trades: u64,
        successful_trades: u64,
    }

    fun calculate_profit_margin(arg0: u64, arg1: u64) : u64 {
        if (arg0 <= arg1) {
            return 0
        };
        (arg0 - arg1) * 10000 / arg1
    }

    public entry fun check_and_execute_arbitrage(arg0: &mut ArbitrageBot, arg1: &mut 0xdcb58c8f89f2e34d0e282427f88f7dd85181d9101b6254fbbf80467d52f6405b::swap::SwapPool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 3);
        let (v0, v1) = 0xdcb58c8f89f2e34d0e282427f88f7dd85181d9101b6254fbbf80467d52f6405b::swap::get_exchange_rates(arg1);
        if (calculate_profit_margin(v0, v1) > arg0.profit_threshold) {
            let v2 = determine_trade_size(0x2::balance::value<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(&arg0.trading_balance_usdc), 0x2::balance::value<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(&arg0.trading_balance_wusdc));
            if (v0 > v1) {
                execute_usdc_arbitrage(arg0, arg1, v2, arg2);
            } else {
                execute_wusdc_arbitrage(arg0, arg1, v2, arg2);
            };
            arg0.total_trades = arg0.total_trades + 1;
            arg0.successful_trades = arg0.successful_trades + 1;
            let v3 = ArbitrageExecuted{
                profit_usdc        : 0x2::balance::value<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(&arg0.total_profit_usdc),
                profit_wusdc       : 0x2::balance::value<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(&arg0.total_profit_wusdc),
                usdc_to_wusdc_rate : v0,
                wusdc_to_usdc_rate : v1,
                timestamp          : 0x2::tx_context::epoch(arg2),
            };
            0x2::event::emit<ArbitrageExecuted>(v3);
        };
    }

    public entry fun deposit_usdc(arg0: &mut ArbitrageBot, arg1: 0x2::coin::Coin<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(&mut arg0.trading_balance_usdc, 0x2::coin::into_balance<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(arg1));
    }

    public entry fun deposit_wusdc(arg0: &mut ArbitrageBot, arg1: 0x2::coin::Coin<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(&mut arg0.trading_balance_wusdc, 0x2::coin::into_balance<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(arg1));
    }

    fun determine_trade_size(arg0: u64, arg1: u64) : u64 {
        let v0 = if (arg0 < arg1) {
            arg0
        } else {
            arg1
        };
        if (v0 < 1000000) {
            1000000
        } else if (v0 > 10000000000) {
            10000000000
        } else {
            v0
        }
    }

    fun execute_usdc_arbitrage(arg0: &mut ArbitrageBot, arg1: &mut 0xdcb58c8f89f2e34d0e282427f88f7dd85181d9101b6254fbbf80467d52f6405b::swap::SwapPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(0x2::balance::split<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(&mut arg0.trading_balance_usdc, arg2), arg3);
        let v1 = 0x2::coin::value<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(&v0);
        let v2 = 0xdcb58c8f89f2e34d0e282427f88f7dd85181d9101b6254fbbf80467d52f6405b::swap::swap_wusdc_to_usdc(arg1, 0xdcb58c8f89f2e34d0e282427f88f7dd85181d9101b6254fbbf80467d52f6405b::swap::swap_usdc_to_wusdc(arg1, v0, arg3), arg3);
        let v3 = 0x2::coin::value<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(&v2);
        if (v3 > v1) {
            0x2::balance::join<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(&mut arg0.total_profit_usdc, 0x2::coin::into_balance<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(0x2::coin::split<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(&mut v2, v3 - v1, arg3)));
        };
        0x2::balance::join<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(&mut arg0.trading_balance_usdc, 0x2::coin::into_balance<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(v2));
    }

    fun execute_wusdc_arbitrage(arg0: &mut ArbitrageBot, arg1: &mut 0xdcb58c8f89f2e34d0e282427f88f7dd85181d9101b6254fbbf80467d52f6405b::swap::SwapPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(0x2::balance::split<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(&mut arg0.trading_balance_wusdc, arg2), arg3);
        let v1 = 0x2::coin::value<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(&v0);
        let v2 = 0xdcb58c8f89f2e34d0e282427f88f7dd85181d9101b6254fbbf80467d52f6405b::swap::swap_usdc_to_wusdc(arg1, 0xdcb58c8f89f2e34d0e282427f88f7dd85181d9101b6254fbbf80467d52f6405b::swap::swap_wusdc_to_usdc(arg1, v0, arg3), arg3);
        let v3 = 0x2::coin::value<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(&v2);
        if (v3 > v1) {
            0x2::balance::join<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(&mut arg0.total_profit_wusdc, 0x2::coin::into_balance<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(0x2::coin::split<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(&mut v2, v3 - v1, arg3)));
        };
        0x2::balance::join<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(&mut arg0.trading_balance_wusdc, 0x2::coin::into_balance<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(v2));
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
        0x2::balance::value<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(&arg0.total_profit_usdc)
    }

    public fun get_total_profit_wusdc(arg0: &ArbitrageBot) : u64 {
        0x2::balance::value<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(&arg0.total_profit_wusdc)
    }

    public fun get_trading_balance_usdc(arg0: &ArbitrageBot) : u64 {
        0x2::balance::value<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(&arg0.trading_balance_usdc)
    }

    public fun get_trading_balance_wusdc(arg0: &ArbitrageBot) : u64 {
        0x2::balance::value<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(&arg0.trading_balance_wusdc)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ArbitrageBot{
            id                    : 0x2::object::new(arg0),
            owner                 : 0x2::tx_context::sender(arg0),
            profit_threshold      : 50,
            min_trade_size        : 1000000,
            max_trade_size        : 10000000000,
            total_profit_usdc     : 0x2::balance::zero<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(),
            total_profit_wusdc    : 0x2::balance::zero<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(),
            trading_balance_usdc  : 0x2::balance::zero<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(),
            trading_balance_wusdc : 0x2::balance::zero<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(),
            active                : true,
            total_trades          : 0,
            successful_trades     : 0,
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

    public entry fun withdraw_profits(arg0: &mut ArbitrageBot, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 3);
        if (arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>>(0x2::coin::from_balance<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(0x2::balance::split<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(&mut arg0.total_profit_usdc, arg1), arg3), arg0.owner);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>>(0x2::coin::from_balance<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(0x2::balance::split<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(&mut arg0.total_profit_wusdc, arg1), arg3), arg0.owner);
        };
    }

    // decompiled from Move bytecode v6
}

