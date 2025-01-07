module 0x2a1072f1b780c7ef89649472a2eead8468cceaa6838daeec6d28eda41c9b6f76::my_kiosk {
    public entry fun unwrap<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x2::kiosk::take<T0>(arg0, arg1, arg2), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

