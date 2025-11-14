module 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::value {
    public(friend) fun clock_now(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun coin_value(arg0: 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal, arg1: 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal, arg2: u8) : 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal {
        0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::div(0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::mul(arg0, arg1), 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from(0x1::u64::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

