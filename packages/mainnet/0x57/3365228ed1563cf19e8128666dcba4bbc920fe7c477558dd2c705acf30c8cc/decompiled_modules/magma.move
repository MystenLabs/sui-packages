module 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::magma {
    struct Ticket<phantom T0, phantom T1> {
        plan: 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::Plan,
        receipt: 0x1::option::Option<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>,
    }

    fun amount_out<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::tick_manager<T0, T1>(arg0);
        let v1 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::first_score_for_swap(v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg0), arg1);
        let v2 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0);
        let v3 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg0);
        let v4 = arg2;
        let v5 = 0;
        let v6 = 0;
        while (v4 > 0 && v6 < 32) {
            if (0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::is_none(&v1)) {
                return 0
            };
            let (v7, v8) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::borrow_tick_for_swap(v0, 0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::borrow(&v1), arg1);
            v1 = v8;
            let v9 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::sqrt_price(v7);
            let (v10, v11, v12, v13) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::compute_swap_step(v2, v9, v3, v4, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg0), arg1, true);
            let v14 = (v10 as u128) + (v13 as u128);
            if (v14 > (v4 as u128)) {
                return 0
            };
            let v15 = v4 - (v14 as u64);
            v4 = v15;
            let v16 = v5 + (v11 as u128);
            v5 = v16;
            if (v16 > 18446744073709551615) {
                return 0
            };
            if (v12 == v9) {
                let v17 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::liquidity_net(v7);
                let v18 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::abs_u128(v17);
                if (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::is_neg(v17) == arg1) {
                    let v19 = (v3 as u256) + (v18 as u256);
                    if (v19 > 340282366920938463463374607431768211455) {
                        return 0
                    };
                    v3 = (v19 as u128);
                } else {
                    if (v18 > v3) {
                        return 0
                    };
                    v3 = v3 - v18;
                };
            } else if (v15 != 0) {
                return 0
            };
            v2 = v12;
            v6 = v6 + 1;
        };
        if (v4 == 0) {
            (v5 as u64)
        } else {
            0
        }
    }

    public fun finish_a2b<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: Ticket<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let Ticket {
            plan    : v0,
            receipt : v1,
        } = arg3;
        let v2 = v1;
        let v3 = v0;
        if (0x1::option::is_none<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(&v2)) {
            0x1::option::destroy_none<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(v2);
            0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::finish<T0>(v3, arg2, 0, arg4);
            return
        };
        let v4 = 0x1::option::destroy_some<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(v2);
        let v5 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v4);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::repay<T0>(&v3, &mut arg2, v5), 0x2::balance::zero<T1>(), v4);
        0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::finish<T0>(v3, arg2, v5, arg4);
    }

    public fun finish_b2a<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: Ticket<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let Ticket {
            plan    : v0,
            receipt : v1,
        } = arg3;
        let v2 = v1;
        let v3 = v0;
        if (0x1::option::is_none<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(&v2)) {
            0x1::option::destroy_none<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(v2);
            0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::finish<T1>(v3, arg2, 0, arg4);
            return
        };
        let v4 = 0x1::option::destroy_some<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(v2);
        let v5 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v4);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::repay<T1>(&v3, &mut arg2, v5), v4);
        0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::finish<T1>(v3, arg2, v5, arg4);
    }

    fun limit<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: bool) : u128 {
        if (arg1) {
            4295048017
        } else {
            79226673515401279992447579054
        }
    }

    public fun quote<T0, T1>(arg0: &mut 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::Plan, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: bool) {
        0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::hop<T0, T1>(arg0, 0x2::object::id_address<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg2), arg3);
        let v0 = 0;
        while (v0 < 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::count(arg0)) {
            let v1 = 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::input(arg0, v0);
            let v2 = if (v1 == 0) {
                0
            } else {
                amount_out<T0, T1>(arg2, arg3, v1)
            };
            0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::output(arg0, v0, v2);
            v0 = v0 + 1;
        };
    }

    public fun start_a2b<T0, T1>(arg0: 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::Plan, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, Ticket<T0, T1>) {
        let v0 = 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::choose<T0>(&mut arg0, 0x2::object::id_address<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg2));
        if (v0 == 0) {
            let v1 = Ticket<T0, T1>{
                plan    : arg0,
                receipt : 0x1::option::none<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(),
            };
            return (0x2::balance::zero<T1>(), v1)
        };
        let (v2, v3, v4) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg1, arg2, true, true, v0, limit<T0, T1>(arg2, true), arg3);
        0x2::balance::destroy_zero<T0>(v2);
        let v5 = Ticket<T0, T1>{
            plan    : arg0,
            receipt : 0x1::option::some<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(v4),
        };
        (v3, v5)
    }

    public fun start_b2a<T0, T1>(arg0: 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::Plan, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, Ticket<T0, T1>) {
        let v0 = 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::choose<T1>(&mut arg0, 0x2::object::id_address<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg2));
        if (v0 == 0) {
            let v1 = Ticket<T0, T1>{
                plan    : arg0,
                receipt : 0x1::option::none<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(),
            };
            return (0x2::balance::zero<T0>(), v1)
        };
        let (v2, v3, v4) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg1, arg2, false, true, v0, limit<T0, T1>(arg2, false), arg3);
        0x2::balance::destroy_zero<T1>(v3);
        let v5 = Ticket<T0, T1>{
            plan    : arg0,
            receipt : 0x1::option::some<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(v4),
        };
        (v2, v5)
    }

    public fun swap_a2b<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return 0x2::balance::zero<T1>()
        };
        let (v1, v2, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v0, limit<T0, T1>(arg1, true), arg3);
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(v1);
        0x2::balance::destroy_zero<T0>(arg2);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v4)), 0x2::balance::zero<T1>(), v4);
        v2
    }

    public fun swap_b2a<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T1>(arg2);
            return 0x2::balance::zero<T0>()
        };
        let (v1, v2, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg0, arg1, false, true, v0, limit<T0, T1>(arg1, false), arg3);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        0x2::balance::destroy_zero<T1>(arg2);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v4)), v4);
        v1
    }

    // decompiled from Move bytecode v7
}

