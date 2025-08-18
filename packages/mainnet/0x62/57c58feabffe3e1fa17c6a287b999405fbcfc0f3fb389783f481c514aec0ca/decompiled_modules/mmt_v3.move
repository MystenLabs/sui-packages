module 0x6257c58feabffe3e1fa17c6a287b999405fbcfc0f3fb389783f481c514aec0ca::mmt_v3 {
    struct MagmaSwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap<T0, T1>(arg0: 0x1::option::Option<0x2::coin::Coin<T0>>, arg1: 0x1::option::Option<0x2::coin::Coin<T1>>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0x6257c58feabffe3e1fa17c6a287b999405fbcfc0f3fb389783f481c514aec0ca::utils::parse_amount_and_direction<T0, T1>(&arg0, &arg1);
        let v2 = if (v1) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price()
        } else {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price()
        };
        let (v3, v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, v1, true, v0, v2, arg3, arg4, arg5);
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
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v5, v8, v9, arg4, arg5);
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg0);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg1);
        let v10 = if (v1) {
            0x2::balance::value<T1>(&v6)
        } else {
            0x2::balance::value<T0>(&v7)
        };
        let v11 = MagmaSwapEvent{
            pool_id      : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg2),
            a2b          : v1,
            amount_in    : v0,
            amount_out   : v10,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<MagmaSwapEvent>(v11);
        (0x2::coin::from_balance<T0>(v7, arg5), 0x2::coin::from_balance<T1>(v6, arg5))
    }

    public fun swap_a2b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        swap<T0, T1>(0x1::option::some<0x2::coin::Coin<T0>>(arg0), 0x1::option::none<0x2::coin::Coin<T1>>(), arg1, arg2, arg3, arg4)
    }

    public fun swap_b2a<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        swap<T0, T1>(0x1::option::none<0x2::coin::Coin<T0>>(), 0x1::option::some<0x2::coin::Coin<T1>>(arg0), arg1, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

