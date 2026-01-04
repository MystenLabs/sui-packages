module 0x911f1376d8dc4e869a513eea765cdea635b2f356ffc6335633fb92d20ed64fef::dt_math {
    public(friend) fun div(arg0: u64, arg1: u64) : u64 {
        let (_, v1) = div_internal(arg0, arg1);
        v1
    }

    fun div_internal(arg0: u64, arg1: u64) : (u64, u64) {
        let v0 = (arg0 as u128);
        let v1 = (arg1 as u128);
        let v2 = if (v0 * 1000000000 % v1 == 0) {
            0
        } else {
            1
        };
        (v2, ((v0 * 1000000000 / v1) as u64))
    }

    public(friend) fun mul(arg0: u64, arg1: u64) : u64 {
        let (_, v1) = mul_internal(arg0, arg1);
        v1
    }

    public(friend) fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let (_, v1) = mul_div_internal(arg0, arg1, arg2);
        v1
    }

    fun mul_div_internal(arg0: u64, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = (arg0 as u128);
        let v1 = (arg1 as u128);
        let v2 = (arg2 as u128);
        let v3 = if (v0 * v1 % v2 == 0) {
            0
        } else {
            1
        };
        (v3, ((v0 * v1 / v2) as u64))
    }

    fun mul_internal(arg0: u64, arg1: u64) : (u64, u64) {
        let v0 = (arg0 as u128);
        let v1 = (arg1 as u128);
        let v2 = if (v0 * v1 % 1000000000 == 0) {
            0
        } else {
            1
        };
        (v2, ((v0 * v1 / 1000000000) as u64))
    }

    // decompiled from Move bytecode v6
}

