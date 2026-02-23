module 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::ctoken_table {
    struct CTokenTable has store, key {
        id: 0x2::object::UID,
        coin_types: 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::GenericCoinTypeStorage<0x1::type_name::TypeName>,
        ctoken_values: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        balances: 0x2::bag::Bag,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : CTokenTable {
        CTokenTable{
            id            : 0x2::object::new(arg0),
            coin_types    : 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::new<0x1::type_name::TypeName>(arg0),
            ctoken_values : 0x2::table::new<0x1::type_name::TypeName, u64>(arg0),
            balances      : 0x2::bag::new(arg0),
        }
    }

    public(friend) fun ctoken_type_name<T0, T1>() : 0x1::type_name::TypeName {
        0x1::type_name::with_defining_ids<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::ctoken::CToken<T0, T1>>()
    }

    public(friend) fun ctoken_value_by_coin_type(arg0: &CTokenTable, arg1: 0x1::type_name::TypeName) : u64 {
        if (!0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::supports_type<0x1::type_name::TypeName>(&arg0.coin_types, arg1)) {
            0
        } else {
            ctoken_value_by_ctoken_type(arg0, *0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::load_by_type<0x1::type_name::TypeName>(&arg0.coin_types, arg1))
        }
    }

    public(friend) fun ctoken_value_by_ctoken_type(arg0: &CTokenTable, arg1: 0x1::type_name::TypeName) : u64 {
        if (!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.ctoken_values, arg1)) {
            return 0
        };
        *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.ctoken_values, arg1)
    }

    public(friend) fun is_supporting_collateral<T0, T1>(arg0: &CTokenTable) : bool {
        0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.ctoken_values, ctoken_type_name<T0, T1>())
    }

    public(friend) fun join_ctoken<T0, T1>(arg0: &mut CTokenTable, arg1: 0x2::balance::Balance<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::ctoken::CToken<T0, T1>>) {
        assert!(0x2::balance::value<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::ctoken::CToken<T0, T1>>(&arg1) > 0, 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::error::reserve_join_zero_value());
        assert!(0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::supports<0x1::type_name::TypeName, T1>(&arg0.coin_types), 13906834474991091711);
        let v0 = ctoken_type_name<T0, T1>();
        *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.ctoken_values, v0) = 0x2::balance::join<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::ctoken::CToken<T0, T1>>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::ctoken::CToken<T0, T1>>>(&mut arg0.balances, v0), arg1);
    }

    public(friend) fun split_ctoken<T0, T1>(arg0: &mut CTokenTable, arg1: u64) : 0x2::balance::Balance<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::ctoken::CToken<T0, T1>> {
        assert!(arg1 > 0, 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::error::reserve_split_zero_value());
        let v0 = ctoken_type_name<T0, T1>();
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::ctoken::CToken<T0, T1>>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::ctoken::CToken<T0, T1>>(v1) >= arg1, 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::error::constraint_split_ctoken_too_many());
        if (0x2::balance::value<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::ctoken::CToken<T0, T1>>(v1) == 0) {
            0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::remove<0x1::type_name::TypeName, T1>(&mut arg0.coin_types);
            0x2::balance::destroy_zero<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::ctoken::CToken<T0, T1>>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::ctoken::CToken<T0, T1>>>(&mut arg0.balances, v0));
            0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.ctoken_values, v0);
        } else {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.ctoken_values, v0) = 0x2::balance::value<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::ctoken::CToken<T0, T1>>(v1);
        };
        0x2::balance::split<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::ctoken::CToken<T0, T1>>(v1, arg1)
    }

    public(friend) fun support_collateral_token<T0, T1>(arg0: &mut CTokenTable) {
        let v0 = ctoken_type_name<T0, T1>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.ctoken_values, v0), 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::error::constraint_double_support_ctoken());
        0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::store<0x1::type_name::TypeName, T1>(&mut arg0.coin_types, v0);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::ctoken::CToken<T0, T1>>>(&mut arg0.balances, v0, 0x2::balance::zero<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::ctoken::CToken<T0, T1>>());
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.ctoken_values, v0, 0);
    }

    public(friend) fun supported_coin_types(arg0: &CTokenTable) : vector<0x1::type_name::TypeName> {
        if (0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::is_empty<0x1::type_name::TypeName>(&arg0.coin_types)) {
            0x1::vector::empty<0x1::type_name::TypeName>()
        } else {
            0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::generic_store::keys<0x1::type_name::TypeName>(&arg0.coin_types)
        }
    }

    // decompiled from Move bytecode v6
}

