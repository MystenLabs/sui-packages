module 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::ob_market {
    struct ObMarketplace has key {
        id: 0x2::object::UID,
        beneficiary: address,
        fee: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ObMarketplace{
            id          : 0x2::object::new(arg0),
            beneficiary : 0x2::tx_context::sender(arg0),
            fee         : 0,
        };
        0x2::transfer::share_object<ObMarketplace>(v0);
    }

    public entry fun modify_ob_market(arg0: &mut ObMarketplace, arg1: address, arg2: u64) {
        assert!(arg2 < 10000, 1);
        arg0.fee = arg2;
        arg0.beneficiary = arg1;
    }

    public entry fun ob_accept_bid<T0: store + key, T1>(arg0: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<T0, T1>, arg1: &0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist, arg2: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::BpsRoyaltyStrategy<T0>, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::kiosk::Kiosk, arg6: 0x2::object::ID, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::market_sell<T0, T1>(arg0, arg4, arg7, arg6, arg8);
        let v1 = 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::finish_trade<T0, T1>(arg0, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::trade_id(&v0), arg4, arg5, arg8);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::confirm_transfer<T0>(arg1, &mut v1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::confirm_transfer<T0, T1>(arg2, &mut v1);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::confirm<T0, T1>(v1, arg3, arg8);
    }

    public entry fun ob_adjust_price<T0: store + key, T1>(arg0: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: u64, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::edit_ask<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun ob_bid<T0: store + key, T1>(arg0: &ObMarketplace, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<T0, T1>, arg2: &mut 0x2::kiosk::Kiosk, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg3 * arg0.fee / 10000;
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::create_bid_with_commission<T0, T1>(arg1, arg2, arg3 - v0, arg0.beneficiary, v0, &mut arg4, arg5);
        0x2::coin::destroy_zero<T1>(arg4);
    }

    public entry fun ob_buy<T0: store + key, T1>(arg0: &ObMarketplace, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<T0, T1>, arg2: &0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist, arg3: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::BpsRoyaltyStrategy<T0>, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::kiosk::Kiosk, arg7: 0x2::object::ID, arg8: u64, arg9: &mut 0x2::coin::Coin<T1>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = arg8 * arg0.fee / 10000;
        assert!(0x2::coin::value<T1>(arg9) == v0 + arg8, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(arg9, v0, arg10), arg0.beneficiary);
        let v1 = 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::buy_nft<T0, T1>(arg1, arg5, arg6, arg7, arg8, arg9, arg10);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::confirm_transfer<T0>(arg2, &mut v1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::confirm_transfer<T0, T1>(arg3, &mut v1);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::confirm<T0, T1>(v1, arg4, arg10);
    }

    public entry fun ob_buy_without_allow_list<T0: store + key, T1>(arg0: &ObMarketplace, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<T0, T1>, arg2: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::BpsRoyaltyStrategy<T0>, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::kiosk::Kiosk, arg6: 0x2::object::ID, arg7: u64, arg8: &mut 0x2::coin::Coin<T1>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = arg7 * arg0.fee / 10000;
        assert!(0x2::coin::value<T1>(arg8) == v0 + arg7, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(arg8, v0, arg9), arg0.beneficiary);
        let v1 = 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::buy_nft<T0, T1>(arg1, arg4, arg5, arg6, arg7, arg8, arg9);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::confirm_transfer<T0, T1>(arg2, &mut v1);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::confirm<T0, T1>(v1, arg3, arg9);
    }

    public entry fun ob_buy_without_ruler<T0: store + key, T1>(arg0: &ObMarketplace, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<T0, T1>, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::kiosk::Kiosk, arg5: 0x2::object::ID, arg6: u64, arg7: &mut 0x2::coin::Coin<T1>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = arg6 * arg0.fee / 10000;
        assert!(0x2::coin::value<T1>(arg7) == v0 + arg6, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(arg7, v0, arg8), arg0.beneficiary);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::confirm<T0, T1>(0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::buy_nft<T0, T1>(arg1, arg3, arg4, arg5, arg6, arg7, arg8), arg2, arg8);
    }

    public entry fun ob_cancel_bid<T0: store + key, T1>(arg0: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T1>(arg2);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::cancel_bid<T0, T1>(arg0, arg1, &mut v0, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun ob_delist<T0: store + key, T1>(arg0: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: u64, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::cancel_ask<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun ob_list<T0: store + key, T1>(arg0: &ObMarketplace, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<T0, T1>, arg2: &mut 0x2::kiosk::Kiosk, arg3: u64, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::create_ask_with_commission<T0, T1>(arg1, arg2, arg3, arg4, arg0.beneficiary, arg3 * arg0.fee / 10000, arg5);
    }

    // decompiled from Move bytecode v6
}

