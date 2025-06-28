module 0x5bdb9e5f28fc1da5da4e3861f64b86dd8609adf4fda0ea61f3532d9b9aa4f509::math {
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

    // decompiled from Move bytecode v6
}

