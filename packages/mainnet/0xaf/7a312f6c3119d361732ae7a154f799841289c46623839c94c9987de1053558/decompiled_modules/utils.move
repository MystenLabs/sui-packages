module 0xaf7a312f6c3119d361732ae7a154f799841289c46623839c94c9987de1053558::utils {
    public fun safe_mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

