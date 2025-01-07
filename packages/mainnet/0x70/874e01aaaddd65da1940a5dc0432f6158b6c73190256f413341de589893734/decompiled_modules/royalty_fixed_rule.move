module 0x70874e01aaaddd65da1940a5dc0432f6158b6c73190256f413341de589893734::royalty_fixed_rule {
    struct RoyaltyFixed has store, key {
        id: 0x2::object::UID,
        shares: 0x70874e01aaaddd65da1940a5dc0432f6158b6c73190256f413341de589893734::royalty_share::Shares,
        amount: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        royalty_id: 0x2::object::ID,
    }

    public fun new(arg0: 0x70874e01aaaddd65da1940a5dc0432f6158b6c73190256f413341de589893734::royalty_share::Shares, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : RoyaltyFixed {
        RoyaltyFixed{
            id      : 0x2::object::new(arg2),
            shares  : arg0,
            amount  : arg1,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        }
    }

    public fun add<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: &RoyaltyFixed) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{royalty_id: 0x2::object::id<RoyaltyFixed>(arg2)};
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    public entry fun distribute(arg0: &mut RoyaltyFixed, arg1: &mut 0x2::tx_context::TxContext) {
        0x70874e01aaaddd65da1940a5dc0432f6158b6c73190256f413341de589893734::royalty_share::distribute(&arg0.shares, &mut arg0.balance, arg1);
    }

    public fun pay<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: &mut RoyaltyFixed, arg3: &mut 0x2::balance::Balance<0x2::sui::SUI>) {
        let v0 = Rule{dummy_field: false};
        assert!(0x2::object::id<RoyaltyFixed>(arg2) == 0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0).royalty_id, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::balance::split<0x2::sui::SUI>(arg3, arg2.amount));
        let v1 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v1, arg1);
    }

    // decompiled from Move bytecode v6
}

