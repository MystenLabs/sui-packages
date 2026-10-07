module 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::launch {
    public fun create<T0, T1>(arg0: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: address, arg4: u64, arg5: u64, arg6: vector<address>, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: 0x2::coin::Coin<0x2::sui::SUI>, arg24: 0x2::coin::Coin<T1>, arg25: &0x2::clock::Clock, arg26: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg18 <= 10000, 106);
        let (v0, v1) = 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::new_curve<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg9, arg23, arg24, 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::launch_options(arg5, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17), arg25, arg26);
        let v2 = v1;
        let v3 = v0;
        if (arg18 > 0) {
            let v4 = (((0x2::coin::value<T0>(&v2) as u128) * (arg18 as u128) / (10000 as u128)) as u64);
            assert!(v4 > 0, 107);
            0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::farm::create_internal<T0, T1>(&mut v3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v2, v4, arg26)), arg19, arg20, arg21, arg22, 0x2::clock::timestamp_ms(arg25), arg26);
        };
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::share<T0, T1>(v3);
        v2
    }

    // decompiled from Move bytecode v7
}

