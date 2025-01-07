module 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        version: u64,
        stable: bool,
        locked: bool,
        lp_supply: 0x2::balance::Supply<LP_TOKEN<T0, T1>>,
        reserve_x: 0x2::balance::Balance<T0>,
        reserve_y: 0x2::balance::Balance<T1>,
        decimal_x: u8,
        decimal_y: u8,
        last_update_time: u64,
        last_price_x_cumulative: u256,
        last_price_y_cumulative: u256,
        observations: 0x2::table_vec::TableVec<Observation>,
        fee: Fee<T0, T1>,
    }

    struct Fee<phantom T0, phantom T1> has store {
        fee_x: 0x2::balance::Balance<T0>,
        fee_y: 0x2::balance::Balance<T1>,
        index_x: u256,
        index_y: u256,
        fee_percentage: u8,
    }

    struct VSDB has drop {
        dummy_field: bool,
    }

    struct AMMState has drop, store {
        last_swap: u64,
        earneed_times: u8,
    }

    struct Observation has store {
        timestamp: u64,
        reserve_x_cumulative: u256,
        reserve_y_cumulative: u256,
    }

    struct LP_TOKEN<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct LP<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        lp_balance: 0x2::balance::Balance<LP_TOKEN<T0, T1>>,
        index_x: u256,
        index_y: u256,
        claimable_x: u64,
        claimable_y: u64,
    }

    struct Receipt<phantom T0, phantom T1, phantom T2> {
        amount: u64,
        fee: u64,
    }

    public(friend) fun new<T0, T1>(arg0: 0x1::string::String, arg1: bool, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0x2::coin::CoinMetadata<T1>, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = LP_TOKEN<T0, T1>{dummy_field: false};
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg5) / 1000;
        let v2 = Fee<T0, T1>{
            fee_x          : 0x2::balance::zero<T0>(),
            fee_y          : 0x2::balance::zero<T1>(),
            index_x        : 0,
            index_y        : 0,
            fee_percentage : arg4,
        };
        let v3 = Observation{
            timestamp            : v1,
            reserve_x_cumulative : 0,
            reserve_y_cumulative : 0,
        };
        let v4 = Pool<T0, T1>{
            id                      : 0x2::object::new(arg5),
            name                    : arg0,
            version                 : 1,
            stable                  : arg1,
            locked                  : false,
            lp_supply               : 0x2::balance::create_supply<LP_TOKEN<T0, T1>>(v0),
            reserve_x               : 0x2::balance::zero<T0>(),
            reserve_y               : 0x2::balance::zero<T1>(),
            decimal_x               : 0x2::coin::get_decimals<T0>(arg2),
            decimal_y               : 0x2::coin::get_decimals<T1>(arg3),
            last_update_time        : v1,
            last_price_x_cumulative : 0,
            last_price_y_cumulative : 0,
            observations            : 0x2::table_vec::singleton<Observation>(v3, arg5),
            fee                     : v2,
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v4);
        0x2::object::id<Pool<T0, T1>>(&v4)
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut LP<T0, T1>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_pool_unlocked<T0, T1>(arg0);
        assert!(arg0.version == 1, 1);
        update_lp_<T0, T1>(arg0, arg3);
        0x2::balance::join<LP_TOKEN<T0, T1>>(&mut arg3.lp_balance, add_liquidity_<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7));
    }

    fun add_liquidity_<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<LP_TOKEN<T0, T1>> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 && v1 > 0, 102);
        let (v2, v3, v4) = get_reserves<T0, T1>(arg0);
        let (v5, v6) = if (v2 == 0 && v3 == 0) {
            (arg1, arg2)
        } else {
            let v7 = quote(v2, v3, v0);
            if (v7 <= v1) {
                assert!(v7 >= arg4, 103);
                let v8 = if (0x2::coin::value<T1>(&arg2) == v7) {
                    arg2
                } else {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, 0x2::tx_context::sender(arg6));
                    0x2::coin::split<T1>(&mut arg2, v7, arg6)
                };
                (arg1, v8)
            } else {
                let v9 = quote(v3, v2, v1);
                assert!(v9 <= v0, 103);
                assert!(v9 >= arg3, 103);
                let v10 = if (0x2::coin::value<T0>(&arg1) == v7) {
                    arg1
                } else {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg6));
                    0x2::coin::split<T0>(&mut arg1, v9, arg6)
                };
                (v10, arg2)
            }
        };
        let v11 = v6;
        let v12 = v5;
        let v13 = 0x2::coin::value<T0>(&v12);
        let v14 = 0x2::coin::value<T1>(&v11);
        let v15 = if (0x2::balance::supply_value<LP_TOKEN<T0, T1>>(&arg0.lp_supply) == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<LP_TOKEN<T0, T1>>>(0x2::coin::from_balance<LP_TOKEN<T0, T1>>(0x2::balance::increase_supply<LP_TOKEN<T0, T1>>(&mut arg0.lp_supply, 1000), arg6), @0x0);
            0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::amm_math::mul_sqrt(v13, v14) - 1000
        } else {
            0x2::math::min((((v13 as u128) * (v4 as u128) / (v2 as u128)) as u64), (((v14 as u128) * (v4 as u128) / (v3 as u128)) as u64))
        };
        update_timestamp_<T0, T1>(arg0, arg5);
        0x2::balance::join<T0>(&mut arg0.reserve_x, 0x2::coin::into_balance<T0>(v12));
        0x2::balance::join<T1>(&mut arg0.reserve_y, 0x2::coin::into_balance<T1>(v11));
        0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::event::liquidity_added<T0, T1>(v13, v14, v15);
        let (v16, v17, _) = get_reserves<T0, T1>(arg0);
        0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::event::sync<T0, T1>(v16, v17);
        0x2::balance::increase_supply<LP_TOKEN<T0, T1>>(&mut arg0.lp_supply, v15)
    }

    public fun amm_state_borrow(arg0: &0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb) : &AMMState {
        let v0 = VSDB{dummy_field: false};
        0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::df_borrow<VSDB, AMMState>(arg0, v0)
    }

    fun amm_state_borrow_mut(arg0: &mut 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb) : &mut AMMState {
        let v0 = VSDB{dummy_field: false};
        0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::df_borrow_mut<VSDB, AMMState>(arg0, v0)
    }

    fun assert_pool_unlocked<T0, T1>(arg0: &Pool<T0, T1>) {
        assert!(arg0.locked == false, 101);
    }

    fun assert_valid_type<T0, T1, T2>() {
        let v0 = 0x1::type_name::get<T2>();
        assert!(0x1::type_name::get<T0>() == v0 || 0x1::type_name::get<T1>() == v0, 100);
    }

    public fun calculate_fee(arg0: u64, arg1: u8) : u64 {
        arg0 * (arg1 as u64) / 10000 + 1
    }

    fun claim_fees_<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut LP<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::coin::Coin<T0>>, 0x1::option::Option<0x2::coin::Coin<T1>>, u64, u64) {
        update_lp_<T0, T1>(arg0, arg1);
        let v0 = arg1.claimable_x;
        let v1 = arg1.claimable_y;
        let v2 = if (v0 > 0) {
            0x1::option::some<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.fee.fee_x, v0, arg2))
        } else {
            0x1::option::none<0x2::coin::Coin<T0>>()
        };
        let v3 = if (v1 > 0) {
            0x1::option::some<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.fee.fee_y, v1, arg2))
        } else {
            0x1::option::none<0x2::coin::Coin<T1>>()
        };
        arg1.claimable_x = 0;
        arg1.claimable_y = 0;
        (v2, v3, v0, v1)
    }

    public fun claim_fees_dev<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut LP<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::coin::Coin<T0>>, 0x1::option::Option<0x2::coin::Coin<T1>>, u64, u64) {
        assert!(arg0.version == 1, 1);
        claim_fees_<T0, T1>(arg0, arg1, arg2)
    }

    public entry fun claim_fees_player<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut LP<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        let (v0, v1, _, _) = claim_fees_<T0, T1>(arg0, arg1, arg2);
        let v4 = v1;
        let v5 = v0;
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&v5)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::extract<0x2::coin::Coin<T0>>(&mut v5), 0x2::tx_context::sender(arg2));
        };
        if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v4)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x1::option::extract<0x2::coin::Coin<T1>>(&mut v4), 0x2::tx_context::sender(arg2));
        };
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(v5);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v4);
    }

    public fun claimable<T0, T1>(arg0: &Pool<T0, T1>, arg1: &LP<T0, T1>) : (u64, u64) {
        let v0 = lp_balance<T0, T1>(arg1);
        let v1 = arg1.claimable_x;
        let v2 = v1;
        let v3 = arg1.claimable_y;
        let v4 = v3;
        if (v0 > 0) {
            let v5 = arg0.fee.index_x - arg1.index_x;
            let v6 = arg0.fee.index_y - arg1.index_y;
            if (v5 > 0) {
                v2 = v1 + (((v0 as u256) * v5 / 1000000000000000000) as u64);
            };
            if (v6 > 0) {
                v4 = v3 + (((v0 as u256) * v6 / 1000000000000000000) as u64);
            };
        };
        (v2, v4)
    }

    public fun clear(arg0: &mut 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb) {
        let v0 = VSDB{dummy_field: false};
        let AMMState {
            last_swap     : _,
            earneed_times : _,
        } = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::df_remove<VSDB, AMMState>(v0, arg0);
    }

    public fun create_lp<T0, T1>(arg0: &Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : LP<T0, T1> {
        assert!(arg0.version == 1, 1);
        assert_pool_unlocked<T0, T1>(arg0);
        LP<T0, T1>{
            id          : 0x2::object::new(arg1),
            lp_balance  : 0x2::balance::zero<LP_TOKEN<T0, T1>>(),
            index_x     : arg0.fee.index_x,
            index_y     : arg0.fee.index_y,
            claimable_x : 0,
            claimable_y : 0,
        }
    }

    public fun current<T0, T1, T2>(arg0: &Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        assert_valid_type<T0, T1, T2>();
        let v0 = unix_timestamp(arg2);
        let v1 = get_latest_observation<T0, T1>(arg0);
        let v2 = v1;
        let (v3, v4) = current_cumulative_prices<T0, T1>(arg0, arg2);
        let v5 = 0x2::table_vec::length<Observation>(&arg0.observations);
        if (v5 == 1) {
            return 0
        };
        if (v0 == v1.timestamp) {
            v2 = 0x2::table_vec::borrow<Observation>(&arg0.observations, v5 - 2);
        };
        let v6 = v0 - v2.timestamp;
        0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::amm_math::get_output_<T0, T1, T2>(arg0.stable, arg1, (((v3 - v2.reserve_x_cumulative) / (v6 as u256)) as u64), (((v4 - v2.reserve_y_cumulative) / (v6 as u256)) as u64), arg0.decimal_x, arg0.decimal_y)
    }

    public fun current_cumulative_prices<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x2::clock::Clock) : (u256, u256) {
        let v0 = unix_timestamp(arg1);
        let v1 = get_latest_observation<T0, T1>(arg0);
        let v2 = v1.reserve_x_cumulative;
        let v3 = v2;
        let v4 = v1.reserve_y_cumulative;
        let v5 = v4;
        let (v6, v7, _) = get_reserves<T0, T1>(arg0);
        if (v1.timestamp != v0) {
            let v9 = v0 - v1.timestamp;
            v3 = v2 + (v6 as u256) * (v9 as u256);
            v5 = v4 + (v7 as u256) * (v9 as u256);
        };
        (v3, v5)
    }

    public fun decimal_x<T0, T1>(arg0: &Pool<T0, T1>) : u8 {
        arg0.decimal_x
    }

    public fun decimal_y<T0, T1>(arg0: &Pool<T0, T1>) : u8 {
        arg0.decimal_y
    }

    public entry fun delete_lp<T0, T1>(arg0: LP<T0, T1>) {
        let LP {
            id          : v0,
            lp_balance  : v1,
            index_x     : _,
            index_y     : _,
            claimable_x : v4,
            claimable_y : v5,
        } = arg0;
        assert!(v4 == 0 && v5 == 0, 108);
        0x2::balance::destroy_zero<LP_TOKEN<T0, T1>>(v1);
        0x2::object::delete(v0);
    }

    fun earn_xp_(arg0: &mut 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb, arg1: &0x2::clock::Clock) {
        let v0 = unix_timestamp(arg1);
        let v1 = amm_state_borrow_mut(arg0);
        if (v0 / 604800 * 604800 > v1.last_swap) {
            v1.earneed_times = 0;
        };
        v1.last_swap = v0;
        if (v1.earneed_times < 5) {
            v1.earneed_times = v1.earneed_times + 1;
            let v2 = VSDB{dummy_field: false};
            0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::earn_xp<VSDB>(v2, arg0, 3);
        };
    }

    public fun fee_x<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.fee.fee_x)
    }

    public fun fee_y<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.fee.fee_y)
    }

    public fun get_latest_observation<T0, T1>(arg0: &Pool<T0, T1>) : &Observation {
        get_observation<T0, T1>(arg0, 0x2::table_vec::length<Observation>(&arg0.observations) - 1)
    }

    fun get_observation<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : &Observation {
        0x2::table_vec::borrow<Observation>(&arg0.observations, arg1)
    }

    public fun get_output<T0, T1, T2>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        assert_valid_type<T0, T1, T2>();
        let (v0, v1, _) = get_reserves<T0, T1>(arg0);
        0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::amm_math::get_output_<T0, T1, T2>(arg0.stable, arg1 - calculate_fee(arg1, arg0.fee.fee_percentage), v0, v1, arg0.decimal_x, arg0.decimal_y)
    }

    public fun get_output_fee<T0, T1, T2>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u8) : u64 {
        assert_valid_type<T0, T1, T2>();
        let (v0, v1, _) = get_reserves<T0, T1>(arg0);
        0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::amm_math::get_output_<T0, T1, T2>(arg0.stable, arg1 - calculate_fee(arg1, arg2), v0, v1, arg0.decimal_x, arg0.decimal_y)
    }

    public fun get_reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_x), 0x2::balance::value<T1>(&arg0.reserve_y), 0x2::balance::supply_value<LP_TOKEN<T0, T1>>(&arg0.lp_supply))
    }

    public entry fun initialize(arg0: &0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::VSDBRegistry, arg1: &mut 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb) {
        let v0 = VSDB{dummy_field: false};
        let v1 = AMMState{
            last_swap     : 0,
            earneed_times : 0,
        };
        0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::df_add<VSDB, AMMState>(v0, arg0, arg1, v1);
    }

    public fun is_initialized(arg0: &0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb) : bool {
        let v0 = VSDB{dummy_field: false};
        0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::df_exists<VSDB>(arg0, v0)
    }

    public entry fun join_lp<T0, T1>(arg0: &Pool<T0, T1>, arg1: &mut LP<T0, T1>, arg2: &mut LP<T0, T1>, arg3: u64) {
        assert!(arg0.version == 1, 1);
        assert_pool_unlocked<T0, T1>(arg0);
        update_lp_<T0, T1>(arg0, arg1);
        update_lp_<T0, T1>(arg0, arg2);
        0x2::balance::join<LP_TOKEN<T0, T1>>(&mut arg1.lp_balance, 0x2::balance::split<LP_TOKEN<T0, T1>>(&mut arg2.lp_balance, arg3));
    }

    public fun loan_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Receipt<T0, T1, T0>) {
        assert_pool_unlocked<T0, T1>(arg0);
        assert!(arg0.version == 1, 1);
        let (v0, _, _) = get_reserves<T0, T1>(arg0);
        assert!(arg1 <= v0, 106);
        let v3 = (arg0.fee.fee_percentage as u64);
        let v4 = Receipt<T0, T1, T0>{
            amount : arg1,
            fee    : arg1 / (10000 - v3) * v3 + 1,
        };
        (0x2::coin::take<T0>(&mut arg0.reserve_x, arg1, arg2), v4)
    }

    public fun loan_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Receipt<T0, T1, T1>) {
        assert_pool_unlocked<T0, T1>(arg0);
        assert!(arg0.version == 1, 1);
        let (_, v1, _) = get_reserves<T0, T1>(arg0);
        assert!(arg1 <= v1, 106);
        let v3 = (arg0.fee.fee_percentage as u64);
        let v4 = Receipt<T0, T1, T1>{
            amount : arg1,
            fee    : arg1 / (10000 - v3) * v3 + 1,
        };
        (0x2::coin::take<T1>(&mut arg0.reserve_y, arg1, arg2), v4)
    }

    public fun lp_balance<T0, T1>(arg0: &LP<T0, T1>) : u64 {
        0x2::balance::value<LP_TOKEN<T0, T1>>(&arg0.lp_balance)
    }

    public fun lp_supply<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::supply_value<LP_TOKEN<T0, T1>>(&arg0.lp_supply)
    }

    public fun name<T0, T1>(arg0: &Pool<T0, T1>) : 0x1::string::String {
        arg0.name
    }

    public fun prices<T0, T1, T2>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64) : vector<u64> {
        assert_valid_type<T0, T1, T2>();
        smaple<T0, T1, T2>(arg0, arg1, arg2, 1)
    }

    public fun quote(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0 && arg1 > 0, 102);
        assert!(arg2 > 0, 102);
        (((arg1 as u128) * (arg2 as u128) / (arg0 as u128)) as u64)
    }

    public fun quote_TWAP<T0, T1, T2>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64) : u64 {
        assert_valid_type<T0, T1, T2>();
        let v0 = prices<T0, T1, T2>(arg0, arg1, arg2);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v0)) {
            v1 = v1 + *0x1::vector::borrow<u64>(&v0, v2);
            v2 = v2 + 1;
        };
        v1 / arg2
    }

    public fun quote_add_liquidity<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64) : (u64, u64, u64) {
        let (v0, v1, v2) = get_reserves<T0, T1>(arg0);
        if (v0 == 0 && v1 == 0) {
            return (arg1, arg2, 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::amm_math::mul_sqrt(arg1, arg2) - 1000)
        };
        let v3 = quote(v0, v1, arg1);
        let (v4, v5) = if (v3 <= arg2) {
            (arg1, v3)
        } else {
            (quote(v1, v0, arg2), arg2)
        };
        (v4, v5, 0x2::math::min((((v4 as u128) * (v2 as u128) / (v0 as u128)) as u64), (((v5 as u128) * (v2 as u128) / (v1 as u128)) as u64)))
    }

    public fun quote_remove_liquidity<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : (u64, u64) {
        let (v0, v1, v2) = get_reserves<T0, T1>(arg0);
        (quote(v2, v0, arg1), quote(v2, v1, arg1))
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut LP<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_pool_unlocked<T0, T1>(arg0);
        assert!(arg0.version == 1, 1);
        update_lp_<T0, T1>(arg0, arg1);
        let v0 = 0x2::coin::take<LP_TOKEN<T0, T1>>(&mut arg1.lp_balance, arg2, arg6);
        let (v1, v2) = remove_liquidity_<T0, T1>(arg0, v0, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg6));
    }

    fun remove_liquidity_<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP_TOKEN<T0, T1>>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<LP_TOKEN<T0, T1>>(&arg1);
        assert!(v0 > 0, 102);
        let (v1, v2, v3) = get_reserves<T0, T1>(arg0);
        let v4 = quote(v3, v1, v0);
        let v5 = quote(v3, v2, v0);
        assert!(v4 > 0 && v5 > 0, 102);
        assert!(v4 >= arg2, 103);
        assert!(v5 >= arg3, 103);
        update_timestamp_<T0, T1>(arg0, arg4);
        0x2::balance::decrease_supply<LP_TOKEN<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP_TOKEN<T0, T1>>(arg1));
        0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::event::liquidity_removed<T0, T1>(v4, v5, v0);
        let (v6, v7, _) = get_reserves<T0, T1>(arg0);
        0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::event::sync<T0, T1>(v6, v7);
        (0x2::coin::take<T0>(&mut arg0.reserve_x, v4, arg5), 0x2::coin::take<T1>(&mut arg0.reserve_y, v5, arg5))
    }

    public fun repay_loan_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: Receipt<T0, T1, T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        let Receipt {
            amount : v0,
            fee    : v1,
        } = arg2;
        assert!(0x2::coin::value<T0>(&arg1) == v0 + v1, 107);
        0x2::coin::put<T0>(&mut arg0.fee.fee_x, 0x2::coin::split<T0>(&mut arg1, v1, arg4));
        update_fee_index_x_<T0, T1>(arg0, v1);
        0x2::coin::put<T0>(&mut arg0.reserve_x, arg1);
        update_timestamp_<T0, T1>(arg0, arg3);
    }

    public fun repay_loan_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: Receipt<T0, T1, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        let Receipt {
            amount : v0,
            fee    : v1,
        } = arg2;
        assert!(0x2::coin::value<T1>(&arg1) == v0 + v1, 107);
        0x2::coin::put<T1>(&mut arg0.fee.fee_y, 0x2::coin::split<T1>(&mut arg1, v1, arg4));
        update_fee_index_x_<T0, T1>(arg0, v1);
        0x2::coin::put<T1>(&mut arg0.reserve_y, arg1);
        update_timestamp_<T0, T1>(arg0, arg3);
    }

    public fun smaple<T0, T1, T2>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64) : vector<u64> {
        assert_valid_type<T0, T1, T2>();
        let v0 = 0x2::table_vec::length<Observation>(&arg0.observations) - 1;
        let v1 = 0x1::vector::empty<u64>();
        let v2 = v0 - arg2 * arg3;
        while (v2 < v0) {
            let v3 = 0x2::table_vec::borrow<Observation>(&arg0.observations, v2 + arg3);
            let v4 = 0x2::table_vec::borrow<Observation>(&arg0.observations, v2);
            let v5 = v3.timestamp - v4.timestamp;
            0x1::vector::push_back<u64>(&mut v1, 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::amm_math::get_output_<T0, T1, T2>(arg0.stable, arg1, (((v3.reserve_x_cumulative - v4.reserve_x_cumulative) / (v5 as u256)) as u64), (((v3.reserve_y_cumulative - v4.reserve_y_cumulative) / (v5 as u256)) as u64), arg0.decimal_x, arg0.decimal_y));
            v2 = v2 + arg3;
        };
        v1
    }

    public fun stable<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.stable
    }

    public entry fun swap_for_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_pool_unlocked<T0, T1>(arg0);
        assert!(arg0.version == 1, 1);
        let v0 = swap_for_x_<T0, T1>(arg0, 0x1::option::none<u8>(), arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    fun swap_for_x_<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x1::option::Option<u8>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg2);
        let (v1, v2, _) = get_reserves<T0, T1>(arg0);
        assert!(v1 > 0 && v2 > 0, 104);
        assert!(v0 > 0, 102);
        let v4 = if (0x1::option::is_some<u8>(&arg1)) {
            0x1::option::destroy_some<u8>(arg1)
        } else {
            arg0.fee.fee_percentage
        };
        let v5 = calculate_fee(v0, v4);
        let v6 = 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::amm_math::get_output_<T0, T1, T1>(arg0.stable, v0 - v5, v1, v2, arg0.decimal_x, arg0.decimal_y);
        assert!(v6 >= arg3, 103);
        update_timestamp_<T0, T1>(arg0, arg4);
        0x2::balance::join<T1>(&mut arg0.reserve_y, 0x2::coin::into_balance<T1>(arg2));
        0x2::coin::put<T1>(&mut arg0.fee.fee_y, 0x2::coin::take<T1>(&mut arg0.reserve_y, v5, arg5));
        update_fee_index_y_<T0, T1>(arg0, v5);
        let (v7, v8, _) = get_reserves<T0, T1>(arg0);
        if (arg0.stable) {
            let v10 = 0x2::math::pow(10, arg0.decimal_x);
            let v11 = 0x2::math::pow(10, arg0.decimal_y);
            assert!(0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::amm_math::k_(v1, v2 + v0, v10, v11) >= 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::amm_math::k_(v1, v2, v10, v11), 105);
        } else {
            assert!((v7 as u128) * (v8 as u128) >= (v1 as u128) * (v2 as u128), 105);
        };
        0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::event::swap<T0, T1>(v0, v6);
        0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::event::sync<T0, T1>(v7, v8);
        0x2::coin::take<T0>(&mut arg0.reserve_x, v6, arg5)
    }

    public fun swap_for_x_dev<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        assert_pool_unlocked<T0, T1>(arg0);
        assert!(arg0.version == 1, 1);
        let v0 = swap_for_x_<T0, T1>(arg0, 0x1::option::none<u8>(), arg1, arg2, arg3, arg4);
        (v0, 0x2::coin::value<T0>(&v0))
    }

    public entry fun swap_for_x_vsdb<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_pool_unlocked<T0, T1>(arg0);
        assert!(arg0.version == 1, 1);
        assert!(!0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::is_expired(arg3, arg4), 109);
        earn_xp_(arg3, arg4);
        let v0 = if (arg0.stable) {
            0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::level(arg3) / 3
        } else {
            0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::level(arg3)
        };
        let v1 = if (arg0.fee.fee_percentage <= v0) {
            1
        } else {
            arg0.fee.fee_percentage - v0
        };
        let v2 = swap_for_x_<T0, T1>(arg0, 0x1::option::some<u8>(v1), arg1, arg2, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg5));
    }

    public entry fun swap_for_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_pool_unlocked<T0, T1>(arg0);
        assert!(arg0.version == 1, 1);
        let v0 = swap_for_y_<T0, T1>(arg0, 0x1::option::none<u8>(), arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg4));
    }

    fun swap_for_y_<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x1::option::Option<u8>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let (v1, v2, _) = get_reserves<T0, T1>(arg0);
        assert!(v0 > 0, 102);
        assert!(v1 > 0 && v2 > 0, 104);
        let v4 = if (0x1::option::is_some<u8>(&arg1)) {
            0x1::option::destroy_some<u8>(arg1)
        } else {
            arg0.fee.fee_percentage
        };
        let v5 = calculate_fee(v0, v4);
        let v6 = 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::amm_math::get_output_<T0, T1, T0>(arg0.stable, v0 - v5, v1, v2, arg0.decimal_x, arg0.decimal_y);
        assert!(v6 >= arg3, 103);
        update_timestamp_<T0, T1>(arg0, arg4);
        0x2::balance::join<T0>(&mut arg0.reserve_x, 0x2::coin::into_balance<T0>(arg2));
        0x2::coin::put<T0>(&mut arg0.fee.fee_x, 0x2::coin::take<T0>(&mut arg0.reserve_x, v5, arg5));
        update_fee_index_x_<T0, T1>(arg0, v5);
        let (v7, v8, _) = get_reserves<T0, T1>(arg0);
        if (arg0.stable) {
            let v10 = 0x2::math::pow(10, arg0.decimal_x);
            let v11 = 0x2::math::pow(10, arg0.decimal_y);
            assert!(0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::amm_math::k_(v1 + v0, v2, v10, v11) >= 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::amm_math::k_(v1, v2, v10, v11), 105);
        } else {
            assert!((v7 as u128) * (v8 as u128) >= (v1 as u128) * (v2 as u128), 105);
        };
        0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::event::swap<T0, T1>(v0, v6);
        0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::event::sync<T0, T1>(v7, v8);
        0x2::coin::take<T1>(&mut arg0.reserve_y, v6, arg5)
    }

    public fun swap_for_y_dev<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        assert_pool_unlocked<T0, T1>(arg0);
        assert!(arg0.version == 1, 1);
        let v0 = swap_for_y_<T0, T1>(arg0, 0x1::option::none<u8>(), arg1, arg2, arg3, arg4);
        (v0, 0x2::coin::value<T1>(&v0))
    }

    public entry fun swap_for_y_vsdb<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_pool_unlocked<T0, T1>(arg0);
        assert!(arg0.version == 1, 1);
        assert!(!0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::is_expired(arg3, arg4), 109);
        earn_xp_(arg3, arg4);
        let v0 = if (arg0.stable) {
            0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::level(arg3) / 3
        } else {
            0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::level(arg3)
        };
        let v1 = if (arg0.fee.fee_percentage <= v0) {
            1
        } else {
            arg0.fee.fee_percentage - v0
        };
        let v2 = swap_for_y_<T0, T1>(arg0, 0x1::option::some<u8>(v1), arg1, arg2, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg5));
    }

    public(friend) fun udpate_lock<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool) {
        assert!(arg0.version == 1, 1);
        arg0.locked = arg1;
    }

    fun unix_timestamp(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public(friend) fun update_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u8) {
        assert!(arg0.version == 1, 1);
        arg0.fee.fee_percentage = arg1;
    }

    fun update_fee_index_x_<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        arg0.fee.index_x = arg0.fee.index_x + (arg1 as u256) * 1000000000000000000 / (lp_supply<T0, T1>(arg0) as u256);
        0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::event::fee<T0>(arg1);
    }

    fun update_fee_index_y_<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        arg0.fee.index_y = arg0.fee.index_y + (arg1 as u256) * 1000000000000000000 / (lp_supply<T0, T1>(arg0) as u256);
        0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::event::fee<T1>(arg1);
    }

    fun update_lp_<T0, T1>(arg0: &Pool<T0, T1>, arg1: &mut LP<T0, T1>) {
        let v0 = lp_balance<T0, T1>(arg1);
        if (v0 > 0) {
            let v1 = arg0.fee.index_x - arg1.index_x;
            let v2 = arg0.fee.index_y - arg1.index_y;
            if (v1 > 0) {
                arg1.claimable_x = arg1.claimable_x + (((v0 as u256) * v1 / 1000000000000000000) as u64);
            };
            if (v2 > 0) {
                arg1.claimable_y = arg1.claimable_y + (((v0 as u256) * v2 / 1000000000000000000) as u64);
            };
        };
        arg1.index_x = arg0.fee.index_x;
        arg1.index_y = arg0.fee.index_y;
    }

    public(friend) fun update_stable<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool) {
        assert!(arg0.version == 1, 1);
        arg0.stable = arg1;
    }

    fun update_timestamp_<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = (0x2::balance::value<T0>(&arg0.reserve_x) as u256);
        let v1 = (0x2::balance::value<T1>(&arg0.reserve_y) as u256);
        let v2 = unix_timestamp(arg1);
        let v3 = v2 - arg0.last_update_time;
        if (v3 > 0 && v0 != 0 && v1 != 0) {
            arg0.last_price_x_cumulative = arg0.last_price_x_cumulative + v0 * (v3 as u256);
            arg0.last_price_y_cumulative = arg0.last_price_y_cumulative + v1 * (v3 as u256);
        };
        if (v2 - get_latest_observation<T0, T1>(arg0).timestamp > 1800) {
            let v4 = Observation{
                timestamp            : v2,
                reserve_x_cumulative : arg0.last_price_x_cumulative,
                reserve_y_cumulative : arg0.last_price_y_cumulative,
            };
            0x2::table_vec::push_back<Observation>(&mut arg0.observations, v4);
        };
        arg0.last_update_time = v2;
    }

    public entry fun zap_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut LP<T0, T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_pool_unlocked<T0, T1>(arg0);
        assert!(!arg0.stable, 110);
        assert!(arg0.version == 1, 1);
        let (v0, _, _) = get_reserves<T0, T1>(arg0);
        let v3 = 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::amm_math::zap_optimized_input((v0 as u256), (0x2::coin::value<T0>(&arg1) as u256), arg0.fee.fee_percentage);
        let v4 = get_output<T0, T1, T0>(arg0, v3);
        let v5 = 0x2::coin::split<T0>(&mut arg1, v3, arg6);
        let v6 = swap_for_y_<T0, T1>(arg0, 0x1::option::none<u8>(), v5, v4, arg5, arg6);
        add_liquidity<T0, T1>(arg0, arg1, v6, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun zap_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut LP<T0, T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_pool_unlocked<T0, T1>(arg0);
        assert!(!arg0.stable, 110);
        assert!(arg0.version == 1, 1);
        let (_, v1, _) = get_reserves<T0, T1>(arg0);
        let v3 = 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::amm_math::zap_optimized_input((v1 as u256), (0x2::coin::value<T1>(&arg1) as u256), arg0.fee.fee_percentage);
        let v4 = get_output<T0, T1, T1>(arg0, v3);
        let v5 = 0x2::coin::split<T1>(&mut arg1, v3, arg6);
        let v6 = swap_for_x_<T0, T1>(arg0, 0x1::option::none<u8>(), v5, v4, arg5, arg6);
        add_liquidity<T0, T1>(arg0, v6, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

