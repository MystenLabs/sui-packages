module 0xf8870f988ab09be7c5820a856bd5e9da84fc7192e095a7a8829919293b00a36c::utils {
    public fun mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0xf8870f988ab09be7c5820a856bd5e9da84fc7192e095a7a8829919293b00a36c::errors::zero_amount());
        safe_cast_to_u64((arg0 as u128) * (arg1 as u128) / (arg2 as u128))
    }

    public fun safe_cast_to_u64(arg0: u128) : u64 {
        assert!(arg0 <= 18446744073709551615, 0xf8870f988ab09be7c5820a856bd5e9da84fc7192e095a7a8829919293b00a36c::errors::arithmetic_overflow());
        (arg0 as u64)
    }

    // decompiled from Move bytecode v6
}

