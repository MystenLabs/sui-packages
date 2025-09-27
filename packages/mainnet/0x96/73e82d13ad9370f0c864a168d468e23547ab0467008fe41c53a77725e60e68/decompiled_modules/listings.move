module 0x9673e82d13ad9370f0c864a168d468e23547ab0467008fe41c53a77725e60e68::listings {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun buy_exclusive_item_with_royalty<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::kiosk::PurchaseCap<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap) {
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = Rule{dummy_field: false};
        0x2::transfer_policy::add_to_balance<T0, Rule>(v3, arg4, arg3);
        let v4 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v4, &mut v2);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v2);
        0x2::kiosk::place<T0>(arg5, arg6, v0);
    }

    // decompiled from Move bytecode v6
}

