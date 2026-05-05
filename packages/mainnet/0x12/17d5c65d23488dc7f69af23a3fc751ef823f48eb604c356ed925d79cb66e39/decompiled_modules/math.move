module 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::math {
    public fun face_from_backing(arg0: u64, arg1: u64) : u64 {
        mul_div_down(arg0, arg1, 1000000000)
    }

    public fun final_value(arg0: u64, arg1: u64) : u64 {
        mul_div_down(arg0, arg1, 1000000000)
    }

    public fun mul_div_down(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 1);
        let v0 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128), 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down());
        assert!(0x1::option::is_some<u128>(&v0), 0);
        let v1 = 0x1::option::destroy_some<u128>(v0);
        assert!(v1 <= 18446744073709551615, 0);
        (v1 as u64)
    }

    public fun rate_from_value(arg0: u64, arg1: u64) : u64 {
        mul_div_down(arg0, 1000000000, arg1)
    }

    public fun rate_scale() : u64 {
        1000000000
    }

    public fun safe_add(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) + (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 0);
        (v0 as u64)
    }

    // decompiled from Move bytecode v7
}

