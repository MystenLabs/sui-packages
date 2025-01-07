module 0x80c9ae19eb5e2856386f35cbd2bbbcb625ee6bada6682694e6fc1bd046496fdb::trader {
    public fun list<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x9a84b6a7914aedd6741e73cc2ca23cbc77e22ed3c5f884c072a51868fedde45b::hyperspace::list<T0, 0x9a84b6a7914aedd6741e73cc2ca23cbc77e22ed3c5f884c072a51868fedde45b::hyperspace_mp::Hyperspace_mp>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun test<T0>(arg0: &mut 0x2::transfer_policy::TransferRequest<T0>, arg1: &mut 0x2::kiosk::Kiosk) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

