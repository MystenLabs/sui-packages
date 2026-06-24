module 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::yield_module {
    public entry fun claim_yield(arg0: &mut 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::nft::VaultzNFT, arg1: &mut 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::VaultLaunch, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::nft::nft_launch_id(arg0) == 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::id(arg1), 300);
        let v0 = claimable_yield(arg0, arg1);
        assert!(v0 > 0, 301);
        0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::nft::add_yield_claimed(arg0, v0);
        let v1 = 0x2::tx_context::sender(arg2);
        0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::events::emit_yield_claimed(0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::nft::nft_id(arg0), 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::id(arg1), v1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::withdraw_yield(arg1, v0, arg2), v1);
    }

    public fun claimable_yield(arg0: &0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::nft::VaultzNFT, arg1: &0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::VaultLaunch) : u64 {
        if (0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::nft::nft_launch_id(arg0) != 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::id(arg1)) {
            return 0
        };
        let v0 = 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::total_token_allocation(arg1);
        if (v0 == 0) {
            return 0
        };
        let v1 = (((0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::yield_pool_balance(arg1) as u128) * (0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::nft::token_allocation(arg0) as u128) / (v0 as u128)) as u64);
        let v2 = 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::nft::yield_claimed(arg0);
        if (v1 > v2) {
            v1 - v2
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

