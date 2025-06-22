module 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::helper {
    public fun calculate_earnings(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::token_decimals() as u128)) as u64)
    }

    public fun calculate_fee(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::price_factor() as u128)) as u64)
    }

    public fun calculate_purchase(arg0: u64, arg1: u64, arg2: u64) : (u64, u64, u64) {
        let v0 = calculate_fee(arg0, arg1);
        let v1 = arg0 - v0;
        (v0, v1, calculate_tokens(v1, arg2))
    }

    public fun calculate_tokens(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::token_decimals() as u128) / (arg1 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

