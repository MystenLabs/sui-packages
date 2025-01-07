module 0x7c942c91e68cdc3bd3f48e8f341e370ad33a2abf50a5991c5ac994b27460d6b9::royalty_policy {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        amount_bp: u16,
        beneficiary: address,
    }

    public fun calculate_royalty_fee(arg0: u16, arg1: u64) : u64 {
        (((arg1 as u128) * (arg0 as u128) / 10000) as u64)
    }

    public fun get_royalty_rules<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>) : (u16, address) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0);
        (v1.amount_bp, v1.beneficiary)
    }

    public fun new_royalty_policy<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u16, arg3: address) {
        assert!(arg2 < 10000, 0);
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            amount_bp   : arg2,
            beneficiary : arg3,
        };
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun pay<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0);
        let v2 = calculate_royalty_fee(v1.amount_bp, 0x2::transfer_policy::paid<T0>(arg1));
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v2, 1);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v2, arg3), v1.beneficiary);
        };
        let v3 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v3, arg1);
    }

    public entry fun update_royalty_bp<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u16, arg3: address) {
        assert!(arg2 < 10000, 0);
        0x2::transfer_policy::remove_rule<T0, Rule, Config>(arg0, arg1);
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            amount_bp   : arg2,
            beneficiary : arg3,
        };
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    // decompiled from Move bytecode v6
}

