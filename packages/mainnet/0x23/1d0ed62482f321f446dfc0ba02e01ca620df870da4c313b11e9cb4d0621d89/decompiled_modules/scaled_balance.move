module 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::scaled_balance {
    public fun balance_of(arg0: u256, arg1: u256) : u256 {
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::ray_math::ray_mul(arg0, arg1)
    }

    public fun burn_scaled(arg0: u256, arg1: u256) : u256 {
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::ray_math::ray_div(arg0, arg1)
    }

    public fun mint_scaled(arg0: u256, arg1: u256) : u256 {
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::ray_math::ray_div(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

