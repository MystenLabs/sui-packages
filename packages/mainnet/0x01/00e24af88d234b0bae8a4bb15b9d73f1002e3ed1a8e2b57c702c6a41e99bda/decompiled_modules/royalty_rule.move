module 0x100e24af88d234b0bae8a4bb15b9d73f1002e3ed1a8e2b57c702c6a41e99bda::royalty_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        amount_bp: u16,
    }

    public fun add<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u16) {
        assert!(arg2 <= 10000, 0);
        let v0 = Rule{dummy_field: false};
        let v1 = Config{amount_bp: arg2};
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun fee_amount<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: u64) : u64 {
        let v0 = Rule{dummy_field: false};
        ((((arg1 as u128) * (0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0).amount_bp as u128) + 9999) / 10000) as u64)
    }

    public fun pay<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= fee_amount<T0>(arg0, 0x2::transfer_policy::paid<T0>(arg1)), 1);
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::add_to_balance<T0, Rule>(v0, arg0, arg2);
        let v1 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v1, arg1);
    }

    // decompiled from Move bytecode v6
}

