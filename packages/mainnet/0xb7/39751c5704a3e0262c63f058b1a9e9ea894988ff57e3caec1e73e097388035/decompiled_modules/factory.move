module 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::factory {
    struct FACTORY has drop {
        dummy_field: bool,
    }

    struct PoolSimpleInfo has copy, drop, store {
        pool_id: 0x2::object::ID,
        pool_key: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        tick_spacing: u32,
    }

    struct Pools has store, key {
        id: 0x2::object::UID,
        list: 0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::linked_table::LinkedTable<0x2::object::ID, PoolSimpleInfo>,
        index: u64,
    }

    struct InitFactoryEvent has copy, drop {
        pools_id: 0x2::object::ID,
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

    public fun create_pool<T0, T1>(arg0: &mut Pools, arg1: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::checked_package_version(arg1);
        let v0 = create_pool_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_share_object<0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::Pool<T0, T1>>(v0);
        0x2::object::id<0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::Pool<T0, T1>>(&v0)
    }

    public fun create_pool_<T0, T1>(arg0: &mut Pools, arg1: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::Pool<T0, T1> {
        0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::checked_package_version(arg1);
        create_pool_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    fun create_pool_internal<T0, T1>(arg0: &mut Pools, arg1: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::Pool<T0, T1> {
        assert!(arg3 >= 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::tick_math::min_sqrt_price() && arg3 <= 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::tick_math::max_sqrt_price(), 2);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(v0 != v1, 3);
        let v2 = new_pool_key<T0, T1>(arg2);
        if (0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::linked_table::contains<0x2::object::ID, PoolSimpleInfo>(&arg0.list, v2)) {
            abort 1
        };
        let v3 = if (0x1::string::length(&arg4) == 0) {
            0x1::string::utf8(b"")
        } else {
            arg4
        };
        let v4 = 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::new<T0, T1>(arg2, arg3, 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::get_fee_rate(arg2, arg1), v3, arg0.index, arg5, arg6);
        arg0.index = arg0.index + 1;
        let v5 = 0x2::object::id<0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::Pool<T0, T1>>(&v4);
        let v6 = PoolSimpleInfo{
            pool_id      : v5,
            pool_key     : v2,
            coin_type_a  : v0,
            coin_type_b  : v1,
            tick_spacing : arg2,
        };
        0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::linked_table::push_back<0x2::object::ID, PoolSimpleInfo>(&mut arg0.list, v2, v6);
        let v7 = CreatePoolEvent{
            pool_id      : v5,
            coin_type_a  : 0x1::string::from_ascii(0x1::type_name::into_string(v0)),
            coin_type_b  : 0x1::string::from_ascii(0x1::type_name::into_string(v1)),
            tick_spacing : arg2,
        };
        0x2::event::emit<CreatePoolEvent>(v7);
        v4
    }

    public fun create_pool_with_liquidity<T0, T1>(arg0: &mut Pools, arg1: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: u32, arg6: u32, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::position::Position, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::checked_package_version(arg1);
        let v0 = create_pool_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg12, arg13);
        let v1 = 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::open_position<T0, T1>(arg1, &mut v0, arg5, arg6, arg13);
        let v2 = if (arg11) {
            arg9
        } else {
            arg10
        };
        let v3 = 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::add_liquidity_fix_coin<T0, T1>(arg1, &mut v0, &mut v1, v2, arg11, arg12, arg13);
        let (v4, v5) = 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::add_liquidity_pay_amount<T0, T1>(&v3);
        if (arg11) {
            assert!(v5 <= arg10, 4);
        } else {
            assert!(v4 <= arg9, 5);
        };
        0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::repay_add_liquidity<T0, T1>(arg1, &mut v0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg7, v4, arg13)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg8, v5, arg13)), v3);
        0x2::transfer::public_share_object<0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::Pool<T0, T1>>(v0);
        (v1, arg7, arg8)
    }

    public fun fetch_pools(arg0: &Pools, arg1: vector<0x2::object::ID>, arg2: u64) : vector<PoolSimpleInfo> {
        let v0 = 0x1::vector::empty<PoolSimpleInfo>();
        let v1 = if (0x1::vector::is_empty<0x2::object::ID>(&arg1)) {
            0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::linked_table::head<0x2::object::ID, PoolSimpleInfo>(&arg0.list)
        } else {
            0x1::option::some<0x2::object::ID>(*0x1::vector::borrow<0x2::object::ID>(&arg1, 0))
        };
        let v2 = v1;
        let v3 = 0;
        while (0x1::option::is_some<0x2::object::ID>(&v2) && v3 < arg2) {
            let v4 = 0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::linked_table::borrow_node<0x2::object::ID, PoolSimpleInfo>(&arg0.list, *0x1::option::borrow<0x2::object::ID>(&v2));
            v2 = 0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::linked_table::next<0x2::object::ID, PoolSimpleInfo>(v4);
            0x1::vector::push_back<PoolSimpleInfo>(&mut v0, *0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::linked_table::borrow_value<0x2::object::ID, PoolSimpleInfo>(v4));
            v3 = v3 + 1;
        };
        v0
    }

    public fun index(arg0: &Pools) : u64 {
        arg0.index
    }

    fun init(arg0: FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Pools{
            id    : 0x2::object::new(arg1),
            list  : 0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::linked_table::new<0x2::object::ID, PoolSimpleInfo>(arg1),
            index : 0,
        };
        0x2::transfer::share_object<Pools>(v0);
        let v1 = InitFactoryEvent{pools_id: 0x2::object::id<Pools>(&v0)};
        0x2::event::emit<InitFactoryEvent>(v1);
        0x2::package::claim_and_keep<FACTORY>(arg0, arg1);
    }

    public fun new_pool_key<T0, T1>(arg0: u32) : 0x2::object::ID {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = *0x1::ascii::as_bytes(&v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v3 = 0x1::ascii::as_bytes(&v2);
        let v4 = 0;
        let v5 = false;
        while (v4 < 0x1::vector::length<u8>(v3)) {
            let v6 = *0x1::vector::borrow<u8>(v3, v4);
            if (!v5 && v4 < 0x1::vector::length<u8>(&v1)) {
                let v7 = *0x1::vector::borrow<u8>(&v1, v4);
                if (v7 < v6) {
                    abort 6
                };
                if (v7 > v6) {
                    v5 = true;
                };
            };
            0x1::vector::push_back<u8>(&mut v1, v6);
            v4 = v4 + 1;
        };
        if (!v5) {
            if (0x1::vector::length<u8>(&v1) < 0x1::vector::length<u8>(v3)) {
                abort 6
            };
        };
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u32>(&arg0));
        0x2::object::id_from_bytes(0x2::hash::blake2b256(&v1))
    }

    public fun pool_id(arg0: &PoolSimpleInfo) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun pool_key(arg0: &PoolSimpleInfo) : 0x2::object::ID {
        arg0.pool_key
    }

    public fun pool_simple_info(arg0: &Pools, arg1: 0x2::object::ID) : &PoolSimpleInfo {
        0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::linked_table::borrow<0x2::object::ID, PoolSimpleInfo>(&arg0.list, arg1)
    }

    public fun tick_spacing(arg0: &PoolSimpleInfo) : u32 {
        arg0.tick_spacing
    }

    // decompiled from Move bytecode v6
}

