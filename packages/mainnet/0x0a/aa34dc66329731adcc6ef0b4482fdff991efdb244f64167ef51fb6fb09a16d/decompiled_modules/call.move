module 0xaaa34dc66329731adcc6ef0b4482fdff991efdb244f64167ef51fb6fb09a16d::call {
    public entry fun add_liquidity<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let (v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::add_liquidity<T0, T1>(arg0, arg2, arg3, arg4, 0, 0, arg5, arg1, arg6);
        let v3 = v2;
        let v4 = v1;
        if (0x2::coin::value<T0>(&v4) == 0) {
            0x2::coin::destroy_zero<T0>(v4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, v0);
        };
        if (0x2::coin::value<T1>(&v3) == 0) {
            0x2::coin::destroy_zero<T1>(v3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, v0);
        };
    }

    public entry fun buy<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let (v1, v2) = buy_internal<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T1>(arg3), arg4, arg5);
        let v3 = v2;
        if (0x2::balance::value<T1>(&v3) == 0) {
            0x2::balance::destroy_zero<T1>(v3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg5), v0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg5), v0);
    }

    fun buy_internal<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, false, true, arg4, 79226673515401279992447579050, arg2, arg1, arg5);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (_, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, v5), arg1, arg5);
        (v0, arg3)
    }

    public entry fun close_position(arg0: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::close_position(arg0, arg1, arg2);
    }

    public entry fun collect_reward<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::is_empty(arg1), 111);
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T0, T1>(arg0, arg1, arg3, arg2, arg4);
        let v2 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v2);
    }

    public entry fun open_position<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: u16, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0);
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_spacing<T0, T1>(arg0));
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_tick_at_sqrt_price(v0 / 10000 * (arg2 as u128));
        let v3 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_tick_at_sqrt_price(v0 / 10000 * (arg3 as u128));
        0x2::transfer::public_transfer<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::open_position<T0, T1>(arg0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::sub(v2, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::mod(v2, v1)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::sub(v3, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::mod(v3, v1)), arg1, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let (v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::remove_liquidity<T0, T1>(arg0, arg1, arg3, 0, 0, arg4, arg2, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, v0);
    }

    public entry fun remove_liquidity_and_buy<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let (v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::remove_liquidity<T0, T1>(arg0, arg1, arg3, 0, 0, arg4, arg2, arg5);
        let v3 = v2;
        let (v4, v5) = buy_internal<T0, T1>(arg0, arg2, arg4, 0x2::coin::into_balance<T1>(v3), 0x2::coin::value<T1>(&v3), arg5);
        let v6 = v5;
        let v7 = v4;
        if (0x2::balance::value<T1>(&v6) == 0) {
            0x2::balance::destroy_zero<T1>(v6);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v6, arg5), v0);
        };
        0x2::balance::join<T0>(&mut v7, 0x2::coin::into_balance<T0>(v1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg5), v0);
    }

    public entry fun sell<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let (v1, v2) = sell_internal<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg3), arg4, arg5);
        let v3 = v1;
        if (0x2::balance::value<T0>(&v3) == 0) {
            0x2::balance::destroy_zero<T0>(v3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg5), v0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg5), v0);
    }

    public entry fun sell_and_add_liquidity<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let (v1, v2) = sell_internal<T0, T1>(arg1, arg2, arg3, 0x2::coin::into_balance<T0>(arg4), arg5 / 2, arg6);
        let (v3, v4) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::add_liquidity<T0, T1>(arg1, arg0, 0x2::coin::from_balance<T0>(v1, arg6), 0x2::coin::from_balance<T1>(v2, arg6), 0, 0, arg3, arg2, arg6);
        let v5 = v4;
        let v6 = v3;
        if (0x2::coin::value<T0>(&v6) == 0) {
            0x2::coin::destroy_zero<T0>(v6);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, v0);
        };
        if (0x2::coin::value<T1>(&v5) == 0) {
            0x2::coin::destroy_zero<T1>(v5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, v0);
        };
    }

    fun sell_internal<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, true, true, arg4, 4295048017, arg2, arg1, arg5);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::balance::split<T0>(&mut arg3, v4), 0x2::balance::zero<T1>(), arg1, arg5);
        (arg3, v1)
    }

    // decompiled from Move bytecode v6
}

