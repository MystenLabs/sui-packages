module 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::ctoken_table {
    struct CTokenTable has store, key {
        id: 0x2::object::UID,
        coin_types: 0xfa6003d96385f88f62cb5e6d8e7c0786464add393ec44a5023b14f7a6fd37e7a::generic_store::GenericCoinTypeStorage<0x1::type_name::TypeName>,
        ctoken_values: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        balances: 0x2::bag::Bag,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : CTokenTable {
        CTokenTable{
            id            : 0x2::object::new(arg0),
            coin_types    : 0xfa6003d96385f88f62cb5e6d8e7c0786464add393ec44a5023b14f7a6fd37e7a::generic_store::new<0x1::type_name::TypeName>(arg0),
            ctoken_values : 0x2::table::new<0x1::type_name::TypeName, u64>(arg0),
            balances      : 0x2::bag::new(arg0),
        }
    }

    public fun ctoken_type_name<T0, T1>() : 0x1::type_name::TypeName {
        0x1::type_name::get<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::ctoken::CToken<T0, T1>>()
    }

    public fun ctoken_value_by_coin_type(arg0: &CTokenTable, arg1: 0x1::type_name::TypeName) : u64 {
        if (!0xfa6003d96385f88f62cb5e6d8e7c0786464add393ec44a5023b14f7a6fd37e7a::generic_store::supports_type<0x1::type_name::TypeName>(&arg0.coin_types, arg1)) {
            0
        } else {
            ctoken_value_by_ctoken_type(arg0, *0xfa6003d96385f88f62cb5e6d8e7c0786464add393ec44a5023b14f7a6fd37e7a::generic_store::load_by_type<0x1::type_name::TypeName>(&arg0.coin_types, arg1))
        }
    }

    public fun ctoken_value_by_ctoken_type(arg0: &CTokenTable, arg1: 0x1::type_name::TypeName) : u64 {
        if (!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.ctoken_values, arg1)) {
            return 0
        };
        *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.ctoken_values, arg1)
    }

    public fun is_supporting_collateral<T0, T1>(arg0: &CTokenTable) : bool {
        0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.ctoken_values, ctoken_type_name<T0, T1>())
    }

    public(friend) fun join_ctoken<T0, T1>(arg0: &mut CTokenTable, arg1: 0x2::balance::Balance<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::ctoken::CToken<T0, T1>>) {
        assert!(0x2::balance::value<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::ctoken::CToken<T0, T1>>(&arg1) > 0, 13906834487875993599);
        assert!(0xfa6003d96385f88f62cb5e6d8e7c0786464add393ec44a5023b14f7a6fd37e7a::generic_store::supports<0x1::type_name::TypeName, T1>(&arg0.coin_types), 13906834492170960895);
        let v0 = ctoken_type_name<T0, T1>();
        *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.ctoken_values, v0) = 0x2::balance::join<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::ctoken::CToken<T0, T1>>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::ctoken::CToken<T0, T1>>>(&mut arg0.balances, v0), arg1);
    }

    public(friend) fun split_ctoken<T0, T1>(arg0: &mut CTokenTable, arg1: u64) : 0x2::balance::Balance<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::ctoken::CToken<T0, T1>> {
        assert!(arg1 > 0, 13906834548005535743);
        let v0 = ctoken_type_name<T0, T1>();
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::ctoken::CToken<T0, T1>>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::ctoken::CToken<T0, T1>>(v1) >= arg1, 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::error::constraint_split_ctoken_too_many());
        if (0x2::balance::value<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::ctoken::CToken<T0, T1>>(v1) == 0) {
            0xfa6003d96385f88f62cb5e6d8e7c0786464add393ec44a5023b14f7a6fd37e7a::generic_store::remove<0x1::type_name::TypeName, T1>(&mut arg0.coin_types);
            0x2::balance::destroy_zero<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::ctoken::CToken<T0, T1>>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::ctoken::CToken<T0, T1>>>(&mut arg0.balances, v0));
            0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.ctoken_values, v0);
        } else {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.ctoken_values, v0) = 0x2::balance::value<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::ctoken::CToken<T0, T1>>(v1);
        };
        0x2::balance::split<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::ctoken::CToken<T0, T1>>(v1, arg1)
    }

    public(friend) fun support_collateral_token<T0, T1>(arg0: &mut CTokenTable) {
        let v0 = ctoken_type_name<T0, T1>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.ctoken_values, v0), 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::error::constraint_double_support_ctoken());
        0xfa6003d96385f88f62cb5e6d8e7c0786464add393ec44a5023b14f7a6fd37e7a::generic_store::store<0x1::type_name::TypeName, T1>(&mut arg0.coin_types, v0);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::ctoken::CToken<T0, T1>>>(&mut arg0.balances, v0, 0x2::balance::zero<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::ctoken::CToken<T0, T1>>());
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.ctoken_values, v0, 0);
    }

    public fun supported_coin_types(arg0: &CTokenTable) : vector<0x1::type_name::TypeName> {
        if (0xfa6003d96385f88f62cb5e6d8e7c0786464add393ec44a5023b14f7a6fd37e7a::generic_store::is_empty<0x1::type_name::TypeName>(&arg0.coin_types)) {
            0x1::vector::empty<0x1::type_name::TypeName>()
        } else {
            0xfa6003d96385f88f62cb5e6d8e7c0786464add393ec44a5023b14f7a6fd37e7a::generic_store::keys<0x1::type_name::TypeName>(&arg0.coin_types)
        }
    }

    // decompiled from Move bytecode v6
}

