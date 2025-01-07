module 0x2146f08901ff5523b5c21342af49382ae87db0b70bb1f1b8107205121134e3b0::extension {
    struct DeloreanExt has drop {
        dummy_field: bool,
    }

    public fun add(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DeloreanExt{dummy_field: false};
        0x2::kiosk_extension::add<DeloreanExt>(v0, arg0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg1), 2, arg2);
    }

    public(friend) fun lock<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: T0, arg2: &0x2::transfer_policy::TransferPolicy<T0>) {
        let v0 = DeloreanExt{dummy_field: false};
        0x2::kiosk_extension::lock<DeloreanExt, T0>(v0, arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

