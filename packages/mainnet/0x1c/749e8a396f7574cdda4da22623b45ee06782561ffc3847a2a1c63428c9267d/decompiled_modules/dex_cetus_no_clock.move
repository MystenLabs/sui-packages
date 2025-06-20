module 0x1c749e8a396f7574cdda4da22623b45ee06782561ffc3847a2a1c63428c9267d::dex_cetus_no_clock {
    struct CetusSwapExecutedNoTimestamp has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        method: vector<u8>,
        package: address,
        epoch: u64,
    }

    public entry fun swap_sui_to_usdc_emergency(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg1));
    }

    public entry fun swap_sui_to_usdc_minimal(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 9003);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_sui_to_usdc_no_clock(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 9001);
        assert!(arg2 > 0, 9005);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(arg1 != @0x0, 9003);
        let v2 = CetusSwapExecutedNoTimestamp{
            sender         : v1,
            amount_in      : v0,
            min_amount_out : arg2,
            pool_id        : arg1,
            method         : b"ptb_no_clock_workaround",
            package        : 0x1c749e8a396f7574cdda4da22623b45ee06782561ffc3847a2a1c63428c9267d::constants::cetus_package(),
            epoch          : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<CetusSwapExecutedNoTimestamp>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
    }

    public entry fun test_entry_point_accessibility(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CetusSwapExecutedNoTimestamp{
            sender         : 0x2::tx_context::sender(arg0),
            amount_in      : 0,
            min_amount_out : 0,
            pool_id        : @0x0,
            method         : b"test_no_clock_entry_point",
            package        : @0x0,
            epoch          : 0x2::tx_context::epoch(arg0),
        };
        0x2::event::emit<CetusSwapExecutedNoTimestamp>(v0);
    }

    // decompiled from Move bytecode v6
}

