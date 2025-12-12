module 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::math {
    public fun apply_slippage(arg0: u64, arg1: u64) : u64 {
        mul_div(arg0, 10000 - arg1, 10000)
    }

    public fun basis_points() : u64 {
        10000
    }

    public fun check_slippage(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg1 >= mul_div(arg0, 10000 - arg2, 10000)
    }

    public fun get_amount_in(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg0 > 0, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::insufficient_output_amount());
        assert!(arg1 > 0 && arg2 > 0, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::insufficient_liquidity());
        assert!(arg2 > arg0, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::insufficient_liquidity());
        arg1 * arg0 * 10000 / (arg2 - arg0) * (10000 - arg3) + 1
    }

    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg0 > 0, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::insufficient_input_amount());
        assert!(arg1 > 0 && arg2 > 0, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::insufficient_liquidity());
        let v0 = mul_div(arg0, 10000 - arg3, 10000);
        v0 * arg2 / (arg1 + v0)
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::zero_amount());
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= (18446744073709551615 as u128), 0xd79a17afa8df58530cb298dc8d4be6abc39cf5e26f9eb2b91b723e820388333f::erros::insufficient_input_amount());
        (v0 as u64)
    }

    public fun sqrt(arg0: u64) : u64 {
        if (arg0 < 4) {
            if (arg0 == 0) {
                0
            } else {
                1
            }
        } else {
            let v1 = arg0 / 2 + 1;
            while (v1 < arg0) {
                let v2 = arg0 / v1 + v1;
                v1 = v2 / 2;
            };
            arg0
        }
    }

    // decompiled from Move bytecode v6
}

