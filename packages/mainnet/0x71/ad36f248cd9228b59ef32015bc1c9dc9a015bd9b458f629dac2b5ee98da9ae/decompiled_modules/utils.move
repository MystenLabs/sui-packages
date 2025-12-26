module 0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::utils {
    public fun mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::errors::zero_amount());
        safe_cast_to_u64((arg0 as u128) * (arg1 as u128) / (arg2 as u128))
    }

    public fun safe_cast_to_u64(arg0: u128) : u64 {
        assert!(arg0 <= 18446744073709551615, 0x71ad36f248cd9228b59ef32015bc1c9dc9a015bd9b458f629dac2b5ee98da9ae::errors::arithmetic_overflow());
        (arg0 as u64)
    }

    // decompiled from Move bytecode v6
}

