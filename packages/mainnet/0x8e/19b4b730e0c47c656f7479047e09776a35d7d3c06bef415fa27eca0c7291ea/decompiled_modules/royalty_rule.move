module 0x8e19b4b730e0c47c656f7479047e09776a35d7d3c06bef415fa27eca0c7291ea::royalty_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        amount_bp: u16,
        min_amount: u64,
    }

    public fun add<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u16, arg3: u64) {
        assert!(arg2 <= 10000, 0);
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            amount_bp  : arg2,
            min_amount : arg3,
        };
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun fee_amount<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: u64) : u64 {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0);
        let v2 = (((arg1 as u128) * (v1.amount_bp as u128) / 10000) as u64);
        let v3 = v2;
        if (v2 < v1.min_amount) {
            v3 = v1.min_amount;
        };
        v3
    }

    public fun pay<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = fee_amount<T0>(arg0, 0x2::transfer_policy::paid<T0>(arg1));
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v0, 1);
        let v1 = Rule{dummy_field: false};
        0x2::transfer_policy::add_to_balance<T0, Rule>(v1, arg0, 0x2::coin::split<0x2::sui::SUI>(arg2, v0, arg3));
        let v2 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v2, arg1);
    }

    // decompiled from Move bytecode v6
}

