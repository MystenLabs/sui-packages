module 0x69ed5000acf83bcf9fa5fe44d041ada877d34879e88a71ab7b65b3dbceaea2a9::wrapper {
    struct Wrapper has store, key {
        id: 0x2::object::UID,
        deep_reserves: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
        deep_reserves_coverage_fees: 0x2::bag::Bag,
        protocol_fees: 0x2::bag::Bag,
    }

    struct FundCap has store, key {
        id: 0x2::object::UID,
        wrapper_id: 0x2::object::ID,
    }

    struct ChargedFeeKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun join(arg0: &mut Wrapper, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_reserves, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1));
    }

    public fun admin_withdraw_deep_reserves_coverage_fee<T0>(arg0: &0x69ed5000acf83bcf9fa5fe44d041ada877d34879e88a71ab7b65b3dbceaea2a9::admin::AdminCap, arg1: &mut Wrapper, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 1000
    }

    public fun admin_withdraw_deep_reserves_coverage_fee_v2<T0>(arg0: &mut Wrapper, arg1: &0x69ed5000acf83bcf9fa5fe44d041ada877d34879e88a71ab7b65b3dbceaea2a9::admin::AdminCap, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: u16, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x69ed5000acf83bcf9fa5fe44d041ada877d34879e88a71ab7b65b3dbceaea2a9::multisig::check_if_sender_is_multisig_address(arg2, arg3, arg4, arg5), 3);
        withdraw_deep_reserves_coverage_fee_internal<T0>(arg0, arg5)
    }

    public fun admin_withdraw_protocol_fee<T0>(arg0: &0x69ed5000acf83bcf9fa5fe44d041ada877d34879e88a71ab7b65b3dbceaea2a9::admin::AdminCap, arg1: &mut Wrapper, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 1000
    }

    public fun admin_withdraw_protocol_fee_v2<T0>(arg0: &mut Wrapper, arg1: &0x69ed5000acf83bcf9fa5fe44d041ada877d34879e88a71ab7b65b3dbceaea2a9::admin::AdminCap, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: u16, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x69ed5000acf83bcf9fa5fe44d041ada877d34879e88a71ab7b65b3dbceaea2a9::multisig::check_if_sender_is_multisig_address(arg2, arg3, arg4, arg5), 3);
        let v0 = ChargedFeeKey<T0>{dummy_field: false};
        if (0x2::bag::contains<ChargedFeeKey<T0>>(&arg0.protocol_fees, v0)) {
            0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<ChargedFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fees, v0)), arg5)
        } else {
            0x2::coin::zero<T0>(arg5)
        }
    }

    public fun create_fund_cap(arg0: &0x69ed5000acf83bcf9fa5fe44d041ada877d34879e88a71ab7b65b3dbceaea2a9::admin::AdminCap, arg1: &Wrapper, arg2: &mut 0x2::tx_context::TxContext) : FundCap {
        abort 1000
    }

    public fun create_fund_cap_v2(arg0: &Wrapper, arg1: &0x69ed5000acf83bcf9fa5fe44d041ada877d34879e88a71ab7b65b3dbceaea2a9::admin::AdminCap, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: u16, arg5: &mut 0x2::tx_context::TxContext) : FundCap {
        assert!(0x69ed5000acf83bcf9fa5fe44d041ada877d34879e88a71ab7b65b3dbceaea2a9::multisig::check_if_sender_is_multisig_address(arg2, arg3, arg4, arg5), 3);
        FundCap{
            id         : 0x2::object::new(arg5),
            wrapper_id : 0x2::object::uid_to_inner(&arg0.id),
        }
    }

    public fun deep_reserves(arg0: &Wrapper) : u64 {
        0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.deep_reserves)
    }

    public fun get_deep_reserves_value(arg0: &Wrapper) : u64 {
        abort 1000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Wrapper{
            id                          : 0x2::object::new(arg0),
            deep_reserves               : 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(),
            deep_reserves_coverage_fees : 0x2::bag::new(arg0),
            protocol_fees               : 0x2::bag::new(arg0),
        };
        let v1 = FundCap{
            id         : 0x2::object::new(arg0),
            wrapper_id : 0x2::object::uid_to_inner(&v0.id),
        };
        0x2::transfer::share_object<Wrapper>(v0);
        0x2::transfer::transfer<FundCap>(v1, 0x2::tx_context::sender(arg0));
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
        assert!(arg1 <= 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.deep_reserves), 2);
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_reserves, arg1), arg2)
    }

    public fun withdraw_deep_reserves(arg0: &0x69ed5000acf83bcf9fa5fe44d041ada877d34879e88a71ab7b65b3dbceaea2a9::admin::AdminCap, arg1: &mut Wrapper, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        abort 1000
    }

    public fun withdraw_deep_reserves_coverage_fee<T0>(arg0: &FundCap, arg1: &mut Wrapper, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 1000
    }

    fun withdraw_deep_reserves_coverage_fee_internal<T0>(arg0: &mut Wrapper, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = ChargedFeeKey<T0>{dummy_field: false};
        if (0x2::bag::contains<ChargedFeeKey<T0>>(&arg0.deep_reserves_coverage_fees, v0)) {
            0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<ChargedFeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.deep_reserves_coverage_fees, v0)), arg1)
        } else {
            0x2::coin::zero<T0>(arg1)
        }
    }

    public fun withdraw_deep_reserves_coverage_fee_v2<T0>(arg0: &mut Wrapper, arg1: &FundCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.wrapper_id == 0x2::object::uid_to_inner(&arg0.id), 1);
        withdraw_deep_reserves_coverage_fee_internal<T0>(arg0, arg2)
    }

    public fun withdraw_deep_reserves_v2(arg0: &mut Wrapper, arg1: &0x69ed5000acf83bcf9fa5fe44d041ada877d34879e88a71ab7b65b3dbceaea2a9::admin::AdminCap, arg2: u64, arg3: vector<vector<u8>>, arg4: vector<u8>, arg5: u16, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        assert!(0x69ed5000acf83bcf9fa5fe44d041ada877d34879e88a71ab7b65b3dbceaea2a9::multisig::check_if_sender_is_multisig_address(arg3, arg4, arg5, arg6), 3);
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_reserves, arg2), arg6)
    }

    // decompiled from Move bytecode v6
}

