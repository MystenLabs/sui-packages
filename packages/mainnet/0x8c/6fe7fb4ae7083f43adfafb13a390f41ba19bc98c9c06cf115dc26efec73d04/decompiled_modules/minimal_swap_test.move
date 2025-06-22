module 0x8c6fe7fb4ae7083f43adfafb13a390f41ba19bc98c9c06cf115dc26efec73d04::minimal_swap_test {
    struct SwapExecuted has copy, drop {
        dex_name: vector<u8>,
        input_amount: u64,
        calculated_output: u64,
        sender: address,
        timestamp: u64,
    }

    public entry fun test_atomic_arbitrage_calculation(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 7001);
        let v1 = v0 * 2500 / 1000000000 * 395000000 / 1000000;
        let v2 = if (v1 > v0) {
            v1 - v0
        } else {
            0
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x1);
        let v3 = SwapExecuted{
            dex_name          : b"ATOMIC_ARBITRAGE_CALC",
            input_amount      : v0,
            calculated_output : v2,
            sender            : 0x2::tx_context::sender(arg3),
            timestamp         : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SwapExecuted>(v3);
    }

    public entry fun test_bluefin_sui_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 7001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x1);
        let v1 = SwapExecuted{
            dex_name          : b"BLUEFIN_TEST",
            input_amount      : v0,
            calculated_output : v0 * 2500 / 1000000000,
            sender            : 0x2::tx_context::sender(arg3),
            timestamp         : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SwapExecuted>(v1);
    }

    public entry fun test_deepbook_sui_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 7001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x1);
        let v1 = SwapExecuted{
            dex_name          : b"DEEPBOOK_TEST",
            input_amount      : v0,
            calculated_output : v0 * 2480 / 1000000000,
            sender            : 0x2::tx_context::sender(arg3),
            timestamp         : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SwapExecuted>(v1);
    }

    // decompiled from Move bytecode v6
}

