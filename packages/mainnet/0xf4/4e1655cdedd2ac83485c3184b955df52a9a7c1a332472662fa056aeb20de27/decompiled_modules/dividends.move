module 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::dividends {
    public fun allocate(arg0: u64, arg1: &vector<u128>) : (vector<u64>, u64) {
        let v0 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::dividend_summary::new();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(arg1)) {
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::dividend_summary::observe(&mut v0, *0x1::vector::borrow<u128>(arg1, v1));
            v1 = v1 + 1;
        };
        let v2 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::dividend_summary::finish(&v0, arg0);
        let v3 = vector[];
        let v4 = arg0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u128>(arg1)) {
            let v6 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::dividend_summary::payout(&v2, *0x1::vector::borrow<u128>(arg1, v5));
            v4 = v4 - v6;
            0x1::vector::push_back<u64>(&mut v3, v6);
            v5 = v5 + 1;
        };
        (v3, v4)
    }

    public fun ragequit_forfeit(arg0: u64) : (u64, u64, u64) {
        let v0 = arg0 / 2;
        let v1 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div(v0, 6000, 10000);
        (arg0 - v0, v1, v0 - v1)
    }

    public fun weight(arg0: u64, arg1: u64, arg2: u64) : u128 {
        (arg0 as u128) * (0x1::u64::min(arg1 / 86400000, 30) as u128) * (arg2 as u128)
    }

    // decompiled from Move bytecode v7
}

