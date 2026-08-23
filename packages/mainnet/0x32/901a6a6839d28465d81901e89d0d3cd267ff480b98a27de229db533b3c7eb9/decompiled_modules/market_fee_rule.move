module 0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::market_fee_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        amount_bps: u16,
        min_amount: u64,
        beneficiary: address,
        creator_share_bps: u16,
    }

    public fun has_rule<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>) : bool {
        0x2::transfer_policy::has_rule<T0, Rule>(arg0)
    }

    public fun add<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u16, arg3: u64, arg4: address, arg5: u16) {
        assert!(arg2 <= 500, 1);
        assert!(arg5 <= 10000, 1);
        assert!(arg4 != @0x0, 1);
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            amount_bps        : arg2,
            min_amount        : arg3,
            beneficiary       : arg4,
            creator_share_bps : arg5,
        };
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun fee_amount<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: u64) : u64 {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0);
        let v2 = (((arg1 as u128) * (v1.amount_bps as u128) / (10000 as u128)) as u64);
        let v3 = v2;
        if (v2 < v1.min_amount) {
            v3 = v1.min_amount;
        };
        v3
    }

    public fun pay<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = fee_amount<T0>(arg0, 0x2::transfer_policy::paid<T0>(arg1));
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v0, 0);
        let v1 = Rule{dummy_field: false};
        let v2 = 0x2::transfer_policy::get_rule<T0, Rule, Config>(v1, arg0);
        let v3 = (((v0 as u128) * (v2.creator_share_bps as u128) / (10000 as u128)) as u64);
        let v4 = 0x2::coin::split<0x2::sui::SUI>(arg2, v0, arg3);
        if (v3 > 0) {
            let v5 = Rule{dummy_field: false};
            0x2::transfer_policy::add_to_balance<T0, Rule>(v5, arg0, 0x2::coin::split<0x2::sui::SUI>(&mut v4, v3, arg3));
        };
        if (0x2::coin::value<0x2::sui::SUI>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v2.beneficiary);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v4);
        };
        let v6 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v6, arg1);
    }

    // decompiled from Move bytecode v7
}

