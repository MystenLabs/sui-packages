module 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::price_policy {
    struct PricePolicyRegistry has store, key {
        id: 0x2::object::UID,
        price_policies: 0x2::table::Table<0x1::type_name::TypeName, 0x1::type_name::TypeName>,
    }

    public(friend) fun add_price_policy<T0: drop>(arg0: &mut PricePolicyRegistry, arg1: 0x1::type_name::TypeName) {
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

