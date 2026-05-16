module 0x7fb4bb8fc904a235806734ae0eb3c205fa7ac283c60633ede8be75f2056c7645::pool {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        reserve_a: 0x2::balance::Balance<T0>,
        reserve_b: 0x2::balance::Balance<T1>,
        total_liquidity: u256,
    }

    struct Position<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        liquidity: u256,
        pool_id: 0x2::object::ID,
    }

    struct LiquidityAdded has copy, drop {
        liquidity: u256,
        amount_a: u64,
        amount_b: u64,
    }

    struct LiquidityRemoved has copy, drop {
        liquidity: u256,
        amount_a: u64,
        amount_b: u64,
    }

    public fun add_liquidity_buggy<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u256, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x7fb4bb8fc904a235806734ae0eb3c205fa7ac283c60633ede8be75f2056c7645::math_u256::checked_shlw(arg1);
        let (v2, v3) = 0x7fb4bb8fc904a235806734ae0eb3c205fa7ac283c60633ede8be75f2056c7645::math_u256::checked_shlw(arg1);
        let v4 = if (v1) {
            arg2 + 1
        } else {
            ((v0 >> 64) as u64)
        };
        let v5 = if (v3) {
            arg3 + 1
        } else {
            ((v2 >> 64) as u64)
        };
        assert!(v4 <= arg2 && v5 <= arg3, 0);
        0x2::coin::put<T0>(&mut arg0.reserve_a, 0x2::coin::take<T0>(&mut arg0.reserve_a, v4, arg4));
        0x2::coin::put<T1>(&mut arg0.reserve_b, 0x2::coin::take<T1>(&mut arg0.reserve_b, v5, arg4));
        arg0.total_liquidity = arg0.total_liquidity + arg1;
        let v6 = Position<T0, T1>{
            id        : 0x2::object::new(arg4),
            liquidity : arg1,
            pool_id   : 0x2::object::id<Pool<T0, T1>>(arg0),
        };
        0x2::transfer::transfer<Position<T0, T1>>(v6, 0x2::tx_context::sender(arg4));
        let v7 = LiquidityAdded{
            liquidity : arg1,
            amount_a  : v4,
            amount_b  : v5,
        };
        0x2::event::emit<LiquidityAdded>(v7);
    }

    public fun create_pool<T0, T1>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::coin::TreasuryCap<T1>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (Pool<T0, T1>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = Pool<T0, T1>{
            id              : 0x2::object::new(arg4),
            reserve_a       : 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(arg0, arg2, arg4)),
            reserve_b       : 0x2::coin::into_balance<T1>(0x2::coin::mint<T1>(arg1, arg3, arg4)),
            total_liquidity : 0,
        };
        (v0, 0x2::coin::zero<T0>(arg4), 0x2::coin::zero<T1>(arg4))
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: Position<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == arg1.pool_id, 1);
        let v0 = arg1.liquidity;
        let v1 = arg0.total_liquidity;
        assert!(v1 >= v0, 2);
        let v2 = (((v0 as u256) * (0x2::balance::value<T0>(&arg0.reserve_a) as u256) / v1) as u64);
        let v3 = (((v0 as u256) * (0x2::balance::value<T1>(&arg0.reserve_b) as u256) / v1) as u64);
        arg0.total_liquidity = v1 - v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.reserve_a, v2, arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.reserve_b, v3, arg2), 0x2::tx_context::sender(arg2));
        let Position {
            id        : v4,
            liquidity : _,
            pool_id   : _,
        } = arg1;
        0x2::object::delete(v4);
        let v7 = LiquidityRemoved{
            liquidity : v0,
            amount_a  : v2,
            amount_b  : v3,
        };
        0x2::event::emit<LiquidityRemoved>(v7);
    }

    // decompiled from Move bytecode v7
}

