module 0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::deposit {
    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        liquidity_initial: u128,
        liquidity_final: u128,
        vault_coin_minted: u64,
        lp_coin_a: u64,
        lp_coin_b: u64,
        total_supply: u64,
        sender: address,
    }

    public fun deposit<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &0x7903ed759a2e2749ecdb64a8f100b0a547185f2ef7ea286048aa1f174c8a8b9a::oracle::KriyaOracle, arg7: &0x2::clock::Clock, arg8: &0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::version::Version, arg9: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x1::option::Option<0x2::coin::Coin<T0>>, 0x1::option::Option<0x2::coin::Coin<T1>>) {
        0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::version::assert_supported_version(arg8);
        0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::vault::check_pool_compatibility<T0, T1, T2, T3>(arg0, arg1);
        assert!(0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::vault::seed_balance<T0, T1, T2, T3>(arg0) > 0, 0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::error::vault_non_seeded());
        assert!(0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::vault::is_deposit_enabled<T0, T1, T2, T3>(arg0), 0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::error::deposit_disabled());
        assert!(!0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::vault::is_locked<T0, T1, T2, T3>(arg0), 0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::error::vault_locked());
        let (v0, v1) = 0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::vault::get_position_tick_range<T0, T1, T2, T3>(arg0);
        let v2 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::tick_index_current<T0, T1>(arg1);
        let (v3, v4) = if (0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::lt(v2, v0)) {
            (0x2::coin::value<T0>(&arg2), 0)
        } else if (0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::gte(v2, v1)) {
            (0, 0x2::coin::value<T1>(&arg3))
        } else {
            let (_, v6, v7) = 0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::utils::check_is_fix_coin_a(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v0), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v1), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg1), 0x2::coin::value<T0>(&arg2), 0x2::coin::value<T1>(&arg3));
            (v6, v7)
        };
        assert!(v3 >= arg4, 0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::error::min_deposit_a_not_satisfied());
        assert!(v4 >= arg5, 0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::error::min_deposit_b_not_satisfied());
        let v8 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::liquidity(0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::vault::position_borrow<T0, T1, T2, T3>(arg0));
        let (v9, v10) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity::add_liquidity<T0, T1>(arg1, 0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::vault::position_borrow_mut<T0, T1, T2, T3>(arg0), 0x2::coin::split<T0>(&mut arg2, v3, arg10), 0x2::coin::split<T1>(&mut arg3, v4, arg10), 0, 0, arg7, arg9, arg10);
        let v11 = v10;
        let v12 = v9;
        check_deposit_limit<T0, T1, T2, T3>(arg0, arg1, arg6, arg7);
        0x2::coin::join<T0>(&mut arg2, v12);
        0x2::coin::join<T1>(&mut arg3, v11);
        let v13 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::liquidity(0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::vault::position_borrow<T0, T1, T2, T3>(arg0));
        let v14 = 0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::vault::mint_vault_coin<T0, T1, T2, T3>(arg0, v13 - v8, v8, arg10);
        emit_event(0x2::object::id<0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::vault::Vault<T0, T1, T2, T3>>(arg0), v8, v13, 0x2::coin::value<T2>(&v14), v3 - 0x2::coin::value<T0>(&v12), v4 - 0x2::coin::value<T1>(&v11), 0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::vault::total_supply<T0, T1, T2, T3>(arg0), 0x2::tx_context::sender(arg10));
        (v14, destroy_if_zero<T0>(arg2), destroy_if_zero<T1>(arg3))
    }

    fun check_deposit_limit<T0, T1, T2, T3: copy + drop + store>(arg0: &0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::vault::Vault<T0, T1, T2, T3>, arg1: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0x7903ed759a2e2749ecdb64a8f100b0a547185f2ef7ea286048aa1f174c8a8b9a::oracle::KriyaOracle, arg3: &0x2::clock::Clock) {
        let v0 = 0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::vault::deposit_limit<T0, T1, T2, T3>(arg0);
        if (v0 > 0) {
            let (v1, v2) = 0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::vault::get_position_assets<T0, T1, T2, T3>(arg0, arg1);
            let (v3, v4) = 0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::vault::decimals<T0, T1, T2, T3>(arg0);
            assert!((((0x7903ed759a2e2749ecdb64a8f100b0a547185f2ef7ea286048aa1f174c8a8b9a::oracle::get_price(arg2, 0x1::type_name::get<T0>(), arg3) as u128) * (v1 as u128) / (0x2::math::pow(10, v3) as u128)) as u64) + (((0x7903ed759a2e2749ecdb64a8f100b0a547185f2ef7ea286048aa1f174c8a8b9a::oracle::get_price(arg2, 0x1::type_name::get<T1>(), arg3) as u128) * (v2 as u128) / (0x2::math::pow(10, v4) as u128)) as u64) <= v0, 0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::error::deposit_limit_reached());
        };
    }

    public entry fun deposit_entry<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &0x7903ed759a2e2749ecdb64a8f100b0a547185f2ef7ea286048aa1f174c8a8b9a::oracle::KriyaOracle, arg7: &0x2::clock::Clock, arg8: &0xec00703df008c19f9a32fd2ac99327757a3578bad53c026273248d0b2830eeb::version::Version, arg9: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = deposit<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v3 = v2;
        let v4 = v1;
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&v4)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::extract<0x2::coin::Coin<T0>>(&mut v4), 0x2::tx_context::sender(arg10));
        };
        if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v3)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x1::option::extract<0x2::coin::Coin<T1>>(&mut v3), 0x2::tx_context::sender(arg10));
        };
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(v4);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg10));
    }

    fun destroy_if_zero<T0>(arg0: 0x2::coin::Coin<T0>) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        let v0 = 0x1::option::none<0x2::coin::Coin<T0>>();
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x1::option::fill<0x2::coin::Coin<T0>>(&mut v0, arg0);
        };
        v0
    }

    fun emit_event(arg0: 0x2::object::ID, arg1: u128, arg2: u128, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: address) {
        let v0 = DepositEvent{
            vault_id          : arg0,
            liquidity_initial : arg1,
            liquidity_final   : arg2,
            vault_coin_minted : arg3,
            lp_coin_a         : arg4,
            lp_coin_b         : arg5,
            total_supply      : arg6,
            sender            : arg7,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

