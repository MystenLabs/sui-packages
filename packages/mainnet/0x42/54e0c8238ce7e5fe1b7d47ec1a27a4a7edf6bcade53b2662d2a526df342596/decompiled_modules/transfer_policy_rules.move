module 0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::transfer_policy_rules {
    struct RoyaltyRule has drop {
        dummy_field: bool,
    }

    struct PlatformFeeRule has drop {
        dummy_field: bool,
    }

    struct RoyaltyConfig has drop, store {
        rate_bps: u64,
        recipient: address,
    }

    struct PlatformFeeConfig has drop, store {
        rate_bps: u64,
        recipient: address,
    }

    struct RoyaltyConfigured has copy, drop {
        policy_id: 0x2::object::ID,
        rate_bps: u64,
        recipient: address,
    }

    struct PlatformFeeConfigured has copy, drop {
        policy_id: 0x2::object::ID,
        rate_bps: u64,
        recipient: address,
    }

    struct FeesWithdrawn has copy, drop {
        policy_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
    }

    public fun calculate_platform_fee<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: u64) : u64 {
        if (0x2::transfer_policy::has_rule<T0, PlatformFeeRule>(arg0)) {
            let v1 = PlatformFeeRule{dummy_field: false};
            arg1 * 0x2::transfer_policy::get_rule<T0, PlatformFeeRule, PlatformFeeConfig>(v1, arg0).rate_bps / 10000
        } else {
            0
        }
    }

    public fun calculate_royalty_fee<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: u64) : u64 {
        if (0x2::transfer_policy::has_rule<T0, RoyaltyRule>(arg0)) {
            let v1 = RoyaltyRule{dummy_field: false};
            arg1 * 0x2::transfer_policy::get_rule<T0, RoyaltyRule, RoyaltyConfig>(v1, arg0).rate_bps / 10000
        } else {
            0
        }
    }

    public entry fun configure_platform_fee<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 10000, 0);
        if (0x2::transfer_policy::has_rule<T0, PlatformFeeRule>(arg0)) {
            0x2::transfer_policy::remove_rule<T0, PlatformFeeRule, PlatformFeeConfig>(arg0, arg1);
        };
        let v0 = PlatformFeeConfig{
            rate_bps  : arg2,
            recipient : arg3,
        };
        let v1 = PlatformFeeRule{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, PlatformFeeRule, PlatformFeeConfig>(v1, arg0, arg1, v0);
        let v2 = PlatformFeeConfigured{
            policy_id : 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg0),
            rate_bps  : arg2,
            recipient : arg3,
        };
        0x2::event::emit<PlatformFeeConfigured>(v2);
    }

    public entry fun configure_royalty<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 10000, 0);
        if (0x2::transfer_policy::has_rule<T0, RoyaltyRule>(arg0)) {
            0x2::transfer_policy::remove_rule<T0, RoyaltyRule, RoyaltyConfig>(arg0, arg1);
        };
        let v0 = RoyaltyConfig{
            rate_bps  : arg2,
            recipient : arg3,
        };
        let v1 = RoyaltyRule{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, RoyaltyRule, RoyaltyConfig>(v1, arg0, arg1, v0);
        let v2 = RoyaltyConfigured{
            policy_id : 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg0),
            rate_bps  : arg2,
            recipient : arg3,
        };
        0x2::event::emit<RoyaltyConfigured>(v2);
    }

    public fun pay_platform_fee<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = calculate_platform_fee<T0>(arg0, 0x2::transfer_policy::paid<T0>(arg1));
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v0, 2);
        let v1 = PlatformFeeRule{dummy_field: false};
        0x2::transfer_policy::add_to_balance<T0, PlatformFeeRule>(v1, arg0, 0x2::coin::split<0x2::sui::SUI>(arg2, v0, arg3));
        let v2 = PlatformFeeRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, PlatformFeeRule>(v2, arg1);
    }

    public fun pay_royalty<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = calculate_royalty_fee<T0>(arg0, 0x2::transfer_policy::paid<T0>(arg1));
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v0, 2);
        let v1 = RoyaltyRule{dummy_field: false};
        0x2::transfer_policy::add_to_balance<T0, RoyaltyRule>(v1, arg0, 0x2::coin::split<0x2::sui::SUI>(arg2, v0, arg3));
        let v2 = RoyaltyRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, RoyaltyRule>(v2, arg1);
    }

    public fun withdraw_and_share<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::transfer_policy::withdraw<T0>(arg0, arg1, 0x1::option::none<u64>(), arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        if (0x2::transfer_policy::has_rule<T0, RoyaltyRule>(arg0) && 0x2::transfer_policy::has_rule<T0, PlatformFeeRule>(arg0)) {
            let v2 = PlatformFeeRule{dummy_field: false};
            let v3 = 0x2::transfer_policy::get_rule<T0, PlatformFeeRule, PlatformFeeConfig>(v2, arg0);
            let v4 = calculate_platform_fee<T0>(arg0, v1);
            if (v4 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, v4, arg2), v3.recipient);
            };
            let v5 = RoyaltyRule{dummy_field: false};
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::transfer_policy::get_rule<T0, RoyaltyRule, RoyaltyConfig>(v5, arg0).recipient);
        } else if (0x2::transfer_policy::has_rule<T0, PlatformFeeRule>(arg0)) {
            let v6 = PlatformFeeRule{dummy_field: false};
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::transfer_policy::get_rule<T0, PlatformFeeRule, PlatformFeeConfig>(v6, arg0).recipient);
        } else if (0x2::transfer_policy::has_rule<T0, RoyaltyRule>(arg0)) {
            let v7 = RoyaltyRule{dummy_field: false};
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::transfer_policy::get_rule<T0, RoyaltyRule, RoyaltyConfig>(v7, arg0).recipient);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg2));
        };
        let v8 = FeesWithdrawn{
            policy_id : 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg0),
            amount    : v1,
            recipient : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<FeesWithdrawn>(v8);
    }

    // decompiled from Move bytecode v6
}

