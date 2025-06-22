module 0xb500760004acc014bd5d919a52e4b9e9bc854086813bb48f5452e1171981a61b::dex_aftermath {
    struct AftermathSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        fee_tier: u64,
        method: vector<u8>,
        package: address,
        timestamp: u64,
    }

    public fun get_aftermath_package() : address {
        0xb500760004acc014bd5d919a52e4b9e9bc854086813bb48f5452e1171981a61b::constants::aftermath_package()
    }

    public fun get_aftermath_sui_usdc_pool() : address {
        @0x7903f6ab51fba9f9f88d78a77f1d5d1ae3b73f6515c3d4e7a4c7b56b8c22c3e7
    }

    public fun is_aftermath_operational() : bool {
        0xb500760004acc014bd5d919a52e4b9e9bc854086813bb48f5452e1171981a61b::constants::aftermath_package() != @0x0
    }

    public fun validate_aftermath_ptb_params(arg0: u64, arg1: u64, arg2: address) : bool {
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
            fee_tier       : 250,
            method         : b"ptb_validation_call",
            package        : 0xb500760004acc014bd5d919a52e4b9e9bc854086813bb48f5452e1171981a61b::constants::aftermath_package(),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AftermathSwapExecuted>(v0);
        true
    }

    // decompiled from Move bytecode v6
}

