module 0x6fe5ead9fec465c3a8bb644fbdc7c29da5c7d32ec84faa7c54aa7532faa2e781::trimmed_amount {
    struct TrimmedAmount has copy, drop, store {
        amount: u64,
        decimals: u8,
    }

    public fun amount(arg0: &TrimmedAmount) : u64 {
        arg0.amount
    }

    public fun decimals(arg0: &TrimmedAmount) : u8 {
        arg0.decimals
    }

    fun min(arg0: u8, arg1: u8) : u8 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun new(arg0: u64, arg1: u8) : TrimmedAmount {
        TrimmedAmount{
            amount   : arg0,
            decimals : arg1,
        }
    }

    public fun remove_dust<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u8, arg2: u8) : (TrimmedAmount, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::coin::value<T0>(arg0);
        let v1 = trim(v0, arg1, arg2);
        (v1, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg0), v0 - untrim(&v1, arg1)))
    }

    public fun scale(arg0: u64, arg1: u8, arg2: u8) : u64 {
        if (arg1 == arg2) {
            return arg0
        };
        if (arg1 > arg2) {
            let v1 = arg1 - arg2;
            assert!(v1 <= 18, 0);
            arg0 / 0x1::u64::pow(10, v1)
        } else {
            let v2 = arg2 - arg1;
            assert!(v2 <= 18, 0);
            let v3 = 0x1::u64::pow(10, v2);
            assert!(arg0 <= 18446744073709551615 / v3, 1);
            arg0 * v3
        }
    }

    public fun take_bytes(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::Cursor<u8>) : TrimmedAmount {
        new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u64_be(arg0), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::poke<u8>(arg0))
    }

    public fun to_bytes(arg0: &TrimmedAmount) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, arg0.decimals);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.amount);
        v0
    }

    public fun trim(arg0: u64, arg1: u8, arg2: u8) : TrimmedAmount {
        let v0 = min(8, min(arg1, arg2));
        new(scale(arg0, arg1, v0), v0)
    }

    public fun untrim(arg0: &TrimmedAmount, arg1: u8) : u64 {
        scale(arg0.amount, arg0.decimals, arg1)
    }

    // decompiled from Move bytecode v6
}

