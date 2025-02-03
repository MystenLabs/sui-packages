module 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::price_policy {
    struct PricePolicyRegistry has store, key {
        id: 0x2::object::UID,
        price_policies: 0x2::table::Table<0x1::type_name::TypeName, 0x1::type_name::TypeName>,
    }

    public(friend) fun add_price_policy<T0: drop>(arg0: &mut PricePolicyRegistry, arg1: 0x1::type_name::TypeName) {
        if (0x2::table::contains<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg0.price_policies, arg1)) {
            0x2::table::remove<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&mut arg0.price_policies, arg1);
        };
        0x2::table::add<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&mut arg0.price_policies, arg1, 0x1::type_name::get<T0>());
    }

    public fun get_price_policy(arg0: &PricePolicyRegistry, arg1: 0x1::type_name::TypeName) : 0x1::type_name::TypeName {
        *0x2::table::borrow<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg0.price_policies, arg1)
    }

    public(friend) fun initialize(arg0: &mut 0x2::tx_context::TxContext) : PricePolicyRegistry {
        PricePolicyRegistry{
            id             : 0x2::object::new(arg0),
            price_policies : 0x2::table::new<0x1::type_name::TypeName, 0x1::type_name::TypeName>(arg0),
        }
    }

    // decompiled from Move bytecode v6
}

