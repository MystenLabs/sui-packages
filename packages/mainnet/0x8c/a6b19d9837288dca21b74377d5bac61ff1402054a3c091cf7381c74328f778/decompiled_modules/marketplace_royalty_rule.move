module 0x8ca6b19d9837288dca21b74377d5bac61ff1402054a3c091cf7381c74328f778::marketplace_royalty_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        amount_bp: u16,
    }

    struct RoyaltyRequest {
        royalty: u64,
    }

    public entry fun add<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u16) {
        assert!(10000 >= arg2, 0);
        let v0 = Rule{dummy_field: false};
        let v1 = Config{amount_bp: arg2};
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun calculate<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: u64) : RoyaltyRequest {
        let v0 = Rule{dummy_field: false};
        RoyaltyRequest{royalty: (((0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0).amount_bp as u128) * (arg1 as u128) / (10000 as u128)) as u64)}
    }

    public fun get(arg0: &RoyaltyRequest) : u64 {
        arg0.royalty
    }

    public fun handle<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: RoyaltyRequest, arg3: 0x2::coin::Coin<0x2::sui::SUI>) {
        let RoyaltyRequest {  } = arg2;
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::add_to_balance<T0, Rule>(v0, arg0, arg3);
        let v1 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v1, arg1);
    }

    public fun remove<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        0x2::transfer_policy::remove_rule<T0, Rule, Config>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

