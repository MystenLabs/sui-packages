module 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::math_safe_precise {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun quadratic(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        ((0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::math_u128::exp((arg0 as u128), 2) / 4294967296 * (arg1 as u128) / 4294967296 + (arg2 as u128) * (arg0 as u128) / 4294967296 + (arg3 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

