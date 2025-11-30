module 0x271f7facd86c4d18a5f52ca16b0b6b9654006191bbab2e14bc1a784ea35069b7::lock_rule {
    struct LockRule has drop {
        dummy_field: bool,
    }

    struct LockConfig has drop, store {
        dummy_field: bool,
    }

    public fun add_rule<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = LockRule{dummy_field: false};
        let v1 = LockConfig{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, LockRule, LockConfig>(v0, arg0, arg1, v1);
    }

    public fun remove_rule<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        0x2::transfer_policy::remove_rule<T0, LockRule, LockConfig>(arg0, arg1);
    }

    public fun verify<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: &0x2::kiosk::Kiosk) {
        assert!(0x2::kiosk::has_item(arg2, 0x2::transfer_policy::item<T0>(arg1)), 0);
        let v0 = LockRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, LockRule>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

