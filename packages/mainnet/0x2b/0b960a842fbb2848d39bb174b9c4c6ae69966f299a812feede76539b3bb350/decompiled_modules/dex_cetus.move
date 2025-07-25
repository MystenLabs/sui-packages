module 0x2b0b960a842fbb2848d39bb174b9c4c6ae69966f299a812feede76539b3bb350::dex_cetus {
    struct CetusSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        fee_tier: u64,
        method: vector<u8>,
        package: address,
        timestamp: u64,
    }

    public fun get_cetus_package() : address {
        0x2b0b960a842fbb2848d39bb174b9c4c6ae69966f299a812feede76539b3bb350::constants::cetus_package()
    }

    public fun get_cetus_sui_usdc_pool() : address {
        0x2b0b960a842fbb2848d39bb174b9c4c6ae69966f299a812feede76539b3bb350::constants::cetus_sui_usdc_pool()
    }

    public fun is_cetus_operational() : bool {
        0x2b0b960a842fbb2848d39bb174b9c4c6ae69966f299a812feede76539b3bb350::constants::cetus_package() != @0x0
    }

    public fun validate_cetus_ptb_params(arg0: u64, arg1: u64, arg2: address) : bool {
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
        assert!(arg0 > 0, 7001);
        assert!(arg1 > 0, 7004);
        assert!(arg2 != @0x0, 7003);
        let v0 = CetusSwapExecuted{
            sender         : 0x2::tx_context::sender(arg4),
            amount_in      : arg0,
            min_amount_out : arg1,
            pool_id        : arg2,
            fee_tier       : 500,
            method         : b"ptb_validation_call",
            package        : 0x2b0b960a842fbb2848d39bb174b9c4c6ae69966f299a812feede76539b3bb350::constants::cetus_package(),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CetusSwapExecuted>(v0);
        true
    }

    // decompiled from Move bytecode v6
}

