module 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::scaled_balance {
    public fun balance_of(arg0: u256, arg1: u256) : u256 {
        0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray_mul(arg0, arg1)
    }

    public fun burn_scaled(arg0: u256, arg1: u256) : u256 {
        0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray_div(arg0, arg1)
    }

    public fun mint_scaled(arg0: u256, arg1: u256) : u256 {
        0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray_div(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

