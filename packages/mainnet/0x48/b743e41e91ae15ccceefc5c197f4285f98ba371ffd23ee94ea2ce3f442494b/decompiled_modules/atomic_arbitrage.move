module 0x48b743e41e91ae15ccceefc5c197f4285f98ba371ffd23ee94ea2ce3f442494b::atomic_arbitrage {
    struct AtomicSwapResult has drop {
        input_amount: u64,
        dex_a: u8,
        dex_b: u8,
        success: bool,
    }

    struct SecurityAuditLog has drop {
        amount_limit: u64,
        sqrt_price_limit: u128,
        by_amount_in: bool,
        partner_length: u64,
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

    public entry fun validate_ptb_atomic_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: u8, arg3: u64, arg4: u128, arg5: vector<u8>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 10000000, 1);
        assert!(arg1 != arg2, 2);
        assert!(is_valid_dex_id(arg1), 6);
        assert!(is_valid_dex_id(arg2), 6);
        assert!(arg3 > 0, 1);
        assert!(arg4 > 0, 1);
        assert!(0x1::vector::length<u8>(&arg5) <= 32, 1);
        assert!(is_supported_routing(arg1, arg2), 6);
        let v0 = AtomicSwapResult{
            input_amount : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            dex_a        : arg1,
            dex_b        : arg2,
            success      : true,
        };
        let v1 = SecurityAuditLog{
            amount_limit     : arg3,
            sqrt_price_limit : arg4,
            by_amount_in     : arg6,
            partner_length   : 0x1::vector::length<u8>(&arg5),
        };
        let SecurityAuditLog {
            amount_limit     : _,
            sqrt_price_limit : _,
            by_amount_in     : _,
            partner_length   : _,
        } = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg7));
        let AtomicSwapResult {
            input_amount : _,
            dex_a        : _,
            dex_b        : _,
            success      : _,
        } = v0;
    }

    // decompiled from Move bytecode v6
}

