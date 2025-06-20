module 0xfe36e81de2121ad6cb26e9434acc0ffa2b2154b6c1f5adf26739f0cc97ce3ad0::dex_cetus {
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

    public fun calculate_cetus_fee(arg0: u64) : u64 {
        arg0 * 500 / 1000000
    }

    public fun calculate_min_usdc_output(arg0: u64) : u64 {
        arg0 * 105 / 100 * 95 / 100 / 1000
    }

    public fun get_cetus_package() : address {
        0xfe36e81de2121ad6cb26e9434acc0ffa2b2154b6c1f5adf26739f0cc97ce3ad0::constants::cetus_package()
    }

    public fun get_cetus_sui_usdc_pool() : address {
        0xfe36e81de2121ad6cb26e9434acc0ffa2b2154b6c1f5adf26739f0cc97ce3ad0::constants::cetus_sui_usdc_pool()
    }

    public fun is_cetus_operational() : bool {
        0xfe36e81de2121ad6cb26e9434acc0ffa2b2154b6c1f5adf26739f0cc97ce3ad0::constants::cetus_package() != @0x0
    }

    public entry fun prepare_sui_for_cetus_ptb(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == arg1, 7001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 7001);
        assert!(arg2 > 0, 7004);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(arg1 != @0x0, 7003);
        let v2 = CetusSwapExecuted{
            sender         : v1,
            amount_in      : v0,
            min_amount_out : arg2,
            pool_id        : arg1,
            fee_tier       : 500,
            method         : b"ptb_external_package_call",
            package        : 0xfe36e81de2121ad6cb26e9434acc0ffa2b2154b6c1f5adf26739f0cc97ce3ad0::constants::cetus_package(),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CetusSwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
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

    // decompiled from Move bytecode v6
}

