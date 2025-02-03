module 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::price_receipt {
    struct PriceReceipt {
        for: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        asset_values: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        debt_value: 0x1::option::Option<u64>,
    }

    public(friend) fun new(arg0: &0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::price_policy::PricePolicyRegistry, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : PriceReceipt {
        PriceReceipt{
            for          : arg1,
            policy_id    : 0x2::object::id<0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::price_policy::PricePolicyRegistry>(arg0),
            asset_values : 0x2::table::new<0x1::type_name::TypeName, u64>(arg2),
            debt_value   : 0x1::option::none<u64>(),
        }
    }

    public fun burn(arg0: PriceReceipt) {
        let PriceReceipt {
            for          : _,
            policy_id    : _,
            asset_values : v2,
            debt_value   : _,
        } = arg0;
        0x2::table::drop<0x1::type_name::TypeName, u64>(v2);
    }

    public fun get_asset_value(arg0: &PriceReceipt, arg1: 0x1::type_name::TypeName) : u64 {
        *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.asset_values, arg1)
    }

    public fun get_debt_value(arg0: &PriceReceipt) : u64 {
        *0x1::option::borrow<u64>(&arg0.debt_value)
    }

    public fun set_asset_value<T0: drop>(arg0: T0, arg1: &0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::price_policy::PricePolicyRegistry, arg2: &mut PriceReceipt, arg3: 0x1::type_name::TypeName, arg4: u64) {
        assert!(arg2.policy_id == 0x2::object::id<0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::price_policy::PricePolicyRegistry>(arg1), 0);
        assert!(0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::price_policy::get_price_policy(arg1, arg3) == 0x1::type_name::get<T0>(), 1);
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg2.asset_values, arg3, arg4);
    }

    public fun set_debt_value<T0: drop>(arg0: T0, arg1: &0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::price_policy::PricePolicyRegistry, arg2: &mut PriceReceipt, arg3: 0x1::type_name::TypeName, arg4: u64) {
        assert!(arg2.policy_id == 0x2::object::id<0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::price_policy::PricePolicyRegistry>(arg1), 0);
        assert!(0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::price_policy::get_price_policy(arg1, arg3) == 0x1::type_name::get<T0>(), 1);
        0x1::option::fill<u64>(&mut arg2.debt_value, arg4);
    }

    // decompiled from Move bytecode v6
}

