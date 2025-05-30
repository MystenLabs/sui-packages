module 0x8c902211239dfaa0faa1296bf3e157157322f09be4332332fa515d82d8745b9b::royalty_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct RoyaltyConfig has drop, store {
        basis_points: u16,
        min_amount: u64,
        recipient: address,
    }

    struct RuleConfig has drop, store {
        config: RoyaltyConfig,
    }

    public fun add<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u16, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 10000, 1);
        let v0 = RoyaltyConfig{
            basis_points : arg2,
            min_amount   : arg3,
            recipient    : 0x2::tx_context::sender(arg4),
        };
        let v1 = RuleConfig{config: v0};
        let v2 = Rule{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, Rule, RuleConfig>(v2, arg0, arg1, v1);
    }

    public fun fee_amount<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: u64) : u64 {
        let v0 = Rule{dummy_field: false};
        let v1 = &0x2::transfer_policy::get_rule<T0, Rule, RuleConfig>(v0, arg0).config;
        let v2 = arg1 * (v1.basis_points as u64) / 10000;
        if (v2 < v1.min_amount) {
            v1.min_amount
        } else {
            v2
        }
    }

    public fun pay<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = &0x2::transfer_policy::get_rule<T0, Rule, RuleConfig>(v0, arg0).config;
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v3 = fee_amount<T0>(arg0, v2);
        assert!(v2 >= v3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v3, arg3), v1.recipient);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v4 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v4, arg1);
    }

    // decompiled from Move bytecode v6
}

