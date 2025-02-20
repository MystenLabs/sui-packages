module 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::setup {
    struct LENDING_MARKET has drop {
        dummy_field: bool,
    }

    public fun setup(arg0: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market_registry::Registry, arg1: &mut 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::registry::Registry, arg2: &mut 0x2::coin::CoinMetadata<0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::lp_usdc_sui::LP_USDC_SUI>, arg3: 0x2::coin::TreasuryCap<0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::lp_usdc_sui::LP_USDC_SUI>, arg4: &0x2::coin::CoinMetadata<0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::usdc::USDC>, arg5: &0x2::coin::CoinMetadata<0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::sui::SUI>, arg6: &mut 0x2::coin::CoinMetadata<0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::b_usdc::B_USDC>, arg7: &mut 0x2::coin::CoinMetadata<0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::b_sui::B_SUI>, arg8: 0x2::coin::TreasuryCap<0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::b_usdc::B_USDC>, arg9: 0x2::coin::TreasuryCap<0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::b_sui::B_SUI>, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market_registry::create_lending_market<LENDING_MARKET>(arg0, arg10);
        let v2 = v1;
        0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::bank::create_bank_and_share<LENDING_MARKET, 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::usdc::USDC, 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::b_usdc::B_USDC>(arg1, arg4, arg6, arg8, &v2, arg10);
        0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::bank::create_bank_and_share<LENDING_MARKET, 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::sui::SUI, 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::b_sui::B_SUI>(arg1, arg5, arg7, arg9, &v2, arg10);
        0x2::transfer::public_share_object<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<LENDING_MARKET>>(v2);
        0x2::transfer::public_share_object<0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::pool::Pool<0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::b_usdc::B_USDC, 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::b_sui::B_SUI, 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::cpmm::CpQuoter, 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::lp_usdc_sui::LP_USDC_SUI>>(0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::cpmm::new<0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::b_usdc::B_USDC, 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::b_sui::B_SUI, 0x2e868e44010e06c0fc925d29f35029b6ef75a50e03d997585980fb2acea45ec6::lp_usdc_sui::LP_USDC_SUI>(arg1, 100, 0, arg6, arg7, arg2, arg3, arg10));
        0x2::transfer::public_transfer<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarketOwnerCap<LENDING_MARKET>>(v0, 0x2::tx_context::sender(arg10));
    }

    // decompiled from Move bytecode v6
}

