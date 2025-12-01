module 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::value {
    public(friend) fun clock_now(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun coin_value(arg0: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal, arg1: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal, arg2: u8) : 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal {
        0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::div(0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::mul(arg0, arg1), 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::from(0x1::u64::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

