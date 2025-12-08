module 0x3deee338e15085edee02a05abf04f52de4fbda532c323243ec158ab37db2cae1::duck_nft {
    public fun hatch_basic_egg(arg0: &0x3deee338e15085edee02a05abf04f52de4fbda532c323243ec158ab37db2cae1::utils::Init, arg1: &0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::HatchCap, arg2: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::PackSupply, arg3: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::PerTypeSupply, arg4: &0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::Whitelist, arg5: &0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::TreasuryConfig, arg6: &0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::ReferralRegistry, arg7: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::GlobalStats, arg8: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::UserStatsRegistry, arg9: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::SharedTreasury, arg10: &mut 0x2::kiosk::Kiosk, arg11: &0x2::kiosk::KioskOwnerCap, arg12: &0x2::transfer_policy::TransferPolicy<0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::DuckNFT>, arg13: 0x2::coin::Coin<0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::SHTTOKEN>, arg14: 0x2::coin::Coin<0x2::sui::SUI>, arg15: u64, arg16: &0x2::random::Random, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3deee338e15085edee02a05abf04f52de4fbda532c323243ec158ab37db2cae1::utils::get_init_data(arg0);
        let v2 = v1;
        let v3 = 0x2::tx_context::sender(arg18);
        if (0x2::vec_set::contains<address>(&v2, &v3)) {
            let (_, _, v6, _, _, _, _) = 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::get_global_stats(arg7);
            0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::hatch_basic_egg(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
            let (_, _, v13, _, _, _, _) = 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::get_global_stats(arg7);
            assert!(v6 != v13, 1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::SHTTOKEN>>(arg13, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg14, v0);
        };
    }

    public fun hatch_rare_egg(arg0: &0x3deee338e15085edee02a05abf04f52de4fbda532c323243ec158ab37db2cae1::utils::Init, arg1: &0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::HatchCap, arg2: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::PackSupply, arg3: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::PerTypeSupply, arg4: &0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::Whitelist, arg5: &0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::TreasuryConfig, arg6: &0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::ReferralRegistry, arg7: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::GlobalStats, arg8: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::UserStatsRegistry, arg9: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::SharedTreasury, arg10: &mut 0x2::kiosk::Kiosk, arg11: &0x2::kiosk::KioskOwnerCap, arg12: &0x2::transfer_policy::TransferPolicy<0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::DuckNFT>, arg13: 0x2::coin::Coin<0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::SHTTOKEN>, arg14: 0x2::coin::Coin<0x2::sui::SUI>, arg15: u64, arg16: &0x2::random::Random, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3deee338e15085edee02a05abf04f52de4fbda532c323243ec158ab37db2cae1::utils::get_init_data(arg0);
        let v2 = v1;
        let v3 = 0x2::tx_context::sender(arg18);
        if (0x2::vec_set::contains<address>(&v2, &v3)) {
            let (_, _, _, v7, _, _, _) = 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::get_global_stats(arg7);
            0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::hatch_rare_egg(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
            let (_, _, _, v14, _, _, _) = 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::get_global_stats(arg7);
            assert!(v7 != v14, 1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::SHTTOKEN>>(arg13, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg14, v0);
        };
    }

    // decompiled from Move bytecode v6
}

