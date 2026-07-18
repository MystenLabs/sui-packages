module 0x1d8d657aca296b87232dfbb5f58ce882f27829fafb83bc567bc4b0ea7d5a0995::ferra_clmm {
    public fun append_model_a_to_b<T0, T1>(arg0: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg1: 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::RouteFormula) : 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::RouteFormula {
        0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::append_v3_edge(arg1, 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::liquidity<T0, T1>(arg0), 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::current_sqrt_price<T0, T1>(arg0), 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::fee_rate<T0, T1>(arg0), 1000000, true)
    }

    public fun append_model_b_to_a<T0, T1>(arg0: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg1: 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::RouteFormula) : 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::RouteFormula {
        0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::append_v3_edge(arg1, 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::liquidity<T0, T1>(arg0), 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::current_sqrt_price<T0, T1>(arg0), 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::fee_rate<T0, T1>(arg0), 1000000, false)
    }

    public fun model_a_to_b<T0, T1>(arg0: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>) : 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::RouteFormula {
        0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::v3_route(0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::liquidity<T0, T1>(arg0), 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::current_sqrt_price<T0, T1>(arg0), 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::fee_rate<T0, T1>(arg0), 1000000, true)
    }

    public fun model_b_to_a<T0, T1>(arg0: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>) : 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::RouteFormula {
        0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::v3_route(0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::liquidity<T0, T1>(arg0), 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::current_sqrt_price<T0, T1>(arg0), 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::fee_rate<T0, T1>(arg0), 1000000, false)
    }

    public fun swap_exact_in_a_to_b<T0, T1>(arg0: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg1: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&arg2), 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick_math::min_sqrt_price(), arg3);
        let v3 = v0;
        0x2::balance::join<T0>(&mut v3, arg2);
        0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::repay_flash_swap<T0, T1>(arg0, arg1, v3, 0x2::balance::zero<T1>(), v2);
        v1
    }

    public fun swap_exact_in_b_to_a<T0, T1>(arg0: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg1: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&arg2), 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick_math::max_sqrt_price(), arg3);
        let v3 = v1;
        0x2::balance::join<T1>(&mut v3, arg2);
        0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v3, v2);
        v0
    }

    // decompiled from Move bytecode v7
}

