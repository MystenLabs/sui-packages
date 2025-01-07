module 0x352263f24e561509e3d20ae8f7142cba7276418b92ea7325f4e21664cf84232f::bulkbuy {
    public fun silent_buy_nft_from_orderbook<T0: store + key, T1>(arg0: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg7: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::BpsRoyaltyStrategy<T0>, arg8: &mut 0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::borrow_asks<T0, T1>(arg0);
        if (0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::has_key<vector<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Ask>>(v0, arg4)) {
            let v1 = 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit_u64::borrow<vector<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Ask>>(v0, arg4);
            let v2 = 0;
            let v3 = 0x1::vector::length<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Ask>(v1);
            while (v3 > v2) {
                if (&arg3 == 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::ask_nft_id(0x1::vector::borrow<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Ask>(v1, v2))) {
                    break
                };
                v2 = v2 + 1;
            };
            if (v2 < v3) {
                let v4 = 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::buy_nft<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg9);
                0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::confirm_transfer<T0>(arg8, &mut v4);
                0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::confirm_transfer<T0, T1>(arg7, &mut v4);
                0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::confirm<T0, T1>(v4, arg6, arg9);
            };
        };
    }

    // decompiled from Move bytecode v6
}

