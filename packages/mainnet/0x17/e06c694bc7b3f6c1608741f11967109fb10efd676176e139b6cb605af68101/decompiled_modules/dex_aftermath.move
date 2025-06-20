module 0x17e06c694bc7b3f6c1608741f11967109fb10efd676176e139b6cb605af68101::dex_aftermath {
    struct AftermathSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        method: vector<u8>,
        timestamp: u64,
    }

    public fun calculate_min_usdc_output(arg0: u64) : u64 {
        arg0 * 105 / 100 * 95 / 100 / 1000
    }

    public fun get_aftermath_package() : address {
        @0x7903f6ab51fba9f9f88d78a77f1d5d1ae3b73f6515c3d4e7a4c7b56b8c22c3e7
    }

    public fun validate_ptb_params(arg0: u64, arg1: u64, arg2: address) : bool {
        if (arg0 > 0) {
            if (arg1 > 0) {
                arg2 != @0x0
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun validate_sui_usdc_swap(arg0: u64, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : bool {
        assert!(arg0 > 0, 6001);
        assert!(arg1 > 0, 6004);
        assert!(arg2 != @0x0, 6003);
        let v0 = AftermathSwapExecuted{
            sender         : 0x2::tx_context::sender(arg4),
            amount_in      : arg0,
            min_amount_out : arg1,
            pool_id        : arg2,
            method         : b"ptb_validation_call",
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AftermathSwapExecuted>(v0);
        true
    }

    // decompiled from Move bytecode v6
}

