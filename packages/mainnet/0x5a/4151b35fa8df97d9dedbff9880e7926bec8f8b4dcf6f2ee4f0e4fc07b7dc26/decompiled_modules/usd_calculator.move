module 0x5a4151b35fa8df97d9dedbff9880e7926bec8f8b4dcf6f2ee4f0e4fc07b7dc26::usd_calculator {
    public(friend) fun decimal_usd_to_u64(arg0: 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal) : u64 {
        0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::floor(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::mul(arg0, 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(0x1::u64::pow(10, 6))))
    }

    // decompiled from Move bytecode v6
}

