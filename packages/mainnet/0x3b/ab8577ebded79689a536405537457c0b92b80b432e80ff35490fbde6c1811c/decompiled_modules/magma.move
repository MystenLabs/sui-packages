module 0x109a6beef3ac427eb06276404d6b3dee87c5fca28851756b535dc81f63b00d9a::magma {
    struct DeferredReceipt<phantom T0, phantom T1> {
        repay_a: 0x2::balance::Balance<T0>,
        repay_b: 0x2::balance::Balance<T1>,
        receipt: 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>,
        amount: u64,
        a_to_b: bool,
    }

    fun append_model<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &mut 0x3ee7be8b6bf110d3216162c35484336e76cddaf8b60fdb8818c067c000a28f34::optimizer::RouteFormula, arg2: bool) {
        0x3ee7be8b6bf110d3216162c35484336e76cddaf8b60fdb8818c067c000a28f34::optimizer::append_v3_edge(arg1, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg0), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg0), 1000000, arg2);
    }

    public fun append_model_a_to_b<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &mut 0x3ee7be8b6bf110d3216162c35484336e76cddaf8b60fdb8818c067c000a28f34::optimizer::RouteFormula) {
        append_model<T0, T1>(arg0, arg1, true);
    }

    public fun append_model_b_to_a<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &mut 0x3ee7be8b6bf110d3216162c35484336e76cddaf8b60fdb8818c067c000a28f34::optimizer::RouteFormula) {
        append_model<T0, T1>(arg0, arg1, false);
    }

    public fun flash_swap_exact_in_a_to_b<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T1>, DeferredReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg0, arg1, true, true, arg2, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::min_sqrt_price(), arg3);
        let v3 = v2;
        assert!(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v3) == arg2, 1);
        let v4 = DeferredReceipt<T0, T1>{
            repay_a : v0,
            repay_b : 0x2::balance::zero<T1>(),
            receipt : v3,
            amount  : arg2,
            a_to_b  : true,
        };
        (v1, v4)
    }

    public fun flash_swap_exact_in_b_to_a<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, DeferredReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg2, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::max_sqrt_price(), arg3);
        let v3 = v2;
        assert!(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v3) == arg2, 1);
        let v4 = DeferredReceipt<T0, T1>{
            repay_a : 0x2::balance::zero<T0>(),
            repay_b : v1,
            receipt : v3,
            amount  : arg2,
            a_to_b  : false,
        };
        (v0, v4)
    }

    public fun repay_flash_swap_a_to_b<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: DeferredReceipt<T0, T1>) {
        let DeferredReceipt {
            repay_a : v0,
            repay_b : v1,
            receipt : v2,
            amount  : v3,
            a_to_b  : v4,
        } = arg3;
        let v5 = v0;
        assert!(v4 && 0x2::balance::value<T0>(&arg2) == v3, 2);
        0x2::balance::join<T0>(&mut v5, arg2);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, v5, v1, v2);
    }

    public fun repay_flash_swap_b_to_a<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: DeferredReceipt<T0, T1>) {
        let DeferredReceipt {
            repay_a : v0,
            repay_b : v1,
            receipt : v2,
            amount  : v3,
            a_to_b  : v4,
        } = arg3;
        let v5 = v1;
        assert!(!v4 && 0x2::balance::value<T1>(&arg2) == v3, 2);
        0x2::balance::join<T1>(&mut v5, arg2);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, v0, v5, v2);
    }

    public fun repayment_amount<T0, T1>(arg0: &DeferredReceipt<T0, T1>) : u64 {
        arg0.amount
    }

    public fun swap_exact_in<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        swap_exact_in_a_to_b<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun swap_exact_in_a_to_b<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let (v1, v2, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::min_sqrt_price(), arg3);
        let v4 = v3;
        let v5 = v1;
        assert!(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v4) == v0, 1);
        0x2::balance::join<T0>(&mut v5, arg2);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, v5, 0x2::balance::zero<T1>(), v4);
        v2
    }

    public fun swap_exact_in_b_to_a<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg2);
        let (v1, v2, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg0, arg1, false, true, v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::max_sqrt_price(), arg3);
        let v4 = v3;
        let v5 = v2;
        assert!(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v4) == v0, 1);
        0x2::balance::join<T1>(&mut v5, arg2);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v5, v4);
        v1
    }

    // decompiled from Move bytecode v7
}

