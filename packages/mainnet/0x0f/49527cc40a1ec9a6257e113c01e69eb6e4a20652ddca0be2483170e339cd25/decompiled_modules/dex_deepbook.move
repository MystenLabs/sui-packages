module 0xf49527cc40a1ec9a6257e113c01e69eb6e4a20652ddca0be2483170e339cd25::dex_deepbook {
    struct DeepBookRealSwapExecuted has copy, drop {
        sender: address,
        sui_amount_in: u64,
        usdc_amount_out: u64,
        pool_id: address,
        package: address,
        timestamp: u64,
    }

    public fun get_deepbook_package() : address {
        0xf49527cc40a1ec9a6257e113c01e69eb6e4a20652ddca0be2483170e339cd25::constants::deepbook_package()
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
        assert!(arg1 > 0, 6002);
        assert!(arg2 != @0x0, 6003);
        let v0 = DeepBookRealSwapExecuted{
            sender          : 0x2::tx_context::sender(arg4),
            sui_amount_in   : arg0,
            usdc_amount_out : arg1,
            pool_id         : arg2,
            package         : 0xf49527cc40a1ec9a6257e113c01e69eb6e4a20652ddca0be2483170e339cd25::constants::deepbook_package(),
            timestamp       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DeepBookRealSwapExecuted>(v0);
        true
    }

    // decompiled from Move bytecode v6
}

