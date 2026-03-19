module 0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::custom_liquidate {
    struct CustomLiquidateReceipt<phantom T0> {
        balances: 0x2::bag::Bag,
        types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        flash_loan_debts: 0x2::table::Table<u8, 0x2::table::Table<0x1::type_name::TypeName, u64>>,
    }

    public fun custom_liquidate<T0, T1, T2>(arg0: &mut CustomLiquidateReceipt<T1>, arg1: &0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::liquidator::Liquidator, arg2: u64, arg3: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg4: 0x2::object::ID, arg5: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg6: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = take_balance_internal<T1, T2>(arg0, arg2);
        let (v1, v2) = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::liquidate::liquidate_as_coin<T0, T2, T1>(arg3, 0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::liquidator::borrow_package_caller_cap(arg1), arg4, arg5, 0x2::coin::from_balance<T2>(v0, arg9), arg6, arg7, arg8, arg9);
        let v3 = v2;
        put_balance_internal<T1, T1>(arg0, 0x2::coin::into_balance<T1>(v1));
        if (0x2::coin::value<T2>(&v3) == 0) {
            0x2::coin::destroy_zero<T2>(v3);
        } else {
            put_balance_internal<T1, T2>(arg0, 0x2::coin::into_balance<T2>(v3));
        };
    }

    public fun add_flash_loan_debts<T0: drop, T1, T2>(arg0: &mut CustomLiquidateReceipt<T1>, arg1: &0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::liquidator::Liquidator, arg2: T0, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::liquidator::is_package_whitelisted<T0>(arg1), 0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::error::package_not_whitelisted());
        add_flash_loan_debts_internal<T1, T2>(arg0, arg3, arg4, arg5);
    }

    fun add_flash_loan_debts_internal<T0, T1>(arg0: &mut CustomLiquidateReceipt<T0>, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
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

    public fun create_receipt<T0>(arg0: &0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::liquidator::Liquidator, arg1: &mut 0x2::tx_context::TxContext) : CustomLiquidateReceipt<T0> {
        0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::liquidator::ensure_caller_whitelisted(arg0, 0x2::tx_context::sender(arg1));
        CustomLiquidateReceipt<T0>{
            balances         : 0x2::bag::new(arg1),
            types            : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            flash_loan_debts : 0x2::table::new<u8, 0x2::table::Table<0x1::type_name::TypeName, u64>>(arg1),
        }
    }

    public fun drain_to_recipient<T0, T1>(arg0: &mut CustomLiquidateReceipt<T0>, arg1: &0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::liquidator::Liquidator, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.types, &v0);
            0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::liquidator::transfer_to_recipient<T1>(arg1, 0x2::coin::from_balance<T1>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0), arg2));
        };
    }

    public fun get_types<T0>(arg0: &CustomLiquidateReceipt<T0>) : vector<0x1::type_name::TypeName> {
        0x2::vec_set::into_keys<0x1::type_name::TypeName>(arg0.types)
    }

    public fun mock_custom_liquidate<T0, T1>(arg0: &mut CustomLiquidateReceipt<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>) {
        put_balance_internal<T0, T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
        if (0x2::coin::value<T1>(&arg2) == 0) {
            0x2::coin::destroy_zero<T1>(arg2);
        } else {
            put_balance_internal<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg2));
        };
    }

    public fun put_balance<T0: drop, T1, T2>(arg0: &mut CustomLiquidateReceipt<T1>, arg1: &0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::liquidator::Liquidator, arg2: T0, arg3: 0x2::balance::Balance<T2>) {
        assert!(0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::liquidator::is_package_whitelisted<T0>(arg1), 0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::error::package_not_whitelisted());
        put_balance_internal<T1, T2>(arg0, arg3);
    }

    fun put_balance_internal<T0, T1>(arg0: &mut CustomLiquidateReceipt<T0>, arg1: 0x2::balance::Balance<T1>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0, arg1);
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.types, v0);
        };
    }

    public fun sub_flash_loan_debts<T0: drop, T1, T2>(arg0: &mut CustomLiquidateReceipt<T1>, arg1: &0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::liquidator::Liquidator, arg2: T0, arg3: u8, arg4: u64) {
        assert!(0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::liquidator::is_package_whitelisted<T0>(arg1), 0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::error::package_not_whitelisted());
        sub_flash_loan_debts_internal<T1, T2>(arg0, arg3, arg4);
    }

    fun sub_flash_loan_debts_internal<T0, T1>(arg0: &mut CustomLiquidateReceipt<T0>, arg1: u8, arg2: u64) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::table::contains<u8, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&arg0.flash_loan_debts, arg1), 0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::error::invalid_protocol_id());
        let v1 = 0x2::table::borrow_mut<u8, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&mut arg0.flash_loan_debts, arg1);
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(v1, v0), 0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::error::invalid_coin_type());
        let v2 = *0x2::table::borrow<0x1::type_name::TypeName, u64>(v1, v0);
        assert!(v2 >= arg2, 0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::error::invalid_repay_amount());
        let v3 = v2 - arg2;
        let v4 = if (v3 == 0) {
            0x2::table::remove<0x1::type_name::TypeName, u64>(v1, v0);
            0x2::table::is_empty<0x1::type_name::TypeName, u64>(v1)
        } else {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(v1, v0) = v3;
            false
        };
        if (v4) {
            0x2::table::destroy_empty<0x1::type_name::TypeName, u64>(0x2::table::remove<u8, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&mut arg0.flash_loan_debts, arg1));
        };
    }

    public fun take_balance<T0: drop, T1, T2>(arg0: &mut CustomLiquidateReceipt<T1>, arg1: &0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::liquidator::Liquidator, arg2: T0, arg3: u64) : 0x2::balance::Balance<T2> {
        assert!(0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::liquidator::is_package_whitelisted<T0>(arg1), 0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::error::package_not_whitelisted());
        take_balance_internal<T1, T2>(arg0, arg3)
    }

    fun take_balance_internal<T0, T1>(arg0: &mut CustomLiquidateReceipt<T0>, arg1: u64) : 0x2::balance::Balance<T1> {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::error::invalid_coin_type());
        let v1 = 0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.balances, v0));
        assert!(v1 >= arg1, 0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::error::insufficient_balance());
        if (arg1 == v1) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.types, &v0);
            0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0)
        } else {
            0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0), arg1)
        }
    }

    public fun verify_custom_liquidate<T0>(arg0: CustomLiquidateReceipt<T0>) {
        let CustomLiquidateReceipt {
            balances         : v0,
            types            : v1,
            flash_loan_debts : v2,
        } = arg0;
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        assert!(0x2::table::is_empty<u8, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&v3), 0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::error::flash_loan_debts_not_empty());
        0x2::table::destroy_empty<u8, 0x2::table::Table<0x1::type_name::TypeName, u64>>(v3);
        assert!(0x2::vec_set::is_empty<0x1::type_name::TypeName>(&v4), 0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::error::balances_not_empty());
        assert!(0x2::bag::is_empty(&v5), 0xf7a6f6b6d72bd90f97c308d2e18a60fe8998d336e83a7817832e8a36bd3d202f::error::balances_not_empty());
        0x2::bag::destroy_empty(v5);
    }

    // decompiled from Move bytecode v6
}

