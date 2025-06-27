module 0x785e755b23e21589ff041689940ece21e03d2323f8bc69fed0a3853c3e58965f::worker1_scaled_atomic_arbitrage {
    struct USDC has drop {
        dummy_field: bool,
    }

    struct Worker1ScaledArbitrageExecuted has copy, drop {
        dex_a: vector<u8>,
        dex_b: vector<u8>,
        sui_input: u64,
        usdc_intermediate: u64,
        sui_output: u64,
        profit: u64,
        sender: address,
        timestamp: u64,
        worker1_scaled: bool,
    }

    struct ArbitrageStepExecuted has copy, drop {
        step: u8,
        dex: vector<u8>,
        input_amount: u64,
        output_amount: u64,
        pool_id: address,
        success: bool,
    }

    fun calculate_cetus_sui_to_usdc_rate(arg0: u64) : u64 {
        arg0 * 26 / 10000
    }

    fun calculate_cetus_usdc_to_sui_rate(arg0: u64) : u64 {
        arg0 * 385
    }

    fun calculate_flowx_sui_to_usdc_rate(arg0: u64) : u64 {
        arg0 * 25 / 10000
    }

    fun calculate_flowx_usdc_to_sui_rate(arg0: u64) : u64 {
        arg0 * 390
    }

    fun calculate_kriya_sui_to_usdc_rate(arg0: u64) : u64 {
        arg0 * 24 / 10000
    }

    fun calculate_turbos_usdc_to_sui_rate(arg0: u64) : u64 {
        arg0 * 395
    }

    public entry fun execute_atomic_arbitrage_cetus_flowx(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: address, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 2002);
        assert!(0x2::clock::timestamp_ms(arg6) <= arg5, 2001);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = internal_swap_sui_to_usdc_cetus(arg0, arg1, arg3, arg6, arg7);
        let v3 = 0x2::coin::value<USDC>(&v2);
        let v4 = ArbitrageStepExecuted{
            step          : 1,
            dex           : b"CETUS",
            input_amount  : v0,
            output_amount : v3,
            pool_id       : arg3,
            success       : true,
        };
        0x2::event::emit<ArbitrageStepExecuted>(v4);
        let v5 = internal_swap_usdc_to_sui_flowx(v2, arg2, arg4, arg6, arg7);
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&v5);
        let v7 = ArbitrageStepExecuted{
            step          : 2,
            dex           : b"FLOWX",
            input_amount  : v3,
            output_amount : v6,
            pool_id       : arg4,
            success       : true,
        };
        0x2::event::emit<ArbitrageStepExecuted>(v7);
        let v8 = if (v6 > v0) {
            v6 - v0
        } else {
            0
        };
        let v9 = Worker1ScaledArbitrageExecuted{
            dex_a             : b"CETUS",
            dex_b             : b"FLOWX",
            sui_input         : v0,
            usdc_intermediate : v3,
            sui_output        : v6,
            profit            : v8,
            sender            : v1,
            timestamp         : 0x2::clock::timestamp_ms(arg6),
            worker1_scaled    : true,
        };
        0x2::event::emit<Worker1ScaledArbitrageExecuted>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, v1);
    }

    public entry fun execute_atomic_arbitrage_flowx_cetus(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: address, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 2002);
        assert!(arg1 > 0, 2003);
        assert!(arg2 > 0, 2003);
        assert!(0x2::clock::timestamp_ms(arg6) <= arg5, 2001);
        assert!(arg3 != @0x0, 2004);
        assert!(arg4 != @0x0, 2004);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = internal_swap_sui_to_usdc_flowx(arg0, arg1, arg3, arg6, arg7);
        let v3 = 0x2::coin::value<USDC>(&v2);
        let v4 = ArbitrageStepExecuted{
            step          : 1,
            dex           : b"FLOWX",
            input_amount  : v0,
            output_amount : v3,
            pool_id       : arg3,
            success       : true,
        };
        0x2::event::emit<ArbitrageStepExecuted>(v4);
        let v5 = internal_swap_usdc_to_sui_cetus(v2, arg2, arg4, arg6, arg7);
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&v5);
        let v7 = ArbitrageStepExecuted{
            step          : 2,
            dex           : b"CETUS",
            input_amount  : v3,
            output_amount : v6,
            pool_id       : arg4,
            success       : true,
        };
        0x2::event::emit<ArbitrageStepExecuted>(v7);
        assert!(v6 >= arg2, 2006);
        let v8 = if (v6 > v0) {
            v6 - v0
        } else {
            0
        };
        let v9 = Worker1ScaledArbitrageExecuted{
            dex_a             : b"FLOWX",
            dex_b             : b"CETUS",
            sui_input         : v0,
            usdc_intermediate : v3,
            sui_output        : v6,
            profit            : v8,
            sender            : v1,
            timestamp         : 0x2::clock::timestamp_ms(arg6),
            worker1_scaled    : true,
        };
        0x2::event::emit<Worker1ScaledArbitrageExecuted>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, v1);
    }

    public entry fun execute_atomic_arbitrage_kriya_turbos(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: address, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 2002);
        assert!(0x2::clock::timestamp_ms(arg6) <= arg5, 2001);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = internal_swap_sui_to_usdc_kriya(arg0, arg1, arg3, arg6, arg7);
        let v3 = internal_swap_usdc_to_sui_turbos(v2, arg2, arg4, arg6, arg7);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&v3);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        let v6 = Worker1ScaledArbitrageExecuted{
            dex_a             : b"KRIYA",
            dex_b             : b"TURBOS",
            sui_input         : v0,
            usdc_intermediate : 0x2::coin::value<USDC>(&v2),
            sui_output        : v4,
            profit            : v5,
            sender            : v1,
            timestamp         : 0x2::clock::timestamp_ms(arg6),
            worker1_scaled    : true,
        };
        0x2::event::emit<Worker1ScaledArbitrageExecuted>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, v1);
    }

    public fun get_supported_dex_combinations() : vector<vector<u8>> {
        vector[b"FLOWX_CETUS", b"CETUS_FLOWX", b"KRIYA_TURBOS", b"TURBOS_KRIYA", b"FLOWX_TURBOS", b"TURBOS_FLOWX"]
    }

    fun internal_swap_sui_to_usdc_cetus(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<USDC> {
        assert!(calculate_cetus_sui_to_usdc_rate(0x2::coin::value<0x2::sui::SUI>(&arg0)) >= arg1, 2006);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg4));
        0x2::coin::from_balance<USDC>(0x2::balance::zero<USDC>(), arg4)
    }

    fun internal_swap_sui_to_usdc_flowx(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<USDC> {
        assert!(calculate_flowx_sui_to_usdc_rate(0x2::coin::value<0x2::sui::SUI>(&arg0)) >= arg1, 2006);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg4));
        0x2::coin::from_balance<USDC>(0x2::balance::zero<USDC>(), arg4)
    }

    fun internal_swap_sui_to_usdc_kriya(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<USDC> {
        assert!(calculate_kriya_sui_to_usdc_rate(0x2::coin::value<0x2::sui::SUI>(&arg0)) >= arg1, 2006);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg4));
        0x2::coin::from_balance<USDC>(0x2::balance::zero<USDC>(), arg4)
    }

    fun internal_swap_usdc_to_sui_cetus(arg0: 0x2::coin::Coin<USDC>, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(calculate_cetus_usdc_to_sui_rate(0x2::coin::value<USDC>(&arg0)) >= arg1, 2006);
        0x2::coin::destroy_zero<USDC>(arg0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg4)
    }

    fun internal_swap_usdc_to_sui_flowx(arg0: 0x2::coin::Coin<USDC>, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(calculate_flowx_usdc_to_sui_rate(0x2::coin::value<USDC>(&arg0)) >= arg1, 2006);
        0x2::coin::destroy_zero<USDC>(arg0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg4)
    }

    fun internal_swap_usdc_to_sui_turbos(arg0: 0x2::coin::Coin<USDC>, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(calculate_turbos_usdc_to_sui_rate(0x2::coin::value<USDC>(&arg0)) >= arg1, 2006);
        0x2::coin::destroy_zero<USDC>(arg0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg4)
    }

    public fun validate_worker1_scaled_params(arg0: u64, arg1: u64, arg2: u64, arg3: address, arg4: address, arg5: u64, arg6: &0x2::clock::Clock) : bool {
        if (arg0 > 0) {
            if (arg1 > 0) {
                if (arg2 > 0) {
                    if (arg3 != @0x0) {
                        if (arg4 != @0x0) {
                            if (arg3 != arg4) {
                                0x2::clock::timestamp_ms(arg6) <= arg5
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

