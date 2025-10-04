module 0xa022fe0b6638c3083b30b043f7abddb3fd3a5245a4ec1b2899f84d245b288e67::cB {
    struct AC {
        from: 0x1::type_name::TypeName,
        balances: 0x2::bag::Bag,
    }

    public fun eA<T0>(arg0: &mut AC, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    public fun fA<T0>(arg0: &0xa022fe0b6638c3083b30b043f7abddb3fd3a5245a4ec1b2899f84d245b288e67::dB::AP, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : AC {
        0xa022fe0b6638c3083b30b043f7abddb3fd3a5245a4ec1b2899f84d245b288e67::dB::gJ(arg0);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 341);
        let v0 = 0x2::bag::new(arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0, v1, 0x2::coin::into_balance<T0>(arg1));
        AC{
            from     : v1,
            balances : v0,
        }
    }

    public fun fF<T0>(arg0: AC, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let AC {
            from     : _,
            balances : v1,
        } = arg0;
        let v2 = v1;
        assert!(0x2::bag::is_empty(&v2), 314);
        0x2::bag::destroy_empty(v2);
        0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v2, 0x1::type_name::with_defining_ids<T0>()), arg1)
    }

    public fun fG<T0>(arg0: &mut AC, arg1: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public fun gD<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun gH<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun gO<T0>(arg0: &mut AC) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            return 0x2::balance::zero<T0>()
        };
        0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0)
    }

    // decompiled from Move bytecode v6
}

