module 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::deepbook {
    struct Fees has drop {
        price: u64,
        available: u64,
        required: u64,
    }

    public fun check<T0, T1>(arg0: &mut 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: &0x2::clock::Clock) {
        if (!0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::checking(arg0)) {
            return
        };
        let (v0, v1) = quote<T0, T1>(arg1, arg2, 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_amount(arg0), arg4);
        0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_step(arg0, v0, v1, arg3);
    }

    public fun check_own_deep<T0, T1>(arg0: &mut 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: &mut Fees, arg5: u64, arg6: &0x2::clock::Clock) {
        if (!0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::checking(arg0)) {
            return
        };
        let (v0, v1, v2) = quote_own_deep<T0, T1>(arg1, arg2, 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_amount(arg0), arg6);
        if (v2 > arg5) {
            0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_step(arg0, 0, 0, arg3);
            return
        };
        if ((arg4.required as u256) + (v2 as u256) > (arg4.available as u256)) {
            0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_step(arg0, 0, 0, arg3);
            return
        };
        arg4.required = arg4.required + v2;
        0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_step(arg0, v0, v1, arg3);
    }

    public fun end_check(arg0: &mut 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe, arg1: &mut Fees) {
        let v0 = ((arg1.required as u256) * (arg1.price as u256) + 999999999) / 1000000000;
        arg1.required = 0;
        if (v0 > 18446744073709551615) {
            0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_step(arg0, 0, 0, false);
            0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_end(arg0);
        } else {
            0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_end_with_cost(arg0, (v0 as u64));
        };
    }

    fun execution_input(arg0: u64, arg1: bool, arg2: u64) : u64 {
        if (arg1) {
            arg0 / arg2 * arg2
        } else {
            arg0
        }
    }

    public fun fold<T0, T1>(arg0: &mut 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1) = quote<T0, T1>(arg1, arg2, arg3, arg4);
        if (v0 == 0 || v1 == 0) {
            0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::fold_closed(arg0);
            return
        };
        0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::fold_to(arg0, (v1 as u256), 0, (v0 as u256), (v0 as u256));
    }

    public fun fold_live<T0, T1>(arg0: &mut 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: &0x2::clock::Clock) {
        let (v0, v1) = quote<T0, T1>(arg1, arg2, 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::reference_input(arg0), arg3);
        if (v0 == 0 || v1 == 0) {
            0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::fold_closed(arg0);
            return
        };
        0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::fold(arg0, (v1 as u256), 0, (v0 as u256));
    }

    public fun fold_live_own_deep<T0, T1>(arg0: &mut 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: &0x2::clock::Clock) {
        let (v0, v1, _) = quote_own_deep<T0, T1>(arg1, arg2, 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::reference_input(arg0), arg3);
        if (v0 == 0 || v1 == 0) {
            0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::fold_closed(arg0);
            return
        };
        0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::fold(arg0, (v1 as u256), 0, (v0 as u256));
    }

    public fun lendable<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        let (v0, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::vault_balances<T0, T1>(arg0);
        let v3 = if (arg1) {
            v0
        } else {
            v1
        };
        if (v3 < arg2) {
            v3
        } else {
            arg2
        }
    }

    public fun new_fees<T0>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, T0>, arg1: &0x2::clock::Clock) : Fees {
        let (_, _, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, T0>(arg0, 1, arg1);
        let v4 = v3;
        let v5 = v2;
        assert!(!0x1::vector::is_empty<u64>(&v5), 0);
        let v6 = *0x1::vector::borrow<u64>(&v5, 0);
        assert!(v6 > 0, 0);
        Fees{
            price     : v6,
            available : *0x1::vector::borrow<u64>(&v4, 0),
            required  : 0,
        }
    }

    public fun quote<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64) {
        let (_, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v3 = execution_input(arg2, arg1, v1);
        if (v3 == 0) {
            return (0, 0)
        };
        if (arg1) {
            if (v3 < v2) {
                return (0, 0)
            };
            let (v6, v7, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg0, v3, arg3);
            (v3 - v6, v7)
        } else {
            let (v9, v10, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg0, v3, arg3);
            if (v9 < v2) {
                return (0, 0)
            };
            (v3 - v10, v9)
        }
    }

    public fun quote_floor<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg0, arg2);
        assert!(v0 > 0, 0);
        ((((arg1 as u256) * (v0 as u256) + 999999999) / 1000000000) as u64)
    }

    public fun quote_own_deep<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let (_, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v3 = execution_input(arg2, arg1, v1);
        if (v3 == 0) {
            return (0, 0, 0)
        };
        if (arg1) {
            if (v3 < v2) {
                return (0, 0, 0)
            };
            let (v7, v8, v9) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg0, v3, arg3);
            (v3 - v7, v8, v9)
        } else {
            let (v10, v11, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg0, v3, arg3);
            if (v10 < v2) {
                return (0, 0, 0)
            };
            (v3 - v11, v10, v12)
        }
    }

    // decompiled from Move bytecode v7
}

