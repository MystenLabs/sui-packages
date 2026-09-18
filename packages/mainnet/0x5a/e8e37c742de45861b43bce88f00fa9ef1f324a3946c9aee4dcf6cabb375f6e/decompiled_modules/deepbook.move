module 0x5ae8e37c742de45861b43bce88f00fa9ef1f324a3946c9aee4dcf6cabb375f6e::deepbook {
    public fun fold<T0, T1>(arg0: &mut 0x5ae8e37c742de45861b43bce88f00fa9ef1f324a3946c9aee4dcf6cabb375f6e::probe::Probe, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1) = if (arg2) {
            let (v2, v3, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg1, arg3, arg4);
            (arg3 - v2, v3)
        } else {
            let (v5, v6, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg1, arg3, arg4);
            (arg3 - v6, v5)
        };
        if (v0 == 0 || v1 == 0) {
            0x5ae8e37c742de45861b43bce88f00fa9ef1f324a3946c9aee4dcf6cabb375f6e::probe::fold_closed(arg0);
            return
        };
        0x5ae8e37c742de45861b43bce88f00fa9ef1f324a3946c9aee4dcf6cabb375f6e::probe::fold(arg0, (v1 as u256), 0, (v0 as u256));
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

    // decompiled from Move bytecode v7
}

