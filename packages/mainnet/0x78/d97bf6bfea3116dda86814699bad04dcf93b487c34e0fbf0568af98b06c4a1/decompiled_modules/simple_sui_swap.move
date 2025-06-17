module 0x78d97bf6bfea3116dda86814699bad04dcf93b487c34e0fbf0568af98b06c4a1::simple_sui_swap {
    struct SwapAttempt has copy, drop {
        user: address,
        amount_in: u64,
        swap_type: vector<u8>,
        timestamp: u64,
    }

    public fun get_test_amount() : u64 {
        10000000
    }

    public entry fun prepare_sui_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(v0 > 0, 1);
        assert!(arg1 > 0, 2);
        let v2 = SwapAttempt{
            user      : v1,
            amount_in : v0,
            swap_type : b"SUI_TO_USDC_PREPARE",
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SwapAttempt>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
    }

    public entry fun test_small_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(v0 <= 10000000, 3);
        assert!(v0 > 0, 4);
        let v2 = SwapAttempt{
            user      : v1,
            amount_in : v0,
            swap_type : b"TEST_SMALL_SUI_SWAP",
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<SwapAttempt>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
    }

    public fun validate_swap_params(arg0: u64, arg1: u64) : bool {
        if (arg0 > 0) {
            if (arg1 > 0) {
                arg0 >= 1000000
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

