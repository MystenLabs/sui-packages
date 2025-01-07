module 0xfa2b5167406a0a54bc170fa50be04d500899697a32308c48ba0ff27553d22e9d::royalty_proportional_rule {
    struct RoyaltyProportional<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        shares: 0xfa2b5167406a0a54bc170fa50be04d500899697a32308c48ba0ff27553d22e9d::royalty_share::Shares,
        amount_bps: u16,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        royalty_id: 0x2::object::ID,
    }

    public fun new<T0: drop>(arg0: 0xfa2b5167406a0a54bc170fa50be04d500899697a32308c48ba0ff27553d22e9d::royalty_share::Shares, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) : RoyaltyProportional<T0> {
        RoyaltyProportional<T0>{
            id         : 0x2::object::new(arg2),
            shares     : arg0,
            amount_bps : arg1,
            balance    : 0x2::balance::zero<0x2::sui::SUI>(),
        }
    }

    public fun add<T0: drop, T1: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T1>, arg1: &0x2::transfer_policy::TransferPolicyCap<T1>, arg2: &RoyaltyProportional<T0>) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{royalty_id: 0x2::object::id<RoyaltyProportional<T0>>(arg2)};
        0x2::transfer_policy::add_rule<T1, Rule, Config>(v0, arg0, arg1, v1);
    }

    public entry fun distribute<T0: drop>(arg0: &mut RoyaltyProportional<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0xfa2b5167406a0a54bc170fa50be04d500899697a32308c48ba0ff27553d22e9d::royalty_share::distribute(&arg0.shares, &mut arg0.balance, arg1);
    }

    public fun pay<T0: drop, T1: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T1>, arg1: &mut 0x2::transfer_policy::TransferRequest<T1>, arg2: &mut RoyaltyProportional<T0>, arg3: 0xfa2b5167406a0a54bc170fa50be04d500899697a32308c48ba0ff27553d22e9d::royalty_basis::RoyaltyBasis<T0>, arg4: &mut 0x2::balance::Balance<0x2::sui::SUI>) {
        let v0 = Rule{dummy_field: false};
        assert!(0x2::object::id<RoyaltyProportional<T0>>(arg2) == 0x2::transfer_policy::get_rule<T1, Rule, Config>(v0, arg0).royalty_id, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::balance::split<0x2::sui::SUI>(arg4, (((0xfa2b5167406a0a54bc170fa50be04d500899697a32308c48ba0ff27553d22e9d::royalty_basis::basis<T0>(&arg3) as u128) * (arg2.amount_bps as u128) / (10000 as u128)) as u64)));
        let v1 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T1, Rule>(v1, arg1);
    }

    // decompiled from Move bytecode v6
}

