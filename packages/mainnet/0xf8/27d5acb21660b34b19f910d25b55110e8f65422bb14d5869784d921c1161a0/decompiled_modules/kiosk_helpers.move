module 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::kiosk_helpers {
    public fun direct_transfer<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg4, 0, arg6), 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let v2 = v1;
        0x2::kiosk::lock<T0>(arg2, arg3, arg5, v0);
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg5)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v2, arg2);
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg5)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg5, &mut v2, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        };
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg5, v2);
    }

    // decompiled from Move bytecode v6
}

