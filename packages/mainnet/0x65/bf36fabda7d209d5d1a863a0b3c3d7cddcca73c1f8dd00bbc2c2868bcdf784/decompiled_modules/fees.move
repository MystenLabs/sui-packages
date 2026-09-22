module 0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::fees {
    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun split(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: bool) : (u64, u64, u64, u64) {
        assert!(arg1 + arg2 + arg3 + arg4 == 10000, 1);
        let v0 = if (arg5) {
            mul_div(arg0, arg1, 10000)
        } else {
            0
        };
        let v1 = mul_div(arg0, arg3, 10000);
        let v2 = mul_div(arg0, arg4, 10000);
        (v0, arg0 - v0 - v1 - v2, v1, v2)
    }

    // decompiled from Move bytecode v7
}

