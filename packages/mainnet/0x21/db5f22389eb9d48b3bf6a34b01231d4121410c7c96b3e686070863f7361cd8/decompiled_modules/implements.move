module 0x21db5f22389eb9d48b3bf6a34b01231d4121410c7c96b3e686070863f7361cd8::implements {
    struct LP<phantom T0, phantom T1> has drop, store {
        dummy_field: bool,
    }

    struct LPMetadata has copy, drop, store {
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
        project_url: 0x1::option::Option<0x2::url::Url>,
    }

    struct Pool<phantom T0, phantom T1> has store {
        global: 0x2::object::ID,
        coin_x: 0x2::balance::Balance<T0>,
        fee_coin_x: 0x2::balance::Balance<T0>,
        coin_y: 0x2::balance::Balance<T1>,
        fee_coin_y: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<LP<T0, T1>>,
        min_liquidity: 0x2::balance::Balance<LP<T0, T1>>,
        creator: address,
        flat_fee_x: u64,
        flat_fee_y: u64,
        creator_fee_percentage: u64,
        lp_metadata: LPMetadata,
        initial_virtual_x_reserves: u64,
        initial_virtual_y_reserves: u64,
        k_constant: u128,
        lp_decimals: u8,
    }

    struct PoolCreationTier has drop, store {
        fee_amount: u64,
        creator_fee_percentage: u64,
    }

    struct Global has key {
        id: 0x2::object::UID,
        has_paused: bool,
        controller: address,
        beneficiary: address,
        pools: 0x2::bag::Bag,
        total_pools_created: u64,
        pool_creation_tiers: vector<PoolCreationTier>,
    }

    public(friend) fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<LP<T0, T1>>, vector<u64>) {
        assert!(arg5, 12);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg3);
        assert!(v0 > 0 && v1 > 0, 0);
        let v2 = 0x2::coin::into_balance<T0>(arg1);
        let v3 = 0x2::coin::into_balance<T1>(arg3);
        let (v4, v5, v6) = get_reserves_size<T0, T1>(arg0);
        let (v7, v8) = calc_optimal_coin_values(v0, v1, arg2, arg4, v4 + arg0.initial_virtual_x_reserves, v5 + arg0.initial_virtual_y_reserves);
        let v9 = if (0 == v6) {
            let v10 = 0x21db5f22389eb9d48b3bf6a34b01231d4121410c7c96b3e686070863f7361cd8::math::sqrt(0x21db5f22389eb9d48b3bf6a34b01231d4121410c7c96b3e686070863f7361cd8::math::mul_to_u128(v7, v8));
            assert!(v10 > 1000, 8);
            0x2::balance::join<LP<T0, T1>>(&mut arg0.min_liquidity, 0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, 1000));
            v10 - 1000
        } else {
            calculate_lp_tokens_exponential<T0, T1>(arg0, v7, v8, v4, v5, v6)
        };
        assert!(v9 > 0, 15);
        if (v7 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, v0 - v7), arg6), 0x2::tx_context::sender(arg6));
        };
        if (v8 < v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v3, v1 - v8), arg6), 0x2::tx_context::sender(arg6));
        };
        let v11 = 0x2::balance::join<T0>(&mut arg0.coin_x, v2);
        let v12 = 0x2::balance::join<T1>(&mut arg0.coin_y, v3);
        assert!(v11 < 1844674407370955, 2);
        assert!(v12 < 1844674407370955, 2);
        arg0.k_constant = ((v11 + arg0.initial_virtual_x_reserves) as u128) * ((v12 + arg0.initial_virtual_y_reserves) as u128);
        let v13 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v13, v0);
        0x1::vector::push_back<u64>(&mut v13, v1);
        0x1::vector::push_back<u64>(&mut v13, v9);
        (0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, v9), arg6), v13)
    }

    public fun assert_lp_value_is_increased(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!((arg0 as u128) * (arg1 as u128) < (arg2 as u128) * (arg3 as u128), 14);
    }

    public(friend) fun beneficiary(arg0: &Global) : address {
        arg0.beneficiary
    }

    public fun calc_optimal_coin_values(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64) {
        if (arg4 == 0 && arg5 == 0) {
            return (arg0, arg1)
        };
        let v0 = 0x21db5f22389eb9d48b3bf6a34b01231d4121410c7c96b3e686070863f7361cd8::math::mul_div(arg0, arg5, arg4);
        if (v0 <= arg1) {
            assert!(v0 >= arg3, 4);
            return (arg0, v0)
        };
        let v1 = 0x21db5f22389eb9d48b3bf6a34b01231d4121410c7c96b3e686070863f7361cd8::math::mul_div(arg1, arg4, arg5);
        assert!(v1 <= arg0, 6);
        assert!(v1 >= arg2, 3);
        (v1, arg1)
    }

    fun calculate_lp_tokens_exponential<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = ((arg3 + arg1 + arg0.initial_virtual_x_reserves) as u128) * 1000000 / ((arg3 + arg0.initial_virtual_x_reserves) as u128);
        let v1 = ((arg4 + arg2 + arg0.initial_virtual_y_reserves) as u128) * 1000000 / ((arg4 + arg0.initial_virtual_y_reserves) as u128);
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        let v3 = (arg5 as u128) * v2 / 1000000 - (arg5 as u128);
        assert!(v3 < (18446744073709551615 as u128), 13);
        (v3 as u64)
    }

    fun calculate_removal_amounts_exponential<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64) {
        let v0 = (arg1 as u128) * 1000000 / (arg4 as u128);
        let v1 = ((((arg2 + arg0.initial_virtual_x_reserves) as u128) * v0 / 1000000) as u64);
        let v2 = ((((arg3 + arg0.initial_virtual_y_reserves) as u128) * v0 / 1000000) as u64);
        let v3 = if (v1 > arg2) {
            arg2
        } else {
            v1
        };
        let v4 = if (v2 > arg3) {
            arg3
        } else {
            v2
        };
        (v3 * 95 / 100, v4 * 95 / 100)
    }

    fun calculate_swap_output(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = (((arg0 as u128) * ((arg2 + arg4) as u128) / (((arg1 + arg3) as u128) + (arg0 as u128))) as u64);
        if (v0 > arg2) {
            arg2
        } else {
            v0
        }
    }

    public(friend) fun controller(arg0: &Global) : address {
        arg0.controller
    }

    public fun create_lp_metadata(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x2::url::Url>, arg4: 0x1::option::Option<0x2::url::Url>) : LPMetadata {
        LPMetadata{
            name        : arg0,
            symbol      : arg1,
            description : arg2,
            icon_url    : arg3,
            project_url : arg4,
        }
    }

    public(friend) fun create_pool<T0, T1>(arg0: &mut Global, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: LPMetadata, arg5: u64, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg7, 12);
        let v0 = generate_lp_name<T0, T1>();
        assert!(!0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, v0), 10);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.beneficiary);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        let v2 = LP<T0, T1>{dummy_field: false};
        let v3 = Pool<T0, T1>{
            global                     : 0x2::object::uid_to_inner(&arg0.id),
            coin_x                     : 0x2::balance::zero<T0>(),
            fee_coin_x                 : 0x2::balance::zero<T0>(),
            coin_y                     : 0x2::balance::zero<T1>(),
            fee_coin_y                 : 0x2::balance::zero<T1>(),
            lp_supply                  : 0x2::balance::create_supply<LP<T0, T1>>(v2),
            min_liquidity              : 0x2::balance::zero<LP<T0, T1>>(),
            creator                    : 0x2::tx_context::sender(arg8),
            flat_fee_x                 : arg2,
            flat_fee_y                 : arg3,
            creator_fee_percentage     : get_creator_fee_percentage(arg0, v1),
            lp_metadata                : arg4,
            initial_virtual_x_reserves : arg5,
            initial_virtual_y_reserves : arg6,
            k_constant                 : (arg5 as u128) * (arg6 as u128),
            lp_decimals                : 18,
        };
        0x2::bag::add<0x1::string::String, Pool<T0, T1>>(&mut arg0.pools, v0, v3);
        arg0.total_pools_created = arg0.total_pools_created + 1;
    }

    public fun generate_lp_name<T0, T1>() : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append_utf8(&mut v0, b"LP-");
        if (is_order<T0, T1>()) {
            0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
            0x1::string::append_utf8(&mut v0, b"-");
            0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        } else {
            0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())));
            0x1::string::append_utf8(&mut v0, b"-");
            0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        };
        v0
    }

    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * ((10000 - 30) as u128);
        0x21db5f22389eb9d48b3bf6a34b01231d4121410c7c96b3e686070863f7361cd8::math::mul_div_u128(v0, (arg2 as u128), (arg1 as u128) * (10000 as u128) + v0)
    }

    fun get_creator_fee_percentage(arg0: &Global, arg1: u64) : u64 {
        let v0 = &arg0.pool_creation_tiers;
        let v1 = 0;
        let v2 = 50;
        while (v1 < 0x1::vector::length<PoolCreationTier>(v0)) {
            let v3 = 0x1::vector::borrow<PoolCreationTier>(v0, v1);
            if (arg1 >= v3.fee_amount) {
                v2 = v3.creator_fee_percentage;
            };
            v1 = v1 + 1;
        };
        v2
    }

    public fun get_fee_amount<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.fee_coin_x), 0x2::balance::value<T1>(&arg0.fee_coin_y))
    }

    public fun get_fee_to_fundation(arg0: u64) : u64 {
        0x21db5f22389eb9d48b3bf6a34b01231d4121410c7c96b3e686070863f7361cd8::math::mul_div(arg0, 30 / 5, 10000)
    }

    public fun get_flat_fees<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (arg0.flat_fee_x, arg0.flat_fee_y)
    }

    public(friend) fun get_mut_pool<T0, T1>(arg0: &mut Global, arg1: bool) : &mut Pool<T0, T1> {
        assert!(arg1, 12);
        let v0 = generate_lp_name<T0, T1>();
        assert!(0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, v0), 11);
        0x2::bag::borrow_mut<0x1::string::String, Pool<T0, T1>>(&mut arg0.pools, v0)
    }

    public fun get_pool_creator<T0, T1>(arg0: &Pool<T0, T1>) : address {
        arg0.creator
    }

    public fun get_pool_info<T0, T1>(arg0: &Pool<T0, T1>) : (address, u64, u64, u64, u64, u64) {
        (arg0.creator, arg0.flat_fee_x, arg0.flat_fee_y, arg0.creator_fee_percentage, arg0.initial_virtual_x_reserves, arg0.initial_virtual_y_reserves)
    }

    public fun get_pool_metadata<T0, T1>(arg0: &Pool<T0, T1>) : &LPMetadata {
        &arg0.lp_metadata
    }

    public fun get_reserves_size<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_x), 0x2::balance::value<T1>(&arg0.coin_y), 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply))
    }

    public fun global_id<T0, T1>(arg0: &Pool<T0, T1>) : 0x2::object::ID {
        arg0.global
    }

    public(friend) fun has_registered<T0, T1>(arg0: &Global) : bool {
        0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, generate_lp_name<T0, T1>())
    }

    public(friend) fun id<T0, T1>(arg0: &Global) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<PoolCreationTier>();
        let v1 = PoolCreationTier{
            fee_amount             : 0,
            creator_fee_percentage : 50,
        };
        0x1::vector::push_back<PoolCreationTier>(&mut v0, v1);
        let v2 = PoolCreationTier{
            fee_amount             : 10000000000,
            creator_fee_percentage : 40,
        };
        0x1::vector::push_back<PoolCreationTier>(&mut v0, v2);
        let v3 = PoolCreationTier{
            fee_amount             : 100000000000,
            creator_fee_percentage : 30,
        };
        0x1::vector::push_back<PoolCreationTier>(&mut v0, v3);
        let v4 = PoolCreationTier{
            fee_amount             : 200000000000,
            creator_fee_percentage : 20,
        };
        0x1::vector::push_back<PoolCreationTier>(&mut v0, v4);
        let v5 = PoolCreationTier{
            fee_amount             : 300000000000,
            creator_fee_percentage : 10,
        };
        0x1::vector::push_back<PoolCreationTier>(&mut v0, v5);
        let v6 = PoolCreationTier{
            fee_amount             : 500000000000,
            creator_fee_percentage : 0,
        };
        0x1::vector::push_back<PoolCreationTier>(&mut v0, v6);
        let v7 = Global{
            id                  : 0x2::object::new(arg0),
            has_paused          : false,
            controller          : @0xd5780ffbf267242c899ac04f9300fa4e6506bc338f671076727d4e32cd1a8f8a,
            beneficiary         : @0xd5780ffbf267242c899ac04f9300fa4e6506bc338f671076727d4e32cd1a8f8a,
            pools               : 0x2::bag::new(arg0),
            total_pools_created : 0,
            pool_creation_tiers : v0,
        };
        0x2::transfer::share_object<Global>(v7);
    }

    public(friend) fun is_emergency(arg0: &Global) : bool {
        arg0.has_paused
    }

    public fun is_order<T0, T1>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x21db5f22389eb9d48b3bf6a34b01231d4121410c7c96b3e686070863f7361cd8::comparator::compare<0x1::type_name::TypeName>(&v0, &v1);
        assert!(!0x21db5f22389eb9d48b3bf6a34b01231d4121410c7c96b3e686070863f7361cd8::comparator::is_equal(&v2), 9);
        0x21db5f22389eb9d48b3bf6a34b01231d4121410c7c96b3e686070863f7361cd8::comparator::is_smaller_than(&v2)
    }

    public(friend) fun modify_controller(arg0: &mut Global, arg1: address) {
        arg0.controller = arg1;
    }

    public(friend) fun pause(arg0: &mut Global) {
        arg0.has_paused = true;
    }

    public(friend) fun register_pool<T0, T1>(arg0: &mut Global, arg1: bool) {
        assert!(arg1, 12);
        let v0 = generate_lp_name<T0, T1>();
        assert!(!0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, v0), 10);
        let v1 = LP<T0, T1>{dummy_field: false};
        let v2 = Pool<T0, T1>{
            global                     : 0x2::object::uid_to_inner(&arg0.id),
            coin_x                     : 0x2::balance::zero<T0>(),
            fee_coin_x                 : 0x2::balance::zero<T0>(),
            coin_y                     : 0x2::balance::zero<T1>(),
            fee_coin_y                 : 0x2::balance::zero<T1>(),
            lp_supply                  : 0x2::balance::create_supply<LP<T0, T1>>(v1),
            min_liquidity              : 0x2::balance::zero<LP<T0, T1>>(),
            creator                    : @0xd5780ffbf267242c899ac04f9300fa4e6506bc338f671076727d4e32cd1a8f8a,
            flat_fee_x                 : 0,
            flat_fee_y                 : 0,
            creator_fee_percentage     : 0,
            lp_metadata                : create_lp_metadata(generate_lp_name<T0, T1>(), 0x1::string::utf8(b"LP"), 0x1::string::utf8(b"Liquidity Provider Token"), 0x1::option::none<0x2::url::Url>(), 0x1::option::none<0x2::url::Url>()),
            initial_virtual_x_reserves : 0,
            initial_virtual_y_reserves : 0,
            k_constant                 : 0,
            lp_decimals                : 18,
        };
        0x2::bag::add<0x1::string::String, Pool<T0, T1>>(&mut arg0.pools, v0, v2);
    }

    public(friend) fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg2, 12);
        let v0 = 0x2::coin::value<LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 0);
        let (v1, v2, v3) = get_reserves_size<T0, T1>(arg0);
        let (v4, v5) = calculate_removal_amounts_exponential<T0, T1>(arg0, v0, v1, v2, v3);
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP<T0, T1>>(arg1));
        arg0.k_constant = ((v1 - v4 + arg0.initial_virtual_x_reserves) as u128) * ((v2 - v5 + arg0.initial_virtual_y_reserves) as u128);
        (0x2::coin::take<T0>(&mut arg0.coin_x, v4, arg3), 0x2::coin::take<T1>(&mut arg0.coin_y, v5, arg3))
    }

    public(friend) fun resume(arg0: &mut Global) {
        arg0.has_paused = false;
    }

    public(friend) fun swap_out<T0, T1>(arg0: &mut Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : vector<u64> {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 0);
        if (arg3) {
            let v1 = get_mut_pool<T0, T1>(arg0, arg3);
            let (v2, v3, _) = get_reserves_size<T0, T1>(v1);
            assert!(v2 > 0 && v3 > 0, 1);
            let v5 = 0x2::coin::value<T0>(&arg1);
            let v6 = v1.flat_fee_x;
            assert!(v5 > v6, 3);
            let v7 = calculate_swap_output(v5 - v6, v2, v3, v1.initial_virtual_x_reserves, v1.initial_virtual_y_reserves);
            assert!(v7 >= arg2, 7);
            let v8 = 0x2::coin::into_balance<T0>(arg1);
            if (v6 > 0) {
                let v9 = 0x2::balance::split<T0>(&mut v8, v6);
                let v10 = v6 * v1.creator_fee_percentage / 100;
                if (v10 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v9, v10), arg4), v1.creator);
                };
                0x2::balance::join<T0>(&mut v1.fee_coin_x, v9);
            };
            0x2::balance::join<T0>(&mut v1.coin_x, v8);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut v1.coin_y, v7, arg4), 0x2::tx_context::sender(arg4));
            let (v11, v12, _) = get_reserves_size<T0, T1>(v1);
            assert_lp_value_is_increased(v2, v3, v11, v12);
            let v14 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v14, v5);
            0x1::vector::push_back<u64>(&mut v14, 0);
            0x1::vector::push_back<u64>(&mut v14, 0);
            0x1::vector::push_back<u64>(&mut v14, v7);
            v14
        } else {
            let v15 = get_mut_pool<T1, T0>(arg0, !arg3);
            let (v16, v17, _) = get_reserves_size<T1, T0>(v15);
            assert!(v16 > 0 && v17 > 0, 1);
            let v19 = 0x2::coin::value<T0>(&arg1);
            let v20 = v15.flat_fee_y;
            assert!(v19 > v20, 4);
            let v21 = calculate_swap_output(v19 - v20, v17, v16, v15.initial_virtual_y_reserves, v15.initial_virtual_x_reserves);
            assert!(v21 >= arg2, 7);
            let v22 = 0x2::coin::into_balance<T0>(arg1);
            if (v20 > 0) {
                let v23 = 0x2::balance::split<T0>(&mut v22, v20);
                let v24 = v20 * v15.creator_fee_percentage / 100;
                if (v24 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v23, v24), arg4), v15.creator);
                };
                0x2::balance::join<T0>(&mut v15.fee_coin_y, v23);
            };
            0x2::balance::join<T0>(&mut v15.coin_y, v22);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut v15.coin_x, v21, arg4), 0x2::tx_context::sender(arg4));
            let (v25, v26, _) = get_reserves_size<T1, T0>(v15);
            assert_lp_value_is_increased(v16, v17, v25, v26);
            let v28 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v28, 0);
            0x1::vector::push_back<u64>(&mut v28, v21);
            0x1::vector::push_back<u64>(&mut v28, v19);
            0x1::vector::push_back<u64>(&mut v28, 0);
            v28
        }
    }

    public(friend) fun withdraw<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64, u64) {
        let v0 = 0x2::balance::value<T0>(&arg0.fee_coin_x);
        let v1 = 0x2::balance::value<T1>(&arg0.fee_coin_y);
        assert!(v0 > 0 && v1 > 0, 0);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.fee_coin_x, v0), arg1), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.fee_coin_y, v1), arg1), v0, v1)
    }

    // decompiled from Move bytecode v6
}

