module 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::yield {
    public entry fun claim_yield(arg0: &mut 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::nft::VaultzNFT, arg1: &mut 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::VaultLaunch, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::nft::launch_id(arg0) == 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::id(arg1), 302);
        assert!(0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::status(arg1) == 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::status_live(), 300);
        let v0 = 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::yield_pool_balance(arg1);
        let v1 = 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::total_token_allocation(arg1);
        if (v0 == 0 || v1 == 0) {
            return
        };
        let v2 = v0 * 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::nft::token_allocation(arg0) / v1;
        let v3 = 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::nft::last_yield_snapshot(arg0);
        let v4 = if (v2 > v3) {
            v2 - v3
        } else {
            0
        };
        assert!(v4 > 0, 301);
        0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::nft::set_last_yield_snapshot(arg0, v2);
        0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::nft::add_yield_claimed(arg0, v4);
        let v5 = 0x2::tx_context::sender(arg2);
        0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::events::emit_yield_claimed(0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::id(arg1), 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::nft::id(arg0), v5, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::withdraw_yield(arg1, v4, arg2), v5);
    }

    public fun claimable_yield(arg0: &0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::nft::VaultzNFT, arg1: &0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::VaultLaunch) : u64 {
        let v0 = 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::yield_pool_balance(arg1);
        let v1 = 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::total_token_allocation(arg1);
        if (v0 == 0 || v1 == 0) {
            return 0
        };
        let v2 = v0 * 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::nft::token_allocation(arg0) / v1;
        let v3 = 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::nft::last_yield_snapshot(arg0);
        if (v2 > v3) {
            v2 - v3
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

