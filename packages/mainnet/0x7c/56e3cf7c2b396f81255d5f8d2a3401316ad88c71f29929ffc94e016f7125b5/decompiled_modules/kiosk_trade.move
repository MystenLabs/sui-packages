module 0x7c56e3cf7c2b396f81255d5f8d2a3401316ad88c71f29929ffc94e016f7125b5::kiosk_trade {
    public entry fun kiosk_buy<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::purchase<T0>(arg0, arg2, arg4);
        let v2 = v1;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg1, &mut v2, 0x2::coin::split<0x2::sui::SUI>(&mut arg4, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg1, arg3), arg5));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg1, v2);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg5));
    }

    public entry fun kiosk_delist<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::delist<T0>(arg0, arg1, arg2);
    }

    public entry fun kiosk_list<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::list<T0>(arg0, arg1, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

