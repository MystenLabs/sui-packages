module 0xb4b1ca0c14d5dac6df1e1d6d120f13cc46761254b0e41c361e6c8eb60b764985::share_calculator {
    public(friend) fun calculate_shares_to_mint(arg0: 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal, arg1: 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal, arg2: u64) : u64 {
        if (0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::is_zero(&arg0)) {
            return 0
        };
        if (arg2 == 0) {
            assert!(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::is_zero(&arg1), 0);
            return 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::floor(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::mul(arg0, 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(0x1::u64::pow(10, 6))))
        };
        assert!(!0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::is_zero(&arg1), 1);
        0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::floor(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::div(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::mul(arg0, 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(arg2)), arg1))
    }

    public(friend) fun calculate_usd_to_return(arg0: u64, arg1: 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal, arg2: u64) : 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal {
        if (arg0 == 0 || arg2 == 0) {
            return 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::zero()
        };
        if (arg0 > arg2) {
            return 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::zero()
        };
        0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::div(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::mul(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(arg0), arg1), 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(arg2))
    }

    // decompiled from Move bytecode v6
}

