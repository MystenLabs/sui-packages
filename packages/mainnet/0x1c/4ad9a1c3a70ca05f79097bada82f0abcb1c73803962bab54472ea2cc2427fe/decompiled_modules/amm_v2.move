module 0x1c4ad9a1c3a70ca05f79097bada82f0abcb1c73803962bab54472ea2cc2427fe::amm_v2 {
    struct AMM_V2 has drop {
        dummy_field: bool,
    }

    struct Global has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<0x2::object::ID, bool>,
        protocol_fee_receiver: address,
        total_protocol_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        pool_counter: u64,
    }

    struct LP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        pool_id: u64,
        lp_treasury: 0x2::coin::TreasuryCap<LP<T0, T1>>,
        lp_supply: u64,
        reserve_x: 0x2::balance::Balance<T0>,
        reserve_y: 0x2::balance::Balance<T1>,
        flat_fee_x: u64,
        flat_fee_y: u64,
        protocol_fee_share: u8,
        creator: address,
        virtual_x_reserves: u64,
        virtual_y_reserves: u64,
        k_constant: u128,
        creator_fees_x: 0x2::balance::Balance<T0>,
        creator_fees_y: 0x2::balance::Balance<T1>,
        protocol_fees_x: 0x2::balance::Balance<T0>,
        protocol_fees_y: 0x2::balance::Balance<T1>,
        bonding_curve_k: u128,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        pool_number: u64,
        coin_x_type: 0x1::string::String,
        coin_y_type: 0x1::string::String,
        creator: address,
        lp_metadata_id: 0x2::object::ID,
    }

    struct SwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        is_x_to_y: bool,
        trader: address,
    }

    struct LiquidityEvent has copy, drop {
        pool_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
        lp_amount: u64,
        is_add: bool,
        user: address,
    }

    struct PoolCreationTier has copy, drop {
        fee_amount: u64,
        protocol_fee_share: u8,
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 || v1 > 0, 5);
        let v2 = calculate_lp_mint_amount(arg0.lp_supply, v0, v1, arg0.virtual_x_reserves, arg0.virtual_y_reserves, arg0.bonding_curve_k);
        assert!(v2 > 0, 5);
        arg0.lp_supply = arg0.lp_supply + v2;
        if (v0 > 0) {
            0x2::balance::join<T0>(&mut arg0.reserve_x, 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg3));
        };
        if (v1 > 0) {
            0x2::balance::join<T1>(&mut arg0.reserve_y, 0x2::coin::into_balance<T1>(arg2));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, 0x2::tx_context::sender(arg3));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(0x2::coin::mint<LP<T0, T1>>(&mut arg0.lp_treasury, v2, arg3), 0x2::tx_context::sender(arg3));
        let v3 = LiquidityEvent{
            pool_id   : 0x2::object::uid_to_inner(&arg0.id),
            amount_x  : v0,
            amount_y  : v1,
            lp_amount : v2,
            is_add    : true,
            user      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<LiquidityEvent>(v3);
    }

    fun calculate_liquidity_return(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128) : (u64, u64) {
        ((((arg2 as u128) * (arg0 as u128) / (arg1 as u128)) as u64), (((arg3 as u128) * (arg0 as u128) / (arg1 as u128)) as u64))
    }

    fun calculate_lp_mint_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u128) : u64 {
        let v0 = if (arg0 == 0) {
            0
        } else {
            arg1
        };
        let v1 = if (arg0 == 0) {
            0
        } else {
            arg2
        };
        let v2 = (0x2::math::sqrt(v0 + arg1 + arg3) as u128) * (0x2::math::sqrt(v1 + arg2 + arg4) as u128);
        let v3 = if (arg0 == 0) {
            (0x2::math::sqrt(arg3) as u128) * (0x2::math::sqrt(arg4) as u128)
        } else {
            (arg0 as u128) * arg5 / 1000000000
        };
        if (v2 > v3) {
            (((v2 - v3) * 1000000000 / arg5) as u64)
        } else {
            0
        }
    }

    fun calculate_output(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u128) : u64 {
        let v0 = arg2 + arg4 - ((arg5 / ((arg1 + arg3 + arg0) as u128)) as u64);
        if (v0 > arg2) {
            arg2
        } else {
            v0
        }
    }

    public fun create_pool_with_lp_tokens<T0, T1>(arg0: &mut Global, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u8, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::coin::CoinMetadata<LP<T0, T1>>) {
        let v0 = get_pool_creation_tier(0x2::coin::value<0x2::sui::SUI>(&arg1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_protocol_fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = arg0.pool_counter;
        arg0.pool_counter = arg0.pool_counter + 1;
        let v2 = if (0x1::vector::is_empty<u8>(&arg9)) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg9))
        };
        let v3 = LP<T0, T1>{dummy_field: false};
        let (v4, v5) = 0x2::coin::create_currency<LP<T0, T1>>(v3, arg5, arg7, arg6, arg8, v2, arg12);
        let v6 = v5;
        let v7 = (arg10 as u128) * (arg11 as u128);
        let v8 = Pool<T0, T1>{
            id                 : 0x2::object::new(arg12),
            pool_id            : v1,
            lp_treasury        : v4,
            lp_supply          : 0,
            reserve_x          : 0x2::balance::zero<T0>(),
            reserve_y          : 0x2::balance::zero<T1>(),
            flat_fee_x         : arg3,
            flat_fee_y         : arg4,
            protocol_fee_share : v0.protocol_fee_share,
            creator            : 0x2::tx_context::sender(arg12),
            virtual_x_reserves : arg10,
            virtual_y_reserves : arg11,
            k_constant         : (arg10 as u128) * (arg11 as u128),
            creator_fees_x     : 0x2::balance::zero<T0>(),
            creator_fees_y     : 0x2::balance::zero<T1>(),
            protocol_fees_x    : 0x2::balance::zero<T0>(),
            protocol_fees_y    : 0x2::balance::zero<T1>(),
            bonding_curve_k    : v7,
        };
        let v9 = 0x2::object::uid_to_inner(&v8.id);
        let v10 = 0x2::coin::value<T0>(&arg2);
        if (v10 > 0) {
            0x2::balance::join<T0>(&mut v8.reserve_x, 0x2::coin::into_balance<T0>(arg2));
            let v11 = calculate_lp_mint_amount(0, v10, 0, arg10, arg11, v7);
            if (v11 > 0) {
                v8.lp_supply = v11;
                0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(0x2::coin::mint<LP<T0, T1>>(&mut v8.lp_treasury, v11, arg12), 0x2::tx_context::sender(arg12));
            };
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg12));
        };
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.pools, v9, true);
        let v12 = PoolCreated{
            pool_id        : v9,
            pool_number    : v1,
            coin_x_type    : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            coin_y_type    : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())),
            creator        : 0x2::tx_context::sender(arg12),
            lp_metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<LP<T0, T1>>>(&v6),
        };
        0x2::event::emit<PoolCreated>(v12);
        0x2::transfer::share_object<Pool<T0, T1>>(v8);
        (v9, v6)
    }

    public fun get_pool_creation_tier(arg0: u64) : PoolCreationTier {
        if (arg0 == 0) {
            PoolCreationTier{fee_amount: 0, protocol_fee_share: 50}
        } else if (arg0 == 10000000000) {
            PoolCreationTier{fee_amount: 10000000000, protocol_fee_share: 40}
        } else if (arg0 == 100000000000) {
            PoolCreationTier{fee_amount: 100000000000, protocol_fee_share: 30}
        } else if (arg0 == 200000000000) {
            PoolCreationTier{fee_amount: 200000000000, protocol_fee_share: 20}
        } else if (arg0 == 300000000000) {
            PoolCreationTier{fee_amount: 300000000000, protocol_fee_share: 10}
        } else {
            assert!(arg0 == 500000000000, 4);
            PoolCreationTier{fee_amount: 500000000000, protocol_fee_share: 0}
        }
    }

    public fun get_pool_info<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64, u64, u64, u8, address) {
        (0x2::balance::value<T0>(&arg0.reserve_x), 0x2::balance::value<T1>(&arg0.reserve_y), arg0.lp_supply, arg0.flat_fee_x, arg0.flat_fee_y, arg0.protocol_fee_share, arg0.creator)
    }

    public fun get_reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_x), 0x2::balance::value<T1>(&arg0.reserve_y))
    }

    fun init(arg0: AMM_V2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id                    : 0x2::object::new(arg1),
            pools                 : 0x2::table::new<0x2::object::ID, bool>(arg1),
            protocol_fee_receiver : 0x2::tx_context::sender(arg1),
            total_protocol_fees   : 0x2::balance::zero<0x2::sui::SUI>(),
            pool_counter          : 0,
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<AMM_V2>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Global>(v0);
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 5);
        assert!(v0 <= arg0.lp_supply, 1);
        let (v1, v2) = calculate_liquidity_return(v0, arg0.lp_supply, 0x2::balance::value<T0>(&arg0.reserve_x), 0x2::balance::value<T1>(&arg0.reserve_y), arg0.virtual_x_reserves, arg0.virtual_y_reserves, arg0.bonding_curve_k);
        0x2::coin::burn<LP<T0, T1>>(&mut arg0.lp_treasury, arg1);
        arg0.lp_supply = arg0.lp_supply - v0;
        if (v1 > 0 && v1 <= 0x2::balance::value<T0>(&arg0.reserve_x)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_x, v1), arg2), 0x2::tx_context::sender(arg2));
        };
        if (v2 > 0 && v2 <= 0x2::balance::value<T1>(&arg0.reserve_y)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_y, v2), arg2), 0x2::tx_context::sender(arg2));
        };
        let v3 = LiquidityEvent{
            pool_id   : 0x2::object::uid_to_inner(&arg0.id),
            amount_x  : v1,
            amount_y  : v2,
            lp_amount : v0,
            is_add    : false,
            user      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<LiquidityEvent>(v3);
    }

    public entry fun swap_x_for_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > arg0.flat_fee_x, 1);
        let v1 = calculate_output(v0 - arg0.flat_fee_x, 0x2::balance::value<T0>(&arg0.reserve_x), 0x2::balance::value<T1>(&arg0.reserve_y), arg0.virtual_x_reserves, arg0.virtual_y_reserves, arg0.k_constant);
        assert!(v1 >= arg2, 2);
        assert!(v1 <= 0x2::balance::value<T1>(&arg0.reserve_y), 1);
        let v2 = 0x2::coin::into_balance<T0>(arg1);
        let v3 = 0x2::balance::split<T0>(&mut v2, arg0.flat_fee_x);
        let v4 = arg0.flat_fee_x * (arg0.protocol_fee_share as u64) / 100;
        let v5 = v4 / 4;
        let v6 = v4 - v5;
        if (v4 > 0) {
            if (v5 > 0) {
                0x2::balance::join<T0>(&mut arg0.creator_fees_x, 0x2::balance::split<T0>(&mut v3, v5));
            };
            if (v6 > 0) {
                0x2::balance::join<T0>(&mut arg0.protocol_fees_x, 0x2::balance::split<T0>(&mut v3, v6));
            };
        };
        0x2::balance::join<T0>(&mut arg0.reserve_x, v3);
        0x2::balance::join<T0>(&mut arg0.reserve_x, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_y, v1), arg3), 0x2::tx_context::sender(arg3));
        let v7 = SwapEvent{
            pool_id    : 0x2::object::uid_to_inner(&arg0.id),
            amount_in  : v0,
            amount_out : v1,
            fee_amount : arg0.flat_fee_x,
            is_x_to_y  : true,
            trader     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SwapEvent>(v7);
    }

    public entry fun swap_y_for_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > arg0.flat_fee_y, 1);
        let v1 = calculate_output(v0 - arg0.flat_fee_y, 0x2::balance::value<T1>(&arg0.reserve_y), 0x2::balance::value<T0>(&arg0.reserve_x), arg0.virtual_y_reserves, arg0.virtual_x_reserves, arg0.k_constant);
        assert!(v1 >= arg2, 2);
        assert!(v1 <= 0x2::balance::value<T0>(&arg0.reserve_x), 1);
        let v2 = 0x2::coin::into_balance<T1>(arg1);
        let v3 = 0x2::balance::split<T1>(&mut v2, arg0.flat_fee_y);
        let v4 = arg0.flat_fee_y * (arg0.protocol_fee_share as u64) / 100;
        let v5 = v4 / 4;
        let v6 = v4 - v5;
        if (v4 > 0) {
            if (v5 > 0) {
                0x2::balance::join<T1>(&mut arg0.creator_fees_y, 0x2::balance::split<T1>(&mut v3, v5));
            };
            if (v6 > 0) {
                0x2::balance::join<T1>(&mut arg0.protocol_fees_y, 0x2::balance::split<T1>(&mut v3, v6));
            };
        };
        0x2::balance::join<T1>(&mut arg0.reserve_y, v3);
        0x2::balance::join<T1>(&mut arg0.reserve_y, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_x, v1), arg3), 0x2::tx_context::sender(arg3));
        let v7 = SwapEvent{
            pool_id    : 0x2::object::uid_to_inner(&arg0.id),
            amount_in  : v0,
            amount_out : v1,
            fee_amount : arg0.flat_fee_y,
            is_x_to_y  : false,
            trader     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SwapEvent>(v7);
    }

    // decompiled from Move bytecode v6
}

