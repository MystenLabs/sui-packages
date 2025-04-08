module 0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::personal_kiosk_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun add<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, Rule, bool>(v0, arg0, arg1, true);
    }

    public fun prove<T0>(arg0: &0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>) {
        assert!(0x2::kiosk::has_item(arg0, 0x2::transfer_policy::item<T0>(arg1)), 0);
        assert!(0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::personal_kiosk::is_personal(arg0), 1);
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

