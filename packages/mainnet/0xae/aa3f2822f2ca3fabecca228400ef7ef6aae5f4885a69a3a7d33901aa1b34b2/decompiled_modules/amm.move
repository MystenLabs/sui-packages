module 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::amm {
    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        reserve_yes: 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::Position,
        reserve_no: 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::Position,
        lp_fee_balance: 0x2::balance::Balance<T0>,
        lp_supply: u64,
    }

    struct LPToken has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct PoolCreated has copy, drop {
        pool: 0x2::object::ID,
        market_id: 0x2::object::ID,
    }

    struct LiquidityAdded has copy, drop {
        pool: 0x2::object::ID,
        collateral_in: u64,
        lp_minted: u64,
    }

    struct LiquidityRemoved has copy, drop {
        pool: 0x2::object::ID,
        lp_burned: u64,
    }

    struct Swapped has copy, drop {
        pool: 0x2::object::ID,
        outcome: u8,
        is_buy: bool,
        collateral: u64,
        shares: u64,
        fee: u64,
    }

    public fun add_liquidity<T0>(arg0: &mut Pool<T0>, arg1: &mut 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::Market<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : (LPToken, 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::Position, 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::Position) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 6);
        let v1 = 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::shares(&arg0.reserve_yes);
        let v2 = 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::shares(&arg0.reserve_no);
        let v3 = if (v1 >= v2) {
            v1
        } else {
            v2
        };
        let (v4, v5) = 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::vault::split<T0>(arg1, arg2, arg3);
        let v6 = v5;
        let v7 = v4;
        let v8 = mul_div(v0, arg0.lp_supply, v3);
        0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::merge(&mut arg0.reserve_yes, v7);
        0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::merge(&mut arg0.reserve_no, v6);
        arg0.lp_supply = arg0.lp_supply + v8;
        let v9 = LiquidityAdded{
            pool          : 0x2::object::id<Pool<T0>>(arg0),
            collateral_in : v0,
            lp_minted     : v8,
        };
        0x2::event::emit<LiquidityAdded>(v9);
        let v10 = LPToken{
            id      : 0x2::object::new(arg3),
            pool_id : 0x2::object::id<Pool<T0>>(arg0),
            amount  : v8,
        };
        (v10, 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::split(&mut v7, v0 - mul_div(v0, v1, v3), arg3), 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::split(&mut v6, v0 - mul_div(v0, v2, v3), arg3))
    }

    public fun buy<T0>(arg0: &mut Pool<T0>, arg1: &mut 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::Market<T0>, arg2: &0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::fee::FeeConfig, arg3: &mut 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::treasury::Treasury<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::Position {
        0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::fee::assert_not_paused(arg2);
        0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::assert_open<T0>(arg1);
        assert!(arg4 == 1 || arg4 == 0, 2);
        assert!(0x2::object::id<0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::Market<T0>>(arg1) == arg0.market_id, 3);
        let v0 = 0x2::coin::value<T0>(&arg5);
        0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::fee::assert_min_trade(arg2, v0);
        let v1 = 0x2::coin::into_balance<T0>(arg5);
        let v2 = 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::fee::calc_total_fee(arg2, v0);
        let v3 = 0x2::balance::split<T0>(&mut v1, v2);
        0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::treasury::deposit<T0>(arg3, 0x2::balance::split<T0>(&mut v3, 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::fee::calc_protocol_fee(arg2, v0)), 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::treasury::kind_trade(), 0x1::option::some<0x2::object::ID>(0x2::object::id<Pool<T0>>(arg0)), 0x2::tx_context::sender(arg7));
        0x2::balance::join<T0>(&mut arg0.lp_fee_balance, v3);
        let v4 = 0x2::balance::value<T0>(&v1);
        let v5 = if (arg4 == 1) {
            0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::shares(&arg0.reserve_yes)
        } else {
            0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::shares(&arg0.reserve_no)
        };
        let v6 = if (arg4 == 1) {
            0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::shares(&arg0.reserve_no)
        } else {
            0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::shares(&arg0.reserve_yes)
        };
        let v7 = v5 + v4 - mul_div(v5, v6, v6 + v4);
        assert!(v7 >= arg6, 1);
        let (v8, v9) = 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::vault::split_balance<T0>(arg1, v1, arg7);
        0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::merge(&mut arg0.reserve_yes, v8);
        0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::merge(&mut arg0.reserve_no, v9);
        let v10 = if (arg4 == 1) {
            0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::split(&mut arg0.reserve_yes, v7, arg7)
        } else {
            0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::split(&mut arg0.reserve_no, v7, arg7)
        };
        let v11 = Swapped{
            pool       : 0x2::object::id<Pool<T0>>(arg0),
            outcome    : arg4,
            is_buy     : true,
            collateral : v0,
            shares     : v7,
            fee        : v2,
        };
        0x2::event::emit<Swapped>(v11);
        v10
    }

    public fun create_pool<T0>(arg0: &mut 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::Market<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : (Pool<T0>, LPToken) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0);
        let (v1, v2) = 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::vault::split<T0>(arg0, arg1, arg2);
        let v3 = Pool<T0>{
            id             : 0x2::object::new(arg2),
            market_id      : 0x2::object::id<0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::Market<T0>>(arg0),
            reserve_yes    : v1,
            reserve_no     : v2,
            lp_fee_balance : 0x2::balance::zero<T0>(),
            lp_supply      : v0,
        };
        let v4 = LPToken{
            id      : 0x2::object::new(arg2),
            pool_id : 0x2::object::id<Pool<T0>>(&v3),
            amount  : v0,
        };
        let v5 = PoolCreated{
            pool      : 0x2::object::id<Pool<T0>>(&v3),
            market_id : v3.market_id,
        };
        0x2::event::emit<PoolCreated>(v5);
        (v3, v4)
    }

    public fun lp_amount(arg0: &LPToken) : u64 {
        arg0.amount
    }

    public fun lp_fees<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.lp_fee_balance)
    }

    public fun lp_pool_id(arg0: &LPToken) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun lp_supply<T0>(arg0: &Pool<T0>) : u64 {
        arg0.lp_supply
    }

    public fun market_id<T0>(arg0: &Pool<T0>) : 0x2::object::ID {
        arg0.market_id
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun remove_liquidity<T0>(arg0: &mut Pool<T0>, arg1: LPToken, arg2: &mut 0x2::tx_context::TxContext) : (0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::Position, 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::Position, 0x2::coin::Coin<T0>) {
        let LPToken {
            id      : v0,
            pool_id : v1,
            amount  : v2,
        } = arg1;
        assert!(v1 == 0x2::object::id<Pool<T0>>(arg0), 4);
        0x2::object::delete(v0);
        arg0.lp_supply = arg0.lp_supply - v2;
        let v3 = LiquidityRemoved{
            pool      : 0x2::object::id<Pool<T0>>(arg0),
            lp_burned : v2,
        };
        0x2::event::emit<LiquidityRemoved>(v3);
        (0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::split(&mut arg0.reserve_yes, mul_div(0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::shares(&arg0.reserve_yes), v2, arg0.lp_supply), arg2), 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::split(&mut arg0.reserve_no, mul_div(0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::shares(&arg0.reserve_no), v2, arg0.lp_supply), arg2), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.lp_fee_balance, mul_div(0x2::balance::value<T0>(&arg0.lp_fee_balance), v2, arg0.lp_supply)), arg2))
    }

    public fun reserves<T0>(arg0: &Pool<T0>) : (u64, u64) {
        (0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::shares(&arg0.reserve_yes), 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::shares(&arg0.reserve_no))
    }

    public fun sell<T0>(arg0: &mut Pool<T0>, arg1: &mut 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::Market<T0>, arg2: &0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::fee::FeeConfig, arg3: &mut 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::treasury::Treasury<T0>, arg4: 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::Position, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::fee::assert_not_paused(arg2);
        0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::assert_open<T0>(arg1);
        assert!(0x2::object::id<0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::Market<T0>>(arg1) == arg0.market_id, 3);
        assert!(0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::market_id(&arg4) == arg0.market_id, 3);
        let v0 = 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::outcome(&arg4);
        let v1 = 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::shares(&arg4);
        assert!(v1 > 0, 6);
        let v2 = if (v0 == 1) {
            0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::shares(&arg0.reserve_yes)
        } else {
            0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::shares(&arg0.reserve_no)
        };
        let v3 = if (v0 == 1) {
            0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::shares(&arg0.reserve_no)
        } else {
            0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::shares(&arg0.reserve_yes)
        };
        let v4 = (v2 as u256) + (v1 as u256) + (v3 as u256);
        let v5 = (((v4 - sqrt_u256(v4 * v4 - 4 * (v1 as u256) * (v3 as u256))) / 2) as u64);
        assert!(v5 > 0, 6);
        assert!(v3 > v5, 5);
        if (v0 == 1) {
            0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::merge(&mut arg0.reserve_yes, arg4);
        } else {
            0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::merge(&mut arg0.reserve_no, arg4);
        };
        let v6 = 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::vault::merge_to_balance<T0>(arg1, 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::split(&mut arg0.reserve_yes, v5, arg6), 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::position::split(&mut arg0.reserve_no, v5, arg6));
        let v7 = 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::fee::calc_total_fee(arg2, v5);
        let v8 = 0x2::balance::split<T0>(&mut v6, v7);
        0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::treasury::deposit<T0>(arg3, 0x2::balance::split<T0>(&mut v8, 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::fee::calc_protocol_fee(arg2, v5)), 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::treasury::kind_trade(), 0x1::option::some<0x2::object::ID>(0x2::object::id<Pool<T0>>(arg0)), 0x2::tx_context::sender(arg6));
        0x2::balance::join<T0>(&mut arg0.lp_fee_balance, v8);
        let v9 = 0x2::balance::value<T0>(&v6);
        assert!(v9 >= arg5, 1);
        let v10 = Swapped{
            pool       : 0x2::object::id<Pool<T0>>(arg0),
            outcome    : v0,
            is_buy     : false,
            collateral : v9,
            shares     : v1,
            fee        : v7,
        };
        0x2::event::emit<Swapped>(v10);
        0x2::coin::from_balance<T0>(v6, arg6)
    }

    public fun share_pool<T0>(arg0: Pool<T0>) {
        0x2::transfer::share_object<Pool<T0>>(arg0);
    }

    fun sqrt_u256(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = arg0 / v0 + v0;
            v0 = v1 / 2;
        };
        arg0
    }

    // decompiled from Move bytecode v7
}

