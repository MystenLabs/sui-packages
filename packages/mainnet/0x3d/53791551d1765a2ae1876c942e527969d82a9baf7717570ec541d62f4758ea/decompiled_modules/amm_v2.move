module 0x3d53791551d1765a2ae1876c942e527969d82a9baf7717570ec541d62f4758ea::amm_v2 {
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

    struct PoolRegistry has key {
        id: 0x2::object::UID,
        pool_metadata: 0x2::table::Table<0x2::object::ID, LPMetadata>,
    }

    struct LPMetadata has copy, drop, store {
        pool_id: 0x2::object::ID,
        coin_x_type: 0x1::string::String,
        coin_y_type: 0x1::string::String,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        pool_id: u64,
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
        lp_metadata: LPMetadata,
        lp_balances: 0x2::table::Table<address, u64>,
    }

    struct LPToken<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        pool_number: u64,
        coin_x_type: 0x1::string::String,
        coin_y_type: 0x1::string::String,
        creator: address,
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
        let v2 = calculate_lp_mint_amount(arg0.lp_supply, v0, v1, 0x2::balance::value<T0>(&arg0.reserve_x), 0x2::balance::value<T1>(&arg0.reserve_y), arg0.virtual_x_reserves, arg0.virtual_y_reserves, arg0.bonding_curve_k);
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
        arg0.k_constant = ((0x2::balance::value<T0>(&arg0.reserve_x) + arg0.virtual_x_reserves) as u128) * ((0x2::balance::value<T1>(&arg0.reserve_y) + arg0.virtual_y_reserves) as u128);
        let v3 = 0x2::tx_context::sender(arg3);
        if (0x2::table::contains<address, u64>(&arg0.lp_balances, v3)) {
            let v4 = 0x2::table::borrow_mut<address, u64>(&mut arg0.lp_balances, v3);
            *v4 = *v4 + v2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.lp_balances, v3, v2);
        };
        let v5 = LPToken<T0, T1>{
            id      : 0x2::object::new(arg3),
            pool_id : 0x2::object::uid_to_inner(&arg0.id),
            amount  : v2,
        };
        0x2::transfer::transfer<LPToken<T0, T1>>(v5, v3);
        let v6 = LiquidityEvent{
            pool_id   : 0x2::object::uid_to_inner(&arg0.id),
            amount_x  : v0,
            amount_y  : v1,
            lp_amount : v2,
            is_add    : true,
            user      : v3,
        };
        0x2::event::emit<LiquidityEvent>(v6);
    }

    fun calculate_liquidity_return(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128) : (u64, u64) {
        let v0 = (arg0 as u128) * 1000000000 / (arg1 as u128);
        let v1 = ((arg2 + arg4) as u128) * v0 / 1000000000;
        let v2 = ((arg3 + arg5) as u128) * v0 / 1000000000;
        let v3 = if (v1 > (arg4 as u128)) {
            ((v1 - (arg4 as u128)) as u64)
        } else {
            (((arg2 as u128) * v0 / 1000000000) as u64)
        };
        let v4 = if (v2 > (arg5 as u128)) {
            ((v2 - (arg5 as u128)) as u64)
        } else {
            (((arg3 as u128) * v0 / 1000000000) as u64)
        };
        let v5 = if (v3 > arg2) {
            arg2
        } else {
            v3
        };
        let v6 = if (v4 > arg3) {
            arg3
        } else {
            v4
        };
        (v5, v6)
    }

    fun calculate_lp_mint_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u128) : u64 {
        if (arg0 == 0) {
            let v1 = (0x1::u64::sqrt(arg1) as u128) * (0x1::u64::sqrt(arg2) as u128) * 1000;
            if (v1 < 1000000) {
                1000000
            } else {
                (v1 as u64)
            }
        } else {
            let v2 = arg3 + arg5;
            let v3 = arg4 + arg6;
            let v4 = if (v2 > 0) {
                (arg1 as u128) * (arg0 as u128) / (v2 as u128)
            } else {
                0
            };
            let v5 = if (v3 > 0) {
                (arg2 as u128) * (arg0 as u128) / (v3 as u128)
            } else {
                0
            };
            let v6 = if (v4 < v5) {
                v4
            } else {
                v5
            };
            if (v6 < 1000) {
                1000
            } else {
                (v6 as u64)
            }
        }
    }

    fun calculate_output(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u128) : u64 {
        let v0 = ((arg2 + arg4) as u128);
        let v1 = arg5 / (((arg1 + arg3) as u128) + (arg0 as u128));
        let v2 = if (v0 > v1) {
            v0 - v1
        } else {
            0
        };
        let v3 = (arg2 as u128);
        let v4 = if (v2 > v3) {
            v3
        } else {
            v2
        };
        (v4 as u64)
    }

    public fun create_pool_with_lp_tokens<T0, T1>(arg0: &mut Global, arg1: &mut PoolRegistry, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: u8, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<T1>(), 8);
        let v0 = get_pool_creation_tier(0x2::coin::value<0x2::sui::SUI>(&arg2));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_protocol_fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v1 = arg0.pool_counter;
        arg0.pool_counter = arg0.pool_counter + 1;
        let v2 = (arg11 as u128) * (arg12 as u128);
        let v3 = LPMetadata{
            pool_id     : 0x2::object::id_from_address(@0x0),
            coin_x_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            coin_y_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())),
            name        : 0x1::string::utf8(arg7),
            symbol      : 0x1::string::utf8(arg8),
            decimals    : arg6,
        };
        let v4 = Pool<T0, T1>{
            id                 : 0x2::object::new(arg13),
            pool_id            : v1,
            lp_supply          : 0,
            reserve_x          : 0x2::balance::zero<T0>(),
            reserve_y          : 0x2::balance::zero<T1>(),
            flat_fee_x         : arg4,
            flat_fee_y         : arg5,
            protocol_fee_share : v0.protocol_fee_share,
            creator            : 0x2::tx_context::sender(arg13),
            virtual_x_reserves : arg11,
            virtual_y_reserves : arg12,
            k_constant         : (arg11 as u128) * (arg12 as u128),
            creator_fees_x     : 0x2::balance::zero<T0>(),
            creator_fees_y     : 0x2::balance::zero<T1>(),
            protocol_fees_x    : 0x2::balance::zero<T0>(),
            protocol_fees_y    : 0x2::balance::zero<T1>(),
            bonding_curve_k    : v2,
            lp_metadata        : v3,
            lp_balances        : 0x2::table::new<address, u64>(arg13),
        };
        let v5 = 0x2::object::uid_to_inner(&v4.id);
        v4.lp_metadata.pool_id = v5;
        0x2::table::add<0x2::object::ID, LPMetadata>(&mut arg1.pool_metadata, v5, v4.lp_metadata);
        let v6 = 0x2::coin::value<T0>(&arg3);
        if (v6 > 0) {
            0x2::balance::join<T0>(&mut v4.reserve_x, 0x2::coin::into_balance<T0>(arg3));
            let v7 = calculate_lp_mint_amount(0, v6, 0, 0x2::balance::value<T0>(&v4.reserve_x), 0x2::balance::value<T1>(&v4.reserve_y), arg11, arg12, v2);
            if (v7 > 0) {
                v4.lp_supply = v7;
                0x2::table::add<address, u64>(&mut v4.lp_balances, 0x2::tx_context::sender(arg13), v7);
                let v8 = LPToken<T0, T1>{
                    id      : 0x2::object::new(arg13),
                    pool_id : v5,
                    amount  : v7,
                };
                0x2::transfer::transfer<LPToken<T0, T1>>(v8, 0x2::tx_context::sender(arg13));
            };
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg13));
        };
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.pools, v5, true);
        let v9 = PoolCreated{
            pool_id     : v5,
            pool_number : v1,
            coin_x_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            coin_y_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())),
            creator     : 0x2::tx_context::sender(arg13),
        };
        0x2::event::emit<PoolCreated>(v9);
        0x2::transfer::share_object<Pool<T0, T1>>(v4);
        v5
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

    public fun get_user_lp_balance<T0, T1>(arg0: &Pool<T0, T1>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.lp_balances, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.lp_balances, arg1)
        } else {
            0
        }
    }

    fun init(arg0: AMM_V2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id                    : 0x2::object::new(arg1),
            pools                 : 0x2::table::new<0x2::object::ID, bool>(arg1),
            protocol_fee_receiver : 0x2::tx_context::sender(arg1),
            total_protocol_fees   : 0x2::balance::zero<0x2::sui::SUI>(),
            pool_counter          : 0,
        };
        let v1 = PoolRegistry{
            id            : 0x2::object::new(arg1),
            pool_metadata : 0x2::table::new<0x2::object::ID, LPMetadata>(arg1),
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<AMM_V2>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Global>(v0);
        0x2::transfer::share_object<PoolRegistry>(v1);
    }

    public entry fun merge_lp_tokens<T0, T1>(arg0: &Pool<T0, T1>, arg1: LPToken<T0, T1>, arg2: LPToken<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let LPToken {
            id      : v0,
            pool_id : v1,
            amount  : v2,
        } = arg1;
        let LPToken {
            id      : v3,
            pool_id : v4,
            amount  : v5,
        } = arg2;
        assert!(v1 == 0x2::object::uid_to_inner(&arg0.id), 9);
        assert!(v4 == 0x2::object::uid_to_inner(&arg0.id), 9);
        0x2::object::delete(v0);
        0x2::object::delete(v3);
        let v6 = LPToken<T0, T1>{
            id      : 0x2::object::new(arg3),
            pool_id : 0x2::object::uid_to_inner(&arg0.id),
            amount  : v2 + v5,
        };
        0x2::transfer::transfer<LPToken<T0, T1>>(v6, 0x2::tx_context::sender(arg3));
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: LPToken<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let LPToken {
            id      : v0,
            pool_id : v1,
            amount  : v2,
        } = arg1;
        0x2::object::delete(v0);
        assert!(v1 == 0x2::object::uid_to_inner(&arg0.id), 9);
        assert!(v2 > 0, 5);
        assert!(v2 <= arg0.lp_supply, 1);
        let v3 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.lp_balances, v3), 1);
        let v4 = 0x2::table::borrow_mut<address, u64>(&mut arg0.lp_balances, v3);
        assert!(*v4 >= v2, 1);
        let (v5, v6) = calculate_liquidity_return(v2, arg0.lp_supply, 0x2::balance::value<T0>(&arg0.reserve_x), 0x2::balance::value<T1>(&arg0.reserve_y), arg0.virtual_x_reserves, arg0.virtual_y_reserves, arg0.bonding_curve_k);
        *v4 = *v4 - v2;
        if (*v4 == 0) {
            0x2::table::remove<address, u64>(&mut arg0.lp_balances, v3);
        };
        arg0.lp_supply = arg0.lp_supply - v2;
        if (v5 > 0 && v5 <= 0x2::balance::value<T0>(&arg0.reserve_x)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_x, v5), arg2), v3);
        };
        if (v6 > 0 && v6 <= 0x2::balance::value<T1>(&arg0.reserve_y)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_y, v6), arg2), v3);
        };
        arg0.k_constant = ((0x2::balance::value<T0>(&arg0.reserve_x) + arg0.virtual_x_reserves) as u128) * ((0x2::balance::value<T1>(&arg0.reserve_y) + arg0.virtual_y_reserves) as u128);
        let v7 = LiquidityEvent{
            pool_id   : 0x2::object::uid_to_inner(&arg0.id),
            amount_x  : v5,
            amount_y  : v6,
            lp_amount : v2,
            is_add    : false,
            user      : v3,
        };
        0x2::event::emit<LiquidityEvent>(v7);
    }

    public entry fun split_lp_token<T0, T1>(arg0: &Pool<T0, T1>, arg1: LPToken<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let LPToken {
            id      : v0,
            pool_id : v1,
            amount  : v2,
        } = arg1;
        assert!(v1 == 0x2::object::uid_to_inner(&arg0.id), 9);
        assert!(arg2 > 0 && arg2 < v2, 4);
        0x2::object::delete(v0);
        let v3 = LPToken<T0, T1>{
            id      : 0x2::object::new(arg3),
            pool_id : 0x2::object::uid_to_inner(&arg0.id),
            amount  : arg2,
        };
        let v4 = LPToken<T0, T1>{
            id      : 0x2::object::new(arg3),
            pool_id : 0x2::object::uid_to_inner(&arg0.id),
            amount  : v2 - arg2,
        };
        let v5 = 0x2::tx_context::sender(arg3);
        0x2::transfer::transfer<LPToken<T0, T1>>(v3, v5);
        0x2::transfer::transfer<LPToken<T0, T1>>(v4, v5);
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
        arg0.k_constant = ((0x2::balance::value<T0>(&arg0.reserve_x) + arg0.virtual_x_reserves) as u128) * ((0x2::balance::value<T1>(&arg0.reserve_y) + arg0.virtual_y_reserves) as u128);
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
        arg0.k_constant = ((0x2::balance::value<T0>(&arg0.reserve_x) + arg0.virtual_x_reserves) as u128) * ((0x2::balance::value<T1>(&arg0.reserve_y) + arg0.virtual_y_reserves) as u128);
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

