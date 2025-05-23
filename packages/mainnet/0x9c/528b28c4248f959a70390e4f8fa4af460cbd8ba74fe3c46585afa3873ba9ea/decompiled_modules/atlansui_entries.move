module 0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui_entries {
    public entry fun accept_offer_with_kiosk<T0, T1: store + key>(arg0: &mut 0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::Platform, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::object::ID, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::accept_offer_with_kiosk<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun accept_offer_with_kiosk_with_scallop<T0, T1: store + key>(arg0: &mut 0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::Platform, arg1: 0x2::object::ID, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: address, arg5: u64, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: 0x2::object::ID, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::accept_offer_with_kiosk_with_scallop<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun accept_offer_with_nft<T0, T1: store + key>(arg0: &mut 0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::Platform, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: T1, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::accept_offer_with_nft<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun accept_offer_with_nft_with_scallop<T0, T1: store + key>(arg0: &mut 0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::Platform, arg1: 0x2::object::ID, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: address, arg5: u64, arg6: T1, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::accept_offer_with_nft_with_scallop<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun accept_offer_with_originbyte_kiosk<T0, T1: store + key>(arg0: &mut 0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::Platform, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &mut 0x2::kiosk::Kiosk, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::accept_offer_with_originbyte_kiosk<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun accept_offer_with_originbyte_kiosk_with_scallop<T0, T1: store + key>(arg0: &mut 0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::Platform, arg1: 0x2::object::ID, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: address, arg5: u64, arg6: &mut 0x2::kiosk::Kiosk, arg7: 0x2::object::ID, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::accept_offer_with_originbyte_kiosk_with_scallop<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun cancel_offer<T0, T1: store + key>(arg0: &mut 0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::Platform, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::cancel_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun cancel_offer_with_scallop<T0, T1: store + key>(arg0: &mut 0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::Platform, arg1: 0x2::object::ID, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::cancel_offer_with_scallop<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun claim_offer<T0, T1: store + key>(arg0: &mut 0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::Platform, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::claim_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun claim_offer_originbyte_kiosk<T0, T1: store + key>(arg0: &mut 0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::Platform, arg1: 0x2::object::ID, arg2: &0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist, arg3: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::BpsRoyaltyStrategy<T1>, arg4: &0x2::transfer_policy::TransferPolicy<T1>, arg5: u64, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::claim_offer_originbyte_kiosk<T0, T1>(arg0, arg1, arg5, arg6, arg7, arg8);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::confirm_transfer<T1>(arg2, &mut v0);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::confirm_transfer<T1, T0>(arg3, &mut v0);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::confirm<T1, T0>(v0, arg4, arg8);
    }

    public entry fun create_collection<T0, T1: store + key>(arg0: &mut 0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::Platform, arg1: &mut 0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::AdminCap, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::create_collection<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun create_offer<T0, T1: store + key>(arg0: &mut 0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::Platform, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::create_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun create_offer_with_scallop<T0, T1: store + key>(arg0: &mut 0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::Platform, arg1: 0x2::object::ID, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::create_offer_with_scallop<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun deposit_into_scallop<T0, T1: store + key>(arg0: &mut 0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::Platform, arg1: 0x2::object::ID, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::deposit_into_scallop<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun repayment_offer<T0, T1: store + key>(arg0: &mut 0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::Platform, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::repayment_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun repayment_offer_kiosk<T0, T1: store + key>(arg0: &mut 0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::Platform, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &mut 0x2::kiosk::Kiosk, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::repayment_offer_kiosk<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun repayment_offer_originbyte_kiosk<T0, T1: store + key>(arg0: &mut 0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::Platform, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &mut 0x2::kiosk::Kiosk, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x1f087b0343dccd6f8353cf448ae9b7885e54ee34e2d0cf398b386b9cfa808a97::atlansui::repayment_offer_originbyte_kiosk<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

