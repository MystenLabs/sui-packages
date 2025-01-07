module 0x2d7d8c039a13b48d9df4120afbb46df2fb25d3fecab1c43b315ab65d99c8e71f::kiosk_lock_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        dummy_field: bool,
    }

    public fun add<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun prove<T0>(arg0: &mut 0x2::transfer_policy::TransferRequest<T0>, arg1: &0x2::kiosk::Kiosk) {
        let v0 = 0x2::transfer_policy::item<T0>(arg0);
        assert!(0x2::kiosk::has_item(arg1, v0) && 0x2::kiosk::is_locked(arg1, v0), 0);
        let v1 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v1, arg0);
    }

    // decompiled from Move bytecode v6
}

