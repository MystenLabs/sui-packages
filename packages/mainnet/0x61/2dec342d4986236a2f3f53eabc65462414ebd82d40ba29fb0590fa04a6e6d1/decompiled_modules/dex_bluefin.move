module 0x612dec342d4986236a2f3f53eabc65462414ebd82d40ba29fb0590fa04a6e6d1::dex_bluefin {
    struct BluefinSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        fee_tier: u64,
        method: vector<u8>,
        package: address,
        timestamp: u64,
    }

    public fun get_bluefin_package() : address {
        0x612dec342d4986236a2f3f53eabc65462414ebd82d40ba29fb0590fa04a6e6d1::constants::bluefin_package()
    }

    public fun get_bluefin_sui_usdc_pool() : address {
        0x612dec342d4986236a2f3f53eabc65462414ebd82d40ba29fb0590fa04a6e6d1::constants::bluefin_sui_usdc_pool()
    }

    public fun is_bluefin_operational() : bool {
        0x612dec342d4986236a2f3f53eabc65462414ebd82d40ba29fb0590fa04a6e6d1::constants::bluefin_package() != @0x0
    }

    public fun validate_bluefin_ptb_params(arg0: u64, arg1: u64, arg2: address) : bool {
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
        assert!(arg0 > 0, 9001);
        assert!(arg1 > 0, 9004);
        assert!(arg2 != @0x0, 9003);
        let v0 = BluefinSwapExecuted{
            sender         : 0x2::tx_context::sender(arg4),
            amount_in      : arg0,
            min_amount_out : arg1,
            pool_id        : arg2,
            fee_tier       : 100,
            method         : b"ptb_validation_call",
            package        : 0x612dec342d4986236a2f3f53eabc65462414ebd82d40ba29fb0590fa04a6e6d1::constants::bluefin_package(),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BluefinSwapExecuted>(v0);
        true
    }

    // decompiled from Move bytecode v6
}

