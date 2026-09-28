module 0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::cetus_custody {
    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        curve_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
    }

    struct LiquidityLocked has copy, drop {
        vault_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        deposited_a: u64,
        deposited_b: u64,
        retained_a: u64,
        retained_b: u64,
    }

    struct FeesRetained has copy, drop {
        vault_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct LiquidityCompounded has copy, drop {
        vault_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        liquidity_added: u128,
    }

    public fun collect<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut Vault<T0, T1>) {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == arg2.pool_id, 0);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg0, arg1, &arg2.position, true);
        let v2 = v1;
        let v3 = v0;
        let v4 = FeesRetained{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg2),
            amount_a : 0x2::balance::value<T0>(&v3),
            amount_b : 0x2::balance::value<T1>(&v2),
        };
        0x2::event::emit<FeesRetained>(v4);
        0x2::balance::join<T0>(&mut arg2.balance_a, v3);
        0x2::balance::join<T1>(&mut arg2.balance_b, v2);
    }

    public fun compound<T0, T1>(arg0: &0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::launchpad::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut Vault<T0, T1>, arg4: u128, arg5: u64, arg6: u64, arg7: u128, arg8: u128, arg9: &0x2::clock::Clock) {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == arg3.pool_id, 0);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2);
        let v1 = if (arg7 > 0) {
            if (arg7 <= v0) {
                v0 <= arg8
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 3);
        assert!(arg8 - arg7 <= arg7 / 50, 3);
        assert!(arg4 > 0, 1);
        collect<T0, T1>(arg1, arg2, arg3);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg1, arg2, &mut arg3.position, arg4, arg9);
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v2);
        let v5 = if (v3 > 0) {
            if (v4 > 0) {
                if (v3 <= arg5) {
                    v4 <= arg6
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v5, 2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut arg3.balance_a, v3), 0x2::balance::split<T1>(&mut arg3.balance_b, v4), v2);
        let v6 = LiquidityCompounded{
            vault_id        : 0x2::object::id<Vault<T0, T1>>(arg3),
            amount_a        : v3,
            amount_b        : v4,
            liquidity_added : arg4,
        };
        0x2::event::emit<LiquidityCompounded>(v6);
    }

    fun create_vault<T0, T1>(arg0: 0x2::object::ID, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u128, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : Vault<T0, T1> {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(60);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3<T0, T1>(arg1, arg2, 60, arg5, 0x1::string::utf8(b""), v0, v1, arg3, arg4, arg6, arg7, arg8);
        lock_position<T0, T1>(arg0, v2, v3, v4, 0x2::coin::value<T0>(&arg3), 0x2::coin::value<T1>(&arg4), arg6, arg8)
    }

    fun existing_vault<T0, T1>(arg0: 0x2::object::ID, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u128, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : Vault<T0, T1> {
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg3) == 60, 0);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::pool_id(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::pool_simple_info(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::new_pool_key<T0, T1>(60))) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), 0);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3);
        let v1 = if (v0 > arg6) {
            v0 - arg6
        } else {
            arg6 - v0
        };
        assert!(arg6 > 0 && v1 <= arg6 / 100, 3);
        let v2 = 0x2::coin::value<T0>(&arg4);
        let v3 = 0x2::coin::value<T1>(&arg5);
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(60);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg1, arg3, v4, v5, arg9);
        let v7 = if (arg7) {
            v2
        } else {
            v3
        };
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg3, &mut v6, v7, arg7, arg8);
        let (v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v8);
        assert!(v9 <= v2 && v10 <= v3, 2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg4, v9, arg9)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg5, v10, arg9)), v8);
        lock_position<T0, T1>(arg0, v6, arg4, arg5, v2, v3, arg7, arg9)
    }

    public fun graduate_existing_token_a<T0>(arg0: &0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::launchpad::Config, arg1: &mut 0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::launchpad::Curve<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::launchpad::begin_cetus_migration<T0>(arg0, arg1, arg6);
        let v4 = existing_vault<T0, 0x2::sui::SUI>(0x2::object::id<0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::launchpad::Curve<T0>>(arg1), arg2, arg3, arg4, v1, v0, sqrt_price(v2, v3), false, arg5, arg6);
        0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::launchpad::complete_cetus_migration<T0>(arg1, v4.pool_id, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v4.position));
        0x2::transfer::share_object<Vault<T0, 0x2::sui::SUI>>(v4);
    }

    public fun graduate_existing_token_b<T0>(arg0: &0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::launchpad::Config, arg1: &mut 0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::launchpad::Curve<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::launchpad::begin_cetus_migration<T0>(arg0, arg1, arg6);
        let v4 = existing_vault<0x2::sui::SUI, T0>(0x2::object::id<0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::launchpad::Curve<T0>>(arg1), arg2, arg3, arg4, v0, v1, sqrt_price(v3, v2), true, arg5, arg6);
        0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::launchpad::complete_cetus_migration<T0>(arg1, v4.pool_id, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v4.position));
        0x2::transfer::share_object<Vault<0x2::sui::SUI, T0>>(v4);
    }

    public fun graduate_token_a<T0>(arg0: &0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::launchpad::Config, arg1: &mut 0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::launchpad::Curve<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::launchpad::begin_cetus_migration<T0>(arg0, arg1, arg5);
        let v4 = create_vault<T0, 0x2::sui::SUI>(0x2::object::id<0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::launchpad::Curve<T0>>(arg1), arg2, arg3, v1, v0, sqrt_price(v2, v3), false, arg4, arg5);
        0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::launchpad::complete_cetus_migration<T0>(arg1, v4.pool_id, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v4.position));
        0x2::transfer::share_object<Vault<T0, 0x2::sui::SUI>>(v4);
    }

    public fun graduate_token_b<T0>(arg0: &0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::launchpad::Config, arg1: &mut 0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::launchpad::Curve<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::launchpad::begin_cetus_migration<T0>(arg0, arg1, arg5);
        let v4 = create_vault<0x2::sui::SUI, T0>(0x2::object::id<0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::launchpad::Curve<T0>>(arg1), arg2, arg3, v0, v1, sqrt_price(v3, v2), true, arg4, arg5);
        0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::launchpad::complete_cetus_migration<T0>(arg1, v4.pool_id, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v4.position));
        0x2::transfer::share_object<Vault<0x2::sui::SUI, T0>>(v4);
    }

    fun lock_position<T0, T1>(arg0: 0x2::object::ID, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : Vault<T0, T1> {
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg1) > 0, 1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::coin::value<T1>(&arg3);
        let v2 = arg4 - v0;
        let v3 = arg5 - v1;
        assert!(v2 > 0 && v3 > 0, 2);
        assert!(arg6 && v0 == 0 || v1 == 0, 2);
        let v4 = Vault<T0, T1>{
            id        : 0x2::object::new(arg7),
            curve_id  : arg0,
            pool_id   : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg1),
            position  : arg1,
            balance_a : 0x2::coin::into_balance<T0>(arg2),
            balance_b : 0x2::coin::into_balance<T1>(arg3),
        };
        let v5 = LiquidityLocked{
            vault_id    : 0x2::object::id<Vault<T0, T1>>(&v4),
            curve_id    : arg0,
            pool_id     : v4.pool_id,
            position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v4.position),
            deposited_a : v2,
            deposited_b : v3,
            retained_a  : v0,
            retained_b  : v1,
        };
        0x2::event::emit<LiquidityLocked>(v5);
        v4
    }

    fun sqrt_price(arg0: u128, arg1: u128) : u128 {
        assert!(arg0 > 0 && arg1 > 0, 3);
        let v0 = ((arg0 as u256) << 128) / (arg1 as u256);
        let v1 = 340282366920938463463374607431768211456;
        let v2 = (v1 + v0 / v1) / 2;
        while (v2 < v1) {
            let v3 = v2 + v0 / v2;
            v2 = v3 / 2;
        };
        (v1 as u128)
    }

    // decompiled from Move bytecode v7
}

