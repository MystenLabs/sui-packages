module 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::momentum {
    struct Ticket<phantom T0, phantom T1> {
        plan: 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::Plan,
        receipt: 0x1::option::Option<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>,
    }

    struct EmbeddedTicket<phantom T0, phantom T1> {
        inner: Ticket<T0, T1>,
        settings: 0x2::object::ID,
    }

    public fun finish_a2b<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: Ticket<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let Ticket {
            plan    : v0,
            receipt : v1,
        } = arg3;
        let v2 = v1;
        let v3 = v0;
        if (0x1::option::is_none<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>(&v2)) {
            0x1::option::destroy_none<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>(v2);
            0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::finish<T0>(v3, arg2, 0, arg4);
            return
        };
        let v4 = 0x1::option::destroy_some<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>(v2);
        let (v5, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v4, 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::repay<T0>(&v3, &mut arg2, v5), 0x2::balance::zero<T1>(), arg0, arg4);
        0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::finish<T0>(v3, arg2, v5, arg4);
    }

    public fun finish_a2b_embedded<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: EmbeddedTicket<T0, T1>, arg4: &0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::settings::Settings, arg5: &mut 0x2::tx_context::TxContext) {
        let EmbeddedTicket {
            inner    : v0,
            settings : v1,
        } = arg3;
        0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::check_settings(v1, arg4);
        let Ticket {
            plan    : v2,
            receipt : v3,
        } = v0;
        let v4 = v3;
        if (0x1::option::is_none<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>(&v4)) {
            0x1::option::destroy_none<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>(v4);
            0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::finish_embedded<T0>(v2, arg2, 0, arg4, arg5);
            return
        };
        let v5 = 0x1::option::destroy_some<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>(v4);
        let (v6, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v5);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v5, 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::repay_embedded<T0>(&mut arg2, v6), 0x2::balance::zero<T1>(), arg0, arg5);
        0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::finish_embedded<T0>(v2, arg2, v6, arg4, arg5);
    }

    public fun finish_b2a<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: Ticket<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let Ticket {
            plan    : v0,
            receipt : v1,
        } = arg3;
        let v2 = v1;
        let v3 = v0;
        if (0x1::option::is_none<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>(&v2)) {
            0x1::option::destroy_none<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>(v2);
            0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::finish<T1>(v3, arg2, 0, arg4);
            return
        };
        let v4 = 0x1::option::destroy_some<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>(v2);
        let (_, v6) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v4, 0x2::balance::zero<T0>(), 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::repay<T1>(&v3, &mut arg2, v6), arg0, arg4);
        0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::finish<T1>(v3, arg2, v6, arg4);
    }

    public fun finish_b2a_embedded<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: EmbeddedTicket<T0, T1>, arg4: &0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::settings::Settings, arg5: &mut 0x2::tx_context::TxContext) {
        let EmbeddedTicket {
            inner    : v0,
            settings : v1,
        } = arg3;
        0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::check_settings(v1, arg4);
        let Ticket {
            plan    : v2,
            receipt : v3,
        } = v0;
        let v4 = v3;
        if (0x1::option::is_none<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>(&v4)) {
            0x1::option::destroy_none<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>(v4);
            0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::finish_embedded<T1>(v2, arg2, 0, arg4, arg5);
            return
        };
        let v5 = 0x1::option::destroy_some<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>(v4);
        let (_, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v5);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v5, 0x2::balance::zero<T0>(), 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::repay_embedded<T1>(&mut arg2, v7), arg0, arg5);
        0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::finish_embedded<T1>(v2, arg2, v7, arg4, arg5);
    }

    fun limit<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool) : u128 {
        if (arg1) {
            4295048017
        } else {
            79226673515401279992447579054
        }
    }

    public fun quote<T0, T1>(arg0: &mut 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::Plan, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: bool) {
        0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::hop<T0, T1>(arg0, 0x2::object::id_address<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1), arg2);
        let v0 = 0;
        while (v0 < 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::count(arg0)) {
            let v1 = 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::input(arg0, v0);
            let v2 = if (v1 == 0) {
                0
            } else {
                let v3 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg1, arg2, true, limit<T0, T1>(arg1, arg2), v1);
                if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_specified(&v3) != 0) {
                    0
                } else {
                    0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v3)
                }
            };
            0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::output(arg0, v0, v2);
            v0 = v0 + 1;
        };
    }

    public fun quote_embedded<T0, T1>(arg0: &mut 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::EmbeddedPlan, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: bool) {
        let v0 = 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::embedded_inner(arg0);
        quote<T0, T1>(v0, arg1, arg2);
    }

    public fun start_a2b<T0, T1>(arg0: 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::Plan, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, Ticket<T0, T1>) {
        let v0 = 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::choose<T0>(&mut arg0, 0x2::object::id_address<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg2));
        if (v0 == 0) {
            let v1 = Ticket<T0, T1>{
                plan    : arg0,
                receipt : 0x1::option::none<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>(),
            };
            return (0x2::balance::zero<T1>(), v1)
        };
        let (v2, v3, v4) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, true, true, v0, limit<T0, T1>(arg2, true), arg3, arg1, arg4);
        0x2::balance::destroy_zero<T0>(v2);
        let v5 = Ticket<T0, T1>{
            plan    : arg0,
            receipt : 0x1::option::some<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>(v4),
        };
        (v3, v5)
    }

    public fun start_a2b_embedded<T0, T1>(arg0: 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::EmbeddedPlan, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, EmbeddedTicket<T0, T1>) {
        let (v0, v1) = 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::unpack_embedded(arg0);
        let (v2, v3) = start_a2b<T0, T1>(v0, arg1, arg2, arg3, arg4);
        let v4 = EmbeddedTicket<T0, T1>{
            inner    : v3,
            settings : v1,
        };
        (v2, v4)
    }

    public fun start_b2a<T0, T1>(arg0: 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::Plan, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, Ticket<T0, T1>) {
        let v0 = 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::choose<T1>(&mut arg0, 0x2::object::id_address<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg2));
        if (v0 == 0) {
            let v1 = Ticket<T0, T1>{
                plan    : arg0,
                receipt : 0x1::option::none<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>(),
            };
            return (0x2::balance::zero<T0>(), v1)
        };
        let (v2, v3, v4) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, false, true, v0, limit<T0, T1>(arg2, false), arg3, arg1, arg4);
        0x2::balance::destroy_zero<T1>(v3);
        let v5 = Ticket<T0, T1>{
            plan    : arg0,
            receipt : 0x1::option::some<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>(v4),
        };
        (v2, v5)
    }

    public fun start_b2a_embedded<T0, T1>(arg0: 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::EmbeddedPlan, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, EmbeddedTicket<T0, T1>) {
        let (v0, v1) = 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::plan::unpack_embedded(arg0);
        let (v2, v3) = start_b2a<T0, T1>(v0, arg1, arg2, arg3, arg4);
        let v4 = EmbeddedTicket<T0, T1>{
            inner    : v3,
            settings : v1,
        };
        (v2, v4)
    }

    public fun swap_a2b<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return 0x2::balance::zero<T1>()
        };
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, true, true, v0, limit<T0, T1>(arg1, true), arg3, arg0, arg4);
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(v1);
        let (v5, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        0x2::balance::destroy_zero<T0>(arg2);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v4, 0x2::balance::split<T0>(&mut arg2, v5), 0x2::balance::zero<T1>(), arg0, arg4);
        v2
    }

    public fun swap_b2a<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T1>(arg2);
            return 0x2::balance::zero<T0>()
        };
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, false, true, v0, limit<T0, T1>(arg1, false), arg3, arg0, arg4);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        let (_, v6) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        0x2::balance::destroy_zero<T1>(arg2);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v4, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, v6), arg0, arg4);
        v1
    }

    // decompiled from Move bytecode v7
}

