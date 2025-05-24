module 0x1c4ad9a1c3a70ca05f79097bada82f0abcb1c73803962bab54472ea2cc2427fe::amm {
    struct AMM has drop {
        dummy_field: bool,
    }

    struct LP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Global has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<0x2::object::ID, bool>,
        protocol_fee_receiver: address,
        total_protocol_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        pool_counter: u64,
        lp_info: 0x2::table::Table<0x2::object::ID, LPTokenInfo>,
    }

    struct LPTokenInfo has copy, drop, store {
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
        pool_id: 0x2::object::ID,
        coin_x_type: 0x1::string::String,
        coin_y_type: 0x1::string::String,
        metadata_id: 0x2::object::ID,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        pool_id: u64,
        lp_balances: 0x2::table::Table<address, u64>,
        lp_supply: u64,
        reserve_x: 0x2::balance::Balance<T0>,
        reserve_y: 0x2::balance::Balance<T1>,
        flat_fee_x: u64,
        flat_fee_y: u64,
        creator_fee_percentage: u8,
        creator: address,
        virtual_x_reserves: u64,
        virtual_y_reserves: u64,
        k_constant: u128,
        creator_fees_x: 0x2::balance::Balance<T0>,
        creator_fees_y: 0x2::balance::Balance<T1>,
        protocol_fees_x: 0x2::balance::Balance<T0>,
        protocol_fees_y: 0x2::balance::Balance<T1>,
    }

    struct PoolCreationTier has drop, store {
        fee_amount: u64,
        creator_fee_percentage: u8,
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

    struct LaunchEvent has copy, drop {
        pool_id: 0x2::object::ID,
        token_type: 0x1::string::String,
        initial_supply: u64,
        virtual_reserves: u64,
        creator: address,
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 || v1 > 0, 5);
        let v2 = calculate_lp_amount(v0, v1, 0x2::balance::value<T0>(&arg0.reserve_x), 0x2::balance::value<T1>(&arg0.reserve_y), arg0.lp_supply, arg0.virtual_x_reserves, arg0.virtual_y_reserves);
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
        let v3 = 0x2::tx_context::sender(arg3);
        if (0x2::table::contains<address, u64>(&arg0.lp_balances, v3)) {
            0x2::table::add<address, u64>(&mut arg0.lp_balances, v3, 0x2::table::remove<address, u64>(&mut arg0.lp_balances, v3) + v2);
        } else {
            0x2::table::add<address, u64>(&mut arg0.lp_balances, v3, v2);
        };
        let v4 = LiquidityEvent{
            pool_id   : 0x2::object::uid_to_inner(&arg0.id),
            amount_x  : v0,
            amount_y  : v1,
            lp_amount : v2,
            is_add    : true,
            user      : v3,
        };
        0x2::event::emit<LiquidityEvent>(v4);
    }

    fun calculate_initial_lp_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0x1::u64::sqrt(arg0 + arg1) * 0x1::u64::sqrt(arg2)
    }

    fun calculate_lp_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : u64 {
        if (arg4 == 0) {
            calculate_initial_lp_amount(arg0, arg5, arg6)
        } else {
            let v1 = (arg0 as u128) * (arg4 as u128) / ((arg2 + arg5) as u128);
            let v2 = (arg1 as u128) * (arg4 as u128) / ((arg3 + arg6) as u128);
            if (v1 < v2) {
                (v1 as u64)
            } else {
                (v2 as u64)
            }
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

    public fun calculate_swap_output<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: bool) : u64 {
        if (arg2) {
            if (arg1 <= arg0.flat_fee_x) {
                0
            } else {
                calculate_output(arg1 - arg0.flat_fee_x, 0x2::balance::value<T0>(&arg0.reserve_x), 0x2::balance::value<T1>(&arg0.reserve_y), arg0.virtual_x_reserves, arg0.virtual_y_reserves, arg0.k_constant)
            }
        } else if (arg1 <= arg0.flat_fee_y) {
            0
        } else {
            calculate_output(arg1 - arg0.flat_fee_y, 0x2::balance::value<T1>(&arg0.reserve_y), 0x2::balance::value<T0>(&arg0.reserve_x), arg0.virtual_y_reserves, arg0.virtual_x_reserves, arg0.k_constant)
        }
    }

    public entry fun claim_creator_fees<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 6);
        let v0 = 0x2::balance::value<T0>(&arg0.creator_fees_x);
        let v1 = 0x2::balance::value<T1>(&arg0.creator_fees_y);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.creator_fees_x, v0), arg1), arg0.creator);
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.creator_fees_y, v1), arg1), arg0.creator);
        };
    }

    public entry fun claim_global_protocol_fees(arg0: &mut Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.protocol_fee_receiver, 6);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.total_protocol_fees);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.total_protocol_fees, v0), arg1), arg0.protocol_fee_receiver);
        };
    }

    public entry fun claim_protocol_fees<T0, T1>(arg0: &Global, arg1: &mut Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.protocol_fee_receiver, 6);
        let v0 = 0x2::balance::value<T0>(&arg1.protocol_fees_x);
        let v1 = 0x2::balance::value<T1>(&arg1.protocol_fees_y);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.protocol_fees_x, v0), arg2), arg0.protocol_fee_receiver);
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.protocol_fees_y, v1), arg2), arg0.protocol_fee_receiver);
        };
    }

    public fun create_pool_balance_based<T0, T1>(arg0: &mut Global, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = get_pool_creation_tier(0x2::coin::value<0x2::sui::SUI>(&arg1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_protocol_fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = arg0.pool_counter;
        arg0.pool_counter = arg0.pool_counter + 1;
        let v2 = Pool<T0, T1>{
            id                     : 0x2::object::new(arg11),
            pool_id                : v1,
            lp_balances            : 0x2::table::new<address, u64>(arg11),
            lp_supply              : 0,
            reserve_x              : 0x2::balance::zero<T0>(),
            reserve_y              : 0x2::balance::zero<T1>(),
            flat_fee_x             : arg3,
            flat_fee_y             : arg4,
            creator_fee_percentage : v0.creator_fee_percentage,
            creator                : 0x2::tx_context::sender(arg11),
            virtual_x_reserves     : arg9,
            virtual_y_reserves     : arg10,
            k_constant             : (arg9 as u128) * (arg10 as u128),
            creator_fees_x         : 0x2::balance::zero<T0>(),
            creator_fees_y         : 0x2::balance::zero<T1>(),
            protocol_fees_x        : 0x2::balance::zero<T0>(),
            protocol_fees_y        : 0x2::balance::zero<T1>(),
        };
        let v3 = 0x2::object::uid_to_inner(&v2.id);
        let v4 = if (0x1::vector::is_empty<u8>(&arg8)) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg8))
        };
        let v5 = LPTokenInfo{
            name        : 0x1::string::utf8(arg5),
            symbol      : 0x1::string::utf8(arg6),
            description : 0x1::string::utf8(arg7),
            icon_url    : v4,
            pool_id     : v3,
            coin_x_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            coin_y_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())),
            metadata_id : 0x2::object::id_from_address(@0x0),
        };
        0x2::table::add<0x2::object::ID, LPTokenInfo>(&mut arg0.lp_info, v3, v5);
        let v6 = 0x2::coin::value<T0>(&arg2);
        if (v6 > 0) {
            0x2::balance::join<T0>(&mut v2.reserve_x, 0x2::coin::into_balance<T0>(arg2));
            let v7 = calculate_initial_lp_amount(v6, arg9, arg10);
            if (v7 > 0) {
                v2.lp_supply = v7;
                0x2::table::add<address, u64>(&mut v2.lp_balances, 0x2::tx_context::sender(arg11), v7);
            };
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg11));
        };
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.pools, v3, true);
        let v8 = PoolCreated{
            pool_id        : v3,
            pool_number    : v1,
            coin_x_type    : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            coin_y_type    : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())),
            creator        : 0x2::tx_context::sender(arg11),
            lp_metadata_id : 0x2::object::id_from_address(@0x0),
        };
        0x2::event::emit<PoolCreated>(v8);
        let v9 = LaunchEvent{
            pool_id          : v3,
            token_type       : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            initial_supply   : v6,
            virtual_reserves : arg9,
            creator          : 0x2::tx_context::sender(arg11),
        };
        0x2::event::emit<LaunchEvent>(v9);
        0x2::transfer::share_object<Pool<T0, T1>>(v2);
        v3
    }

    public fun get_lp_info(arg0: &Global, arg1: 0x2::object::ID) : &LPTokenInfo {
        0x2::table::borrow<0x2::object::ID, LPTokenInfo>(&arg0.lp_info, arg1)
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

    public fun get_pool_info<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64, u64, u64, u8, address) {
        (0x2::balance::value<T0>(&arg0.reserve_x), 0x2::balance::value<T1>(&arg0.reserve_y), arg0.lp_supply, arg0.flat_fee_x, arg0.flat_fee_y, arg0.creator_fee_percentage, arg0.creator)
    }

    public fun get_reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_x), 0x2::balance::value<T1>(&arg0.reserve_y))
    }

    public fun get_total_value_locked<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_x) + 0x2::balance::value<T0>(&arg0.creator_fees_x) + 0x2::balance::value<T0>(&arg0.protocol_fees_x), 0x2::balance::value<T1>(&arg0.reserve_y) + 0x2::balance::value<T1>(&arg0.creator_fees_y) + 0x2::balance::value<T1>(&arg0.protocol_fees_y))
    }

    public fun get_user_lp_balance<T0, T1>(arg0: &Pool<T0, T1>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.lp_balances, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.lp_balances, arg1)
        } else {
            0
        }
    }

    fun init(arg0: AMM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id                    : 0x2::object::new(arg1),
            pools                 : 0x2::table::new<0x2::object::ID, bool>(arg1),
            protocol_fee_receiver : 0x2::tx_context::sender(arg1),
            total_protocol_fees   : 0x2::balance::zero<0x2::sui::SUI>(),
            pool_counter          : 0,
            lp_info               : 0x2::table::new<0x2::object::ID, LPTokenInfo>(arg1),
        };
        0x2::transfer::share_object<Global>(v0);
    }

    public fun lp_info_coin_x_type(arg0: &LPTokenInfo) : 0x1::string::String {
        arg0.coin_x_type
    }

    public fun lp_info_coin_y_type(arg0: &LPTokenInfo) : 0x1::string::String {
        arg0.coin_y_type
    }

    public fun lp_info_description(arg0: &LPTokenInfo) : 0x1::string::String {
        arg0.description
    }

    public fun lp_info_icon_url(arg0: &LPTokenInfo) : 0x1::option::Option<0x2::url::Url> {
        arg0.icon_url
    }

    public fun lp_info_metadata_id(arg0: &LPTokenInfo) : 0x2::object::ID {
        arg0.metadata_id
    }

    public fun lp_info_name(arg0: &LPTokenInfo) : 0x1::string::String {
        arg0.name
    }

    public fun lp_info_symbol(arg0: &LPTokenInfo) : 0x1::string::String {
        arg0.symbol
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 5);
        assert!(arg1 <= arg0.lp_supply, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.lp_balances, v0), 1);
        let v1 = 0x2::table::remove<address, u64>(&mut arg0.lp_balances, v0);
        assert!(v1 >= arg1, 1);
        let v2 = (((0x2::balance::value<T0>(&arg0.reserve_x) as u128) * (arg1 as u128) / (arg0.lp_supply as u128)) as u64);
        let v3 = (((0x2::balance::value<T1>(&arg0.reserve_y) as u128) * (arg1 as u128) / (arg0.lp_supply as u128)) as u64);
        if (v1 > arg1) {
            0x2::table::add<address, u64>(&mut arg0.lp_balances, v0, v1 - arg1);
        };
        arg0.lp_supply = arg0.lp_supply - arg1;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_x, v2), arg2), v0);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_y, v3), arg2), v0);
        };
        let v4 = LiquidityEvent{
            pool_id   : 0x2::object::uid_to_inner(&arg0.id),
            amount_x  : v2,
            amount_y  : v3,
            lp_amount : arg1,
            is_add    : false,
            user      : v0,
        };
        0x2::event::emit<LiquidityEvent>(v4);
    }

    public entry fun swap_x_for_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > arg0.flat_fee_x, 1);
        let v1 = calculate_output(v0 - arg0.flat_fee_x, 0x2::balance::value<T0>(&arg0.reserve_x), 0x2::balance::value<T1>(&arg0.reserve_y), arg0.virtual_x_reserves, arg0.virtual_y_reserves, arg0.k_constant);
        assert!(v1 >= arg2, 2);
        assert!(v1 <= 0x2::balance::value<T1>(&arg0.reserve_y), 1);
        let v2 = 0x2::coin::into_balance<T0>(arg1);
        let v3 = 0x2::balance::split<T0>(&mut v2, arg0.flat_fee_x);
        let v4 = arg0.flat_fee_x * (arg0.creator_fee_percentage as u64) / 100;
        if (v4 > 0) {
            0x2::balance::join<T0>(&mut arg0.creator_fees_x, 0x2::balance::split<T0>(&mut v3, v4));
        };
        0x2::balance::join<T0>(&mut arg0.protocol_fees_x, v3);
        0x2::balance::join<T0>(&mut arg0.reserve_x, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_y, v1), arg3), 0x2::tx_context::sender(arg3));
        let v5 = SwapEvent{
            pool_id    : 0x2::object::uid_to_inner(&arg0.id),
            amount_in  : v0,
            amount_out : v1,
            fee_amount : arg0.flat_fee_x,
            is_x_to_y  : true,
            trader     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SwapEvent>(v5);
    }

    public entry fun swap_y_for_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > arg0.flat_fee_y, 1);
        let v1 = calculate_output(v0 - arg0.flat_fee_y, 0x2::balance::value<T1>(&arg0.reserve_y), 0x2::balance::value<T0>(&arg0.reserve_x), arg0.virtual_y_reserves, arg0.virtual_x_reserves, arg0.k_constant);
        assert!(v1 >= arg2, 2);
        assert!(v1 <= 0x2::balance::value<T0>(&arg0.reserve_x), 1);
        let v2 = 0x2::coin::into_balance<T1>(arg1);
        let v3 = 0x2::balance::split<T1>(&mut v2, arg0.flat_fee_y);
        let v4 = arg0.flat_fee_y * (arg0.creator_fee_percentage as u64) / 100;
        if (v4 > 0) {
            0x2::balance::join<T1>(&mut arg0.creator_fees_y, 0x2::balance::split<T1>(&mut v3, v4));
        };
        0x2::balance::join<T1>(&mut arg0.protocol_fees_y, v3);
        0x2::balance::join<T1>(&mut arg0.reserve_y, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_x, v1), arg3), 0x2::tx_context::sender(arg3));
        let v5 = SwapEvent{
            pool_id    : 0x2::object::uid_to_inner(&arg0.id),
            amount_in  : v0,
            amount_out : v1,
            fee_amount : arg0.flat_fee_y,
            is_x_to_y  : false,
            trader     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SwapEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

