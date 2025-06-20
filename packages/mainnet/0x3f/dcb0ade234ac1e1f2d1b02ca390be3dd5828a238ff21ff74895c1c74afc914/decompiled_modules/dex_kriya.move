module 0x3fdcb0ade234ac1e1f2d1b02ca390be3dd5828a238ff21ff74895c1c74afc914::dex_kriya {
    struct KriyaSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        method: vector<u8>,
        timestamp: u64,
    }

    public fun get_kriya_package() : address {
        @0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66
    }

    public fun validate_kriya_swap_params(arg0: u64, arg1: u64, arg2: address) : bool {
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
        assert!(arg0 > 0, 5001);
        assert!(arg1 > 0, 5004);
        assert!(arg2 != @0x0, 5003);
        let v0 = KriyaSwapExecuted{
            sender         : 0x2::tx_context::sender(arg4),
            amount_in      : arg0,
            min_amount_out : arg1,
            pool_id        : arg2,
            method         : b"ptb_validation_call",
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<KriyaSwapExecuted>(v0);
        true
    }

    // decompiled from Move bytecode v6
}

