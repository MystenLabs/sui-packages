module 0x5c1ce6044c9c9b79e196f219bc168181cb6c7d607b69379606a6934e9f0decd0::ripstation_market {
    struct RipStationMarket has drop {
        dummy_field: bool,
    }

    public fun buy<T0: store + key>(arg0: &0xdd8eb9a8ee5581e683c692dff8513d86b6049d0c99644bbf16c00955cccfdb90::platform::Platform, arg1: &mut 0xdd8eb9a8ee5581e683c692dff8513d86b6049d0c99644bbf16c00955cccfdb90::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &mut 0x16a5fd66e73c2069dd9673615f77506480116c83aabdf4d427a9f85e40ad01cc::ripstation_marketplace::Store, arg3: &mut 0x2::kiosk::Kiosk, arg4: 0x2::object::ID, arg5: u64, arg6: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg7: 0x1::string::String, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x2::kiosk::Kiosk>(arg3);
        let v1 = RipStationMarket{dummy_field: false};
        let (v2, v3, v4, v5) = 0xdd8eb9a8ee5581e683c692dff8513d86b6049d0c99644bbf16c00955cccfdb90::nft::begin_purchase<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0, RipStationMarket>(v1, arg0, arg1, 0x2::object::id_to_address(&v0), arg4, arg5, arg7, arg8, arg9);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = v2;
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg6, 0x16a5fd66e73c2069dd9673615f77506480116c83aabdf4d427a9f85e40ad01cc::ripstation_marketplace::buy_listing<T0>(arg2, arg3, &mut v7, &v6, 0xdd8eb9a8ee5581e683c692dff8513d86b6049d0c99644bbf16c00955cccfdb90::nft::purchase_owner<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v8), arg4, &mut v9, arg6, arg9));
        0xdd8eb9a8ee5581e683c692dff8513d86b6049d0c99644bbf16c00955cccfdb90::nft::finish_purchase<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(v8, arg0, arg1, v7, v6, v9, arg9);
    }

    // decompiled from Move bytecode v7
}

