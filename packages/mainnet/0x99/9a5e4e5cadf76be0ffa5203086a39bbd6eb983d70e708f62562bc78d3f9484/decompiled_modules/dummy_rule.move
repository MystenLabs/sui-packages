module 0x999a5e4e5cadf76be0ffa5203086a39bbd6eb983d70e708f62562bc78d3f9484::dummy_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        dummy_field: bool,
    }

    public fun pay<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::add_to_balance<T0, Rule>(v0, arg0, arg2);
        let v1 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v1, arg1);
    }

    public fun set<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    // decompiled from Move bytecode v6
}

