module 0x9711179ad9d6f030e9825d2d246fa2b8e1aa14a929de4fe30323136532f58c9a::atlansui_entries {
    public entry fun accept_offer_with_nft<T0, T1: store + key>(arg0: &mut 0x9711179ad9d6f030e9825d2d246fa2b8e1aa14a929de4fe30323136532f58c9a::atlansui::Platform, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: T1, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9711179ad9d6f030e9825d2d246fa2b8e1aa14a929de4fe30323136532f58c9a::atlansui::accept_offer_with_nft<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun accept_offer_with_originbyte_kiosk<T0, T1: store + key>(arg0: &mut 0x9711179ad9d6f030e9825d2d246fa2b8e1aa14a929de4fe30323136532f58c9a::atlansui::Platform, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &mut 0x2::kiosk::Kiosk, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x9711179ad9d6f030e9825d2d246fa2b8e1aa14a929de4fe30323136532f58c9a::atlansui::accept_offer_with_originbyte_kiosk<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun cancel_offer<T0, T1: store + key>(arg0: &mut 0x9711179ad9d6f030e9825d2d246fa2b8e1aa14a929de4fe30323136532f58c9a::atlansui::Platform, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x9711179ad9d6f030e9825d2d246fa2b8e1aa14a929de4fe30323136532f58c9a::atlansui::cancel_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun claim_offer<T0, T1: store + key>(arg0: &mut 0x9711179ad9d6f030e9825d2d246fa2b8e1aa14a929de4fe30323136532f58c9a::atlansui::Platform, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9711179ad9d6f030e9825d2d246fa2b8e1aa14a929de4fe30323136532f58c9a::atlansui::claim_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun claim_offer_originbyte_kiosk<T0, T1: store + key>(arg0: &mut 0x9711179ad9d6f030e9825d2d246fa2b8e1aa14a929de4fe30323136532f58c9a::atlansui::Platform, arg1: 0x2::object::ID, arg2: &0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist, arg3: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::BpsRoyaltyStrategy<T1>, arg4: &0x2::transfer_policy::TransferPolicy<T1>, arg5: u64, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9711179ad9d6f030e9825d2d246fa2b8e1aa14a929de4fe30323136532f58c9a::atlansui::claim_offer_originbyte_kiosk<T0, T1>(arg0, arg1, arg5, arg6, arg7, arg8);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::confirm_transfer<T1>(arg2, &mut v0);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::confirm_transfer<T1, T0>(arg3, &mut v0);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::confirm<T1, T0>(v0, arg4, arg8);
    }

    public entry fun create_collection<T0, T1: store + key>(arg0: &mut 0x9711179ad9d6f030e9825d2d246fa2b8e1aa14a929de4fe30323136532f58c9a::atlansui::Platform, arg1: &mut 0x9711179ad9d6f030e9825d2d246fa2b8e1aa14a929de4fe30323136532f58c9a::atlansui::AdminCap, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x9711179ad9d6f030e9825d2d246fa2b8e1aa14a929de4fe30323136532f58c9a::atlansui::create_collection<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun create_offer<T0, T1: store + key>(arg0: &mut 0x9711179ad9d6f030e9825d2d246fa2b8e1aa14a929de4fe30323136532f58c9a::atlansui::Platform, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9711179ad9d6f030e9825d2d246fa2b8e1aa14a929de4fe30323136532f58c9a::atlansui::create_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun repayment_offer<T0, T1: store + key>(arg0: &mut 0x9711179ad9d6f030e9825d2d246fa2b8e1aa14a929de4fe30323136532f58c9a::atlansui::Platform, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x9711179ad9d6f030e9825d2d246fa2b8e1aa14a929de4fe30323136532f58c9a::atlansui::repayment_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun repayment_offer_originbyte_kiosk<T0, T1: store + key>(arg0: &mut 0x9711179ad9d6f030e9825d2d246fa2b8e1aa14a929de4fe30323136532f58c9a::atlansui::Platform, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &mut 0x2::kiosk::Kiosk, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x9711179ad9d6f030e9825d2d246fa2b8e1aa14a929de4fe30323136532f58c9a::atlansui::repayment_offer_originbyte_kiosk<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun accept_offer_with_kiosk<T0, T1: store + key>(arg0: &mut 0x9711179ad9d6f030e9825d2d246fa2b8e1aa14a929de4fe30323136532f58c9a::atlansui::Platform, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::object::ID, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg4, arg5), 4);
        accept_offer_with_nft<T0, T1>(arg0, arg1, arg2, arg3, 0x2::kiosk::take<T1>(arg4, arg5, arg6), arg7, arg8);
    }

    // decompiled from Move bytecode v6
}

