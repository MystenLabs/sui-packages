module 0x61d2ab76ad9d320e857d09130b9d44a6ddb17ba81d71c1249cffe4b7146424af::atlansui_entries {
    public entry fun accept_offer_with_nft<T0, T1: store + key>(arg0: &mut 0x61d2ab76ad9d320e857d09130b9d44a6ddb17ba81d71c1249cffe4b7146424af::atlansui::Platform, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: T1, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x61d2ab76ad9d320e857d09130b9d44a6ddb17ba81d71c1249cffe4b7146424af::atlansui::accept_offer_with_nft<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun cancel_offer<T0, T1: store + key>(arg0: &mut 0x61d2ab76ad9d320e857d09130b9d44a6ddb17ba81d71c1249cffe4b7146424af::atlansui::Platform, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x61d2ab76ad9d320e857d09130b9d44a6ddb17ba81d71c1249cffe4b7146424af::atlansui::cancel_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun claim_offer<T0, T1: store + key>(arg0: &mut 0x61d2ab76ad9d320e857d09130b9d44a6ddb17ba81d71c1249cffe4b7146424af::atlansui::Platform, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x61d2ab76ad9d320e857d09130b9d44a6ddb17ba81d71c1249cffe4b7146424af::atlansui::claim_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun create_collection<T0, T1: store + key>(arg0: &mut 0x61d2ab76ad9d320e857d09130b9d44a6ddb17ba81d71c1249cffe4b7146424af::atlansui::Platform, arg1: &mut 0x61d2ab76ad9d320e857d09130b9d44a6ddb17ba81d71c1249cffe4b7146424af::atlansui::AdminCap, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x61d2ab76ad9d320e857d09130b9d44a6ddb17ba81d71c1249cffe4b7146424af::atlansui::create_collection<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun create_offer<T0, T1: store + key>(arg0: &mut 0x61d2ab76ad9d320e857d09130b9d44a6ddb17ba81d71c1249cffe4b7146424af::atlansui::Platform, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x61d2ab76ad9d320e857d09130b9d44a6ddb17ba81d71c1249cffe4b7146424af::atlansui::create_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun repayment_offer<T0, T1: store + key>(arg0: &mut 0x61d2ab76ad9d320e857d09130b9d44a6ddb17ba81d71c1249cffe4b7146424af::atlansui::Platform, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x61d2ab76ad9d320e857d09130b9d44a6ddb17ba81d71c1249cffe4b7146424af::atlansui::repayment_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    // decompiled from Move bytecode v6
}

