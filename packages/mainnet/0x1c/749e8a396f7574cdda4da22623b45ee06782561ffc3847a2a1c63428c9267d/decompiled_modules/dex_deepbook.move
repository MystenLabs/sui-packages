module 0x1c749e8a396f7574cdda4da22623b45ee06782561ffc3847a2a1c63428c9267d::dex_deepbook {
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
        0x1c749e8a396f7574cdda4da22623b45ee06782561ffc3847a2a1c63428c9267d::constants::deepbook_package()
    }

    public fun get_sui_usdc_pool() : address {
        @0xf948981b806057580f91622417534f491da5f61aeaf33d0ed8e69fd5691c95ce
    }

    public entry fun prepare_sui_for_deepbook_ptb(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == arg1, 6001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 6001);
        assert!(arg2 > 0, 6004);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(arg1 != @0x0, 6003);
        let v2 = DeepBookSwapExecuted{
            sender         : v1,
            amount_in      : v0,
            min_amount_out : arg2,
            pool_id        : arg1,
            method         : b"ptb_external_package_call",
            package        : 0x1c749e8a396f7574cdda4da22623b45ee06782561ffc3847a2a1c63428c9267d::constants::deepbook_package(),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DeepBookSwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
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

    // decompiled from Move bytecode v6
}

