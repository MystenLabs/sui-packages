module 0x1e130edfa2f848d533de8335fbd32fb898aad79b69190342d2d1832e73037ac2::atomic_arbitrage {
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

    public fun calculate_min_usdc_output(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 * get_sui_price_in_usdc() / 1000000000;
        v0 - v0 * arg1 / 10000
    }

    public fun get_available_dex_packages() : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = &mut v0;
        0x1::vector::push_back<address>(v1, 0x1e130edfa2f848d533de8335fbd32fb898aad79b69190342d2d1832e73037ac2::constants::turbos_package());
        0x1::vector::push_back<address>(v1, 0x1e130edfa2f848d533de8335fbd32fb898aad79b69190342d2d1832e73037ac2::constants::cetus_package());
        0x1::vector::push_back<address>(v1, 0x1e130edfa2f848d533de8335fbd32fb898aad79b69190342d2d1832e73037ac2::constants::deepbook_package());
        0x1::vector::push_back<address>(v1, 0x1e130edfa2f848d533de8335fbd32fb898aad79b69190342d2d1832e73037ac2::constants::kriya_package());
        0x1::vector::push_back<address>(v1, 0x1e130edfa2f848d533de8335fbd32fb898aad79b69190342d2d1832e73037ac2::constants::aftermath_package());
        0x1::vector::push_back<address>(v1, 0x1e130edfa2f848d533de8335fbd32fb898aad79b69190342d2d1832e73037ac2::constants::bluefin_package());
        v0
    }

    public fun get_sui_price_in_usdc() : u64 {
        1050000
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

