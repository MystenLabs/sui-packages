module 0xd690a8ebee2620330ef1166f8afefec7509d7e27fb7a74651cdc0090b01d9c9d::deepbook {
    public fun check<T0, T1>(arg0: &mut 0xd690a8ebee2620330ef1166f8afefec7509d7e27fb7a74651cdc0090b01d9c9d::probe::Probe, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: &0x2::clock::Clock) {
        if (!0xd690a8ebee2620330ef1166f8afefec7509d7e27fb7a74651cdc0090b01d9c9d::probe::checking(arg0)) {
            return
        };
        let (v0, v1) = quote<T0, T1>(arg1, arg2, 0xd690a8ebee2620330ef1166f8afefec7509d7e27fb7a74651cdc0090b01d9c9d::probe::check_amount(arg0), arg4);
        0xd690a8ebee2620330ef1166f8afefec7509d7e27fb7a74651cdc0090b01d9c9d::probe::check_step(arg0, v0, v1, arg3);
    }

    fun execution_input(arg0: u64, arg1: bool, arg2: u64) : u64 {
        if (arg1) {
            arg0 / arg2 * arg2
        } else {
            arg0
        }
    }

    public fun fold<T0, T1>(arg0: &mut 0xd690a8ebee2620330ef1166f8afefec7509d7e27fb7a74651cdc0090b01d9c9d::probe::Probe, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1) = quote<T0, T1>(arg1, arg2, arg3, arg4);
        if (v0 == 0 || v1 == 0) {
            0xd690a8ebee2620330ef1166f8afefec7509d7e27fb7a74651cdc0090b01d9c9d::probe::fold_closed(arg0);
            return
        };
        0xd690a8ebee2620330ef1166f8afefec7509d7e27fb7a74651cdc0090b01d9c9d::probe::fold_to(arg0, (v1 as u256), 0, (v0 as u256), (v0 as u256));
    }

    public fun fold_live<T0, T1>(arg0: &mut 0xd690a8ebee2620330ef1166f8afefec7509d7e27fb7a74651cdc0090b01d9c9d::probe::Probe, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: &0x2::clock::Clock) {
        let v0 = 0xd690a8ebee2620330ef1166f8afefec7509d7e27fb7a74651cdc0090b01d9c9d::probe::reference_input(arg0);
        fold<T0, T1>(arg0, arg1, arg2, v0, arg3);
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

    public fun quote<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64) {
        let (_, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v3 = execution_input(arg2, arg1, v1);
        if (v3 == 0) {
            return (0, 0)
        };
        if (arg1) {
            let (v6, v7, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg0, v3, arg3);
            (v3 - v6, v7)
        } else {
            let (v9, v10, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg0, v3, arg3);
            (v3 - v10, v9)
        }
    }

    public fun quote_floor<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg0, arg2);
        assert!(v0 > 0, 0);
        ((((arg1 as u256) * (v0 as u256) + 999999999) / 1000000000) as u64)
    }

    // decompiled from Move bytecode v7
}

