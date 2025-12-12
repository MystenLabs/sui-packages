module 0x16576d795808741f31be9f519cacea3779c999f585ed291c4d301b99f5eaf1cd::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x16576d795808741f31be9f519cacea3779c999f585ed291c4d301b99f5eaf1cd::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

