module 0x9660dd5afd65251e7b31666f9bfa2e6f3ed5f9b617c765113cc09029549508a6::ob_trade {
    struct OB_LIST_EVENT has copy, drop, store {
        seller: address,
        seller_kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        amount: u64,
    }

    struct OB_BUY_EVENT has copy, drop, store {
        nft_id: 0x2::object::ID,
        buyer: address,
        amount: u64,
    }

    struct OB_CANCEL_EVENT has copy, drop, store {
        nft_id: 0x2::object::ID,
        seller: address,
        amount: u64,
    }

    public entry fun ob_buy_nft<T0: store + key, T1>(arg0: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<T0, T1>, arg1: &mut 0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist, arg2: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::BpsRoyaltyStrategy<T0>, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::kiosk::Kiosk, arg6: 0x2::object::ID, arg7: u64, arg8: 0x2::coin::Coin<T1>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::buy_nft<T0, T1>(arg0, arg4, arg5, arg6, arg7, &mut arg8, arg9);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::confirm_transfer<T0>(arg1, &mut v0);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::confirm_transfer<T0, T1>(arg2, &mut v0);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::confirm<T0, T1>(v0, arg3, arg9);
        if (0x2::coin::value<T1>(&arg8) > 0) {
            0x2::pay::keep<T1>(arg8, arg9);
        } else {
            0x2::coin::destroy_zero<T1>(arg8);
        };
        let v1 = OB_BUY_EVENT{
            nft_id : arg6,
            buyer  : 0x2::tx_context::sender(arg9),
            amount : arg7,
        };
        0x2::event::emit<OB_BUY_EVENT>(v1);
    }

    public entry fun ob_cancel<T0: store + key, T1>(arg0: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: u64, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::cancel_ask<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let v0 = OB_CANCEL_EVENT{
            nft_id : arg3,
            seller : 0x2::tx_context::sender(arg4),
            amount : arg2,
        };
        0x2::event::emit<OB_CANCEL_EVENT>(v0);
    }

    public entry fun ob_list<T0: store + key, T1>(arg0: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: u64, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::create_ask_with_commission<T0, T1>(arg0, arg1, arg2, arg3, @0x8084455a96bdde21edd8fe48ec3f15dbe1c82b2ee2e0e963d800f3d7d8fbbcd5, arg2 * 250 / 10000, arg4);
        let v0 = OB_LIST_EVENT{
            seller          : 0x2::tx_context::sender(arg4),
            seller_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            nft_id          : arg3,
            amount          : arg2,
        };
        0x2::event::emit<OB_LIST_EVENT>(v0);
    }

    // decompiled from Move bytecode v6
}

