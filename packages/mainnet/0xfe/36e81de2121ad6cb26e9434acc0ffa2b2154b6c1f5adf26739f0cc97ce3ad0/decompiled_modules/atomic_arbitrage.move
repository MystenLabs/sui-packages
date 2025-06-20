module 0xfe36e81de2121ad6cb26e9434acc0ffa2b2154b6c1f5adf26739f0cc97ce3ad0::atomic_arbitrage {
    struct RealArbitrageExecuted has copy, drop {
        route: vector<u8>,
        input_amount: u64,
        timestamp: u64,
    }

    struct PTBBatchArbitrageExecuted has copy, drop {
        batch_id: u64,
        routes: vector<vector<u8>>,
        total_volume: u64,
        execution_count: u64,
        timestamp: u64,
    }

    public entry fun arb_sui_usdc_aftermath(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) <= arg2, 1102);
        0xfe36e81de2121ad6cb26e9434acc0ffa2b2154b6c1f5adf26739f0cc97ce3ad0::dex_aftermath::swap_sui_to_usdc(arg0, arg1, 1, arg3, arg4);
        let v0 = RealArbitrageExecuted{
            route        : b"SUI_USDC_AFTERMATH",
            input_amount : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            timestamp    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RealArbitrageExecuted>(v0);
    }

    public entry fun arb_sui_usdc_bluefin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) <= arg2, 1102);
        0xfe36e81de2121ad6cb26e9434acc0ffa2b2154b6c1f5adf26739f0cc97ce3ad0::dex_bluefin::swap_sui_to_usdc(arg0, arg1, 1, arg3, arg4);
        let v0 = RealArbitrageExecuted{
            route        : b"SUI_USDC_BLUEFIN",
            input_amount : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            timestamp    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RealArbitrageExecuted>(v0);
    }

    public entry fun arb_sui_usdc_cetus(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) <= arg2, 1102);
        0xfe36e81de2121ad6cb26e9434acc0ffa2b2154b6c1f5adf26739f0cc97ce3ad0::dex_cetus::swap_sui_to_usdc(arg0, arg1, 1, arg3, arg4);
        let v0 = RealArbitrageExecuted{
            route        : b"SUI_USDC_CETUS",
            input_amount : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            timestamp    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RealArbitrageExecuted>(v0);
    }

    public entry fun arb_sui_usdc_deepbook(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) <= arg2, 1102);
        0xfe36e81de2121ad6cb26e9434acc0ffa2b2154b6c1f5adf26739f0cc97ce3ad0::dex_deepbook::swap_sui_to_usdc(arg0, arg1, 1, arg3, arg4);
        let v0 = RealArbitrageExecuted{
            route        : b"SUI_USDC_DEEPBOOK",
            input_amount : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            timestamp    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RealArbitrageExecuted>(v0);
    }

    public entry fun arb_sui_usdc_kriya(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) <= arg2, 1102);
        0xfe36e81de2121ad6cb26e9434acc0ffa2b2154b6c1f5adf26739f0cc97ce3ad0::dex_kriya::swap_sui_to_usdc(arg0, arg1, 1, arg3, arg4);
        let v0 = RealArbitrageExecuted{
            route        : b"SUI_USDC_KRIYA",
            input_amount : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            timestamp    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RealArbitrageExecuted>(v0);
    }

    public entry fun arb_sui_usdc_turbos(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) <= arg2, 1102);
        0xfe36e81de2121ad6cb26e9434acc0ffa2b2154b6c1f5adf26739f0cc97ce3ad0::dex_turbos::swap_sui_to_usdc(arg0, arg1, 1, arg3, arg4);
        let v0 = RealArbitrageExecuted{
            route        : b"SUI_USDC_TURBOS",
            input_amount : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            timestamp    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RealArbitrageExecuted>(v0);
    }

    fun execute_aftermath_swap_ptb(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::value<0x2::sui::SUI>(&arg0);
        0xfe36e81de2121ad6cb26e9434acc0ffa2b2154b6c1f5adf26739f0cc97ce3ad0::dex_aftermath::swap_sui_to_usdc(arg0, arg1, 1, arg2, arg3);
    }

    fun execute_bluefin_swap_ptb(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::value<0x2::sui::SUI>(&arg0);
        0xfe36e81de2121ad6cb26e9434acc0ffa2b2154b6c1f5adf26739f0cc97ce3ad0::dex_bluefin::swap_sui_to_usdc(arg0, arg1, 1, arg2, arg3);
    }

    fun execute_cetus_swap_ptb(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::value<0x2::sui::SUI>(&arg0);
        0xfe36e81de2121ad6cb26e9434acc0ffa2b2154b6c1f5adf26739f0cc97ce3ad0::dex_cetus::swap_sui_to_usdc(arg0, arg1, 1, arg2, arg3);
    }

    fun execute_deepbook_swap_ptb(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::value<0x2::sui::SUI>(&arg0);
        0xfe36e81de2121ad6cb26e9434acc0ffa2b2154b6c1f5adf26739f0cc97ce3ad0::dex_deepbook::swap_sui_to_usdc(arg0, arg1, 1, arg2, arg3);
    }

    fun execute_kriya_swap_ptb(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::value<0x2::sui::SUI>(&arg0);
        0xfe36e81de2121ad6cb26e9434acc0ffa2b2154b6c1f5adf26739f0cc97ce3ad0::dex_kriya::swap_sui_to_usdc(arg0, arg1, 1, arg2, arg3);
    }

    fun execute_turbos_swap_ptb(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::value<0x2::sui::SUI>(&arg0);
        0xfe36e81de2121ad6cb26e9434acc0ffa2b2154b6c1f5adf26739f0cc97ce3ad0::dex_turbos::swap_sui_to_usdc(arg0, arg1, 1, arg2, arg3);
    }

    public fun get_ptb_batch_capacity() : u64 {
        1024
    }

    public fun get_supported_routes() : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"TURBOS");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"DEEPBOOK");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"KRIYA");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"AFTERMATH");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"BLUEFIN");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"CETUS");
        v0
    }

    public entry fun ptb_batch_arbitrage(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: vector<u64>, arg2: vector<address>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0x1::vector::length<u64>(&arg1);
        let v2 = 0x1::vector::empty<vector<u8>>();
        let v3 = 0;
        while (v3 < v1 && v3 < 0x1::vector::length<0x2::coin::Coin<0x2::sui::SUI>>(&arg0)) {
            let v4 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0);
            let v5 = *0x1::vector::borrow<u64>(&arg1, v3);
            v0 = v0 + 0x2::coin::value<0x2::sui::SUI>(&v4);
            if (v5 == 0) {
                execute_turbos_swap_ptb(v4, *0x1::vector::borrow<address>(&arg2, v3), arg4, arg5);
                0x1::vector::push_back<vector<u8>>(&mut v2, b"TURBOS_PTB");
            } else if (v5 == 1) {
                execute_deepbook_swap_ptb(v4, *0x1::vector::borrow<address>(&arg2, v3), arg4, arg5);
                0x1::vector::push_back<vector<u8>>(&mut v2, b"DEEPBOOK_PTB");
            } else if (v5 == 2) {
                execute_kriya_swap_ptb(v4, *0x1::vector::borrow<address>(&arg2, v3), arg4, arg5);
                0x1::vector::push_back<vector<u8>>(&mut v2, b"KRIYA_PTB");
            } else if (v5 == 3) {
                execute_aftermath_swap_ptb(v4, *0x1::vector::borrow<address>(&arg2, v3), arg4, arg5);
                0x1::vector::push_back<vector<u8>>(&mut v2, b"AFTERMATH_PTB");
            } else if (v5 == 4) {
                execute_bluefin_swap_ptb(v4, *0x1::vector::borrow<address>(&arg2, v3), arg4, arg5);
                0x1::vector::push_back<vector<u8>>(&mut v2, b"BLUEFIN_PTB");
            } else {
                assert!(v5 == 5, 1103);
                execute_cetus_swap_ptb(v4, *0x1::vector::borrow<address>(&arg2, v3), arg4, arg5);
                0x1::vector::push_back<vector<u8>>(&mut v2, b"CETUS_PTB");
            };
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
        let v6 = PTBBatchArbitrageExecuted{
            batch_id        : arg3,
            routes          : v2,
            total_volume    : v0,
            execution_count : v1,
            timestamp       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<PTBBatchArbitrageExecuted>(v6);
    }

    public fun validate_ptb_batch(arg0: &vector<u64>, arg1: &vector<address>) : bool {
        let v0 = 0x1::vector::length<u64>(arg0);
        v0 == 0x1::vector::length<address>(arg1) && v0 > 0
    }

    // decompiled from Move bytecode v6
}

