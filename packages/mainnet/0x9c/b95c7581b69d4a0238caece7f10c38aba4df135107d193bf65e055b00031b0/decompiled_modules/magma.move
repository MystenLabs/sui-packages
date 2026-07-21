module 0x1d8d657aca296b87232dfbb5f58ce882f27829fafb83bc567bc4b0ea7d5a0995::magma {
    public fun append_model_a_to_b<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::RouteFormula) : 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::RouteFormula {
        0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::append_v3_edge(arg1, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg0), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg0), 1000000, true)
    }

    public fun append_model_b_to_a<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::RouteFormula) : 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::RouteFormula {
        0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::append_v3_edge(arg1, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg0), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg0), 1000000, false)
    }

    public fun flash_a_to_b<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::RouteFormula, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::select_v3(arg2, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg1), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg1), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg1), 1000000, true, arg3, arg4), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::min_sqrt_price(), arg5);
        (v1, v0, v2)
    }

    public fun flash_b_to_a<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::RouteFormula, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>) {
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::select_v3(arg2, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg1), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg1), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg1), 1000000, false, arg3, arg4), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::max_sqrt_price(), arg5)
    }

    public fun model_a_to_b<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>) : 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::RouteFormula {
        0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::v3_route(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg0), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg0), 1000000, true)
    }

    public fun model_b_to_a<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>) : 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::RouteFormula {
        0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::v3_route(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg0), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg0), 1000000, false)
    }

    public fun settle_a_to_b<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T0>, arg4: 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>, arg5: &mut 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg3, 0x2::balance::split<T0>(&mut arg2, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&arg4)));
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, arg3, 0x2::balance::zero<T1>(), arg4);
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(arg5), arg2);
    }

    public fun settle_b_to_a<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: 0x2::balance::Balance<T1>, arg4: 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>, arg5: &mut 0x2::coin::Coin<T1>) {
        0x2::balance::join<T1>(&mut arg3, 0x2::balance::split<T1>(&mut arg2, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&arg4)));
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), arg3, arg4);
        0x2::balance::join<T1>(0x2::coin::balance_mut<T1>(arg5), arg2);
    }

    public fun swap_exact_in_a_to_b<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&arg2), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::min_sqrt_price(), arg3);
        let v3 = v0;
        0x2::balance::join<T0>(&mut v3, arg2);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, v3, 0x2::balance::zero<T1>(), v2);
        v1
    }

    public fun swap_exact_in_b_to_a<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&arg2), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::max_sqrt_price(), arg3);
        let v3 = v1;
        0x2::balance::join<T1>(&mut v3, arg2);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v3, v2);
        v0
    }

    // decompiled from Move bytecode v7
}

