module 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::value {
    public(friend) fun clock_now(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun coin_value(arg0: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal, arg1: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal, arg2: u8) : 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal {
        0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::div(0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::mul(arg0, arg1), 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::from(0x1::u64::pow(10, arg2)))
    }

    // decompiled from Move bytecode v7
}

