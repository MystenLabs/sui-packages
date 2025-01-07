module 0x45b443d50597b981b01fe292c705b5e1e31c07735661721e8f85537e92015f4e::floor_price_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        floor_price: u64,
    }

    public fun add<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u64) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{floor_price: arg2};
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun prove<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>) {
        let v0 = Rule{dummy_field: false};
        assert!(0x2::transfer_policy::paid<T0>(arg1) >= 0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0).floor_price, 0);
        let v1 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v1, arg1);
    }

    // decompiled from Move bytecode v6
}

