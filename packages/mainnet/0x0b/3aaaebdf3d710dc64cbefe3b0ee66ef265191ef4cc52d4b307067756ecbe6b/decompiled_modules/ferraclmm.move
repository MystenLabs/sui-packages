module 0xb3aaaebdf3d710dc64cbefe3b0ee66ef265191ef4cc52d4b307067756ecbe6b::ferraclmm {
    public fun swap_a2b<T0, T1>(arg0: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg1: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&arg2), 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick_math::min_sqrt_price(), arg3);
        0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), 0x2::balance::zero<T1>(), v2);
        0x2::balance::destroy_zero<T0>(v0);
        0x2::coin::from_balance<T1>(v1, arg4)
    }

    public fun swap_b2a<T0, T1>(arg0: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg1: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::coin::value<T1>(&arg2), 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick_math::max_sqrt_price(), arg3);
        0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg2), v2);
        0x2::balance::destroy_zero<T1>(v1);
        0x2::coin::from_balance<T0>(v0, arg4)
    }

    // decompiled from Move bytecode v6
}

