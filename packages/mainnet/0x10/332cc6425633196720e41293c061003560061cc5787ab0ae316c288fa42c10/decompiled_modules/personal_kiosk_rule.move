module 0x10332cc6425633196720e41293c061003560061cc5787ab0ae316c288fa42c10::personal_kiosk_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun add<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, Rule, bool>(v0, arg0, arg1, true);
    }

    public fun prove<T0>(arg0: &0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>) {
        assert!(0x2::kiosk::has_item(arg0, 0x2::transfer_policy::item<T0>(arg1)), 0);
        assert!(0x10332cc6425633196720e41293c061003560061cc5787ab0ae316c288fa42c10::personal_kiosk::is_personal(arg0), 1);
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

