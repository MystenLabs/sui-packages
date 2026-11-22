module 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::deepbookv3 {
    struct Ticket<phantom T0> {
        plan: 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::Plan,
        loan: 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>,
        principal: u64,
        change: 0x2::balance::Balance<T0>,
    }

    public fun finish_a2b<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: Ticket<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let Ticket {
            plan      : v0,
            loan      : v1,
            principal : v2,
            change    : v3,
        } = arg2;
        let v4 = v1;
        let v5 = v0;
        0x2::balance::join<T0>(&mut arg1, v3);
        if (0x1::option::is_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(&v4)) {
            0x1::option::destroy_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(v4);
            0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::finish<T0>(v5, arg1, 0, arg3);
            return
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::from_balance<T0>(0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::repay<T0>(&v5, &mut arg1, v2), arg3), 0x1::option::destroy_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(v4));
        0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::finish<T0>(v5, arg1, v2, arg3);
    }

    public fun finish_b2a<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: Ticket<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let Ticket {
            plan      : v0,
            loan      : v1,
            principal : v2,
            change    : v3,
        } = arg2;
        let v4 = v1;
        let v5 = v0;
        0x2::balance::join<T1>(&mut arg1, v3);
        if (0x1::option::is_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(&v4)) {
            0x1::option::destroy_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(v4);
            0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::finish<T1>(v5, arg1, 0, arg3);
            return
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::repay<T1>(&v5, &mut arg1, v2), arg3), 0x1::option::destroy_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(v4));
        0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::finish<T1>(v5, arg1, v2, arg3);
    }

    public fun quote<T0, T1>(arg0: &mut 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::Plan, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: &0x2::clock::Clock) {
        0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::hop<T0, T1>(arg0, 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), arg2);
        let v0 = 0;
        while (v0 < 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::count(arg0)) {
            let v1 = 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::input(arg0, v0);
            let v2 = if (v1 == 0) {
                0
            } else {
                let (v3, v4) = if (arg2) {
                    let (v5, v6, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg1, v1, arg3);
                    (v5, v6)
                } else {
                    let (v8, v9, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg1, v1, arg3);
                    (v8, v9)
                };
                if (arg2) {
                    0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::first_input_change<T0>(arg0, v0, v3);
                } else {
                    0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::first_input_change<T1>(arg0, v0, v4);
                };
                if (arg2) {
                    v4
                } else {
                    v3
                }
            };
            0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::output(arg0, v0, v2);
            v0 = v0 + 1;
        };
    }

    public fun start_a2b<T0, T1>(arg0: 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::Plan, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, Ticket<T0>) {
        let v0 = 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::choose<T0>(&mut arg0, 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1));
        if (v0 == 0) {
            let v1 = Ticket<T0>{
                plan      : arg0,
                loan      : 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(),
                principal : 0,
                change    : 0x2::balance::zero<T0>(),
            };
            return (0x2::balance::zero<T1>(), v1)
        };
        let (v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg1, v0, arg3);
        let (v4, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg1, v2, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0, arg2, arg3);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v6);
        let v7 = Ticket<T0>{
            plan      : arg0,
            loan      : 0x1::option::some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(v3),
            principal : v0,
            change    : 0x2::coin::into_balance<T0>(v4),
        };
        (0x2::coin::into_balance<T1>(v5), v7)
    }

    public fun start_b2a<T0, T1>(arg0: 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::Plan, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, Ticket<T1>) {
        let v0 = 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::choose<T1>(&mut arg0, 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1));
        if (v0 == 0) {
            let v1 = Ticket<T1>{
                plan      : arg0,
                loan      : 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(),
                principal : 0,
                change    : 0x2::balance::zero<T1>(),
            };
            return (0x2::balance::zero<T0>(), v1)
        };
        let (v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg1, v0, arg3);
        let (v4, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg1, v2, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0, arg2, arg3);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v6);
        let v7 = Ticket<T1>{
            plan      : arg0,
            loan      : 0x1::option::some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(v3),
            principal : v0,
            change    : 0x2::coin::into_balance<T1>(v5),
        };
        (0x2::coin::into_balance<T0>(v4), v7)
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return 0x2::balance::zero<T1>()
        };
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, 0x2::coin::from_balance<T0>(arg1, arg3), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0, arg2, arg3);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2);
        0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::bank<T0>(0x2::coin::into_balance<T0>(v0), arg3);
        0x2::coin::into_balance<T1>(v1)
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        if (0x2::balance::value<T1>(&arg1) == 0) {
            0x2::balance::destroy_zero<T1>(arg1);
            return 0x2::balance::zero<T0>()
        };
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, 0x2::coin::from_balance<T1>(arg1, arg3), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0, arg2, arg3);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2);
        0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::bank<T1>(0x2::coin::into_balance<T1>(v1), arg3);
        0x2::coin::into_balance<T0>(v0)
    }

    // decompiled from Move bytecode v7
}

