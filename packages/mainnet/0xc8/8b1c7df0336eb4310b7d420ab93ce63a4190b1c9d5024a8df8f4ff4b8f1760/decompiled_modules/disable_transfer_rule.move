module 0xc88b1c7df0336eb4310b7d420ab93ce63a4190b1c9d5024a8df8f4ff4b8f1760::disable_transfer_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        dummy_field: bool,
    }

    public fun add_rule<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun remove_rule<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        0x2::transfer_policy::remove_rule<T0, Rule, Config>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

