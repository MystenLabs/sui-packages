module 0xa45e1445c1be99640c5a66f3a380e0e57c14fcb98ab558b8b19e65c8a6694181::dex_cetus {
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

    public fun cetus_external_delivery_impl(arg0: u64, arg1: address) {
    }

    public fun cetus_external_swap_direct(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 7001);
        assert!(arg2 > 0, 7004);
        assert!(arg1 != @0x0, 7003);
        let v1 = calculate_min_usdc_output(v0);
        assert!(v1 >= arg2, 7001);
        cetus_pure_swap_function(arg0, v1, arg3);
    }

    public fun cetus_pure_swap_function(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: address) {
        0x2::balance::destroy_zero<0x2::sui::SUI>(0x2::coin::into_balance<0x2::sui::SUI>(arg0));
    }

    public fun get_cetus_package() : address {
        0xa45e1445c1be99640c5a66f3a380e0e57c14fcb98ab558b8b19e65c8a6694181::constants::cetus_package()
    }

    public fun get_cetus_sui_usdc_pool() : address {
        0xa45e1445c1be99640c5a66f3a380e0e57c14fcb98ab558b8b19e65c8a6694181::constants::cetus_sui_usdc_pool()
    }

    public fun is_cetus_operational() : bool {
        0xa45e1445c1be99640c5a66f3a380e0e57c14fcb98ab558b8b19e65c8a6694181::constants::cetus_package() != @0x0
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
            package        : 0xa45e1445c1be99640c5a66f3a380e0e57c14fcb98ab558b8b19e65c8a6694181::constants::cetus_package(),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CetusSwapExecuted>(v0);
        true
    }

    // decompiled from Move bytecode v6
}

