module 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::revenue {
    struct ProtocolRevenue has key {
        id: 0x2::object::UID,
        version: u64,
        balances: 0x2::bag::Bag,
        buyback_bps: u64,
        protocol_launch: 0x1::option::Option<0x2::object::ID>,
        allowed_pools: 0x2::vec_set::VecSet<0x2::object::ID>,
        total_burned: u64,
    }

    public(friend) fun add_burned(arg0: &mut ProtocolRevenue, arg1: u64) {
        arg0.total_burned = arg0.total_burned + arg1;
    }

    public(friend) fun assert_pool_allowed(arg0: &ProtocolRevenue, arg1: 0x2::object::ID) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_pools, &arg1), 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::wrong_pool());
    }

    fun assert_version(arg0: &ProtocolRevenue) {
        assert!(arg0.version == 1, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::wrong_version());
    }

    public fun balance_of<T0>(arg0: &ProtocolRevenue) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    public fun buyback_bps(arg0: &ProtocolRevenue) : u64 {
        arg0.buyback_bps
    }

    public(friend) fun deposit<T0>(arg0: &mut ProtocolRevenue, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v1)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1, arg1);
        };
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_revenue_deposited(0x2::object::id<ProtocolRevenue>(arg0), 0x1::type_name::into_string(v1), v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolRevenue{
            id              : 0x2::object::new(arg0),
            version         : 1,
            balances        : 0x2::bag::new(arg0),
            buyback_bps     : 5000,
            protocol_launch : 0x1::option::none<0x2::object::ID>(),
            allowed_pools   : 0x2::vec_set::empty<0x2::object::ID>(),
            total_burned    : 0,
        };
        0x2::transfer::share_object<ProtocolRevenue>(v0);
    }

    public fun is_pool_allowed(arg0: &ProtocolRevenue, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_pools, &arg1)
    }

    public fun protocol_launch(arg0: &ProtocolRevenue) : 0x1::option::Option<0x2::object::ID> {
        arg0.protocol_launch
    }

    public fun set_buyback_bps(arg0: &0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::AdminCap, arg1: &mut ProtocolRevenue, arg2: u64) {
        assert!(arg2 <= 10000, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_config());
        arg1.buyback_bps = arg2;
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_buyback_config_updated(0x2::object::id<ProtocolRevenue>(arg1), arg2, arg1.protocol_launch);
    }

    public fun set_pool_allowed(arg0: &0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::AdminCap, arg1: &mut ProtocolRevenue, arg2: 0x2::object::ID, arg3: bool) {
        if (arg3 && !0x2::vec_set::contains<0x2::object::ID>(&arg1.allowed_pools, &arg2)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg1.allowed_pools, arg2);
        };
        if (!arg3 && 0x2::vec_set::contains<0x2::object::ID>(&arg1.allowed_pools, &arg2)) {
            0x2::vec_set::remove<0x2::object::ID>(&mut arg1.allowed_pools, &arg2);
        };
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_revenue_pool_allowed(0x2::object::id<ProtocolRevenue>(arg1), arg2, arg3);
    }

    public fun set_protocol_launch(arg0: &0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::platform::AdminCap, arg1: &mut ProtocolRevenue, arg2: 0x2::object::ID) {
        arg1.protocol_launch = 0x1::option::some<0x2::object::ID>(arg2);
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_buyback_config_updated(0x2::object::id<ProtocolRevenue>(arg1), arg1.buyback_bps, arg1.protocol_launch);
    }

    public(friend) fun take_buyback_share<T0>(arg0: &mut ProtocolRevenue, arg1: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        assert_version(arg0);
        let v0 = 0x1::u64::mul_div(0x2::balance::value<T0>(&arg1), arg0.buyback_bps, 10000);
        if (v0 > 0) {
            deposit<T0>(arg0, 0x2::balance::split<T0>(&mut arg1, v0));
        };
        arg1
    }

    public fun total_burned(arg0: &ProtocolRevenue) : u64 {
        arg0.total_burned
    }

    public(friend) fun withdraw<T0>(arg0: &mut ProtocolRevenue, arg1: u64) : 0x2::balance::Balance<T0> {
        assert_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (arg1 == 0 || !0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            return 0x2::balance::zero<T0>()
        };
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1)
    }

    // decompiled from Move bytecode v7
}

