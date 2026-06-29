module 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::phronis_amm {
    struct PHRONIS_AMM has drop {
        dummy_field: bool,
    }

    struct PhronisAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PhronisConfig has key {
        id: 0x2::object::UID,
        treasury: address,
    }

    struct PhronisRegistry has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
        pool_count: u64,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        coin_type_x: 0x1::string::String,
        coin_type_y: 0x1::string::String,
        reserve_x: 0x2::balance::Balance<T0>,
        reserve_y: 0x2::balance::Balance<T1>,
        total_lp_shares: u128,
        fee_bps: u64,
        fee_growth_global_x_q64: u256,
        fee_growth_global_y_q64: u256,
        lp_fee_pool_x: 0x2::balance::Balance<T0>,
        lp_fee_pool_y: 0x2::balance::Balance<T1>,
        protocol_fees_x: 0x2::balance::Balance<T0>,
        protocol_fees_y: 0x2::balance::Balance<T1>,
        cumulative_volume_x: u128,
        cumulative_volume_y: u128,
        paused: bool,
        tvl_cap_x: u64,
        last_oracle_update_ms: u64,
        cumulative_price_x_in_y_q64: u256,
        cumulative_price_y_in_x_q64: u256,
    }

    struct Position<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        shares: u128,
        fee_growth_snapshot_x_q64: u256,
        fee_growth_snapshot_y_q64: u256,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        name: 0x1::string::String,
        coin_type_x: 0x1::string::String,
        coin_type_y: 0x1::string::String,
        fee_bps: u64,
        initial_x: u64,
        initial_y: u64,
        creator: address,
    }

    struct LiquidityAdded has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        coin_type_x: 0x1::string::String,
        coin_type_y: 0x1::string::String,
        amount_x: u64,
        amount_y: u64,
        shares: u128,
    }

    struct LiquidityRemoved has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        coin_type_x: 0x1::string::String,
        coin_type_y: 0x1::string::String,
        amount_x: u64,
        amount_y: u64,
        shares_burned: u128,
    }

    struct Swapped has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type_x: 0x1::string::String,
        coin_type_y: 0x1::string::String,
        x_in: u64,
        y_in: u64,
        x_out: u64,
        y_out: u64,
        fee_paid: u64,
    }

    struct FeesClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        coin_type_x: 0x1::string::String,
        coin_type_y: 0x1::string::String,
        amount_x: u64,
        amount_y: u64,
    }

    struct ProtocolFeesSwept has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type_x: 0x1::string::String,
        coin_type_y: 0x1::string::String,
        amount_x: u64,
        amount_y: u64,
        treasury: address,
    }

    struct PositionTransferred has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        coin_type_x: 0x1::string::String,
        coin_type_y: 0x1::string::String,
        from: address,
        to: address,
    }

    struct PoolPaused has copy, drop {
        pool_id: 0x2::object::ID,
        paused: bool,
    }

    struct TvlCapSet has copy, drop {
        pool_id: 0x2::object::ID,
        cap_x: u64,
    }

    struct TreasuryUpdated has copy, drop {
        old_treasury: address,
        new_treasury: address,
    }

    public fun swap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (arg3) {
            assert!(0x2::coin::value<T1>(&arg2) == 0, 1010);
            0x2::coin::destroy_zero<T1>(arg2);
            let v2 = swap_x_to_y<T0, T1>(arg0, arg1, arg4, arg5, arg6);
            (0x2::coin::zero<T0>(arg6), v2)
        } else {
            assert!(0x2::coin::value<T0>(&arg1) == 0, 1010);
            0x2::coin::destroy_zero<T0>(arg1);
            let v3 = swap_y_to_x<T0, T1>(arg0, arg2, arg4, arg5, arg6);
            (v3, 0x2::coin::zero<T1>(arg6))
        }
    }

    fun accrue_fee_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        0x2::balance::join<T0>(&mut arg0.protocol_fees_x, 0x2::balance::split<T0>(&mut arg1, mul_div_u64(v0, 2000, 10000)));
        let v1 = 0x2::balance::value<T0>(&arg1);
        if (arg0.total_lp_shares > 0 && v1 > 0) {
            arg0.fee_growth_global_x_q64 = arg0.fee_growth_global_x_q64 + (v1 as u256) * 18446744073709551616 / (arg0.total_lp_shares as u256);
        };
        0x2::balance::join<T0>(&mut arg0.lp_fee_pool_x, arg1);
    }

    fun accrue_fee_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T1>(arg1);
            return
        };
        0x2::balance::join<T1>(&mut arg0.protocol_fees_y, 0x2::balance::split<T1>(&mut arg1, mul_div_u64(v0, 2000, 10000)));
        let v1 = 0x2::balance::value<T1>(&arg1);
        if (arg0.total_lp_shares > 0 && v1 > 0) {
            arg0.fee_growth_global_y_q64 = arg0.fee_growth_global_y_q64 + (v1 as u256) * 18446744073709551616 / (arg0.total_lp_shares as u256);
        };
        0x2::balance::join<T1>(&mut arg0.lp_fee_pool_y, arg1);
    }

    fun accrue_oracle<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = if (v0 > arg0.last_oracle_update_ms) {
            v0 - arg0.last_oracle_update_ms
        } else {
            0
        };
        if (v1 == 0) {
            return
        };
        let v2 = 0x2::balance::value<T0>(&arg0.reserve_x);
        let v3 = 0x2::balance::value<T1>(&arg0.reserve_y);
        if (v2 > 0 && v3 > 0) {
            arg0.cumulative_price_x_in_y_q64 = arg0.cumulative_price_x_in_y_q64 + (v3 as u256) * 18446744073709551616 / (v2 as u256) * (v1 as u256);
            arg0.cumulative_price_y_in_x_q64 = arg0.cumulative_price_y_in_x_q64 + (v2 as u256) * 18446744073709551616 / (v3 as u256) * (v1 as u256);
        };
        arg0.last_oracle_update_ms = v0;
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (Position<T0, T1>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(!arg0.paused, 1007);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 && v1 > 0, 1002);
        accrue_oracle<T0, T1>(arg0, arg3);
        let v2 = 0x2::balance::value<T0>(&arg0.reserve_x);
        let v3 = 0x2::balance::value<T1>(&arg0.reserve_y);
        let (v4, v5) = if (arg0.total_lp_shares * (v0 as u128) / (v2 as u128) <= arg0.total_lp_shares * (v1 as u128) / (v3 as u128)) {
            (v0, (((v0 as u256) * (v3 as u256) / (v2 as u256)) as u64))
        } else {
            ((((v1 as u256) * (v2 as u256) / (v3 as u256)) as u64), v1)
        };
        assert!(v4 > 0 && v5 > 0, 1001);
        let v6 = arg0.total_lp_shares * (v4 as u128) / (v2 as u128);
        let v7 = arg0.total_lp_shares * (v5 as u128) / (v3 as u128);
        let v8 = if (v6 < v7) {
            v6
        } else {
            v7
        };
        assert!(v8 > 0, 1001);
        assert_within_tvl_cap<T0, T1>(arg0, v4);
        0x2::balance::join<T0>(&mut arg0.reserve_x, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v4, arg4)));
        0x2::balance::join<T1>(&mut arg0.reserve_y, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v5, arg4)));
        arg0.total_lp_shares = arg0.total_lp_shares + v8;
        let v9 = 0x2::object::id<Pool<T0, T1>>(arg0);
        let v10 = Position<T0, T1>{
            id                        : 0x2::object::new(arg4),
            pool_id                   : v9,
            shares                    : v8,
            fee_growth_snapshot_x_q64 : arg0.fee_growth_global_x_q64,
            fee_growth_snapshot_y_q64 : arg0.fee_growth_global_y_q64,
        };
        let v11 = LiquidityAdded{
            pool_id     : v9,
            position_id : 0x2::object::id<Position<T0, T1>>(&v10),
            coin_type_x : arg0.coin_type_x,
            coin_type_y : arg0.coin_type_y,
            amount_x    : v4,
            amount_y    : v5,
            shares      : v8,
        };
        0x2::event::emit<LiquidityAdded>(v11);
        (v10, arg1, arg2)
    }

    fun assert_within_tvl_cap<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) {
        if (arg0.tvl_cap_x == 0) {
            return
        };
        assert!(0x2::balance::value<T0>(&arg0.reserve_x) + arg1 <= arg0.tvl_cap_x, 1008);
    }

    public fun claim_fees<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut Position<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg1.pool_id == 0x2::object::id<Pool<T0, T1>>(arg0), 1004);
        let (v0, v1) = owed_fees<T0, T1>(arg0, arg1.shares, arg1.fee_growth_snapshot_x_q64, arg1.fee_growth_snapshot_y_q64);
        arg1.fee_growth_snapshot_x_q64 = arg0.fee_growth_global_x_q64;
        arg1.fee_growth_snapshot_y_q64 = arg0.fee_growth_global_y_q64;
        let v2 = FeesClaimed{
            pool_id     : 0x2::object::id<Pool<T0, T1>>(arg0),
            position_id : 0x2::object::id<Position<T0, T1>>(arg1),
            coin_type_x : arg0.coin_type_x,
            coin_type_y : arg0.coin_type_y,
            amount_x    : v0,
            amount_y    : v1,
        };
        0x2::event::emit<FeesClaimed>(v2);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.lp_fee_pool_x, v0), arg2), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.lp_fee_pool_y, v1), arg2))
    }

    public fun coin_type_x<T0, T1>(arg0: &Pool<T0, T1>) : &0x1::string::String {
        &arg0.coin_type_x
    }

    public fun coin_type_y<T0, T1>(arg0: &Pool<T0, T1>) : &0x1::string::String {
        &arg0.coin_type_y
    }

    public fun create_pool<T0, T1>(arg0: &mut PhronisRegistry, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Position<T0, T1> {
        let v0 = if (arg3 == 5) {
            true
        } else if (arg3 == 30) {
            true
        } else {
            arg3 == 100
        };
        assert!(v0, 1000);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = 0x2::coin::value<T1>(&arg2);
        assert!(v1 > 0 && v2 > 0, 1001);
        let v3 = type_name_string<T0>();
        let v4 = type_name_string<T1>();
        assert!(v3 != v4, 1011);
        let v5 = registry_key(&v3, &v4, arg3);
        assert!(!0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.pools, v5), 1009);
        let v6 = (sqrt_u256((v1 as u256) * (v2 as u256)) as u128);
        assert!(v6 > 1000, 1001);
        let v7 = v6 - 1000;
        let v8 = 0x2::object::new(arg6);
        let v9 = 0x2::object::uid_to_inner(&v8);
        let v10 = Pool<T0, T1>{
            id                          : v8,
            name                        : arg4,
            coin_type_x                 : v3,
            coin_type_y                 : v4,
            reserve_x                   : 0x2::coin::into_balance<T0>(arg1),
            reserve_y                   : 0x2::coin::into_balance<T1>(arg2),
            total_lp_shares             : v6,
            fee_bps                     : arg3,
            fee_growth_global_x_q64     : 0,
            fee_growth_global_y_q64     : 0,
            lp_fee_pool_x               : 0x2::balance::zero<T0>(),
            lp_fee_pool_y               : 0x2::balance::zero<T1>(),
            protocol_fees_x             : 0x2::balance::zero<T0>(),
            protocol_fees_y             : 0x2::balance::zero<T1>(),
            cumulative_volume_x         : 0,
            cumulative_volume_y         : 0,
            paused                      : false,
            tvl_cap_x                   : 0,
            last_oracle_update_ms       : 0x2::clock::timestamp_ms(arg5),
            cumulative_price_x_in_y_q64 : 0,
            cumulative_price_y_in_x_q64 : 0,
        };
        let v11 = Position<T0, T1>{
            id                        : 0x2::object::new(arg6),
            pool_id                   : v9,
            shares                    : v7,
            fee_growth_snapshot_x_q64 : 0,
            fee_growth_snapshot_y_q64 : 0,
        };
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg0.pools, v5, v9);
        arg0.pool_count = arg0.pool_count + 1;
        let v12 = PoolCreated{
            pool_id     : v9,
            name        : v10.name,
            coin_type_x : v10.coin_type_x,
            coin_type_y : v10.coin_type_y,
            fee_bps     : arg3,
            initial_x   : v1,
            initial_y   : v2,
            creator     : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<PoolCreated>(v12);
        let v13 = LiquidityAdded{
            pool_id     : v9,
            position_id : 0x2::object::id<Position<T0, T1>>(&v11),
            coin_type_x : v10.coin_type_x,
            coin_type_y : v10.coin_type_y,
            amount_x    : v1,
            amount_y    : v2,
            shares      : v7,
        };
        0x2::event::emit<LiquidityAdded>(v13);
        0x2::transfer::share_object<Pool<T0, T1>>(v10);
        v11
    }

    public fun create_pool_display<T0, T1>(arg0: &PhronisAdminCap, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<Pool<T0, T1>> {
        let v0 = 0x2::display::new<Pool<T0, T1>>(arg1, arg2);
        0x2::display::add<Pool<T0, T1>>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Pool<T0, T1>>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Phronis liquidity pool: {coin_type_x} / {coin_type_y} ({fee_bps} bps)"));
        0x2::display::add<Pool<T0, T1>>(&mut v0, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://phronis.tech"));
        0x2::display::update_version<Pool<T0, T1>>(&mut v0);
        v0
    }

    public fun create_position_display<T0, T1>(arg0: &PhronisAdminCap, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<Position<T0, T1>> {
        let v0 = 0x2::display::new<Position<T0, T1>>(arg1, arg2);
        0x2::display::add<Position<T0, T1>>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Phronis LP Position"));
        0x2::display::add<Position<T0, T1>>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Liquidity position in a Phronis pool. {shares} shares."));
        0x2::display::add<Position<T0, T1>>(&mut v0, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://phronis.tech"));
        0x2::display::update_version<Position<T0, T1>>(&mut v0);
        v0
    }

    public fun cumulative_volume<T0, T1>(arg0: &Pool<T0, T1>) : (u128, u128) {
        (arg0.cumulative_volume_x, arg0.cumulative_volume_y)
    }

    public fun fee_bps<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.fee_bps
    }

    fun init(arg0: PHRONIS_AMM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PhronisAdminCap{id: 0x2::object::new(arg1)};
        let v1 = PhronisConfig{
            id       : 0x2::object::new(arg1),
            treasury : @0x72fb6101d12f0c4f35374b50d939f836f2878e695bb559679c823a9ae7fc25d5,
        };
        let v2 = PhronisRegistry{
            id         : 0x2::object::new(arg1),
            pools      : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg1),
            pool_count : 0,
        };
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<PHRONIS_AMM>(arg0, arg1), v3);
        0x2::transfer::public_transfer<PhronisAdminCap>(v0, v3);
        0x2::transfer::share_object<PhronisConfig>(v1);
        0x2::transfer::share_object<PhronisRegistry>(v2);
    }

    public fun is_paused<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.paused
    }

    fun min_fee(arg0: u64, arg1: u64) : u64 {
        let v0 = mul_div_u64(arg0, arg1, 10000);
        if (v0 == 0 && arg0 > 0) {
            1
        } else {
            v0
        }
    }

    fun mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u64)
    }

    public fun name<T0, T1>(arg0: &Pool<T0, T1>) : &0x1::string::String {
        &arg0.name
    }

    public fun oracle<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u256, u256) {
        (arg0.last_oracle_update_ms, arg0.cumulative_price_x_in_y_q64, arg0.cumulative_price_y_in_x_q64)
    }

    fun owed_fees<T0, T1>(arg0: &Pool<T0, T1>, arg1: u128, arg2: u256, arg3: u256) : (u64, u64) {
        ((((arg0.fee_growth_global_x_q64 - arg2) * (arg1 as u256) / 18446744073709551616) as u64), (((arg0.fee_growth_global_y_q64 - arg3) * (arg1 as u256) / 18446744073709551616) as u64))
    }

    public fun position_pool_id<T0, T1>(arg0: &Position<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun position_shares<T0, T1>(arg0: &Position<T0, T1>) : u128 {
        arg0.shares
    }

    public fun protocol_fees<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.protocol_fees_x), 0x2::balance::value<T1>(&arg0.protocol_fees_y))
    }

    public fun quote_x_to_y<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.reserve_x);
        let v1 = 0x2::balance::value<T1>(&arg0.reserve_y);
        let v2 = if (arg1 == 0) {
            true
        } else if (v0 == 0) {
            true
        } else {
            v1 == 0
        };
        if (v2) {
            return 0
        };
        let v3 = arg1 - min_fee(arg1, arg0.fee_bps);
        mul_div_u64(v1, v3, v0 + v3)
    }

    public fun quote_y_to_x<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.reserve_x);
        let v1 = 0x2::balance::value<T1>(&arg0.reserve_y);
        let v2 = if (arg1 == 0) {
            true
        } else if (v0 == 0) {
            true
        } else {
            v1 == 0
        };
        if (v2) {
            return 0
        };
        let v3 = arg1 - min_fee(arg1, arg0.fee_bps);
        mul_div_u64(v0, v3, v1 + v3)
    }

    fun registry_key(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: u64) : vector<u8> {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(arg0));
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(arg1));
        0x1::vector::push_back<u8>(&mut v0, 0);
        let v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<u8>(&mut v0, ((arg2 & 255) as u8));
            arg2 = arg2 >> 8;
            v1 = v1 + 1;
        };
        v0
    }

    public fun registry_pool_count(arg0: &PhronisRegistry) : u64 {
        arg0.pool_count
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: Position<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        accrue_oracle<T0, T1>(arg0, arg2);
        let Position {
            id                        : v0,
            pool_id                   : v1,
            shares                    : v2,
            fee_growth_snapshot_x_q64 : v3,
            fee_growth_snapshot_y_q64 : v4,
        } = arg1;
        let v5 = v0;
        assert!(v1 == 0x2::object::id<Pool<T0, T1>>(arg0), 1004);
        0x2::object::delete(v5);
        let (v6, v7) = owed_fees<T0, T1>(arg0, v2, v3, v4);
        let v8 = (((0x2::balance::value<T0>(&arg0.reserve_x) as u128) * v2 / arg0.total_lp_shares) as u64);
        let v9 = (((0x2::balance::value<T1>(&arg0.reserve_y) as u128) * v2 / arg0.total_lp_shares) as u64);
        arg0.total_lp_shares = arg0.total_lp_shares - v2;
        let v10 = 0x2::balance::split<T0>(&mut arg0.reserve_x, v8);
        let v11 = 0x2::balance::split<T1>(&mut arg0.reserve_y, v9);
        0x2::balance::join<T0>(&mut v10, 0x2::balance::split<T0>(&mut arg0.lp_fee_pool_x, v6));
        0x2::balance::join<T1>(&mut v11, 0x2::balance::split<T1>(&mut arg0.lp_fee_pool_y, v7));
        let v12 = LiquidityRemoved{
            pool_id       : v1,
            position_id   : 0x2::object::uid_to_inner(&v5),
            coin_type_x   : arg0.coin_type_x,
            coin_type_y   : arg0.coin_type_y,
            amount_x      : v8,
            amount_y      : v9,
            shares_burned : v2,
        };
        0x2::event::emit<LiquidityRemoved>(v12);
        (0x2::coin::from_balance<T0>(v10, arg3), 0x2::coin::from_balance<T1>(v11, arg3))
    }

    public fun reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_x), 0x2::balance::value<T1>(&arg0.reserve_y))
    }

    public fun set_paused<T0, T1>(arg0: &PhronisAdminCap, arg1: &mut Pool<T0, T1>, arg2: bool) {
        arg1.paused = arg2;
        let v0 = PoolPaused{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg1),
            paused  : arg2,
        };
        0x2::event::emit<PoolPaused>(v0);
    }

    public fun set_treasury(arg0: &PhronisAdminCap, arg1: &mut PhronisConfig, arg2: address) {
        arg1.treasury = arg2;
        let v0 = TreasuryUpdated{
            old_treasury : arg1.treasury,
            new_treasury : arg2,
        };
        0x2::event::emit<TreasuryUpdated>(v0);
    }

    public fun set_tvl_cap<T0, T1>(arg0: &PhronisAdminCap, arg1: &mut Pool<T0, T1>, arg2: u64) {
        arg1.tvl_cap_x = arg2;
        let v0 = TvlCapSet{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg1),
            cap_x   : arg2,
        };
        0x2::event::emit<TvlCapSet>(v0);
    }

    fun sqrt_u256(arg0: u256) : u256 {
        if (arg0 < 2) {
            return arg0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        arg0
    }

    public fun swap_x_to_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(!arg0.paused, 1007);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1002);
        accrue_oracle<T0, T1>(arg0, arg3);
        let v1 = 0x2::balance::value<T0>(&arg0.reserve_x);
        let v2 = 0x2::balance::value<T1>(&arg0.reserve_y);
        assert!(v1 > 0 && v2 > 0, 1005);
        let v3 = min_fee(v0, arg0.fee_bps);
        let v4 = v0 - v3;
        let v5 = mul_div_u64(v2, v4, v1 + v4);
        assert!(v5 >= arg2, 1003);
        assert!(v5 < v2, 1005);
        assert_within_tvl_cap<T0, T1>(arg0, v4);
        let v6 = 0x2::coin::into_balance<T0>(arg1);
        0x2::balance::join<T0>(&mut arg0.reserve_x, 0x2::balance::split<T0>(&mut v6, v4));
        accrue_fee_x<T0, T1>(arg0, v6);
        arg0.cumulative_volume_x = arg0.cumulative_volume_x + (v0 as u128);
        let v7 = Swapped{
            pool_id     : 0x2::object::id<Pool<T0, T1>>(arg0),
            coin_type_x : arg0.coin_type_x,
            coin_type_y : arg0.coin_type_y,
            x_in        : v0,
            y_in        : 0,
            x_out       : 0,
            y_out       : v5,
            fee_paid    : v3,
        };
        0x2::event::emit<Swapped>(v7);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_y, v5), arg4)
    }

    public fun swap_y_to_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.paused, 1007);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 1002);
        accrue_oracle<T0, T1>(arg0, arg3);
        let v1 = 0x2::balance::value<T0>(&arg0.reserve_x);
        let v2 = 0x2::balance::value<T1>(&arg0.reserve_y);
        assert!(v1 > 0 && v2 > 0, 1005);
        let v3 = min_fee(v0, arg0.fee_bps);
        let v4 = v0 - v3;
        let v5 = mul_div_u64(v1, v4, v2 + v4);
        assert!(v5 >= arg2, 1003);
        assert!(v5 < v1, 1005);
        let v6 = 0x2::coin::into_balance<T1>(arg1);
        0x2::balance::join<T1>(&mut arg0.reserve_y, 0x2::balance::split<T1>(&mut v6, v4));
        accrue_fee_y<T0, T1>(arg0, v6);
        arg0.cumulative_volume_y = arg0.cumulative_volume_y + (v0 as u128);
        let v7 = Swapped{
            pool_id     : 0x2::object::id<Pool<T0, T1>>(arg0),
            coin_type_x : arg0.coin_type_x,
            coin_type_y : arg0.coin_type_y,
            x_in        : 0,
            y_in        : v0,
            x_out       : v5,
            y_out       : 0,
            fee_paid    : v3,
        };
        0x2::event::emit<Swapped>(v7);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_x, v5), arg4)
    }

    public fun sweep_protocol_fees<T0, T1>(arg0: &PhronisConfig, arg1: &mut Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1.protocol_fees_x);
        let v1 = 0x2::balance::value<T1>(&arg1.protocol_fees_y);
        assert!(v0 > 0 || v1 > 0, 1006);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.protocol_fees_x), arg2), arg0.treasury);
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg1.protocol_fees_y), arg2), arg0.treasury);
        };
        let v2 = ProtocolFeesSwept{
            pool_id     : 0x2::object::id<Pool<T0, T1>>(arg1),
            coin_type_x : arg1.coin_type_x,
            coin_type_y : arg1.coin_type_y,
            amount_x    : v0,
            amount_y    : v1,
            treasury    : arg0.treasury,
        };
        0x2::event::emit<ProtocolFeesSwept>(v2);
    }

    public fun total_lp_shares<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.total_lp_shares
    }

    public fun transfer_position<T0, T1>(arg0: &Pool<T0, T1>, arg1: Position<T0, T1>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = PositionTransferred{
            pool_id     : 0x2::object::id<Pool<T0, T1>>(arg0),
            position_id : 0x2::object::id<Position<T0, T1>>(&arg1),
            coin_type_x : arg0.coin_type_x,
            coin_type_y : arg0.coin_type_y,
            from        : 0x2::tx_context::sender(arg3),
            to          : arg2,
        };
        0x2::event::emit<PositionTransferred>(v0);
        0x2::transfer::public_transfer<Position<T0, T1>>(arg1, arg2);
    }

    public fun treasury(arg0: &PhronisConfig) : address {
        arg0.treasury
    }

    public fun tvl_cap_x<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.tvl_cap_x
    }

    fun type_name_string<T0>() : 0x1::string::String {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        0x1::string::utf8(*0x1::ascii::as_bytes(&v0))
    }

    // decompiled from Move bytecode v7
}

