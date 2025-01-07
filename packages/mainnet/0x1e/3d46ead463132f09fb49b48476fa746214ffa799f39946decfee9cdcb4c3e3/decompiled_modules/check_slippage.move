module 0x1e3d46ead463132f09fb49b48476fa746214ffa799f39946decfee9cdcb4c3e3::check_slippage {
    public fun check_slippage<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    public fun check_slippage_and_type<T0>(arg0: &0x2::coin::Coin<T0>, arg1: 0x1::ascii::String, arg2: u64) {
        assert!(arg1 == 0x1::type_name::into_string(0x1::type_name::get<T0>()), 0);
        assert!(0x2::coin::value<T0>(arg0) >= arg2, 1);
    }

    public fun cut_remainder(arg0: u64, arg1: u64) : u64 {
        arg1 - arg1 % arg0
    }

    // decompiled from Move bytecode v6
}

