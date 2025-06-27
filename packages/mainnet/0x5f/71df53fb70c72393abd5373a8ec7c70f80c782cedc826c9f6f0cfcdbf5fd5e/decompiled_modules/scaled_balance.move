module 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::scaled_balance {
    public fun balance_of(arg0: u256, arg1: u256) : u256 {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(arg0, arg1)
    }

    public fun burn_scaled(arg0: u256, arg1: u256) : u256 {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(arg0, arg1)
    }

    public fun mint_scaled(arg0: u256, arg1: u256) : u256 {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

