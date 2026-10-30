module 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::surplus {
    struct LiquidityReserve<phantom T0> has key {
        id: 0x2::object::UID,
        liq: 0x2::balance::Balance<T0>,
        to_pool_total: u64,
        to_treasury_total: u64,
    }

    struct Split has copy, drop {
        to_pool: u64,
        to_treasury: u64,
    }

    struct Deposited has copy, drop {
        soos: u64,
        usdc: u64,
    }

    public fun split<T0>(arg0: &mut 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::FeeConfig<T0>, arg1: &mut LiquidityReserve<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::take_fee_pool<T0>(arg0);
        let v1 = 0x2::balance::value<T0>(&v0);
        assert!(v1 > 0, 801);
        let v2 = (((v1 as u128) * (6180 as u128) / 10000) as u64);
        0x2::balance::join<T0>(&mut arg1.liq, 0x2::balance::split<T0>(&mut v0, v2));
        let v3 = 0x2::balance::value<T0>(&v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg2), @0x4b178f7855b2e84ae9c1585093009bb6c212cd3b5ccf9c76672dda04be087e0);
        arg1.to_pool_total = arg1.to_pool_total + v2;
        arg1.to_treasury_total = arg1.to_treasury_total + v3;
        let v4 = Split{
            to_pool     : v2,
            to_treasury : v3,
        };
        0x2::event::emit<Split>(v4);
    }

    public fun create_reserve<T0>(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LiquidityReserve<T0>{
            id                : 0x2::object::new(arg1),
            liq               : 0x2::balance::zero<T0>(),
            to_pool_total     : 0,
            to_treasury_total : 0,
        };
        0x2::transfer::share_object<LiquidityReserve<T0>>(v0);
    }

    fun deposit<T0, T1>(arg0: &mut LiquidityReserve<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg4: &mut 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0.liq);
        assert!(v0 > 0, 801);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T1, T0>(arg1, arg2, arg3, v0, false, arg5);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T1, T0>(&v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T1, T0>(arg1, arg2, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg4, v2, arg6)), 0x2::balance::split<T0>(&mut arg0.liq, v3), v1);
        let v4 = Deposited{
            soos : v3,
            usdc : v2,
        };
        0x2::event::emit<Deposited>(v4);
    }

    public fun reserve<T0>(arg0: &LiquidityReserve<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.liq)
    }

    public fun to_pool<T0, T1>(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin::AdminCap, arg1: &mut LiquidityReserve<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg3);
        assert!(0x2::object::id_to_address(&v0) == 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::pinned_pool() && 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(arg4) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg3), 800);
        let v1 = &mut arg5;
        deposit<T0, T1>(arg1, arg2, arg3, arg4, v1, arg6, arg7);
        arg5
    }

    // decompiled from Move bytecode v7
}

