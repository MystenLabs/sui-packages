module 0xa730a651c536b4efdd4ca10628e98d2287957439a3dd4cd096790cc525b9b114::withdraw {
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

    public fun withdraw<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0xa730a651c536b4efdd4ca10628e98d2287957439a3dd4cd096790cc525b9b114::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T2>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xa730a651c536b4efdd4ca10628e98d2287957439a3dd4cd096790cc525b9b114::version::Version, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xa730a651c536b4efdd4ca10628e98d2287957439a3dd4cd096790cc525b9b114::version::assert_supported_version(arg6);
        0xa730a651c536b4efdd4ca10628e98d2287957439a3dd4cd096790cc525b9b114::vault::check_pool_compatibility<T0, T1, T2, T3>(arg0, arg1);
        0xa730a651c536b4efdd4ca10628e98d2287957439a3dd4cd096790cc525b9b114::vault::when_not_paused<T0, T1, T2, T3>(arg0);
        assert!(0x2::coin::value<T2>(&arg2) > 0, 0xa730a651c536b4efdd4ca10628e98d2287957439a3dd4cd096790cc525b9b114::error::vc_zero());
        assert!(!0xa730a651c536b4efdd4ca10628e98d2287957439a3dd4cd096790cc525b9b114::vault::is_locked<T0, T1, T2, T3>(arg0), 0xa730a651c536b4efdd4ca10628e98d2287957439a3dd4cd096790cc525b9b114::error::vault_locked());
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::remove_liquidity<T0, T1>(arg1, 0xa730a651c536b4efdd4ca10628e98d2287957439a3dd4cd096790cc525b9b114::vault::position_borrow_mut<T0, T1, T2, T3>(arg0), (0x2::coin::value<T2>(&arg2) as u128) * 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(0xa730a651c536b4efdd4ca10628e98d2287957439a3dd4cd096790cc525b9b114::vault::position_borrow<T0, T1, T2, T3>(arg0)) / (0xa730a651c536b4efdd4ca10628e98d2287957439a3dd4cd096790cc525b9b114::vault::total_supply<T0, T1, T2, T3>(arg0) as u128), arg3, arg4, arg5, arg7, arg8);
        let v2 = v1;
        let v3 = v0;
        0xa730a651c536b4efdd4ca10628e98d2287957439a3dd4cd096790cc525b9b114::vault::burn_vault_coin<T0, T1, T2, T3>(arg0, arg2);
        emit_event(0x2::object::id<0xa730a651c536b4efdd4ca10628e98d2287957439a3dd4cd096790cc525b9b114::vault::Vault<T0, T1, T2, T3>>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(0xa730a651c536b4efdd4ca10628e98d2287957439a3dd4cd096790cc525b9b114::vault::position_borrow<T0, T1, T2, T3>(arg0)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(0xa730a651c536b4efdd4ca10628e98d2287957439a3dd4cd096790cc525b9b114::vault::position_borrow<T0, T1, T2, T3>(arg0)), 0x2::coin::value<T2>(&arg2), 0x2::coin::value<T0>(&v3), 0x2::coin::value<T1>(&v2), 0xa730a651c536b4efdd4ca10628e98d2287957439a3dd4cd096790cc525b9b114::vault::total_supply<T0, T1, T2, T3>(arg0), 0x2::tx_context::sender(arg8));
        let v4 = 0xa730a651c536b4efdd4ca10628e98d2287957439a3dd4cd096790cc525b9b114::vault::calc_withdraw_fee<T0, T1, T2, T3>(arg0, 0x2::coin::value<T0>(&v3));
        let v5 = 0xa730a651c536b4efdd4ca10628e98d2287957439a3dd4cd096790cc525b9b114::vault::calc_withdraw_fee<T0, T1, T2, T3>(arg0, 0x2::coin::value<T1>(&v2));
        if (v4 > 0) {
            0xa730a651c536b4efdd4ca10628e98d2287957439a3dd4cd096790cc525b9b114::vault::add_fee_a<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg8)));
        };
        if (v5 > 0) {
            0xa730a651c536b4efdd4ca10628e98d2287957439a3dd4cd096790cc525b9b114::vault::add_fee_b<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v2, v5, arg8)));
        };
        assert!(0x2::coin::value<T0>(&v3) >= arg3 && 0x2::coin::value<T1>(&v2) >= arg4, 0xa730a651c536b4efdd4ca10628e98d2287957439a3dd4cd096790cc525b9b114::error::min_receive_not_honoured());
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

    public entry fun withdraw_entry<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0xa730a651c536b4efdd4ca10628e98d2287957439a3dd4cd096790cc525b9b114::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T2>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xa730a651c536b4efdd4ca10628e98d2287957439a3dd4cd096790cc525b9b114::version::Version, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = withdraw<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v6
}

