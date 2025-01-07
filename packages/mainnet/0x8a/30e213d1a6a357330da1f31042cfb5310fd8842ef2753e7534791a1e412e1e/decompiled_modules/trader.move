module 0x8a30e213d1a6a357330da1f31042cfb5310fd8842ef2753e7534791a1e412e1e::trader {
    public fun buy<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= arg5 + 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg1, arg5) + 0, 272);
        arg6
    }

    // decompiled from Move bytecode v6
}

