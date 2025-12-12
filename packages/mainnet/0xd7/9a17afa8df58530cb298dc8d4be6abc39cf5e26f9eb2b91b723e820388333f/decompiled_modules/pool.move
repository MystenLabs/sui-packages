module 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::pool {
    struct LiquidityPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin_a_reserve: 0x2::balance::Balance<T0>,
        coin_b_reserve: 0x2::balance::Balance<T1>,
        lp_supply: u64,
        fee_bps: u64,
        admin: address,
        is_paused: bool,
        k_last: u64,
    }

    struct LPToken<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        balance: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut LiquidityPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::pool_paused());
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::zero_amount());
        assert!(v1 > 0, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::zero_amount());
        let v2 = if (arg0.lp_supply == 0) {
            let v3 = 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::math::sqrt(v0 * v1);
            assert!(v3 > 1000, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::insufficient_liquidity_minted());
            v3 - 1000
        } else {
            let v4 = 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::math::mul_div(v0, arg0.lp_supply, 0x2::balance::value<T0>(&arg0.coin_a_reserve));
            let v5 = 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::math::mul_div(v1, arg0.lp_supply, 0x2::balance::value<T1>(&arg0.coin_b_reserve));
            if (v4 < v5) {
                v4
            } else {
                v5
            }
        };
        assert!(v2 >= arg3, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::slippage_exceeded());
        assert!(v2 > 0, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::insufficient_liquidity_minted());
        0x2::balance::join<T0>(&mut arg0.coin_a_reserve, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.coin_b_reserve, 0x2::coin::into_balance<T1>(arg2));
        arg0.lp_supply = arg0.lp_supply + v2;
        let v6 = LPToken<T0, T1>{
            id      : 0x2::object::new(arg5),
            pool_id : 0x2::object::id<LiquidityPool<T0, T1>>(arg0),
            balance : v2,
        };
        0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::events::emit_liquidity_added<T0, T1>(0x2::object::id<LiquidityPool<T0, T1>>(arg0), 0x2::tx_context::sender(arg5), v0, v1, v2, 0x2::clock::timestamp_ms(arg4));
        0x2::transfer::transfer<LPToken<T0, T1>>(v6, 0x2::tx_context::sender(arg5));
    }

    public entry fun create_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        create_pool_with_fee<T0, T1>(arg0, arg1, 30, arg2, arg3);
    }

    public entry fun create_pool_with_fee<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::coin::value<T1>(&arg1);
        let v2 = 0x2::tx_context::sender(arg4);
        assert!(v0 > 0, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::zero_amount());
        assert!(v1 > 0, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::zero_amount());
        assert!(arg2 <= 1000, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::invalid_pool_ratio());
        let v3 = LiquidityPool<T0, T1>{
            id             : 0x2::object::new(arg4),
            coin_a_reserve : 0x2::coin::into_balance<T0>(arg0),
            coin_b_reserve : 0x2::coin::into_balance<T1>(arg1),
            lp_supply      : 0,
            fee_bps        : arg2,
            admin          : v2,
            is_paused      : false,
            k_last         : 0,
        };
        let v4 = 0x2::object::id<LiquidityPool<T0, T1>>(&v3);
        let v5 = AdminCap{
            id      : 0x2::object::new(arg4),
            pool_id : v4,
        };
        0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::events::emit_pool_created<T0, T1>(v4, v0, v1, v2, arg2, 0x2::clock::timestamp_ms(arg3));
        0x2::transfer::transfer<AdminCap>(v5, v2);
        0x2::transfer::share_object<LiquidityPool<T0, T1>>(v3);
    }

    public fun get_fee_bps<T0, T1>(arg0: &LiquidityPool<T0, T1>) : u64 {
        arg0.fee_bps
    }

    public fun get_lp_supply<T0, T1>(arg0: &LiquidityPool<T0, T1>) : u64 {
        arg0.lp_supply
    }

    public fun get_reserves<T0, T1>(arg0: &LiquidityPool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_a_reserve), 0x2::balance::value<T1>(&arg0.coin_b_reserve))
    }

    public fun is_paused<T0, T1>(arg0: &LiquidityPool<T0, T1>) : bool {
        arg0.is_paused
    }

    public fun lp_token_balance<T0, T1>(arg0: &LPToken<T0, T1>) : u64 {
        arg0.balance
    }

    public entry fun pause_pool<T0, T1>(arg0: &mut LiquidityPool<T0, T1>, arg1: &AdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.is_paused = false;
        0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::events::emit_pool_unpaused(0x2::object::id<LiquidityPool<T0, T1>>(arg0), 0x2::tx_context::sender(arg3), 0x2::clock::timestamp_ms(arg2));
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut LiquidityPool<T0, T1>, arg1: LPToken<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let LPToken {
            id      : v0,
            pool_id : _,
            balance : v2,
        } = arg1;
        0x2::object::delete(v0);
        assert!(v2 > 0, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::zero_amount());
        assert!(arg0.lp_supply >= v2, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::insufficient_lp_tokens());
        let v3 = 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::math::mul_div(v2, 0x2::balance::value<T0>(&arg0.coin_a_reserve), arg0.lp_supply);
        let v4 = 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::math::mul_div(v2, 0x2::balance::value<T1>(&arg0.coin_b_reserve), arg0.lp_supply);
        assert!(v3 >= arg2, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::insufficient_a_amount());
        assert!(v4 >= arg3, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::insufficient_b_amount());
        arg0.lp_supply = arg0.lp_supply - v2;
        0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::events::emit_liquidity_removed<T0, T1>(0x2::object::id<LiquidityPool<T0, T1>>(arg0), 0x2::tx_context::sender(arg5), v3, v4, v2, 0x2::clock::timestamp_ms(arg4));
        let v5 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a_reserve, v3), arg5), v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b_reserve, v4), arg5), v5);
    }

    public entry fun swap_a_to_b<T0, T1>(arg0: &mut LiquidityPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::pool_paused());
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::zero_amount());
        let v1 = 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::math::get_amount_out(v0, 0x2::balance::value<T0>(&arg0.coin_a_reserve), 0x2::balance::value<T1>(&arg0.coin_b_reserve), arg0.fee_bps);
        assert!(v1 >= arg2, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::slippage_exceeded());
        assert!(v1 > 0, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::insufficient_output_amount());
        0x2::balance::join<T0>(&mut arg0.coin_a_reserve, 0x2::coin::into_balance<T0>(arg1));
        0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::events::emit_swap_executed<T0, T1>(0x2::object::id<LiquidityPool<T0, T1>>(arg0), 0x2::tx_context::sender(arg4), v0, v1, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::math::mul_div(v0, arg0.fee_bps, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::math::basis_points()), 0x2::clock::timestamp_ms(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b_reserve, v1), arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun swap_b_to_a<T0, T1>(arg0: &mut LiquidityPool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::pool_paused());
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::zero_amount());
        let v1 = 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::math::get_amount_out(v0, 0x2::balance::value<T1>(&arg0.coin_b_reserve), 0x2::balance::value<T0>(&arg0.coin_a_reserve), arg0.fee_bps);
        assert!(v1 >= arg2, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::slippage_exceeded());
        assert!(v1 > 0, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::insufficient_output_amount());
        0x2::balance::join<T1>(&mut arg0.coin_b_reserve, 0x2::coin::into_balance<T1>(arg1));
        0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::events::emit_swap_executed<T1, T0>(0x2::object::id<LiquidityPool<T0, T1>>(arg0), 0x2::tx_context::sender(arg4), v0, v1, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::math::mul_div(v0, arg0.fee_bps, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::math::basis_points()), 0x2::clock::timestamp_ms(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a_reserve, v1), arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun unpause_pool<T0, T1>(arg0: &mut LiquidityPool<T0, T1>, arg1: &AdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.is_paused = false;
        0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::events::emit_pool_unpaused(0x2::object::id<LiquidityPool<T0, T1>>(arg0), 0x2::tx_context::sender(arg3), 0x2::clock::timestamp_ms(arg2));
    }

    // decompiled from Move bytecode v6
}

