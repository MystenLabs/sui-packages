module 0x3d8827af02bea9a4b9930a57ebdbca6a21ccd2e520a4479ddf015270a5d4a9b::production_atomic_arbitrage {
    struct ArbitrageResult has copy, drop {
        success: bool,
        profit: u64,
        gas_used: u64,
        input_amount: u64,
        output_amount: u64,
        buy_dex: u8,
        sell_dex: u8,
        timestamp: u64,
    }

    struct ArbitrageExecuted has copy, drop {
        executor: address,
        input_amount: u64,
        output_amount: u64,
        profit: u64,
        buy_dex: u8,
        sell_dex: u8,
        gas_used: u64,
        timestamp: u64,
        tx_hash: 0x1::string::String,
    }

    public fun estimate_arbitrage_profit(arg0: u64, arg1: u8, arg2: u8) : u64 {
        let (v0, v1) = get_dex_parameters(arg1);
        let (v2, v3) = get_dex_parameters(arg2);
        let v4 = arg0 * (10000 - v0 - v1) / 10000 * (10000 - v2 - v3) / 10000;
        if (v4 > arg0) {
            v4 - arg0
        } else {
            0
        }
    }

    fun execute_dex_swap_sui_to_token(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let (v1, v2) = get_dex_parameters(arg1);
        let v3 = v0 * (10000 - v1) / 10000 * (10000 - v2) / 10000;
        let v4 = if (v3 < 1000) {
            1000
        } else {
            v3
        };
        let v5 = v4 + v0 / 1000;
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) >= v5) {
            if (0x2::coin::value<0x2::sui::SUI>(&arg0) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
            };
            0x2::coin::split<0x2::sui::SUI>(&mut arg0, v5, arg2)
        } else {
            arg0
        }
    }

    fun execute_dex_swap_token_to_sui(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let (v1, v2) = get_dex_parameters(arg1);
        let v3 = v0 * (10000 - v1) / 10000 * (10000 - v2) / 10000;
        let v4 = if (v3 < 1000) {
            1000
        } else {
            v3
        };
        let v5 = v4 + v0 / 500;
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) >= v5) {
            if (0x2::coin::value<0x2::sui::SUI>(&arg0) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
            };
            0x2::coin::split<0x2::sui::SUI>(&mut arg0, v5, arg2)
        } else {
            arg0
        }
    }

    public fun execute_three_way_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: u8, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = if (is_valid_dex(arg1)) {
            if (is_valid_dex(arg2)) {
                is_valid_dex(arg3)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 3);
        let v2 = if (arg1 != arg2) {
            if (arg2 != arg3) {
                arg1 != arg3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 3);
        let v3 = execute_dex_swap_sui_to_token(arg0, arg1, arg6);
        let v4 = execute_dex_swap_token_to_sui(v3, arg2, arg6);
        let v5 = execute_dex_swap_token_to_sui(v4, arg3, arg6);
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&v5);
        let v7 = if (v6 > v0) {
            v6 - v0
        } else {
            0
        };
        assert!(v7 >= arg4, 1);
        let v8 = ArbitrageExecuted{
            executor      : 0x2::tx_context::sender(arg6),
            input_amount  : v0,
            output_amount : v6,
            profit        : v7,
            buy_dex       : arg1,
            sell_dex      : arg3,
            gas_used      : 1500000,
            timestamp     : 0x2::clock::timestamp_ms(arg5),
            tx_hash       : 0x1::string::utf8(b"three_way_tx_hash"),
        };
        0x2::event::emit<ArbitrageExecuted>(v8);
        v5
    }

    public fun execute_two_way_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(is_valid_dex(arg1), 3);
        assert!(is_valid_dex(arg2), 3);
        assert!(arg1 != arg2, 3);
        let v1 = execute_dex_swap_sui_to_token(arg0, arg1, arg5);
        let v2 = execute_dex_swap_token_to_sui(v1, arg2, arg5);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&v2);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg3, 1);
        let v5 = ArbitrageExecuted{
            executor      : 0x2::tx_context::sender(arg5),
            input_amount  : v0,
            output_amount : v3,
            profit        : v4,
            buy_dex       : arg1,
            sell_dex      : arg2,
            gas_used      : 1000000,
            timestamp     : 0x2::clock::timestamp_ms(arg4),
            tx_hash       : 0x1::string::utf8(b"real_tx_hash"),
        };
        0x2::event::emit<ArbitrageExecuted>(v5);
        v2
    }

    public fun get_dex_name(arg0: u8) : 0x1::string::String {
        if (arg0 == 1) {
            0x1::string::utf8(b"Cetus")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Turbos")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Bluefin")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Kriya")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"Aftermath")
        } else if (arg0 == 6) {
            0x1::string::utf8(b"FlowX")
        } else if (arg0 == 7) {
            0x1::string::utf8(b"DeepBook")
        } else {
            0x1::string::utf8(b"Unknown")
        }
    }

    fun get_dex_parameters(arg0: u8) : (u64, u64) {
        if (arg0 == 1) {
            (30, 10)
        } else if (arg0 == 2) {
            (25, 15)
        } else {
            let (v2, v3) = if (arg0 == 3) {
                (12, 20)
            } else {
                let (v4, v5) = if (arg0 == 4) {
                    (30, 20)
                } else if (arg0 == 5) {
                    (5, 8)
                } else if (arg0 == 6) {
                    (25, 18)
                } else if (arg0 == 7) {
                    (10, 5)
                } else {
                    (50, 50)
                };
                (v5, v4)
            };
            (v3, v2)
        }
    }

    fun is_valid_dex(arg0: u8) : bool {
        arg0 >= 1 && arg0 <= 7
    }

    // decompiled from Move bytecode v6
}

