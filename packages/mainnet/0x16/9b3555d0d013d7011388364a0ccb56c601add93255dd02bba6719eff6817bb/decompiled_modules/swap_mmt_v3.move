module 0xd6fe084e689afb050f683cd0d05503374ef4163bf4013d283274105d92b5c48f::swap_mmt_v3 {
    public fun swap<T0, T1, T2, T3>(arg0: 0x1::option::Option<0x2::coin::Coin<T0>>, arg1: 0x1::option::Option<0x2::coin::Coin<T1>>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::swap_transaction::SwapTransaction<T2, T3>, arg6: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::state::State, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::utils::parse_amount_and_direction<T0, T1>(&arg0, &arg1);
        let v2 = if (v1) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price()
        } else {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price()
        };
        let (v3, v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, v1, true, v0, v2, arg3, arg4, arg7);
        let v6 = v4;
        let v7 = v3;
        let v8 = if (v1) {
            0x2::coin::into_balance<T0>(0x1::option::extract<0x2::coin::Coin<T0>>(&mut arg0))
        } else {
            0x2::balance::zero<T0>()
        };
        let v9 = if (v1) {
            0x2::balance::zero<T1>()
        } else {
            0x2::coin::into_balance<T1>(0x1::option::extract<0x2::coin::Coin<T1>>(&mut arg1))
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v5, v8, v9, arg4, arg7);
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg0);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg1);
        let v10 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg2);
        let v11 = if (v1) {
            0x2::balance::value<T1>(&v6)
        } else {
            0x2::balance::value<T0>(&v7)
        };
        0xd6fe084e689afb050f683cd0d05503374ef4163bf4013d283274105d92b5c48f::swap_event::emit_common_swap<T0, T1>(0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::consts::DEX_KRIYA_CLMM(), 0x2::object::id_to_address(&v10), v1, v0, v11, true);
        (0x2::coin::from_balance<T0>(v7, arg7), 0x2::coin::from_balance<T1>(v6, arg7))
    }

    public fun swap_a2b<T0, T1, T2, T3>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::swap_transaction::SwapTransaction<T2, T3>, arg5: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::state::State, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = swap<T0, T1, T2, T3>(0x1::option::some<0x2::coin::Coin<T0>>(arg0), 0x1::option::none<0x2::coin::Coin<T1>>(), arg1, arg2, arg3, arg4, arg5, arg6);
        0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::utils::transfer_or_destroy<T0>(v0, arg6);
        v1
    }

    public fun swap_b2a<T0, T1, T2, T3>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::swap_transaction::SwapTransaction<T2, T3>, arg5: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::state::State, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = swap<T0, T1, T2, T3>(0x1::option::none<0x2::coin::Coin<T0>>(), 0x1::option::some<0x2::coin::Coin<T1>>(arg0), arg1, arg2, arg3, arg4, arg5, arg6);
        0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::utils::transfer_or_destroy<T1>(v1, arg6);
        v0
    }

    // decompiled from Move bytecode v6
}

