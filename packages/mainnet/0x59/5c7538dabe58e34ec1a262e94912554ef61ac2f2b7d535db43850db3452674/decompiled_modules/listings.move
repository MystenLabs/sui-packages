module 0x595c7538dabe58e34ec1a262e94912554ef61ac2f2b7d535db43850db3452674::listings {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun buy_with_tradeport<T0: store + key>(arg0: &mut 0xec175e537be9e48f75fa6929291de6454d2502f1091feb22c0d26a22821bbf28::kiosk_listings::Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _) = 0xec175e537be9e48f75fa6929291de6454d2502f1091feb22c0d26a22821bbf28::kiosk_listings::buy<T0>(arg0, arg1, arg2, arg4, arg5, arg8);
        let v3 = v1;
        let v4 = Rule{dummy_field: false};
        0x2::transfer_policy::add_to_balance<T0, Rule>(v4, arg7, arg6);
        let v5 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v5, &mut v3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg7, v3);
        0x2::kiosk::place<T0>(arg2, arg3, v0);
    }

    // decompiled from Move bytecode v6
}

