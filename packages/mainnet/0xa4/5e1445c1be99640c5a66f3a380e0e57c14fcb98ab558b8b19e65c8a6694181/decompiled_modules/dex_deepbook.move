module 0xa45e1445c1be99640c5a66f3a380e0e57c14fcb98ab558b8b19e65c8a6694181::dex_deepbook {
    struct DeepBookSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        method: vector<u8>,
        package: address,
        timestamp: u64,
    }

    public fun calculate_min_usdc_output(arg0: u64) : u64 {
        arg0 * 180 / 100 * 95 / 100 / 1000
    }

    public fun get_deepbook_package() : address {
        0xa45e1445c1be99640c5a66f3a380e0e57c14fcb98ab558b8b19e65c8a6694181::constants::deepbook_package()
    }

    public fun get_sui_usdc_pool() : address {
        @0xf948981b806057580f91622417534f491da5f61aeaf33d0ed8e69fd5691c95ce
    }

    public fun validate_deepbook_ptb_params(arg0: u64, arg1: u64, arg2: address) : bool {
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
        let v0 = DeepBookSwapExecuted{
            sender         : 0x2::tx_context::sender(arg4),
            amount_in      : arg0,
            min_amount_out : arg1,
            pool_id        : arg2,
            method         : b"ptb_validation_call",
            package        : 0xa45e1445c1be99640c5a66f3a380e0e57c14fcb98ab558b8b19e65c8a6694181::constants::deepbook_package(),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DeepBookSwapExecuted>(v0);
        true
    }

    // decompiled from Move bytecode v6
}

