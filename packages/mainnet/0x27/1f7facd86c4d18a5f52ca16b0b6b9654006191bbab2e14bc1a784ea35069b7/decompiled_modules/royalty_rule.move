module 0x271f7facd86c4d18a5f52ca16b0b6b9654006191bbab2e14bc1a784ea35069b7::royalty_rule {
    struct RoyaltyRule has drop {
        dummy_field: bool,
    }

    struct RoyaltyConfig has drop, store {
        royalty_bps: u64,
        min_royalty: u64,
        recipient: address,
    }

    struct RoyaltyReceipt has drop, store {
        amount_paid: u64,
    }

    struct RoyaltyPaid has copy, drop {
        nft_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
        payer: address,
    }

    struct RoyaltyRuleAdded has copy, drop {
        policy_id: 0x2::object::ID,
        royalty_bps: u64,
        recipient: address,
    }

    public fun add_rule<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u64, arg3: u64, arg4: address) {
        assert!(arg2 <= 1000, 1);
        let v0 = RoyaltyConfig{
            royalty_bps : arg2,
            min_royalty : arg3,
            recipient   : arg4,
        };
        let v1 = RoyaltyRule{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, RoyaltyRule, RoyaltyConfig>(v1, arg0, arg1, v0);
        let v2 = RoyaltyRuleAdded{
            policy_id   : 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg0),
            royalty_bps : arg2,
            recipient   : arg4,
        };
        0x2::event::emit<RoyaltyRuleAdded>(v2);
    }

    public fun remove_rule<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        0x2::transfer_policy::remove_rule<T0, RoyaltyRule, RoyaltyConfig>(arg0, arg1);
    }

    public fun calculate_royalty(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64);
        if (v0 < arg2) {
            arg2
        } else {
            v0
        }
    }

    public fun get_config<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>) : (u64, u64, address) {
        let v0 = RoyaltyRule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, RoyaltyRule, RoyaltyConfig>(v0, arg0);
        (v1.royalty_bps, v1.min_royalty, v1.recipient)
    }

    public fun pay_royalty<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = RoyaltyRule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, RoyaltyRule, RoyaltyConfig>(v0, arg0);
        let v2 = calculate_royalty(0x2::transfer_policy::paid<T0>(arg1), v1.royalty_bps, v1.min_royalty);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v2, 0);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v2), arg3), v1.recipient);
        let v4 = 0x2::tx_context::sender(arg3);
        if (0x2::balance::value<0x2::sui::SUI>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg3), v4);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v3);
        };
        let v5 = RoyaltyRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, RoyaltyRule>(v5, arg1);
        let v6 = RoyaltyPaid{
            nft_id    : 0x2::transfer_policy::item<T0>(arg1),
            amount    : v2,
            recipient : v1.recipient,
            payer     : v4,
        };
        0x2::event::emit<RoyaltyPaid>(v6);
    }

    public fun update_config<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u64, arg3: u64, arg4: address) {
        assert!(arg2 <= 1000, 1);
        0x2::transfer_policy::remove_rule<T0, RoyaltyRule, RoyaltyConfig>(arg0, arg1);
        let v0 = RoyaltyConfig{
            royalty_bps : arg2,
            min_royalty : arg3,
            recipient   : arg4,
        };
        let v1 = RoyaltyRule{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, RoyaltyRule, RoyaltyConfig>(v1, arg0, arg1, v0);
    }

    // decompiled from Move bytecode v6
}

