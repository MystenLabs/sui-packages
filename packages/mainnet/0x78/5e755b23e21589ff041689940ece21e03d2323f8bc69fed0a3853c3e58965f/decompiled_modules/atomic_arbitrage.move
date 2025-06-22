module 0x785e755b23e21589ff041689940ece21e03d2323f8bc69fed0a3853c3e58965f::atomic_arbitrage {
    struct ArbitrageSwapExecuted has copy, drop {
        route: vector<u8>,
        input_amount: u64,
        min_output_amount: u64,
        pool_id: address,
        sender: address,
        timestamp: u64,
    }

    public fun arb_sui_usdc_aftermath(arg0: u64, arg1: u64, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : bool {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 1102);
        assert!(arg0 > 0, 1103);
        assert!(arg1 > 0, 1104);
        assert!(arg2 != @0x0, 1105);
        let v0 = ArbitrageSwapExecuted{
            route             : b"SUI_USDC_AFTERMATH",
            input_amount      : arg0,
            min_output_amount : arg1,
            pool_id           : arg2,
            sender            : 0x2::tx_context::sender(arg5),
            timestamp         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ArbitrageSwapExecuted>(v0);
        true
    }

    public fun arb_sui_usdc_bluefin(arg0: u64, arg1: u64, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : bool {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 1102);
        assert!(arg0 > 0, 1103);
        assert!(arg1 > 0, 1104);
        assert!(arg2 != @0x0, 1105);
        let v0 = ArbitrageSwapExecuted{
            route             : b"SUI_USDC_BLUEFIN",
            input_amount      : arg0,
            min_output_amount : arg1,
            pool_id           : arg2,
            sender            : 0x2::tx_context::sender(arg5),
            timestamp         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ArbitrageSwapExecuted>(v0);
        true
    }

    public fun arb_sui_usdc_cetus(arg0: u64, arg1: u64, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : bool {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 1102);
        assert!(arg0 > 0, 1103);
        assert!(arg1 > 0, 1104);
        assert!(arg2 != @0x0, 1105);
        let v0 = ArbitrageSwapExecuted{
            route             : b"SUI_USDC_CETUS",
            input_amount      : arg0,
            min_output_amount : arg1,
            pool_id           : arg2,
            sender            : 0x2::tx_context::sender(arg5),
            timestamp         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ArbitrageSwapExecuted>(v0);
        true
    }

    public fun arb_sui_usdc_deepbook(arg0: u64, arg1: u64, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : bool {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 1102);
        assert!(arg0 > 0, 1103);
        assert!(arg1 > 0, 1104);
        assert!(arg2 != @0x0, 1105);
        let v0 = ArbitrageSwapExecuted{
            route             : b"SUI_USDC_DEEPBOOK",
            input_amount      : arg0,
            min_output_amount : arg1,
            pool_id           : arg2,
            sender            : 0x2::tx_context::sender(arg5),
            timestamp         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ArbitrageSwapExecuted>(v0);
        true
    }

    public fun arb_sui_usdc_kriya(arg0: u64, arg1: u64, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : bool {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 1102);
        assert!(arg0 > 0, 1103);
        assert!(arg1 > 0, 1104);
        assert!(arg2 != @0x0, 1105);
        let v0 = ArbitrageSwapExecuted{
            route             : b"SUI_USDC_KRIYA",
            input_amount      : arg0,
            min_output_amount : arg1,
            pool_id           : arg2,
            sender            : 0x2::tx_context::sender(arg5),
            timestamp         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ArbitrageSwapExecuted>(v0);
        true
    }

    public fun arb_sui_usdc_sui_aftermath_kriya(arg0: u64, arg1: u64, arg2: u64, arg3: address, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : bool {
        assert!(0x2::clock::timestamp_ms(arg6) <= arg5, 1102);
        assert!(arg0 > 0, 1103);
        assert!(arg1 > 0, 1104);
        assert!(arg2 > 0, 1104);
        assert!(arg3 != @0x0, 1105);
        assert!(arg4 != @0x0, 1105);
        let v0 = ArbitrageSwapExecuted{
            route             : b"SUI_USDC_SUI_AFTERMATH_KRIYA",
            input_amount      : arg0,
            min_output_amount : arg2,
            pool_id           : arg3,
            sender            : 0x2::tx_context::sender(arg7),
            timestamp         : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<ArbitrageSwapExecuted>(v0);
        true
    }

    public fun arb_sui_usdc_sui_bluefin_deepbook(arg0: u64, arg1: u64, arg2: u64, arg3: address, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : bool {
        assert!(0x2::clock::timestamp_ms(arg6) <= arg5, 1102);
        assert!(arg0 > 0, 1103);
        assert!(arg1 > 0, 1104);
        assert!(arg2 > 0, 1104);
        assert!(arg3 != @0x0, 1105);
        assert!(arg4 != @0x0, 1105);
        let v0 = ArbitrageSwapExecuted{
            route             : b"SUI_USDC_SUI_BLUEFIN_DEEPBOOK",
            input_amount      : arg0,
            min_output_amount : arg2,
            pool_id           : arg3,
            sender            : 0x2::tx_context::sender(arg7),
            timestamp         : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<ArbitrageSwapExecuted>(v0);
        true
    }

    public fun arb_sui_usdc_sui_cetus_kriya(arg0: u64, arg1: u64, arg2: u64, arg3: address, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : bool {
        assert!(0x2::clock::timestamp_ms(arg6) <= arg5, 1102);
        assert!(arg0 > 0, 1103);
        assert!(arg1 > 0, 1104);
        assert!(arg2 > 0, 1104);
        assert!(arg3 != @0x0, 1105);
        assert!(arg4 != @0x0, 1105);
        let v0 = ArbitrageSwapExecuted{
            route             : b"SUI_USDC_SUI_CETUS_KRIYA",
            input_amount      : arg0,
            min_output_amount : arg2,
            pool_id           : arg3,
            sender            : 0x2::tx_context::sender(arg7),
            timestamp         : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<ArbitrageSwapExecuted>(v0);
        true
    }

    public fun arb_sui_usdc_sui_cetus_turbos(arg0: u64, arg1: u64, arg2: u64, arg3: address, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : bool {
        assert!(0x2::clock::timestamp_ms(arg6) <= arg5, 1102);
        assert!(arg0 > 0, 1103);
        assert!(arg1 > 0, 1104);
        assert!(arg2 > 0, 1104);
        assert!(arg3 != @0x0, 1105);
        assert!(arg4 != @0x0, 1105);
        let v0 = ArbitrageSwapExecuted{
            route             : b"SUI_USDC_SUI_CETUS_TURBOS",
            input_amount      : arg0,
            min_output_amount : arg2,
            pool_id           : arg3,
            sender            : 0x2::tx_context::sender(arg7),
            timestamp         : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<ArbitrageSwapExecuted>(v0);
        true
    }

    public fun arb_sui_usdc_sui_deepbook_bluefin(arg0: u64, arg1: u64, arg2: u64, arg3: address, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : bool {
        assert!(0x2::clock::timestamp_ms(arg6) <= arg5, 1102);
        assert!(arg0 > 0, 1103);
        assert!(arg1 > 0, 1104);
        assert!(arg2 > 0, 1104);
        assert!(arg3 != @0x0, 1105);
        assert!(arg4 != @0x0, 1105);
        let v0 = ArbitrageSwapExecuted{
            route             : b"SUI_USDC_SUI_DEEPBOOK_BLUEFIN",
            input_amount      : arg0,
            min_output_amount : arg2,
            pool_id           : arg3,
            sender            : 0x2::tx_context::sender(arg7),
            timestamp         : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<ArbitrageSwapExecuted>(v0);
        true
    }

    public fun arb_sui_usdc_sui_deepbook_turbos(arg0: u64, arg1: u64, arg2: u64, arg3: address, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : bool {
        assert!(0x2::clock::timestamp_ms(arg6) <= arg5, 1102);
        assert!(arg0 > 0, 1103);
        assert!(arg1 > 0, 1104);
        assert!(arg2 > 0, 1104);
        assert!(arg3 != @0x0, 1105);
        assert!(arg4 != @0x0, 1105);
        let v0 = ArbitrageSwapExecuted{
            route             : b"SUI_USDC_SUI_DEEPBOOK_TURBOS",
            input_amount      : arg0,
            min_output_amount : arg2,
            pool_id           : arg3,
            sender            : 0x2::tx_context::sender(arg7),
            timestamp         : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<ArbitrageSwapExecuted>(v0);
        true
    }

    public fun arb_sui_usdc_sui_flowx_bidirectional(arg0: u64, arg1: u64, arg2: u64, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : bool {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 1102);
        assert!(arg0 > 0, 1103);
        assert!(arg1 > 0, 1104);
        assert!(arg2 > 0, 1104);
        assert!(arg3 != @0x0, 1105);
        let v0 = ArbitrageSwapExecuted{
            route             : b"SUI_USDC_SUI_FLOWX_BIDIRECTIONAL",
            input_amount      : arg0,
            min_output_amount : arg2,
            pool_id           : arg3,
            sender            : 0x2::tx_context::sender(arg6),
            timestamp         : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ArbitrageSwapExecuted>(v0);
        true
    }

    public fun arb_sui_usdc_sui_flowx_kriya(arg0: u64, arg1: u64, arg2: u64, arg3: address, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : bool {
        assert!(0x2::clock::timestamp_ms(arg6) <= arg5, 1102);
        assert!(arg0 > 0, 1103);
        assert!(arg1 > 0, 1104);
        assert!(arg2 > 0, 1104);
        assert!(arg3 != @0x0, 1105);
        assert!(arg4 != @0x0, 1105);
        let v0 = ArbitrageSwapExecuted{
            route             : b"SUI_USDC_SUI_FLOWX_KRIYA",
            input_amount      : arg0,
            min_output_amount : arg2,
            pool_id           : arg3,
            sender            : 0x2::tx_context::sender(arg7),
            timestamp         : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<ArbitrageSwapExecuted>(v0);
        true
    }

    public fun arb_sui_usdc_sui_kriya_aftermath(arg0: u64, arg1: u64, arg2: u64, arg3: address, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : bool {
        assert!(0x2::clock::timestamp_ms(arg6) <= arg5, 1102);
        assert!(arg0 > 0, 1103);
        assert!(arg1 > 0, 1104);
        assert!(arg2 > 0, 1104);
        assert!(arg3 != @0x0, 1105);
        assert!(arg4 != @0x0, 1105);
        let v0 = ArbitrageSwapExecuted{
            route             : b"SUI_USDC_SUI_KRIYA_AFTERMATH",
            input_amount      : arg0,
            min_output_amount : arg2,
            pool_id           : arg3,
            sender            : 0x2::tx_context::sender(arg7),
            timestamp         : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<ArbitrageSwapExecuted>(v0);
        true
    }

    public fun arb_sui_usdc_sui_kriya_cetus(arg0: u64, arg1: u64, arg2: u64, arg3: address, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : bool {
        assert!(0x2::clock::timestamp_ms(arg6) <= arg5, 1102);
        assert!(arg0 > 0, 1103);
        assert!(arg1 > 0, 1104);
        assert!(arg2 > 0, 1104);
        assert!(arg3 != @0x0, 1105);
        assert!(arg4 != @0x0, 1105);
        let v0 = ArbitrageSwapExecuted{
            route             : b"SUI_USDC_SUI_KRIYA_CETUS",
            input_amount      : arg0,
            min_output_amount : arg2,
            pool_id           : arg3,
            sender            : 0x2::tx_context::sender(arg7),
            timestamp         : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<ArbitrageSwapExecuted>(v0);
        true
    }

    public fun arb_sui_usdc_sui_kriya_flowx(arg0: u64, arg1: u64, arg2: u64, arg3: address, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : bool {
        assert!(0x2::clock::timestamp_ms(arg6) <= arg5, 1102);
        assert!(arg0 > 0, 1103);
        assert!(arg1 > 0, 1104);
        assert!(arg2 > 0, 1104);
        assert!(arg3 != @0x0, 1105);
        assert!(arg4 != @0x0, 1105);
        let v0 = ArbitrageSwapExecuted{
            route             : b"SUI_USDC_SUI_KRIYA_FLOWX",
            input_amount      : arg0,
            min_output_amount : arg2,
            pool_id           : arg3,
            sender            : 0x2::tx_context::sender(arg7),
            timestamp         : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<ArbitrageSwapExecuted>(v0);
        true
    }

    public fun arb_sui_usdc_sui_turbos_cetus(arg0: u64, arg1: u64, arg2: u64, arg3: address, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : bool {
        assert!(0x2::clock::timestamp_ms(arg6) <= arg5, 1102);
        assert!(arg0 > 0, 1103);
        assert!(arg1 > 0, 1104);
        assert!(arg2 > 0, 1104);
        assert!(arg3 != @0x0, 1105);
        assert!(arg4 != @0x0, 1105);
        let v0 = ArbitrageSwapExecuted{
            route             : b"SUI_USDC_SUI_TURBOS_CETUS",
            input_amount      : arg0,
            min_output_amount : arg2,
            pool_id           : arg3,
            sender            : 0x2::tx_context::sender(arg7),
            timestamp         : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<ArbitrageSwapExecuted>(v0);
        true
    }

    public fun arb_sui_usdc_turbos(arg0: u64, arg1: u64, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : bool {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 1102);
        assert!(arg0 > 0, 1103);
        assert!(arg1 > 0, 1104);
        assert!(arg2 != @0x0, 1105);
        let v0 = ArbitrageSwapExecuted{
            route             : b"SUI_USDC_TURBOS",
            input_amount      : arg0,
            min_output_amount : arg1,
            pool_id           : arg2,
            sender            : 0x2::tx_context::sender(arg5),
            timestamp         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ArbitrageSwapExecuted>(v0);
        true
    }

    public fun get_available_dex_packages() : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = &mut v0;
        0x1::vector::push_back<address>(v1, 0x785e755b23e21589ff041689940ece21e03d2323f8bc69fed0a3853c3e58965f::constants::turbos_package());
        0x1::vector::push_back<address>(v1, 0x785e755b23e21589ff041689940ece21e03d2323f8bc69fed0a3853c3e58965f::constants::cetus_package());
        0x1::vector::push_back<address>(v1, 0x785e755b23e21589ff041689940ece21e03d2323f8bc69fed0a3853c3e58965f::constants::deepbook_package());
        0x1::vector::push_back<address>(v1, 0x785e755b23e21589ff041689940ece21e03d2323f8bc69fed0a3853c3e58965f::constants::bluefin_package());
        0x1::vector::push_back<address>(v1, 0x785e755b23e21589ff041689940ece21e03d2323f8bc69fed0a3853c3e58965f::constants::kriya_package());
        0x1::vector::push_back<address>(v1, 0x785e755b23e21589ff041689940ece21e03d2323f8bc69fed0a3853c3e58965f::constants::aftermath_package());
        0x1::vector::push_back<address>(v1, 0x785e755b23e21589ff041689940ece21e03d2323f8bc69fed0a3853c3e58965f::constants::flowx_package());
        v0
    }

    public fun validate_ptb_params(arg0: u64, arg1: u64, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) : bool {
        if (arg0 > 0) {
            if (arg1 > 0) {
                if (arg2 != @0x0) {
                    0x2::clock::timestamp_ms(arg4) <= arg3
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

