module 0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::registry {
    struct PoolSimpleInfo has copy, drop, store {
        pool_id: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        tick_spacing: u32,
    }

    struct Registry has store, key {
        id: 0x2::object::UID,
        pools: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, PoolSimpleInfo>,
        index: u64,
    }

    struct CreatePoolReceipt {
        pool_id: 0x2::object::ID,
    }

    struct InitEvent has copy, drop {
        registry: 0x2::object::ID,
    }

    struct CreatePoolEvent has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type_a: 0x1::string::String,
        coin_type_b: 0x1::string::String,
        tick_spacing: u32,
    }

    public fun coin_types(arg0: &PoolSimpleInfo) : (0x1::type_name::TypeName, 0x1::type_name::TypeName) {
        (arg0.coin_type_a, arg0.coin_type_b)
    }

    public fun create_launch_pool<T0, T1>(arg0: &mut Registry, arg1: &0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::config::GlobalConfig, arg2: u32, arg3: u64, arg4: bool, arg5: u8, arg6: u8, arg7: u32, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u64>, arg10: u128, arg11: 0x1::string::String, arg12: &0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::versioned::Versioned, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (CreatePoolReceipt, 0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::pool::Pool<T0, T1>) {
        0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::versioned::check_version(arg12);
        let v0 = create_pool_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x1::option::some<u8>(arg5), fee_coin_from_u8<T0, T1>(arg6), arg8, arg9, arg7, arg10, arg11, arg13, arg14);
        let v1 = CreatePoolReceipt{pool_id: 0x2::object::id<0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::pool::Pool<T0, T1>>(&v0)};
        (v1, v0)
    }

    public fun create_pool<T0, T1>(arg0: &mut Registry, arg1: &0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::config::GlobalConfig, arg2: u32, arg3: u64, arg4: bool, arg5: u8, arg6: u32, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: u128, arg10: 0x1::string::String, arg11: &0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::versioned::Versioned, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (CreatePoolReceipt, 0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::pool::Pool<T0, T1>) {
        0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::versioned::check_version(arg11);
        let v0 = create_pool_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x1::option::none<u8>(), fee_coin_from_u8<T0, T1>(arg5), arg7, arg8, arg6, arg9, arg10, arg12, arg13);
        let v1 = CreatePoolReceipt{pool_id: 0x2::object::id<0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::pool::Pool<T0, T1>>(&v0)};
        (v1, v0)
    }

    fun create_pool_internal<T0, T1>(arg0: &mut Registry, arg1: &0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::config::GlobalConfig, arg2: u32, arg3: u64, arg4: bool, arg5: 0x1::option::Option<u8>, arg6: 0x1::option::Option<0x1::type_name::TypeName>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: u32, arg10: u128, arg11: 0x1::string::String, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::pool::Pool<T0, T1> {
        assert!(arg10 > 4295048016 && arg10 < 79226673515401279992447579055, 13835341012022591489);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        assert!(v0 != v1, 13835622517064204291);
        let v2 = 0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::config::get_fee_tier(arg1, arg2, arg3);
        let v3 = if (arg4) {
            assert!(0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::config::allow_dynamic_fee(&v2), 13836748434151440395);
            0x1::option::some<0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::dynamic_fee::DynamicFeeConfig>(0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::config::get_dynamic_fee_config(arg1, 1))
        } else {
            0x1::option::none<0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::dynamic_fee::DynamicFeeConfig>()
        };
        let v4 = if (0x1::option::is_some<u8>(&arg5)) {
            0x1::option::some<0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::fee_scheduler::FeeScheduler>(0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::config::get_fee_scheduler(arg1, *0x1::option::borrow<u8>(&arg5)))
        } else {
            0x1::option::none<0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::fee_scheduler::FeeScheduler>()
        };
        let v5 = if (0x1::string::length(&arg11) == 0) {
            0x1::string::utf8(b"https://bq7bkvdje7gvgmv66hrxdy7wx5h5ggtrrnmt66rdkkehb64rvz3q.arweave.net/DD4VVGknzVMyvvHjceP2v0_TGnGLWT96I1KIcPuRrnc")
        } else {
            arg11
        };
        let v6 = 0x2::clock::timestamp_ms(arg12) / 1000;
        let v7 = 0x1::u64::to_string(v6);
        let v8 = 0x1::string::length(&v7);
        let v9 = if (0x1::option::is_some<u64>(&arg7)) {
            let v10 = 0x1::option::extract<u64>(&mut arg7);
            let v11 = 0x1::u64::to_string(v10);
            assert!(0x1::string::length(&v11) == v8, 13837029995027628045);
            assert!(v10 >= v6, 13837029999322595341);
            v10
        } else {
            0x2::clock::timestamp_ms(arg12) / 1000
        };
        let v12 = if (0x1::option::is_some<u64>(&arg8)) {
            let v13 = 0x1::option::extract<u64>(&mut arg8);
            let v14 = 0x1::u64::to_string(v13);
            assert!(0x1::string::length(&v14) == v8, 13837030033682333709);
            assert!(v13 >= v6, 13837030037977301005);
            v13
        } else {
            0x2::clock::timestamp_ms(arg12) / 1000
        };
        let v15 = 0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::pool::new<T0, T1>(arg10, v2, v3, v4, arg6, v9, v12, arg9, v5, arg0.index, arg12, arg13);
        arg0.index = arg0.index + 1;
        let v16 = 0x2::object::id<0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::pool::Pool<T0, T1>>(&v15);
        let v17 = PoolSimpleInfo{
            pool_id      : v16,
            coin_type_a  : v0,
            coin_type_b  : v1,
            tick_spacing : arg2,
        };
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, PoolSimpleInfo>(&mut arg0.pools, v16, v17);
        let v18 = CreatePoolEvent{
            pool_id      : v16,
            coin_type_a  : 0x1::string::from_ascii(0x1::type_name::into_string(v0)),
            coin_type_b  : 0x1::string::from_ascii(0x1::type_name::into_string(v1)),
            tick_spacing : arg2,
        };
        0x2::event::emit<CreatePoolEvent>(v18);
        v15
    }

    public fun destroy_receipt<T0, T1>(arg0: CreatePoolReceipt, arg1: 0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::pool::Pool<T0, T1>, arg2: &0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::versioned::Versioned) {
        0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::versioned::check_version(arg2);
        let CreatePoolReceipt { pool_id: v0 } = arg0;
        assert!(v0 == 0x2::object::id<0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::pool::Pool<T0, T1>>(&arg1), 13836185192139980807);
        0x2::transfer::public_share_object<0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::pool::Pool<T0, T1>>(arg1);
    }

    public fun fee_coin_from_u8<T0, T1>(arg0: u8) : 0x1::option::Option<0x1::type_name::TypeName> {
        let v0 = &arg0;
        if (*v0 == 0) {
            0x1::option::none<0x1::type_name::TypeName>()
        } else if (*v0 == 1) {
            0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>())
        } else {
            assert!(*v0 == 2, 13836467345721655305);
            0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T1>())
        }
    }

    public fun index(arg0: &Registry) : u64 {
        arg0.index
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id    : 0x2::object::new(arg0),
            pools : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<0x2::object::ID, PoolSimpleInfo>(arg0),
            index : 0,
        };
        0x2::transfer::share_object<Registry>(v0);
        let v1 = InitEvent{registry: 0x2::object::id<Registry>(&v0)};
        0x2::event::emit<InitEvent>(v1);
    }

    public fun pool_id(arg0: &PoolSimpleInfo) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun pool_simple_info(arg0: &Registry, arg1: 0x2::object::ID) : &PoolSimpleInfo {
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, PoolSimpleInfo>(&arg0.pools, arg1), 13835904674940846085);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<0x2::object::ID, PoolSimpleInfo>(&arg0.pools, arg1)
    }

    public fun tick_spacing(arg0: &PoolSimpleInfo) : u32 {
        arg0.tick_spacing
    }

    // decompiled from Move bytecode v7
}

