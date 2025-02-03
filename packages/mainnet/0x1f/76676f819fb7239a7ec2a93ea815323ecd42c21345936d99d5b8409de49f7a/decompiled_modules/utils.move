module 0xd61f40358e2c7843e37c42b7c58f75b161df6f08c96e75e310ed2d3b4b82c775::utils {
    public fun safe_mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

