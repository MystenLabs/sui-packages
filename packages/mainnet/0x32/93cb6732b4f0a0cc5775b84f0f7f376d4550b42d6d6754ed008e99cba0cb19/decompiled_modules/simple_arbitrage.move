module 0x3293cb6732b4f0a0cc5775b84f0f7f376d4550b42d6d6754ed008e99cba0cb19::simple_arbitrage {
    struct ArbitrageExecuted has copy, drop {
        pool_buy: address,
        pool_sell: address,
        amount_in: u64,
        amount_out: u64,
        profit: u64,
        timestamp: u64,
    }

    public entry fun check_sui_balance(arg0: &0x2::coin::Coin<0x2::sui::SUI>) : u64 {
        0x2::coin::value<0x2::sui::SUI>(arg0)
    }

    public entry fun execute_sui_usdt_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 <= arg4, 2);
        assert!(is_valid_pool(arg1), 3);
        assert!(is_valid_pool(arg2), 3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v2 = simulate_sell_usdt(simulate_buy_usdt(v1, arg1), arg2);
        let v3 = if (v2 > v1) {
            v2 - v1
        } else {
            0
        };
        assert!(v3 >= arg3, 1);
        let v4 = ArbitrageExecuted{
            pool_buy   : arg1,
            pool_sell  : arg2,
            amount_in  : v1,
            amount_out : v2,
            profit     : v3,
            timestamp  : v0,
        };
        0x2::event::emit<ArbitrageExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg6));
    }

    public fun get_optimal_route(arg0: u64) : (address, address, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = &mut v0;
        0x1::vector::push_back<address>(v1, @0x6d8af9e6afd27262db436f0d37b304a041f710c3ea1fa4c3a9bab36b3569ad3);
        0x1::vector::push_back<address>(v1, @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78);
        0x1::vector::push_back<address>(v1, @0x4e0d2e39f53c1269b8cecef99ae08a477e387c9a03065d2914b0f3e384b4f6a7);
        0x1::vector::push_back<address>(v1, @0x4405b50d791fd3346754e8171aaab6bc2ed26c2c46efdd033c14b30ae507ac33);
        let v2 = @0x6d8af9e6afd27262db436f0d37b304a041f710c3ea1fa4c3a9bab36b3569ad3;
        let v3 = @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78;
        let v4 = 0;
        let v5 = v4;
        let v6 = 0;
        while (v6 < 4) {
            let v7 = 0;
            while (v7 < 4) {
                if (v6 != v7) {
                    let v8 = *0x1::vector::borrow<address>(&v0, v6);
                    let v9 = *0x1::vector::borrow<address>(&v0, v7);
                    let v10 = simulate_sell_usdt(simulate_buy_usdt(arg0, v8), v9);
                    if (v10 > arg0) {
                        let v11 = v10 - arg0;
                        if (v11 > v4) {
                            v5 = v11;
                            v2 = v8;
                            v3 = v9;
                        };
                    };
                };
                v7 = v7 + 1;
            };
            v6 = v6 + 1;
        };
        (v2, v3, v5)
    }

    fun is_valid_pool(arg0: address) : bool {
        if (arg0 == @0x6d8af9e6afd27262db436f0d37b304a041f710c3ea1fa4c3a9bab36b3569ad3) {
            true
        } else if (arg0 == @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78) {
            true
        } else if (arg0 == @0x4e0d2e39f53c1269b8cecef99ae08a477e387c9a03065d2914b0f3e384b4f6a7) {
            true
        } else {
            arg0 == @0x4405b50d791fd3346754e8171aaab6bc2ed26c2c46efdd033c14b30ae507ac33
        }
    }

    fun simulate_buy_usdt(arg0: u64, arg1: address) : u64 {
        let v0 = if (arg1 == @0x6d8af9e6afd27262db436f0d37b304a041f710c3ea1fa4c3a9bab36b3569ad3) {
            30
        } else if (arg1 == @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78) {
            25
        } else if (arg1 == @0x4e0d2e39f53c1269b8cecef99ae08a477e387c9a03065d2914b0f3e384b4f6a7) {
            20
        } else {
            100
        };
        (arg0 - arg0 * v0 / 10000) * 15 / 10
    }

    fun simulate_sell_usdt(arg0: u64, arg1: address) : u64 {
        let v0 = if (arg1 == @0x6d8af9e6afd27262db436f0d37b304a041f710c3ea1fa4c3a9bab36b3569ad3) {
            30
        } else if (arg1 == @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78) {
            25
        } else if (arg1 == @0x4e0d2e39f53c1269b8cecef99ae08a477e387c9a03065d2914b0f3e384b4f6a7) {
            20
        } else {
            100
        };
        (arg0 - arg0 * v0 / 10000) * 10 / 15
    }

    // decompiled from Move bytecode v6
}

