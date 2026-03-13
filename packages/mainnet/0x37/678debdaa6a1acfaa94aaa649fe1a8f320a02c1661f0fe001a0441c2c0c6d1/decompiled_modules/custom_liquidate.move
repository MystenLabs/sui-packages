module 0x37678debdaa6a1acfaa94aaa649fe1a8f320a02c1661f0fe001a0441c2c0c6d1::custom_liquidate {
    struct CustomLiquidateReceipt<phantom T0> {
        balances: 0x2::bag::Bag,
    }

    public fun custom_liquidate<T0, T1, T2>(arg0: &0x37678debdaa6a1acfaa94aaa649fe1a8f320a02c1661f0fe001a0441c2c0c6d1::liquidator::Liquidator, arg1: 0x2::coin::Coin<T2>, arg2: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg3: 0x2::object::ID, arg4: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg5: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : CustomLiquidateReceipt<T1> {
        0x37678debdaa6a1acfaa94aaa649fe1a8f320a02c1661f0fe001a0441c2c0c6d1::liquidator::ensure_caller_whitelisted(arg0, 0x2::tx_context::sender(arg8));
        let v0 = CustomLiquidateReceipt<T1>{balances: 0x2::bag::new(arg8)};
        let (v1, v2) = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::liquidate::liquidate_as_coin<T0, T2, T1>(arg2, 0x37678debdaa6a1acfaa94aaa649fe1a8f320a02c1661f0fe001a0441c2c0c6d1::liquidator::borrow_package_caller_cap(arg0), arg3, arg4, arg1, arg5, arg6, arg7, arg8);
        let v3 = v2;
        let v4 = &mut v0;
        put_balance<T1, T1>(v4, 0x2::coin::into_balance<T1>(v1));
        if (0x2::coin::value<T2>(&v3) == 0) {
            0x2::coin::destroy_zero<T2>(v3);
        } else {
            let v5 = &mut v0;
            put_balance<T1, T2>(v5, 0x2::coin::into_balance<T2>(v3));
        };
        v0
    }

    public(friend) fun put_balance<T0, T1>(arg0: &mut CustomLiquidateReceipt<T0>, arg1: 0x2::balance::Balance<T1>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::with_defining_ids<T1>(), arg1);
        };
    }

    public(friend) fun take_balance<T0, T1>(arg0: &mut CustomLiquidateReceipt<T0>, arg1: u64) : 0x2::balance::Balance<T1> {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 0x37678debdaa6a1acfaa94aaa649fe1a8f320a02c1661f0fe001a0441c2c0c6d1::error::invalid_coin_type());
        let v1 = 0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.balances, v0));
        assert!(v1 >= arg1, 0x37678debdaa6a1acfaa94aaa649fe1a8f320a02c1661f0fe001a0441c2c0c6d1::error::insufficient_balance());
        if (arg1 == v1) {
            0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0)
        } else {
            0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0), arg1)
        }
    }

    public fun verify_custom_liquidate<T0>(arg0: &0x37678debdaa6a1acfaa94aaa649fe1a8f320a02c1661f0fe001a0441c2c0c6d1::liquidator::Liquidator, arg1: CustomLiquidateReceipt<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let CustomLiquidateReceipt { balances: v0 } = arg1;
        assert!(0x2::bag::is_empty(&v0), 0x37678debdaa6a1acfaa94aaa649fe1a8f320a02c1661f0fe001a0441c2c0c6d1::error::balances_not_empty());
        0x2::bag::destroy_empty(v0);
        0x37678debdaa6a1acfaa94aaa649fe1a8f320a02c1661f0fe001a0441c2c0c6d1::liquidator::transfer_to_recipient<T0>(arg0, 0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0, 0x1::type_name::with_defining_ids<T0>()), arg2));
    }

    // decompiled from Move bytecode v6
}

