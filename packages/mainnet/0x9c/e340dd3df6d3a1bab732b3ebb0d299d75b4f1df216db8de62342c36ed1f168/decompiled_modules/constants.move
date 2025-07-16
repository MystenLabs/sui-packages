module 0x9ce340dd3df6d3a1bab732b3ebb0d299d75b4f1df216db8de62342c36ed1f168::constants {
    public fun amount_after_fee(arg0: u64, arg1: u64) : u64 {
        0x9ce340dd3df6d3a1bab732b3ebb0d299d75b4f1df216db8de62342c36ed1f168::safe_math::mul_div_u64(arg0, 1000000 - arg1, 1000000)
    }

    public fun amount_before_fee(arg0: u64, arg1: u64) : u64 {
        0x9ce340dd3df6d3a1bab732b3ebb0d299d75b4f1df216db8de62342c36ed1f168::safe_math::mul_div_u64(arg0, 1000000, 1000000 - arg1)
    }

    public fun current_version() : u64 {
        1
    }

    public fun max_output_delta_pips() : u64 {
        500
    }

    public fun max_price_delta_pips() : u64 {
        20000
    }

    public fun scaling_pips() : u64 {
        1000000
    }

    public fun scaling_pips_u128() : u128 {
        (1000000 as u128)
    }

    public fun scaling_pips_u256() : u256 {
        (1000000 as u256)
    }

    // decompiled from Move bytecode v6
}

