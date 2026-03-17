module 0x34388e8331a382b664f6d828d1347b8a0a7318b9f87fdb674987637aad87850a::custom_liquidate {
    struct CustomLiquidateReceipt<phantom T0> {
        balances: 0x2::bag::Bag,
        flash_loan_debts: 0x2::table::Table<u8, 0x2::table::Table<0x1::type_name::TypeName, u64>>,
    }

    public fun custom_liquidate<T0, T1, T2>(arg0: &mut CustomLiquidateReceipt<T1>, arg1: &0x34388e8331a382b664f6d828d1347b8a0a7318b9f87fdb674987637aad87850a::liquidator::Liquidator, arg2: 0x2::coin::Coin<T2>, arg3: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg4: 0x2::object::ID, arg5: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg6: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::liquidate::liquidate_as_coin<T0, T2, T1>(arg3, 0x34388e8331a382b664f6d828d1347b8a0a7318b9f87fdb674987637aad87850a::liquidator::borrow_package_caller_cap(arg1), arg4, arg5, arg2, arg6, arg7, arg8, arg9);
        let v2 = v1;
        put_balance_internal<T1, T1>(arg0, 0x2::coin::into_balance<T1>(v0));
        if (0x2::coin::value<T2>(&v2) == 0) {
            0x2::coin::destroy_zero<T2>(v2);
        } else {
            put_balance_internal<T1, T2>(arg0, 0x2::coin::into_balance<T2>(v2));
        };
    }

    public(friend) fun add_flash_loan_debts<T0, T1>(arg0: &mut CustomLiquidateReceipt<T0>, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (0x2::table::contains<u8, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&arg0.flash_loan_debts, arg1)) {
            let v1 = 0x2::table::borrow_mut<u8, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&mut arg0.flash_loan_debts, arg1);
            if (0x2::table::contains<0x1::type_name::TypeName, u64>(v1, v0)) {
                let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(v1, v0);
                *v2 = *v2 + arg2;
            } else {
                0x2::table::add<0x1::type_name::TypeName, u64>(v1, v0, arg2);
            };
        } else {
            let v3 = 0x2::table::new<0x1::type_name::TypeName, u64>(arg3);
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut v3, v0, arg2);
            0x2::table::add<u8, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&mut arg0.flash_loan_debts, arg1, v3);
        };
    }

    public(friend) fun borrow_flash_loan_debts_mut<T0>(arg0: &mut CustomLiquidateReceipt<T0>) : &mut 0x2::table::Table<u8, 0x2::table::Table<0x1::type_name::TypeName, u64>> {
        &mut arg0.flash_loan_debts
    }

    public fun create_receipt<T0>(arg0: &0x34388e8331a382b664f6d828d1347b8a0a7318b9f87fdb674987637aad87850a::liquidator::Liquidator, arg1: &mut 0x2::tx_context::TxContext) : CustomLiquidateReceipt<T0> {
        0x34388e8331a382b664f6d828d1347b8a0a7318b9f87fdb674987637aad87850a::liquidator::ensure_caller_whitelisted(arg0, 0x2::tx_context::sender(arg1));
        CustomLiquidateReceipt<T0>{
            balances         : 0x2::bag::new(arg1),
            flash_loan_debts : 0x2::table::new<u8, 0x2::table::Table<0x1::type_name::TypeName, u64>>(arg1),
        }
    }

    public fun put_balance<T0: drop, T1, T2>(arg0: &mut CustomLiquidateReceipt<T1>, arg1: &0x34388e8331a382b664f6d828d1347b8a0a7318b9f87fdb674987637aad87850a::liquidator::Liquidator, arg2: 0x2::balance::Balance<T2>) {
        assert!(0x34388e8331a382b664f6d828d1347b8a0a7318b9f87fdb674987637aad87850a::liquidator::is_package_whitelisted<T0>(arg1), 0x34388e8331a382b664f6d828d1347b8a0a7318b9f87fdb674987637aad87850a::error::package_not_whitelisted());
        put_balance_internal<T1, T2>(arg0, arg2);
    }

    fun put_balance_internal<T0, T1>(arg0: &mut CustomLiquidateReceipt<T0>, arg1: 0x2::balance::Balance<T1>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::with_defining_ids<T1>(), arg1);
        };
    }

    public(friend) fun sub_flash_loan_debts<T0, T1>(arg0: &mut CustomLiquidateReceipt<T0>, arg1: u8, arg2: u64) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (0x2::table::contains<u8, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&arg0.flash_loan_debts, arg1)) {
            let v1 = 0x2::table::borrow_mut<u8, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&mut arg0.flash_loan_debts, arg1);
            if (0x2::table::contains<0x1::type_name::TypeName, u64>(v1, v0)) {
                let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(v1, v0);
                *v2 = *v2 - arg2;
            } else {
                0x34388e8331a382b664f6d828d1347b8a0a7318b9f87fdb674987637aad87850a::error::invalid_coin_type();
            };
        } else {
            0x34388e8331a382b664f6d828d1347b8a0a7318b9f87fdb674987637aad87850a::error::invalid_protocol_id();
        };
    }

    public fun take_balance<T0: drop, T1, T2>(arg0: &mut CustomLiquidateReceipt<T1>, arg1: &0x34388e8331a382b664f6d828d1347b8a0a7318b9f87fdb674987637aad87850a::liquidator::Liquidator, arg2: u64) : 0x2::balance::Balance<T2> {
        assert!(0x34388e8331a382b664f6d828d1347b8a0a7318b9f87fdb674987637aad87850a::liquidator::is_package_whitelisted<T0>(arg1), 0x34388e8331a382b664f6d828d1347b8a0a7318b9f87fdb674987637aad87850a::error::package_not_whitelisted());
        take_balance_internal<T1, T2>(arg0, arg2)
    }

    fun take_balance_internal<T0, T1>(arg0: &mut CustomLiquidateReceipt<T0>, arg1: u64) : 0x2::balance::Balance<T1> {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 0x34388e8331a382b664f6d828d1347b8a0a7318b9f87fdb674987637aad87850a::error::invalid_coin_type());
        let v1 = 0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.balances, v0));
        assert!(v1 >= arg1, 0x34388e8331a382b664f6d828d1347b8a0a7318b9f87fdb674987637aad87850a::error::insufficient_balance());
        if (arg1 == v1) {
            0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0)
        } else {
            0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0), arg1)
        }
    }

    public fun verify_custom_liquidate<T0>(arg0: CustomLiquidateReceipt<T0>, arg1: &0x34388e8331a382b664f6d828d1347b8a0a7318b9f87fdb674987637aad87850a::liquidator::Liquidator, arg2: &mut 0x2::tx_context::TxContext) {
        let CustomLiquidateReceipt {
            balances         : v0,
            flash_loan_debts : v1,
        } = arg0;
        let v2 = v1;
        let v3 = v0;
        assert!(0x2::table::is_empty<u8, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&v2), 0x34388e8331a382b664f6d828d1347b8a0a7318b9f87fdb674987637aad87850a::error::flash_loan_debts_not_empty());
        0x2::table::destroy_empty<u8, 0x2::table::Table<0x1::type_name::TypeName, u64>>(v2);
        assert!(0x2::bag::is_empty(&v3), 0x34388e8331a382b664f6d828d1347b8a0a7318b9f87fdb674987637aad87850a::error::balances_not_empty());
        0x2::bag::destroy_empty(v3);
        0x34388e8331a382b664f6d828d1347b8a0a7318b9f87fdb674987637aad87850a::liquidator::transfer_to_recipient<T0>(arg1, 0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v3, 0x1::type_name::with_defining_ids<T0>()), arg2));
    }

    // decompiled from Move bytecode v6
}

