module 0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::m {
    public fun redeem_penalty_amount<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::coin::value<T0>(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        assert!(v1 >= arg1, 201);
        if (v1 < arg2) {
            let v3 = 0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::div(0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::sub(0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::from(arg2), 0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::from(v1)), 0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::sub(0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::from(arg2), 0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::from(arg1)));
            0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::ceil(0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::add(0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::mul(0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::div(0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::mul(0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::from(arg3), 0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::from(v0)), 0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::from(arg5)), v3), 0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::mul(0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::div(0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::mul(0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::from(arg4), 0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::from(v0)), 0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::from(arg5)), 0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::sub(0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::from(1), v3))))
        } else {
            0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::ceil(0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::div(0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::mul(0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::from(arg4), 0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::from(v0)), 0x56c5c50c8ce96a31a942cfa7849b1aeafb5620179e78f0c148ec6ff95b1dda7b::decimal::from(arg5)))
        }
    }

    // decompiled from Move bytecode v6
}

