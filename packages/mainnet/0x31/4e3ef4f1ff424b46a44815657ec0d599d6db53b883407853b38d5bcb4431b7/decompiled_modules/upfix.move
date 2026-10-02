module 0x2370fb098c171f346ac60e5f980393efd2c3b6ee63ed680bd593cf0102d73c2::upfix {
    public fun add(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) + (arg1 as u128);
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    public fun sell_quote<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64) : (u64, u64) {
        if (arg2 == 0) {
            return (0, 0)
        };
        let (v0, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg0, arg2, arg1);
        (v1, v0)
    }

    // decompiled from Move bytecode v7
}

