module 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::turbos {
    struct Ticket<phantom T0, phantom T1> {
        plan: 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::Plan,
        receipt: 0x1::option::Option<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>,
    }

    public fun finish_a2b<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: 0x2::balance::Balance<T0>, arg3: Ticket<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let Ticket {
            plan    : v0,
            receipt : v1,
        } = arg3;
        let v2 = v1;
        let v3 = v0;
        if (0x1::option::is_none<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(&v2)) {
            0x1::option::destroy_none<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(v2);
            0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::finish<T0>(v3, arg2, 0, arg4);
            return
        };
        let v4 = 0x1::option::destroy_some<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(v2);
        let (_, _, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v4);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg1, 0x2::coin::from_balance<T0>(0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::repay<T0>(&v3, &mut arg2, v7), arg4), 0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg4), v4, arg0);
        0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::finish<T0>(v3, arg2, v7, arg4);
    }

    public fun finish_b2a<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: 0x2::balance::Balance<T1>, arg3: Ticket<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let Ticket {
            plan    : v0,
            receipt : v1,
        } = arg3;
        let v2 = v1;
        let v3 = v0;
        if (0x1::option::is_none<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(&v2)) {
            0x1::option::destroy_none<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(v2);
            0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::finish<T1>(v3, arg2, 0, arg4);
            return
        };
        let v4 = 0x1::option::destroy_some<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(v2);
        let (_, _, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v4);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg1, 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg4), 0x2::coin::from_balance<T1>(0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::repay<T1>(&v3, &mut arg2, v7), arg4), v4, arg0);
        0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::finish<T1>(v3, arg2, v7, arg4);
    }

    fun limit<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool) : u128 {
        if (arg1) {
            4295048017
        } else {
            79226673515401279992447579054
        }
    }

    public fun quote<T0, T1, T2>(arg0: &mut 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::Plan, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: bool) {
        0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::hop<T0, T1>(arg0, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1), arg2);
        let v0 = 0;
        while (v0 < 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::count(arg0)) {
            let v1 = 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::input(arg0, v0);
            let v2 = if (v1 == 0) {
                0
            } else {
                let (_, v4, v5, v6) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_swap::compute_swap(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg1), limit<T0, T1, T2>(arg1, arg2), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_liquidity<T0, T1, T2>(arg1), (v1 as u128), true, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg1));
                if ((v4 as u256) + (v6 as u256) != (v1 as u256) || v5 > 18446744073709551615) {
                    0
                } else {
                    (v5 as u64)
                }
            };
            0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::output(arg0, v0, v2);
            v0 = v0 + 1;
        };
    }

    public fun start_a2b<T0, T1, T2>(arg0: 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::Plan, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, Ticket<T0, T1>) {
        let v0 = 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::choose<T0>(&mut arg0, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2));
        if (v0 == 0) {
            let v1 = Ticket<T0, T1>{
                plan    : arg0,
                receipt : 0x1::option::none<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(),
            };
            return (0x2::balance::zero<T1>(), v1)
        };
        let (v2, v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg2, @0x0, true, (v0 as u128), true, limit<T0, T1, T2>(arg2, true), arg3, arg1, arg4);
        0x2::balance::destroy_zero<T0>(0x2::coin::into_balance<T0>(v2));
        let v5 = Ticket<T0, T1>{
            plan    : arg0,
            receipt : 0x1::option::some<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(v4),
        };
        (0x2::coin::into_balance<T1>(v3), v5)
    }

    public fun start_b2a<T0, T1, T2>(arg0: 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::Plan, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, Ticket<T0, T1>) {
        let v0 = 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::choose<T1>(&mut arg0, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2));
        if (v0 == 0) {
            let v1 = Ticket<T0, T1>{
                plan    : arg0,
                receipt : 0x1::option::none<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(),
            };
            return (0x2::balance::zero<T0>(), v1)
        };
        let (v2, v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg2, @0x0, false, (v0 as u128), true, limit<T0, T1, T2>(arg2, false), arg3, arg1, arg4);
        0x2::balance::destroy_zero<T1>(0x2::coin::into_balance<T1>(v3));
        let v5 = Ticket<T0, T1>{
            plan    : arg0,
            receipt : 0x1::option::some<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(v4),
        };
        (0x2::coin::into_balance<T0>(v2), v5)
    }

    public fun swap_a2b<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return 0x2::balance::zero<T1>()
        };
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg1, @0x0, true, (v0 as u128), true, limit<T0, T1, T2>(arg1, true), arg3, arg0, arg4);
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(0x2::coin::into_balance<T0>(v1));
        let (_, _, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v4);
        0x2::balance::destroy_zero<T0>(arg2);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2, v7), arg4), 0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg4), v4, arg0);
        0x2::coin::into_balance<T1>(v2)
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T1>(arg2);
            return 0x2::balance::zero<T0>()
        };
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg1, @0x0, false, (v0 as u128), true, limit<T0, T1, T2>(arg1, false), arg3, arg0, arg4);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(0x2::coin::into_balance<T1>(v2));
        let (_, _, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v4);
        0x2::balance::destroy_zero<T1>(arg2);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg1, 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg4), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg2, v7), arg4), v4, arg0);
        0x2::coin::into_balance<T0>(v1)
    }

    // decompiled from Move bytecode v7
}

