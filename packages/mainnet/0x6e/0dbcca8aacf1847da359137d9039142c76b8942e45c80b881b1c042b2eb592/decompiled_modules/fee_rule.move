module 0x6e0dbcca8aacf1847da359137d9039142c76b8942e45c80b881b1c042b2eb592::fee_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        fee: u64,
        owner: address,
    }

    public entry fun add<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            fee   : arg2,
            owner : 0x2::tx_context::sender(arg3),
        };
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun pay<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v1.fee, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v1.owner);
        let v2 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v2, arg1);
    }

    // decompiled from Move bytecode v6
}

