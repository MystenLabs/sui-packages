module 0x4cfb4772cf6b253d76364d8cf3f29f94b71d053ec0ca268ce2d698a93938ef79::wrapper {
    struct Wrapper has store, key {
        id: 0x2::object::UID,
        deep_reserves: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
        deep_reserves_coverage_fees: 0x2::bag::Bag,
        protocol_fees: 0x2::bag::Bag,
    }

    struct FundCup has store, key {
        id: 0x2::object::UID,
        wrapper_id: 0x2::object::ID,
    }

    struct ChargedFeeKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun join(arg0: &mut Wrapper, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_reserves, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1));
    }

    public fun create_fund_cap(arg0: &0x4cfb4772cf6b253d76364d8cf3f29f94b71d053ec0ca268ce2d698a93938ef79::admin::AdminCap, arg1: &Wrapper, arg2: &mut 0x2::tx_context::TxContext) : FundCup {
        FundCup{
            id         : 0x2::object::new(arg2),
            wrapper_id : 0x2::object::uid_to_inner(&arg1.id),
        }
    }

    public fun get_deep_reserves_value(arg0: &Wrapper) : u64 {
        0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.deep_reserves)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Wrapper{
            id                          : 0x2::object::new(arg0),
            deep_reserves               : 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(),
            deep_reserves_coverage_fees : 0x2::bag::new(arg0),
            protocol_fees               : 0x2::bag::new(arg0),
        };
        let v1 = FundCup{
            id         : 0x2::object::new(arg0),
            wrapper_id : 0x2::object::uid_to_inner(&v0.id),
        };
        0x2::transfer::share_object<Wrapper>(v0);
        0x2::transfer::transfer<FundCup>(v1, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun join_deep_reserves_coverage_fee<T0>(arg0: &mut Wrapper, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = ChargedFeeKey<T0>{dummy_field: false};
        if (0x2::bag::contains<ChargedFeeKey<T0>>(&arg0.deep_reserves_coverage_fees, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<ChargedFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.deep_reserves_coverage_fees, v0), arg1);
        } else {
            0x2::bag::add<ChargedFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.deep_reserves_coverage_fees, v0, arg1);
        };
    }

    public(friend) fun join_protocol_fee<T0>(arg0: &mut Wrapper, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = ChargedFeeKey<T0>{dummy_field: false};
        if (0x2::bag::contains<ChargedFeeKey<T0>>(&arg0.protocol_fees, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<ChargedFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fees, v0), arg1);
        } else {
            0x2::bag::add<ChargedFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fees, v0, arg1);
        };
    }

    public(friend) fun split_deep_reserves(arg0: &mut Wrapper, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_reserves, arg1), arg2)
    }

    public fun withdraw_deep_reserves_coverage_fee<T0>(arg0: &FundCup, arg1: &mut Wrapper, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.wrapper_id == 0x2::object::uid_to_inner(&arg1.id), 9223372268783009793);
        let v0 = ChargedFeeKey<T0>{dummy_field: false};
        if (0x2::bag::contains<ChargedFeeKey<T0>>(&arg1.deep_reserves_coverage_fees, v0)) {
            0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<ChargedFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg1.deep_reserves_coverage_fees, v0)), arg2)
        } else {
            0x2::coin::zero<T0>(arg2)
        }
    }

    public fun withdraw_protocol_fee<T0>(arg0: &FundCup, arg1: &mut Wrapper, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.wrapper_id == 0x2::object::uid_to_inner(&arg1.id), 9223372358977323009);
        let v0 = ChargedFeeKey<T0>{dummy_field: false};
        if (0x2::bag::contains<ChargedFeeKey<T0>>(&arg1.protocol_fees, v0)) {
            0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<ChargedFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg1.protocol_fees, v0)), arg2)
        } else {
            0x2::coin::zero<T0>(arg2)
        }
    }

    // decompiled from Move bytecode v6
}

