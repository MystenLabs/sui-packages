module 0xb531bba8d504febba31a7dd448bd51b5588faf72bfd6594b0046cd5584c65e3::index {
    struct Registry has key {
        id: 0x2::object::UID,
        seed_pools: 0x2::table::Table<0x1::type_name::TypeName, address>,
        staking_pools: 0x2::table::Table<0x1::type_name::TypeName, address>,
        interest_pools: 0x2::table::Table<0x1::type_name::TypeName, address>,
        policies: 0x2::table::Table<0x1::type_name::TypeName, address>,
    }

    struct RegistryKey<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    public fun add_seed_pool<T0, T1>(arg0: &mut Registry, arg1: address) {
        0x2::table::add<0x1::type_name::TypeName, address>(seed_pools_mut(arg0), 0x1::type_name::get<RegistryKey<T0, T1>>(), arg1);
    }

    public fun assert_new_pool<T0, T1>(arg0: &Registry) {
        assert!(!0x2::table::contains<0x1::type_name::TypeName, address>(&arg0.seed_pools, 0x1::type_name::get<RegistryKey<T0, T1>>()), 0);
    }

    public fun exists_seed_pool<T0, T1>(arg0: &Registry) : bool {
        0x2::table::contains<0x1::type_name::TypeName, address>(&arg0.seed_pools, 0x1::type_name::get<RegistryKey<T0, T1>>())
    }

    public fun get_policy_id<T0>(arg0: &Registry) : address {
        *0x2::table::borrow<0x1::type_name::TypeName, address>(&arg0.policies, 0x1::type_name::get<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id             : 0x2::object::new(arg0),
            seed_pools     : 0x2::table::new<0x1::type_name::TypeName, address>(arg0),
            staking_pools  : 0x2::table::new<0x1::type_name::TypeName, address>(arg0),
            interest_pools : 0x2::table::new<0x1::type_name::TypeName, address>(arg0),
            policies       : 0x2::table::new<0x1::type_name::TypeName, address>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun interest_pool_address<T0, T1>(arg0: &Registry) : 0x1::option::Option<address> {
        let v0 = 0x1::type_name::get<RegistryKey<T0, T1>>();
        if (0x2::table::contains<0x1::type_name::TypeName, address>(&arg0.interest_pools, v0)) {
            0x1::option::some<address>(*0x2::table::borrow<0x1::type_name::TypeName, address>(&arg0.interest_pools, v0))
        } else {
            0x1::option::none<address>()
        }
    }

    public(friend) fun policies_mut(arg0: &mut Registry) : &mut 0x2::table::Table<0x1::type_name::TypeName, address> {
        &mut arg0.policies
    }

    public fun policy_address<T0, T1>(arg0: &Registry) : 0x1::option::Option<address> {
        let v0 = 0x1::type_name::get<RegistryKey<T0, T1>>();
        if (0x2::table::contains<0x1::type_name::TypeName, address>(&arg0.policies, v0)) {
            0x1::option::some<address>(*0x2::table::borrow<0x1::type_name::TypeName, address>(&arg0.policies, v0))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun seed_pool_address<T0, T1>(arg0: &Registry) : 0x1::option::Option<address> {
        let v0 = 0x1::type_name::get<RegistryKey<T0, T1>>();
        if (0x2::table::contains<0x1::type_name::TypeName, address>(&arg0.seed_pools, v0)) {
            0x1::option::some<address>(*0x2::table::borrow<0x1::type_name::TypeName, address>(&arg0.seed_pools, v0))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun seed_pools(arg0: &Registry) : &0x2::table::Table<0x1::type_name::TypeName, address> {
        &arg0.seed_pools
    }

    public(friend) fun seed_pools_mut(arg0: &mut Registry) : &mut 0x2::table::Table<0x1::type_name::TypeName, address> {
        &mut arg0.seed_pools
    }

    public fun staking_pool_address<T0, T1>(arg0: &Registry) : 0x1::option::Option<address> {
        let v0 = 0x1::type_name::get<RegistryKey<T0, T1>>();
        if (0x2::table::contains<0x1::type_name::TypeName, address>(&arg0.staking_pools, v0)) {
            0x1::option::some<address>(*0x2::table::borrow<0x1::type_name::TypeName, address>(&arg0.staking_pools, v0))
        } else {
            0x1::option::none<address>()
        }
    }

    // decompiled from Move bytecode v6
}

