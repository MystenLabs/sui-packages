module 0x5e5f69b1b5a56c8a926881d14a9a542c4a382c4280d1b3228c51e58cb68bc8aa::withdraw {
    struct WithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        liquidity_initial: u128,
        liquidity_final: u128,
        vault_coin_burnt: u64,
        withdraw_coin_a: u64,
        withdraw_coin_b: u64,
    }

    public fun withdraw<T0, T1, T2>(arg0: &mut 0x5e5f69b1b5a56c8a926881d14a9a542c4a382c4280d1b3228c51e58cb68bc8aa::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: 0x2::coin::Coin<T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T2>(&arg3) > 0, 0);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg2, arg1, 0x5e5f69b1b5a56c8a926881d14a9a542c4a382c4280d1b3228c51e58cb68bc8aa::vault::position_borrow_mut<T0, T1, T2>(arg0), (0x2::coin::value<T2>(&arg3) as u128) * 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x5e5f69b1b5a56c8a926881d14a9a542c4a382c4280d1b3228c51e58cb68bc8aa::vault::position_borrow<T0, T1, T2>(arg0)) / (0x5e5f69b1b5a56c8a926881d14a9a542c4a382c4280d1b3228c51e58cb68bc8aa::vault::total_supply<T0, T1, T2>(arg0) as u128), arg4);
        let v2 = v1;
        let v3 = v0;
        0x5e5f69b1b5a56c8a926881d14a9a542c4a382c4280d1b3228c51e58cb68bc8aa::vault::burn_vault_coin<T0, T1, T2>(arg0, arg3);
        emit_event(0x2::object::id<0x5e5f69b1b5a56c8a926881d14a9a542c4a382c4280d1b3228c51e58cb68bc8aa::vault::Vault<T0, T1, T2>>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x5e5f69b1b5a56c8a926881d14a9a542c4a382c4280d1b3228c51e58cb68bc8aa::vault::position_borrow<T0, T1, T2>(arg0)), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x5e5f69b1b5a56c8a926881d14a9a542c4a382c4280d1b3228c51e58cb68bc8aa::vault::position_borrow<T0, T1, T2>(arg0)), 0x2::coin::value<T2>(&arg3), 0x2::balance::value<T0>(&v3), 0x2::balance::value<T1>(&v2));
        0x5e5f69b1b5a56c8a926881d14a9a542c4a382c4280d1b3228c51e58cb68bc8aa::vault::add_fee_a<T0, T1, T2>(arg0, 0x2::balance::split<T0>(&mut v3, 0x5e5f69b1b5a56c8a926881d14a9a542c4a382c4280d1b3228c51e58cb68bc8aa::vault::calc_fee<T0, T1, T2>(arg0, 0x2::balance::value<T0>(&v3))));
        0x5e5f69b1b5a56c8a926881d14a9a542c4a382c4280d1b3228c51e58cb68bc8aa::vault::add_fee_b<T0, T1, T2>(arg0, 0x2::balance::split<T1>(&mut v2, 0x5e5f69b1b5a56c8a926881d14a9a542c4a382c4280d1b3228c51e58cb68bc8aa::vault::calc_fee<T0, T1, T2>(arg0, 0x2::balance::value<T1>(&v2))));
        (0x2::coin::from_balance<T0>(v3, arg5), 0x2::coin::from_balance<T1>(v2, arg5))
    }

    fun emit_event(arg0: 0x2::object::ID, arg1: u128, arg2: u128, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = WithdrawEvent{
            vault_id          : arg0,
            liquidity_initial : arg1,
            liquidity_final   : arg2,
            vault_coin_burnt  : arg3,
            withdraw_coin_a   : arg4,
            withdraw_coin_b   : arg5,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    public entry fun withdraw_entry<T0, T1, T2>(arg0: &mut 0x5e5f69b1b5a56c8a926881d14a9a542c4a382c4280d1b3228c51e58cb68bc8aa::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: 0x2::coin::Coin<T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = withdraw<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

