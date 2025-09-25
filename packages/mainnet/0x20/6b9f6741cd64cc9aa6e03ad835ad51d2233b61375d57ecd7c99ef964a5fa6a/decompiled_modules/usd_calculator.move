module 0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::usd_calculator {
    public(friend) fun decimal_usd_to_u64(arg0: 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal) : u64 {
        0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::floor(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::mul(arg0, 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(0x1::u64::pow(10, 6))))
    }

    // decompiled from Move bytecode v6
}

