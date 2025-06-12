module 0xb2ad6a50acbc9e17ba001d80b4201081cf84d3c11a19e6bc1dc25d27d6c68b54::math {
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

    public(friend) fun pow(arg0: u64, arg1: u64) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg1) {
            v0 = v0 * arg0;
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

