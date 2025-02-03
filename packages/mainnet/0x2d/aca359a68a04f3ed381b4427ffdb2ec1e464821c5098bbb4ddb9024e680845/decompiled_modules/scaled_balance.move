module 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::scaled_balance {
    public fun balance_of(arg0: u256, arg1: u256) : u256 {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray_mul(arg0, arg1)
    }

    public fun burn_scaled(arg0: u256, arg1: u256) : u256 {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray_div(arg0, arg1)
    }

    public fun mint_scaled(arg0: u256, arg1: u256) : u256 {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray_div(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

