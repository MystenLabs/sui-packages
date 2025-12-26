module 0x608e3a4fb821ff73704aee07e3182f36d2f9c177ef284e49d4b3388655c95959::du {
    struct WLock has key {
        id: 0x2::object::UID,
        data: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun get_egg_egg_egg(arg0: &AdminCap, arg1: &0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::HatchCap, arg2: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::PackSupply, arg3: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::PerTypeSupply, arg4: &0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::Whitelist, arg5: &0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::TreasuryConfig, arg6: &0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::ReferralRegistry, arg7: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::GlobalStats, arg8: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::UserStatsRegistry, arg9: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::SharedTreasury, arg10: &mut 0x2::kiosk::Kiosk, arg11: &0x2::kiosk::KioskOwnerCap, arg12: &0x2::transfer_policy::TransferPolicy<0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::DuckNFT>, arg13: 0x2::coin::Coin<0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::SHTTOKEN>, arg14: 0x2::coin::Coin<0x2::sui::SUI>, arg15: u64, arg16: &0x2::random::Random, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, v3, _, _, _) = 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::get_global_stats(arg7);
        0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::hatch_basic_egg(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
        let (_, _, _, v10, _, _, _) = 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::duck_nft::get_global_stats(arg7);
        assert!(v10 > v3, 0);
    }

    public fun get_sht(arg0: &AdminCap, arg1: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::SharedTreasury, arg2: u64, arg3: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::nest::StakedDuck, arg4: &0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::nest::Nest, arg5: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::nest::HarvestStats, arg6: &0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::NestMintCap, arg7: &0x2::random::Random, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::nest::harvest_duck(arg3, arg4, arg5, arg6, arg1, arg7, arg8, arg9);
        assert!(0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::total_supply(arg1) >= 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::total_supply(arg1) + arg2, 0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

