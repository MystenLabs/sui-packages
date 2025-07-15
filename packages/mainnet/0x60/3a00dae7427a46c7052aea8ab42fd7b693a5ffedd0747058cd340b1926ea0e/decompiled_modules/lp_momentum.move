module 0x603a00dae7427a46c7052aea8ab42fd7b693a5ffedd0747058cd340b1926ea0e::lp_momentum {
    struct MomentumWitness has drop {
        dummy_field: bool,
    }

    public fun rebalance<T0, T1>(arg0: &0x89c356890981b86e1416e2ab9eb76f770ef638610ce5e40dcc287711cc6c660c::registry::Registry, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg4: u32, arg5: u32, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position) {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(&arg3);
        let (v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::remove_liquidity<T0, T1>(arg2, &mut arg3, v0, 0, 0, arg8, arg1, arg9);
        let (v3, v4) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T0, T1>(arg2, &mut arg3, arg8, arg1, arg9);
        let v5 = 0x2::coin::into_balance<T1>(v2);
        let v6 = 0x2::coin::into_balance<T0>(v1);
        let v7 = 0x2::coin::into_balance<T1>(v4);
        let v8 = 0x2::coin::into_balance<T0>(v3);
        if (arg7) {
            0x2::balance::join<T0>(&mut v6, 0x2::balance::withdraw_all<T0>(&mut v8));
            0x2::balance::join<T1>(&mut v5, 0x2::balance::withdraw_all<T1>(&mut v7));
        };
        let v9 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::open_position<T0, T1>(arg2, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg4), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg5), arg1, arg9);
        let v10 = &mut v9;
        let (v11, v12) = zap_in_int<T0, T1>(arg1, arg2, v10, v6, v5, arg6, arg8, arg9);
        let v13 = v12;
        let v14 = v11;
        0x89c356890981b86e1416e2ab9eb76f770ef638610ce5e40dcc287711cc6c660c::events::emit_rebalanced<MomentumWitness>(arg0, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg2), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg3), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&v9), 0x2::balance::value<T0>(&v6), 0x2::balance::value<T1>(&v5), 0x2::balance::value<T0>(&v14), 0x2::balance::value<T1>(&v13), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_lower_index(&arg3)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_upper_index(&arg3)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_lower_index(&v9)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_upper_index(&v9)), v0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(&v9));
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::close_position(arg3, arg1, arg9);
        0x2::balance::join<T0>(&mut v14, v8);
        0x2::balance::join<T1>(&mut v13, v7);
        (0x2::coin::from_balance<T0>(v14, arg9), 0x2::coin::from_balance<T1>(v13, arg9), v9)
    }

    fun swap_to_optimal<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2, _) = 0x603a00dae7427a46c7052aea8ab42fd7b693a5ffedd0747058cd340b1926ea0e::swap_math::optimal_swap<T0, T1>(arg1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_lower_index(arg2)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_upper_index(arg2)), 0x2::balance::value<T0>(&arg3), 0x2::balance::value<T1>(&arg4));
        if (v0 == 0 && v1 == 0) {
            return (arg3, arg4)
        };
        let v4 = if (v2) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price() + 1
        } else {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price() - 1
        };
        let (v5, v6, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, v2, true, v0, v4, arg6, arg0, arg7);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        if (v2) {
            assert!(0x2::balance::value<T1>(&v9) >= 0x89c356890981b86e1416e2ab9eb76f770ef638610ce5e40dcc287711cc6c660c::constants::amount_after_fee(v1, arg5), 1);
        } else {
            assert!(0x2::balance::value<T0>(&v10) >= 0x89c356890981b86e1416e2ab9eb76f770ef638610ce5e40dcc287711cc6c660c::constants::amount_after_fee(v1, arg5), 1);
        };
        let (v11, v12) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v8);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v8, 0x2::balance::split<T0>(&mut arg3, v11), 0x2::balance::split<T1>(&mut arg4, v12), arg0, arg7);
        0x2::balance::join<T0>(&mut arg3, v10);
        0x2::balance::join<T1>(&mut arg4, v9);
        (arg3, arg4)
    }

    public fun zap_in<T0, T1>(arg0: &0x89c356890981b86e1416e2ab9eb76f770ef638610ce5e40dcc287711cc6c660c::registry::Registry, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = zap_in_int<T0, T1>(arg1, arg2, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), arg6, arg7, arg8);
        let v2 = v1;
        let v3 = v0;
        0x89c356890981b86e1416e2ab9eb76f770ef638610ce5e40dcc287711cc6c660c::events::emit_zapped_in<MomentumWitness>(arg0, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg2), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg3), 0x2::balance::value<T0>(&v3), 0x2::balance::value<T1>(&v2));
        (0x2::coin::from_balance<T0>(v3, arg8), 0x2::coin::from_balance<T1>(v2, arg8))
    }

    fun zap_in_int<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = swap_to_optimal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = v1;
        let v3 = v0;
        assert!(0x2::balance::value<T0>(&v3) > 0 || 0x2::balance::value<T1>(&v2) > 0, 0);
        let (v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::add_liquidity<T0, T1>(arg1, arg2, 0x2::coin::from_balance<T0>(v3, arg7), 0x2::coin::from_balance<T1>(v2, arg7), 0, 0, arg6, arg0, arg7);
        (0x2::coin::into_balance<T0>(v4), 0x2::coin::into_balance<T1>(v5))
    }

    // decompiled from Move bytecode v6
}

