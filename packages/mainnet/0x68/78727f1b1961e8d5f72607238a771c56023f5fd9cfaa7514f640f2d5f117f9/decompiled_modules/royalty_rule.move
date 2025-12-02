module 0x6878727f1b1961e8d5f72607238a771c56023f5fd9cfaa7514f640f2d5f117f9::royalty_rule {
    struct RoyaltyRule has drop {
        dummy_field: bool,
    }

    struct RoyaltyConfig has drop, store {
        recipient: address,
        basis_points: u16,
    }

    public fun add_to_policy<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: RoyaltyConfig) {
        let v0 = RoyaltyRule{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, RoyaltyRule, RoyaltyConfig>(v0, arg0, arg1, arg2);
    }

    public entry fun add_to_policy_entry<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: address, arg3: u16) {
        add_to_policy<T0>(arg0, arg1, new_config<T0>(arg2, arg3));
    }

    public fun basis_points(arg0: &RoyaltyConfig) : u16 {
        arg0.basis_points
    }

    public fun calculate_royalty<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: u64) : u64 {
        let v0 = RoyaltyRule{dummy_field: false};
        (((arg1 as u128) * (0x2::transfer_policy::get_rule<T0, RoyaltyRule, RoyaltyConfig>(v0, arg0).basis_points as u128) / 10000) as u64)
    }

    public fun get_recipient<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>) : address {
        let v0 = RoyaltyRule{dummy_field: false};
        0x2::transfer_policy::get_rule<T0, RoyaltyRule, RoyaltyConfig>(v0, arg0).recipient
    }

    public fun new_config<T0>(arg0: address, arg1: u16) : RoyaltyConfig {
        RoyaltyConfig{
            recipient    : arg0,
            basis_points : arg1,
        }
    }

    public fun pay<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = RoyaltyRule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, RoyaltyRule, RoyaltyConfig>(v0, arg0);
        let v2 = (((0x2::transfer_policy::paid<T0>(arg1) as u128) * (v1.basis_points as u128) / 10000) as u64);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v2, 0);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v2, arg3), v1.recipient);
        };
        let v3 = RoyaltyRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, RoyaltyRule>(v3, arg1);
    }

    public fun pay_exact<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = RoyaltyRule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, RoyaltyRule, RoyaltyConfig>(v0, arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= (((0x2::transfer_policy::paid<T0>(arg1) as u128) * (v1.basis_points as u128) / 10000) as u64), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v1.recipient);
        let v2 = RoyaltyRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, RoyaltyRule>(v2, arg1);
    }

    // decompiled from Move bytecode v6
}

