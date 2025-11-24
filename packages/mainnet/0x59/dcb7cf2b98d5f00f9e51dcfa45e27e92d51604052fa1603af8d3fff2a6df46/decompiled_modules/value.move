module 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::value {
    public(friend) fun clock_now(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun coin_value(arg0: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal, arg1: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal, arg2: u8) : 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal {
        0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::div(0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::mul(arg0, arg1), 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::from(0x1::u64::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

