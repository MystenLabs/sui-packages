module 0x5dd1fb9f784129f0815c8e54ed917ad698401c0900ebeb1525f37fac98a94dda::royalty_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct RoyaltyConfig has drop, store {
        fee_bps: u64,
    }

    public fun add(arg0: &mut 0x2::transfer_policy::TransferPolicy<0x5dd1fb9f784129f0815c8e54ed917ad698401c0900ebeb1525f37fac98a94dda::walrus_names::NameCap>, arg1: &0x2::transfer_policy::TransferPolicyCap<0x5dd1fb9f784129f0815c8e54ed917ad698401c0900ebeb1525f37fac98a94dda::walrus_names::NameCap>, arg2: u64) {
        assert!(arg2 <= 1000, 0);
        let v0 = Rule{dummy_field: false};
        let v1 = RoyaltyConfig{fee_bps: arg2};
        0x2::transfer_policy::add_rule<0x5dd1fb9f784129f0815c8e54ed917ad698401c0900ebeb1525f37fac98a94dda::walrus_names::NameCap, Rule, RoyaltyConfig>(v0, arg0, arg1, v1);
    }

    public(friend) fun deposit(arg0: &mut 0x2::transfer_policy::TransferPolicy<0x5dd1fb9f784129f0815c8e54ed917ad698401c0900ebeb1525f37fac98a94dda::walrus_names::NameCap>, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::add_to_balance<0x5dd1fb9f784129f0815c8e54ed917ad698401c0900ebeb1525f37fac98a94dda::walrus_names::NameCap, Rule>(v0, arg0, arg1);
    }

    public fun fee_bps(arg0: &0x2::transfer_policy::TransferPolicy<0x5dd1fb9f784129f0815c8e54ed917ad698401c0900ebeb1525f37fac98a94dda::walrus_names::NameCap>) : u64 {
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::get_rule<0x5dd1fb9f784129f0815c8e54ed917ad698401c0900ebeb1525f37fac98a94dda::walrus_names::NameCap, Rule, RoyaltyConfig>(v0, arg0).fee_bps
    }

    public fun pay(arg0: &mut 0x2::transfer_policy::TransferPolicy<0x5dd1fb9f784129f0815c8e54ed917ad698401c0900ebeb1525f37fac98a94dda::walrus_names::NameCap>, arg1: &mut 0x2::transfer_policy::TransferRequest<0x5dd1fb9f784129f0815c8e54ed917ad698401c0900ebeb1525f37fac98a94dda::walrus_names::NameCap>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = Rule{dummy_field: false};
        0x2::transfer_policy::add_to_balance<0x5dd1fb9f784129f0815c8e54ed917ad698401c0900ebeb1525f37fac98a94dda::walrus_names::NameCap, Rule>(v1, arg0, 0x2::coin::split<0x2::sui::SUI>(arg2, ((((0x2::transfer_policy::paid<0x5dd1fb9f784129f0815c8e54ed917ad698401c0900ebeb1525f37fac98a94dda::walrus_names::NameCap>(arg1) as u128) * (0x2::transfer_policy::get_rule<0x5dd1fb9f784129f0815c8e54ed917ad698401c0900ebeb1525f37fac98a94dda::walrus_names::NameCap, Rule, RoyaltyConfig>(v0, arg0).fee_bps as u128) + 9999) / 10000) as u64), arg3));
        let v2 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<0x5dd1fb9f784129f0815c8e54ed917ad698401c0900ebeb1525f37fac98a94dda::walrus_names::NameCap, Rule>(v2, arg1);
    }

    public fun update_fee(arg0: &mut 0x2::transfer_policy::TransferPolicy<0x5dd1fb9f784129f0815c8e54ed917ad698401c0900ebeb1525f37fac98a94dda::walrus_names::NameCap>, arg1: &0x2::transfer_policy::TransferPolicyCap<0x5dd1fb9f784129f0815c8e54ed917ad698401c0900ebeb1525f37fac98a94dda::walrus_names::NameCap>, arg2: u64) {
        assert!(arg2 <= 1000, 0);
        0x2::transfer_policy::remove_rule<0x5dd1fb9f784129f0815c8e54ed917ad698401c0900ebeb1525f37fac98a94dda::walrus_names::NameCap, Rule, RoyaltyConfig>(arg0, arg1);
        let v0 = Rule{dummy_field: false};
        let v1 = RoyaltyConfig{fee_bps: arg2};
        0x2::transfer_policy::add_rule<0x5dd1fb9f784129f0815c8e54ed917ad698401c0900ebeb1525f37fac98a94dda::walrus_names::NameCap, Rule, RoyaltyConfig>(v0, arg0, arg1, v1);
    }

    // decompiled from Move bytecode v7
}

