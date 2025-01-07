module 0x94f27d71ea24cadaf37956c0a77ca1c59561cbf9ff08ead7e990059a8584713c::royalty_proportional_rule {
    struct RoyaltyProportional has store, key {
        id: 0x2::object::UID,
        shares: 0x94f27d71ea24cadaf37956c0a77ca1c59561cbf9ff08ead7e990059a8584713c::royalty_share::Shares,
        amount_bps: u16,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        royalty_id: 0x2::object::ID,
    }

    public fun new(arg0: 0x94f27d71ea24cadaf37956c0a77ca1c59561cbf9ff08ead7e990059a8584713c::royalty_share::Shares, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) : RoyaltyProportional {
        RoyaltyProportional{
            id         : 0x2::object::new(arg2),
            shares     : arg0,
            amount_bps : arg1,
            balance    : 0x2::balance::zero<0x2::sui::SUI>(),
        }
    }

    public fun add<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: &RoyaltyProportional) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{royalty_id: 0x2::object::id<RoyaltyProportional>(arg2)};
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    public entry fun distribute(arg0: &mut RoyaltyProportional, arg1: &mut 0x2::tx_context::TxContext) {
        0x94f27d71ea24cadaf37956c0a77ca1c59561cbf9ff08ead7e990059a8584713c::royalty_share::distribute(&arg0.shares, &mut arg0.balance, arg1);
    }

    public fun pay<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: &mut RoyaltyProportional, arg3: &mut 0x2::balance::Balance<0x2::sui::SUI>) {
        let v0 = Rule{dummy_field: false};
        assert!(0x2::object::id<RoyaltyProportional>(arg2) == 0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0).royalty_id, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::balance::split<0x2::sui::SUI>(arg3, (((0x2::transfer_policy::paid<T0>(arg1) as u128) * (arg2.amount_bps as u128) / (10000 as u128)) as u64)));
        let v1 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v1, arg1);
    }

    // decompiled from Move bytecode v6
}

