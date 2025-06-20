module 0xdedb536b93f2b09ca605428ebb627f8e33e1d12822556ddc7ce9fe84aa3a5c66::dex_aftermath {
    struct AftermathSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        method: vector<u8>,
        timestamp: u64,
    }

    public fun get_aftermath_package() : address {
        @0x7903f6ab51fba9f9f88d78a77f1d5d1ae3b73f6515c3d4e7a4c7b56b8c22c3e7
    }

    public entry fun swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 6001);
        assert!(arg2 > 0, 6004);
        assert!(arg1 != @0x0, 6003);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = AftermathSwapExecuted{
            sender         : v1,
            amount_in      : v0,
            min_amount_out : arg2,
            pool_id        : arg1,
            method         : b"real_external_package_integration",
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AftermathSwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
    }

    // decompiled from Move bytecode v6
}

