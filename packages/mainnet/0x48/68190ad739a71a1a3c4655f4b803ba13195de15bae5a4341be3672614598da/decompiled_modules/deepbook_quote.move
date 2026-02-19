module 0x4868190ad739a71a1a3c4655f4b803ba13195de15bae5a4341be3672614598da::deepbook_quote {
    fun first_or_zero(arg0: &vector<u64>) : u64 {
        if (0x1::vector::is_empty<u64>(arg0)) {
            0
        } else {
            *0x1::vector::borrow<u64>(arg0, 0)
        }
    }

    public fun quote<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64) : (u64, u64, u64) {
        let (v0, _, v2, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, arg2, arg1);
        let v4 = v2;
        let v5 = v0;
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg0, arg1), first_or_zero(&v5), first_or_zero(&v4))
    }

    // decompiled from Move bytecode v6
}

