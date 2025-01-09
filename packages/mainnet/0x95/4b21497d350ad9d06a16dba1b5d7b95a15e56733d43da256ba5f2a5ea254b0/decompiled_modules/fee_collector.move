module 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::fee_collector {
    struct FeeCollector<phantom T0> has store {
        balances: 0x2::bag::Bag,
    }

    public fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : FeeCollector<T0> {
        FeeCollector<T0>{balances: 0x2::bag::new(arg0)}
    }

    public fun balance<T0, T1>(arg0: &mut FeeCollector<T1>) : u64 {
        let v0 = key<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
    }

    public fun add_fee<T0, T1>(arg0: &mut FeeCollector<T1>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = key<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::coin::put<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
            return
        };
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::coin::into_balance<T0>(arg1));
    }

    fun key<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::get<T0>()
    }

    public fun withdraw<T0, T1>(arg0: &T1, arg1: &mut FeeCollector<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (arg2 == 0) {
            return 0x2::coin::zero<T0>(arg3)
        };
        let v0 = key<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg1.balances, v0), 1);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 0);
        0x2::coin::take<T0>(v1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

