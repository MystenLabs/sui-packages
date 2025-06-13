module 0xf847d969ced8152deec9262d24966cc735ad29a2df01af7f2f0d8c59d9dd032f::rules {
    struct RULES has drop {
        dummy_field: bool,
    }

    public fun get_royalty_fee_amount<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: u64) : u64 {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg0, arg1)
    }

    public fun pay_royalty_rule<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg0, arg1, arg2);
    }

    public fun prove_kiosk_lock_rule<T0>(arg0: &0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg2: &mut 0x2::transfer_policy::TransferRequest<T0>) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(arg2, arg0);
    }

    public fun prove_personal_kiosk_rule<T0>(arg0: &0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg2: &mut 0x2::transfer_policy::TransferRequest<T0>) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::prove<T0>(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

