module 0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::withdraw {
    struct WithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        liquidity_initial: u128,
        liquidity_final: u128,
        vault_coin_burnt: u64,
        withdraw_coin_a: u64,
        withdraw_coin_b: u64,
        total_supply: u64,
        sender: address,
    }

    public fun withdraw<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T2>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::version::Version, arg7: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::version::assert_supported_version(arg6);
        0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::vault::check_pool_compatibility<T0, T1, T2, T3>(arg0, arg1);
        assert!(0x2::coin::value<T2>(&arg2) > 0, 0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::error::vc_zero());
        let (v0, v1) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity::remove_liquidity<T0, T1>(arg1, 0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::vault::position_borrow_mut<T0, T1, T2, T3>(arg0), (0x2::coin::value<T2>(&arg2) as u128) * 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::liquidity(0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::vault::position_borrow<T0, T1, T2, T3>(arg0)) / (0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::vault::total_supply<T0, T1, T2, T3>(arg0) as u128), arg3, arg4, arg5, arg7, arg8);
        let v2 = v1;
        let v3 = v0;
        0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::vault::burn_vault_coin<T0, T1, T2, T3>(arg0, arg2);
        emit_event(0x2::object::id<0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::vault::Vault<T0, T1, T2, T3>>(arg0), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::liquidity(0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::vault::position_borrow<T0, T1, T2, T3>(arg0)), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::liquidity(0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::vault::position_borrow<T0, T1, T2, T3>(arg0)), 0x2::coin::value<T2>(&arg2), 0x2::coin::value<T0>(&v3), 0x2::coin::value<T1>(&v2), 0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::vault::total_supply<T0, T1, T2, T3>(arg0), 0x2::tx_context::sender(arg8));
        let v4 = 0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::vault::calc_withdraw_fee<T0, T1, T2, T3>(arg0, 0x2::coin::value<T0>(&v3));
        let v5 = 0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::vault::calc_withdraw_fee<T0, T1, T2, T3>(arg0, 0x2::coin::value<T1>(&v2));
        if (v4 > 0) {
            0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::vault::add_fee_a<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg8)));
        };
        if (v5 > 0) {
            0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::vault::add_fee_b<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v2, v5, arg8)));
        };
        assert!(0x2::coin::value<T0>(&v3) >= arg3 && 0x2::coin::value<T1>(&v2) >= arg4, 0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::error::min_receive_not_honoured());
        (v3, v2)
    }

    fun emit_event(arg0: 0x2::object::ID, arg1: u128, arg2: u128, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: address) {
        let v0 = WithdrawEvent{
            vault_id          : arg0,
            liquidity_initial : arg1,
            liquidity_final   : arg2,
            vault_coin_burnt  : arg3,
            withdraw_coin_a   : arg4,
            withdraw_coin_b   : arg5,
            total_supply      : arg6,
            sender            : arg7,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    public entry fun withdraw_entry<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T2>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x4a93c81599978a1fe875774af88a76cc918ad4320f4306699cbea874fc0c3578::version::Version, arg7: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = withdraw<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v6
}

