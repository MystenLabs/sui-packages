module 0xdcb58c8f89f2e34d0e282427f88f7dd85181d9101b6254fbbf80467d52f6405b::swap {
    struct SwapExecuted has copy, drop {
        from_usdc: bool,
        amount_in: u64,
        amount_out: u64,
        exchange_rate: u64,
        timestamp: u64,
    }

    struct SwapPool has key {
        id: 0x2::object::UID,
        owner: address,
        usdc_balance: 0x2::balance::Balance<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>,
        wusdc_balance: 0x2::balance::Balance<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>,
        exchange_rate_usdc_to_wusdc: u64,
        exchange_rate_wusdc_to_usdc: u64,
    }

    public entry fun add_liquidity(arg0: &mut SwapPool, arg1: 0x2::coin::Coin<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>, arg2: 0x2::coin::Coin<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 3);
        0x2::balance::join<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(&mut arg0.usdc_balance, 0x2::coin::into_balance<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(arg1));
        0x2::balance::join<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(&mut arg0.wusdc_balance, 0x2::coin::into_balance<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(arg2));
    }

    public fun get_balances(arg0: &SwapPool) : (u64, u64) {
        (0x2::balance::value<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(&arg0.usdc_balance), 0x2::balance::value<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(&arg0.wusdc_balance))
    }

    public fun get_exchange_rates(arg0: &SwapPool) : (u64, u64) {
        (arg0.exchange_rate_usdc_to_wusdc, arg0.exchange_rate_wusdc_to_usdc)
    }

    public fun get_usdc_from_pool(arg0: &mut SwapPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC> {
        0x2::coin::from_balance<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(0x2::balance::split<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(&mut arg0.usdc_balance, arg1), arg2)
    }

    public fun get_wusdc_from_pool(arg0: &mut SwapPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN> {
        0x2::coin::from_balance<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(0x2::balance::split<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(&mut arg0.wusdc_balance, arg1), arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SwapPool{
            id                          : 0x2::object::new(arg0),
            owner                       : 0x2::tx_context::sender(arg0),
            usdc_balance                : 0x2::balance::zero<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(),
            wusdc_balance               : 0x2::balance::zero<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(),
            exchange_rate_usdc_to_wusdc : 10000,
            exchange_rate_wusdc_to_usdc : 10000,
        };
        0x2::transfer::share_object<SwapPool>(v0);
    }

    public fun swap_usdc_to_wusdc(arg0: &mut SwapPool, arg1: 0x2::coin::Coin<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN> {
        let v0 = 0x2::coin::value<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(&arg1);
        let v1 = v0 * arg0.exchange_rate_usdc_to_wusdc / 10000;
        assert!(0x2::balance::value<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(&arg0.wusdc_balance) >= v1, 1);
        0x2::balance::join<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(&mut arg0.usdc_balance, 0x2::coin::into_balance<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(arg1));
        let v2 = SwapExecuted{
            from_usdc     : true,
            amount_in     : v0,
            amount_out    : v1,
            exchange_rate : arg0.exchange_rate_usdc_to_wusdc,
            timestamp     : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::coin::from_balance<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(0x2::balance::split<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(&mut arg0.wusdc_balance, v1), arg2)
    }

    public fun swap_wusdc_to_usdc(arg0: &mut SwapPool, arg1: 0x2::coin::Coin<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC> {
        let v0 = 0x2::coin::value<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(&arg1);
        let v1 = v0 * arg0.exchange_rate_wusdc_to_usdc / 10000;
        assert!(0x2::balance::value<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(&arg0.usdc_balance) >= v1, 1);
        0x2::balance::join<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(&mut arg0.wusdc_balance, 0x2::coin::into_balance<0x96f8d367f9be711c66943ab5612416285220a5cdfea3aa059870db8ea1d274de::coin::COIN>(arg1));
        let v2 = SwapExecuted{
            from_usdc     : false,
            amount_in     : v0,
            amount_out    : v1,
            exchange_rate : arg0.exchange_rate_wusdc_to_usdc,
            timestamp     : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::coin::from_balance<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(0x2::balance::split<0x187f9c4f4fdd3b2b9da24c9bfd606689c836819be74525950c0993ba8941a5b9::usdc::USDC>(&mut arg0.usdc_balance, v1), arg2)
    }

    public entry fun update_exchange_rates(arg0: &mut SwapPool, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 3);
        assert!(arg1 > 0 && arg2 > 0, 2);
        arg0.exchange_rate_usdc_to_wusdc = arg1;
        arg0.exchange_rate_wusdc_to_usdc = arg2;
    }

    // decompiled from Move bytecode v6
}

