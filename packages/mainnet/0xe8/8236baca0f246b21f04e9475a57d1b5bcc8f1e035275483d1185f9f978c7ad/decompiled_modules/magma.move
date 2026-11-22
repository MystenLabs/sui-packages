module 0xe88236baca0f246b21f04e9475a57d1b5bcc8f1e035275483d1185f9f978c7ad::magma {
    struct Ticket<phantom T0, phantom T1> {
        plan: 0xe88236baca0f246b21f04e9475a57d1b5bcc8f1e035275483d1185f9f978c7ad::plan::Plan,
        receipt: 0x1::option::Option<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>,
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
            0xe88236baca0f246b21f04e9475a57d1b5bcc8f1e035275483d1185f9f978c7ad::plan::finish<T0>(v3, arg2, 0, arg4);
            return
        };
        let v4 = 0x1::option::destroy_some<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(v2);
        let v5 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v4);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0xe88236baca0f246b21f04e9475a57d1b5bcc8f1e035275483d1185f9f978c7ad::plan::repay<T0>(&v3, &mut arg2, v5), 0x2::balance::zero<T1>(), v4);
        0xe88236baca0f246b21f04e9475a57d1b5bcc8f1e035275483d1185f9f978c7ad::plan::finish<T0>(v3, arg2, v5, arg4);
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
            0xe88236baca0f246b21f04e9475a57d1b5bcc8f1e035275483d1185f9f978c7ad::plan::finish<T1>(v3, arg2, 0, arg4);
            return
        };
        let v4 = 0x1::option::destroy_some<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(v2);
        let v5 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v4);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0xe88236baca0f246b21f04e9475a57d1b5bcc8f1e035275483d1185f9f978c7ad::plan::repay<T1>(&v3, &mut arg2, v5), v4);
        0xe88236baca0f246b21f04e9475a57d1b5bcc8f1e035275483d1185f9f978c7ad::plan::finish<T1>(v3, arg2, v5, arg4);
    }

    fun limit<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: bool) : u128 {
        if (arg1) {
            4295048017
        } else {
            79226673515401279992447579054
        }
    }

    public fun quote<T0, T1>(arg0: &mut 0xe88236baca0f246b21f04e9475a57d1b5bcc8f1e035275483d1185f9f978c7ad::plan::Plan, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: bool) {
        0xe88236baca0f246b21f04e9475a57d1b5bcc8f1e035275483d1185f9f978c7ad::plan::hop<T0, T1>(arg0, 0x2::object::id_address<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg2), arg3);
        let v0 = 0;
        while (v0 < 0xe88236baca0f246b21f04e9475a57d1b5bcc8f1e035275483d1185f9f978c7ad::plan::count(arg0)) {
            let v1 = 0xe88236baca0f246b21f04e9475a57d1b5bcc8f1e035275483d1185f9f978c7ad::plan::input(arg0, v0);
            let v2 = if (v1 == 0) {
                0
            } else {
                let v3 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculate_swap_result<T0, T1>(arg1, arg2, arg3, true, v1);
                if (0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_is_exceed(&v3)) {
                    0
                } else {
                    0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_amount_out(&v3)
                }
            };
            0xe88236baca0f246b21f04e9475a57d1b5bcc8f1e035275483d1185f9f978c7ad::plan::output(arg0, v0, v2);
            v0 = v0 + 1;
        };
    }

    public fun start_a2b<T0, T1>(arg0: 0xe88236baca0f246b21f04e9475a57d1b5bcc8f1e035275483d1185f9f978c7ad::plan::Plan, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, Ticket<T0, T1>) {
        let v0 = 0xe88236baca0f246b21f04e9475a57d1b5bcc8f1e035275483d1185f9f978c7ad::plan::choose<T0>(&mut arg0, 0x2::object::id_address<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg2));
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

    public fun start_b2a<T0, T1>(arg0: 0xe88236baca0f246b21f04e9475a57d1b5bcc8f1e035275483d1185f9f978c7ad::plan::Plan, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, Ticket<T0, T1>) {
        let v0 = 0xe88236baca0f246b21f04e9475a57d1b5bcc8f1e035275483d1185f9f978c7ad::plan::choose<T1>(&mut arg0, 0x2::object::id_address<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg2));
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

