module 0x8c6fe7fb4ae7083f43adfafb13a390f41ba19bc98c9c06cf115dc26efec73d04::atomic_arbitrage_minimal {
    struct USDC has drop {
        dummy_field: bool,
    }

    struct AtomicArbitrageExecuted has copy, drop {
        sender: address,
        input_amount: u64,
        output_amount: u64,
        profit: u64,
        dex_a: vector<u8>,
        dex_b: vector<u8>,
        timestamp: u64,
    }

    public entry fun arb_cetus_turbos(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: address, arg3: u64, arg4: u128, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v1 > 0, 1001);
        assert!(v1 >= v1 + arg3, 1002);
        let v2 = AtomicArbitrageExecuted{
            sender        : v0,
            input_amount  : v1,
            output_amount : v1,
            profit        : v1 - v1,
            dex_a         : b"CETUS",
            dex_b         : b"TURBOS",
            timestamp     : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v0);
    }

    public entry fun arb_kriya_cetus(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: address, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v1 > 0, 1001);
        assert!(v1 >= v1 + arg3, 1002);
        let v2 = AtomicArbitrageExecuted{
            sender        : v0,
            input_amount  : v1,
            output_amount : v1,
            profit        : v1 - v1,
            dex_a         : b"KRIYA",
            dex_b         : b"CETUS",
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v0);
    }

    public entry fun execute_atomic_arbitrage_bluefin_deepbook(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: address, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v1 > 0, 1001);
        assert!(v1 >= v1 + arg3, 1002);
        let v2 = AtomicArbitrageExecuted{
            sender        : v0,
            input_amount  : v1,
            output_amount : v1,
            profit        : v1 - v1,
            dex_a         : b"BLUEFIN",
            dex_b         : b"DEEPBOOK",
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v0);
    }

    public entry fun execute_atomic_arbitrage_deepbook_bluefin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: address, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v1 > 0, 1001);
        assert!(v1 >= v1 + arg3, 1002);
        let v2 = AtomicArbitrageExecuted{
            sender        : v0,
            input_amount  : v1,
            output_amount : v1,
            profit        : v1 - v1,
            dex_a         : b"DEEPBOOK",
            dex_b         : b"BLUEFIN",
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

