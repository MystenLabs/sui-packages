module 0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

