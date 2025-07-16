module 0x3a82b560114b8b165e427b6758c13d29fc8ddd5ed8769ddeb8fbfd165d5bda63::gachapon_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        dummy_field: bool,
    }

    public fun add<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    entry fun default<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<T0>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        add<T0>(v4, &v2);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<T0>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<T0>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun prove<T0, T1: store + key>(arg0: &mut 0x2::transfer_policy::TransferRequest<T1>, arg1: &0x3a82b560114b8b165e427b6758c13d29fc8ddd5ed8769ddeb8fbfd165d5bda63::gachapon::Gachapon<T0>, arg2: &0x2::kiosk::Kiosk) {
        0x3a82b560114b8b165e427b6758c13d29fc8ddd5ed8769ddeb8fbfd165d5bda63::gachapon::assert_valid_kiosk<T0>(arg1, arg2);
        assert!(0x2::transfer_policy::from<T1>(arg0) == 0x3a82b560114b8b165e427b6758c13d29fc8ddd5ed8769ddeb8fbfd165d5bda63::gachapon::kiosk_id<T0>(arg1) || 0x2::kiosk::has_item(arg2, 0x2::transfer_policy::item<T1>(arg0)), 0);
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T1, Rule>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

