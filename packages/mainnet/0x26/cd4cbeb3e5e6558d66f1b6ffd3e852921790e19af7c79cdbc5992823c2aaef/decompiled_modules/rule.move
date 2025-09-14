module 0x26cd4cbeb3e5e6558d66f1b6ffd3e852921790e19af7c79cdbc5992823c2aaef::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        price: u64,
    }

    public fun add<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u64) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{price: arg2};
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun pay<T0, T1>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0);
        let v2 = 0x2::coin::split<T1>(arg2, v1.price, arg4);
        assert!(0x2::coin::value<T1>(&v2) == v1.price, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, arg3);
        let v3 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v3, arg1);
    }

    public fun remove<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        0x2::transfer_policy::remove_rule<T0, Rule, Config>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

