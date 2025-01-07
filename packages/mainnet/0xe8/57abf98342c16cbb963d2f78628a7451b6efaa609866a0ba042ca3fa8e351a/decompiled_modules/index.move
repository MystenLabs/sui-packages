module 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::index {
    struct Registry has key {
        id: 0x2::object::UID,
        seed_pools: 0x2::table::Table<0x1::type_name::TypeName, address>,
        staking_pools: 0x2::table::Table<0x1::type_name::TypeName, address>,
        interest_pools: 0x2::table::Table<0x1::type_name::TypeName, address>,
        policies: 0x2::table::Table<0x1::type_name::TypeName, address>,
        list: 0x2::table::Table<0x1::type_name::TypeName, MemeData>,
    }

    struct MemeData has copy, store {
        seed_pool: address,
        policy: address,
        staking_pool: 0x1::option::Option<address>,
        interest_pool: 0x1::option::Option<address>,
        lp_type: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    struct RegistryKey<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    public fun add_interest_pool<T0, T1>(arg0: &mut Registry, arg1: address) {
        let v0 = interest_pools_mut(arg0);
        0x2::table::add<0x1::type_name::TypeName, address>(v0, 0x1::type_name::get<RegistryKey<T0, T1>>(), arg1);
        0x1::option::fill<address>(&mut 0x2::table::borrow_mut<0x1::type_name::TypeName, MemeData>(&mut arg0.list, 0x1::type_name::get<RegistryKey<T0, T1>>()).interest_pool, arg1);
    }

    public fun add_seed_pool<T0, T1>(arg0: &mut Registry, arg1: address, arg2: address) {
        let v0 = seed_pools_mut(arg0);
        0x2::table::add<0x1::type_name::TypeName, address>(v0, 0x1::type_name::get<RegistryKey<T0, T1>>(), arg1);
        let v1 = policies_mut(arg0);
        0x2::table::add<0x1::type_name::TypeName, address>(v1, 0x1::type_name::get<T1>(), arg2);
        let v2 = MemeData{
            seed_pool     : arg1,
            policy        : arg2,
            staking_pool  : 0x1::option::none<address>(),
            interest_pool : 0x1::option::none<address>(),
            lp_type       : 0x1::option::none<0x1::type_name::TypeName>(),
        };
        0x2::table::add<0x1::type_name::TypeName, MemeData>(&mut arg0.list, 0x1::type_name::get<RegistryKey<T0, T1>>(), v2);
    }

    public fun add_staking_pool<T0, T1>(arg0: &mut Registry, arg1: address) {
        let v0 = staking_pools_mut(arg0);
        0x2::table::add<0x1::type_name::TypeName, address>(v0, 0x1::type_name::get<RegistryKey<T0, T1>>(), arg1);
        0x1::option::fill<address>(&mut 0x2::table::borrow_mut<0x1::type_name::TypeName, MemeData>(&mut arg0.list, 0x1::type_name::get<RegistryKey<T0, T1>>()).staking_pool, arg1);
    }

    public fun assert_new_pool<T0, T1>(arg0: &Registry) {
        assert!(!0x2::table::contains<0x1::type_name::TypeName, address>(&arg0.seed_pools, 0x1::type_name::get<RegistryKey<T0, T1>>()), 0);
    }

    public fun exists_interest_pool<T0, T1>(arg0: &Registry) : bool {
        0x2::table::contains<0x1::type_name::TypeName, address>(&arg0.interest_pools, 0x1::type_name::get<RegistryKey<T0, T1>>())
    }

    public fun exists_seed_pool<T0, T1>(arg0: &Registry) : bool {
        0x2::table::contains<0x1::type_name::TypeName, address>(&arg0.seed_pools, 0x1::type_name::get<RegistryKey<T0, T1>>())
    }

    public fun exists_staking_pool<T0, T1>(arg0: &Registry) : bool {
        0x2::table::contains<0x1::type_name::TypeName, address>(&arg0.staking_pools, 0x1::type_name::get<RegistryKey<T0, T1>>())
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
            list           : 0x2::table::new<0x1::type_name::TypeName, MemeData>(arg0),
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

    public(friend) fun interest_pools_mut(arg0: &mut Registry) : &mut 0x2::table::Table<0x1::type_name::TypeName, address> {
        &mut arg0.interest_pools
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

    public(friend) fun staking_pools_mut(arg0: &mut Registry) : &mut 0x2::table::Table<0x1::type_name::TypeName, address> {
        &mut arg0.staking_pools
    }

    // decompiled from Move bytecode v6
}

