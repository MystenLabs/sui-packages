module 0x2f74f5c5f5d5ef2a8c12fdbbb37b4206c623dc757be7674736705c2ce06916d6::trader {
    public fun test<T0>(arg0: &mut 0x2::transfer_policy::TransferRequest<T0>, arg1: &mut 0x2::kiosk::Kiosk) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

