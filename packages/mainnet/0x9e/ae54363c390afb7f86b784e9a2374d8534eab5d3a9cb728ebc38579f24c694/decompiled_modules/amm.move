module 0x9eae54363c390afb7f86b784e9a2374d8534eab5d3a9cb728ebc38579f24c694::amm {
    struct AMM has drop {
        dummy_field: bool,
    }

    struct Global has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<0x2::object::ID, bool>,
        protocol_fee_receiver: address,
        total_protocol_fees: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        reserve_x: 0x2::balance::Balance<T0>,
        reserve_y: 0x2::balance::Balance<T1>,
        lp_supply: u64,
        lp_name: 0x1::string::String,
        lp_symbol: 0x1::string::String,
        lp_description: 0x1::string::String,
        lp_icon_url: 0x1::option::Option<0x2::url::Url>,
        lp_decimals: u8,
        flat_fee_x: u64,
        flat_fee_y: u64,
        creator_fee_percentage: u8,
        creator: address,
        initial_virtual_x_reserves: u64,
        initial_virtual_y_reserves: u64,
        k_constant: u128,
        creator_fees_x: 0x2::balance::Balance<T0>,
        creator_fees_y: 0x2::balance::Balance<T1>,
        protocol_fees_x: 0x2::balance::Balance<T0>,
        protocol_fees_y: 0x2::balance::Balance<T1>,
    }

    struct LPCoin<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct PoolCreationTier has drop, store {
        fee_amount: u64,
        creator_fee_percentage: u8,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
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
    }

    struct LiquidityEvent has copy, drop {
        pool_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
        lp_amount: u64,
        is_add: bool,
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = if (arg0.lp_supply == 0) {
            let v3 = 0x1::u64::sqrt(v0) * 0x1::u64::sqrt(v1);
            arg0.lp_supply = v3;
            v3
        } else {
            let v4 = 0x1::u64::min(v0 * arg0.lp_supply / 0x2::balance::value<T0>(&arg0.reserve_x), v1 * arg0.lp_supply / 0x2::balance::value<T1>(&arg0.reserve_y));
            arg0.lp_supply = arg0.lp_supply + v4;
            v4
        };
        0x2::balance::join<T0>(&mut arg0.reserve_x, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.reserve_y, 0x2::coin::into_balance<T1>(arg2));
        let v5 = LiquidityEvent{
            pool_id   : 0x2::object::uid_to_inner(&arg0.id),
            amount_x  : v0,
            amount_y  : v1,
            lp_amount : v2,
            is_add    : true,
        };
        0x2::event::emit<LiquidityEvent>(v5);
    }

    fun calculate_output(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u128) : u64 {
        let v0 = arg2 + arg4 - ((arg5 / ((arg1 + arg3 + arg0) as u128)) as u64);
        if (v0 > arg2) {
            arg2
        } else {
            v0
        }
    }

    public fun calculate_swap_output<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: bool) : u64 {
        if (arg2) {
            calculate_output(arg1 - arg0.flat_fee_x, 0x2::balance::value<T0>(&arg0.reserve_x), 0x2::balance::value<T1>(&arg0.reserve_y), arg0.initial_virtual_x_reserves, arg0.initial_virtual_y_reserves, arg0.k_constant)
        } else {
            calculate_output(arg1 - arg0.flat_fee_y, 0x2::balance::value<T1>(&arg0.reserve_y), 0x2::balance::value<T0>(&arg0.reserve_x), arg0.initial_virtual_y_reserves, arg0.initial_virtual_x_reserves, arg0.k_constant)
        }
    }

    public entry fun claim_creator_fees<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 3);
        let v0 = 0x2::balance::value<T0>(&arg0.creator_fees_x);
        let v1 = 0x2::balance::value<T1>(&arg0.creator_fees_y);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.creator_fees_x, v0), arg1), arg0.creator);
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.creator_fees_y, v1), arg1), arg0.creator);
        };
    }

    public entry fun create_pool<T0, T1>(arg0: &mut Global, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = get_pool_creation_tier(0x2::coin::value<0x2::sui::SUI>(&arg1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_protocol_fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = if (arg7 == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg7))
        };
        let v2 = Pool<T0, T1>{
            id                         : 0x2::object::new(arg10),
            reserve_x                  : 0x2::balance::zero<T0>(),
            reserve_y                  : 0x2::balance::zero<T1>(),
            lp_supply                  : 0,
            lp_name                    : 0x1::string::utf8(arg4),
            lp_symbol                  : 0x1::string::utf8(arg5),
            lp_description             : 0x1::string::utf8(arg6),
            lp_icon_url                : v1,
            lp_decimals                : 9,
            flat_fee_x                 : arg2,
            flat_fee_y                 : arg3,
            creator_fee_percentage     : v0.creator_fee_percentage,
            creator                    : 0x2::tx_context::sender(arg10),
            initial_virtual_x_reserves : arg8,
            initial_virtual_y_reserves : arg9,
            k_constant                 : (arg8 as u128) * (arg9 as u128),
            creator_fees_x             : 0x2::balance::zero<T0>(),
            creator_fees_y             : 0x2::balance::zero<T1>(),
            protocol_fees_x            : 0x2::balance::zero<T0>(),
            protocol_fees_y            : 0x2::balance::zero<T1>(),
        };
        let v3 = 0x2::object::uid_to_inner(&v2.id);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.pools, v3, true);
        let v4 = PoolCreated{
            pool_id     : v3,
            coin_x_type : 0x1::string::utf8(b"X"),
            coin_y_type : 0x1::string::utf8(b"Y"),
            creator     : 0x2::tx_context::sender(arg10),
        };
        0x2::event::emit<PoolCreated>(v4);
        0x2::transfer::share_object<Pool<T0, T1>>(v2);
    }

    public fun get_lp_supply<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.lp_supply
    }

    public fun get_pool_creation_tier(arg0: u64) : PoolCreationTier {
        if (arg0 == 0) {
            PoolCreationTier{fee_amount: 0, creator_fee_percentage: 50}
        } else if (arg0 == 10000000000) {
            PoolCreationTier{fee_amount: 10000000000, creator_fee_percentage: 40}
        } else if (arg0 == 100000000000) {
            PoolCreationTier{fee_amount: 100000000000, creator_fee_percentage: 30}
        } else if (arg0 == 200000000000) {
            PoolCreationTier{fee_amount: 200000000000, creator_fee_percentage: 20}
        } else if (arg0 == 300000000000) {
            PoolCreationTier{fee_amount: 300000000000, creator_fee_percentage: 10}
        } else {
            assert!(arg0 == 500000000000, 4);
            PoolCreationTier{fee_amount: 500000000000, creator_fee_percentage: 0}
        }
    }

    public fun get_reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_x), 0x2::balance::value<T1>(&arg0.reserve_y))
    }

    fun init(arg0: AMM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id                    : 0x2::object::new(arg1),
            pools                 : 0x2::table::new<0x2::object::ID, bool>(arg1),
            protocol_fee_receiver : 0x2::tx_context::sender(arg1),
            total_protocol_fees   : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Global>(v0);
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 5);
        assert!(arg1 <= arg0.lp_supply, 1);
        let v0 = 0x2::balance::value<T0>(&arg0.reserve_x) * arg1 / arg0.lp_supply;
        let v1 = 0x2::balance::value<T1>(&arg0.reserve_y) * arg1 / arg0.lp_supply;
        arg0.lp_supply = arg0.lp_supply - arg1;
        let v2 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_x, v0), arg2), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_y, v1), arg2), v2);
        let v3 = LiquidityEvent{
            pool_id   : 0x2::object::uid_to_inner(&arg0.id),
            amount_x  : v0,
            amount_y  : v1,
            lp_amount : arg1,
            is_add    : false,
        };
        0x2::event::emit<LiquidityEvent>(v3);
    }

    public entry fun swap_x_for_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > arg0.flat_fee_x, 1);
        let v1 = calculate_output(v0 - arg0.flat_fee_x, 0x2::balance::value<T0>(&arg0.reserve_x), 0x2::balance::value<T1>(&arg0.reserve_y), arg0.initial_virtual_x_reserves, arg0.initial_virtual_y_reserves, arg0.k_constant);
        assert!(v1 >= arg2, 2);
        assert!(v1 <= 0x2::balance::value<T1>(&arg0.reserve_y), 1);
        let v2 = 0x2::coin::into_balance<T0>(arg1);
        let v3 = 0x2::balance::split<T0>(&mut v2, arg0.flat_fee_x);
        if (arg0.creator_fee_percentage > 0) {
            0x2::balance::join<T0>(&mut arg0.creator_fees_x, 0x2::balance::split<T0>(&mut v3, arg0.flat_fee_x * (arg0.creator_fee_percentage as u64) / 100));
        };
        0x2::balance::join<T0>(&mut arg0.protocol_fees_x, v3);
        0x2::balance::join<T0>(&mut arg0.reserve_x, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_y, v1), arg3), 0x2::tx_context::sender(arg3));
        let v4 = SwapEvent{
            pool_id    : 0x2::object::uid_to_inner(&arg0.id),
            amount_in  : v0,
            amount_out : v1,
            fee_amount : arg0.flat_fee_x,
            is_x_to_y  : true,
        };
        0x2::event::emit<SwapEvent>(v4);
    }

    public entry fun swap_y_for_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > arg0.flat_fee_y, 1);
        let v1 = calculate_output(v0 - arg0.flat_fee_y, 0x2::balance::value<T1>(&arg0.reserve_y), 0x2::balance::value<T0>(&arg0.reserve_x), arg0.initial_virtual_y_reserves, arg0.initial_virtual_x_reserves, arg0.k_constant);
        assert!(v1 >= arg2, 2);
        assert!(v1 <= 0x2::balance::value<T0>(&arg0.reserve_x), 1);
        let v2 = 0x2::coin::into_balance<T1>(arg1);
        let v3 = 0x2::balance::split<T1>(&mut v2, arg0.flat_fee_y);
        if (arg0.creator_fee_percentage > 0) {
            0x2::balance::join<T1>(&mut arg0.creator_fees_y, 0x2::balance::split<T1>(&mut v3, arg0.flat_fee_y * (arg0.creator_fee_percentage as u64) / 100));
        };
        0x2::balance::join<T1>(&mut arg0.protocol_fees_y, v3);
        0x2::balance::join<T1>(&mut arg0.reserve_y, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_x, v1), arg3), 0x2::tx_context::sender(arg3));
        let v4 = SwapEvent{
            pool_id    : 0x2::object::uid_to_inner(&arg0.id),
            amount_in  : v0,
            amount_out : v1,
            fee_amount : arg0.flat_fee_y,
            is_x_to_y  : false,
        };
        0x2::event::emit<SwapEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

