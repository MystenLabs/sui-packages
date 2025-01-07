module 0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::deposit {
    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        liquidity_initial: u128,
        liquidity_final: u128,
        vault_coin_minted: u64,
        lp_coin_a: u64,
        lp_coin_b: u64,
        sender: address,
    }

    public fun deposit<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::version::Version, arg8: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x1::option::Option<0x2::coin::Coin<T0>>, 0x1::option::Option<0x2::coin::Coin<T1>>) {
        0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::version::assert_supported_version(arg7);
        0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::vault::check_pool_compatibility<T0, T1, T2, T3>(arg0, arg1);
        assert!(0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::vault::seed_balance<T0, T1, T2, T3>(arg0) > 0, 4);
        assert!(0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::vault::is_deposit_enabled<T0, T1, T2, T3>(arg0), 7);
        let (v0, v1) = 0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::vault::get_position_tick_range<T0, T1, T2, T3>(arg0);
        let v2 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::tick_index_current<T0, T1>(arg1);
        let (v3, v4) = if (0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::lt(v2, v0)) {
            (0x2::coin::value<T0>(&arg2), 0)
        } else if (0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::gte(v2, v1)) {
            (0, 0x2::coin::value<T1>(&arg3))
        } else {
            let (_, v6, v7) = 0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::utils::check_is_fix_coin_a(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v0), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v1), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg1), 0x2::coin::value<T0>(&arg2), 0x2::coin::value<T1>(&arg3));
            (v6, v7)
        };
        assert!(v3 >= arg4, 5);
        assert!(v4 >= arg5, 6);
        let v8 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::liquidity(0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::vault::position_borrow<T0, T1, T2, T3>(arg0));
        let (v9, v10) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity::add_liquidity<T0, T1>(arg1, 0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::vault::position_borrow_mut<T0, T1, T2, T3>(arg0), 0x2::coin::split<T0>(&mut arg2, v3, arg9), 0x2::coin::split<T1>(&mut arg3, v4, arg9), 0, 0, arg6, arg8, arg9);
        let v11 = v10;
        let v12 = v9;
        0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::vault::add_free_balance_a<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T0>(v12));
        0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::vault::add_free_balance_b<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T1>(v11));
        let v13 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::liquidity(0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::vault::position_borrow<T0, T1, T2, T3>(arg0));
        let v14 = 0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::vault::mint_vault_coin<T0, T1, T2, T3>(arg0, v13 - v8, v8, arg9);
        emit_event(0x2::object::id<0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::vault::Vault<T0, T1, T2, T3>>(arg0), v8, v13, 0x2::coin::value<T2>(&v14), v3 - 0x2::coin::value<T0>(&v12), v4 - 0x2::coin::value<T1>(&v11), 0x2::tx_context::sender(arg9));
        (v14, destroy_if_zero<T0>(arg2), destroy_if_zero<T1>(arg3))
    }

    public entry fun deposit_entry<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x51d244c821eca47420040cf33506dc044c388d75120b0d3ab19b09d4a2e37d28::version::Version, arg8: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = deposit<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v3 = v2;
        let v4 = v1;
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&v4)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::extract<0x2::coin::Coin<T0>>(&mut v4), 0x2::tx_context::sender(arg9));
        };
        if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v3)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x1::option::extract<0x2::coin::Coin<T1>>(&mut v3), 0x2::tx_context::sender(arg9));
        };
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(v4);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg9));
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

    fun emit_event(arg0: 0x2::object::ID, arg1: u128, arg2: u128, arg3: u64, arg4: u64, arg5: u64, arg6: address) {
        let v0 = DepositEvent{
            vault_id          : arg0,
            liquidity_initial : arg1,
            liquidity_final   : arg2,
            vault_coin_minted : arg3,
            lp_coin_a         : arg4,
            lp_coin_b         : arg5,
            sender            : arg6,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

