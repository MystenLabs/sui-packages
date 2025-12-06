module 0x83a27ebd27688f162aab3e3137faaefac0c0d2f8ae81ea9c733ae3f8a1842b2::duck_nft {
    public fun hatch_genesis_rare_egg(arg0: &0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::HatchCap, arg1: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::PackSupply, arg2: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::PerTypeSupply, arg3: &0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::Whitelist, arg4: &0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::TreasuryConfig, arg5: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::GlobalStats, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &0x2::transfer_policy::TransferPolicy<0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::DuckNFT>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: u64, arg11: &0x2::random::Random, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let (_, _, v2, v3, _, _, _) = 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::get_global_stats(arg5);
        0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::hatch_genesis_rare_egg(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let (_, _, v9, v10, _, _, _) = 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::get_global_stats(arg5);
        assert!(v2 != v9 || v3 != v10, 1);
    }

    // decompiled from Move bytecode v6
}

