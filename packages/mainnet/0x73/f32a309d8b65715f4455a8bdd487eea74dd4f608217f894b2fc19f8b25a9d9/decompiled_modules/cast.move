module 0x73f32a309d8b65715f4455a8bdd487eea74dd4f608217f894b2fc19f8b25a9d9::cast {
    public fun balance_value_u128<T0>(arg0: &0x2::balance::Balance<T0>) : u128 {
        (0x2::balance::value<T0>(arg0) as u128)
    }

    public fun u64_to_u128(arg0: u64) : u128 {
        (arg0 as u128)
    }

    // decompiled from Move bytecode v7
}

