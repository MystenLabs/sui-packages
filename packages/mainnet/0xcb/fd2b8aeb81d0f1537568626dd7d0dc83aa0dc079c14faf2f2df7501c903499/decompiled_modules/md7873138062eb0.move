module 0x9ade52d362349ac2132bd59b16a7e18efaba6c5c8902eb0e35c3a5df817bd6f5::md7873138062eb0 {
    public fun f237ea2f702f8(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg1 == 0) {
            true
        } else if (arg2 >= arg1) {
            true
        } else {
            arg0 == 0
        };
        if (v0) {
            return 0
        };
        ((((arg0 as u128) * ((arg1 - arg2) as u128) / (arg1 as u128) + 1) * (10000 + (arg3 as u128)) / 10000) as u64)
    }

    public fun ff6ef9b26b4e1<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64) : (u64, u64) {
        if (arg2 == 0) {
            return (0, 0)
        };
        let (v0, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg0, arg2, arg1);
        (v0, v1)
    }

    // decompiled from Move bytecode v7
}

