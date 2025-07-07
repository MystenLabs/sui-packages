module 0x64d70dc68e8bd47d1120f37026bb95dcd1124b8138a430a8fe0896dc6fb17622::atomic_arbitrage {
    struct AtomicSwapResult has drop {
        input_amount: u64,
        dex_a: u8,
        dex_b: u8,
        success: bool,
    }

    public fun get_exact_sui_amount() : u64 {
        10000000
    }

    public fun is_supported_routing(arg0: u8, arg1: u8) : bool {
        if (arg0 == 1 && arg1 == 2) {
            true
        } else if (arg0 == 1 && arg1 == 3) {
            true
        } else if (arg0 == 2 && arg1 == 1) {
            true
        } else if (arg0 == 3 && arg1 == 1) {
            true
        } else if (arg0 == 5 && arg1 == 1) {
            true
        } else if (arg0 == 6 && arg1 == 1) {
            true
        } else {
            arg0 == 4 && arg1 == 1
        }
    }

    public fun is_valid_dex_id(arg0: u8) : bool {
        arg0 >= 1 && arg0 <= 6
    }

    public entry fun validate_ptb_atomic_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 10000000, 1);
        assert!(arg1 != arg2, 2);
        assert!(is_valid_dex_id(arg1), 6);
        assert!(is_valid_dex_id(arg2), 6);
        assert!(is_supported_routing(arg1, arg2), 6);
        let v0 = AtomicSwapResult{
            input_amount : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            dex_a        : arg1,
            dex_b        : arg2,
            success      : true,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
        let AtomicSwapResult {
            input_amount : _,
            dex_a        : _,
            dex_b        : _,
            success      : _,
        } = v0;
    }

    // decompiled from Move bytecode v6
}

