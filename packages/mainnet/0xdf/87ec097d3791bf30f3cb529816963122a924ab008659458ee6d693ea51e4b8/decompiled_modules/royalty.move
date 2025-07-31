module 0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::royalty {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        amount_bp: u16,
    }

    public fun pay<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = (((0x2::transfer_policy::paid<T0>(arg1) as u128) * (0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0).amount_bp as u128) / 10000) as u64);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v1, 0);
        let v2 = Rule{dummy_field: false};
        0x2::transfer_policy::add_to_balance<T0, Rule>(v2, arg0, 0x2::coin::split<0x2::sui::SUI>(arg2, v1, arg3));
        let v3 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v3, arg1);
    }

    public(friend) fun setup<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{amount_bp: 500};
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    // decompiled from Move bytecode v6
}

