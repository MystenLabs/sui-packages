module 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::pool_math {
    public(friend) fun assert_lp_supply_reserve_ratio(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!((arg2 as u128) * (arg1 as u128) >= (arg0 as u128) * (arg3 as u128), 3);
    }

    fun lp_tokens_to_mint(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (arg2 == 0) {
            if (arg4 == 0) {
                return arg3
            };
            (0x1::u128::sqrt((arg3 as u128) * (arg4 as u128)) as u64)
        } else if (arg1 == 0) {
            0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::math::safe_mul_div(arg3, arg2, arg0)
        } else {
            0x1::u64::min(0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::math::safe_mul_div(arg3, arg2, arg0), 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::math::safe_mul_div(arg4, arg2, arg1))
        }
    }

    public(friend) fun quote_deposit(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64, u64) {
        let (v0, v1) = tokens_to_deposit(arg0, arg1, arg3, arg4);
        let v2 = lp_tokens_to_mint(arg0, arg1, arg2, v0, v1);
        assert!(v2 > 0, 6);
        (v0, v1, v2)
    }

    public(friend) fun quote_redeem(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64) {
        let v0 = 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::math::safe_mul_div(arg0, arg3, arg2);
        let v1 = 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::math::safe_mul_div(arg1, arg3, arg2);
        assert!(v0 >= arg4, 1);
        assert!(v1 >= arg5, 2);
        (v0, v1)
    }

    fun tokens_to_deposit(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        assert!(arg2 > 0, 4);
        if (arg0 == 0 && arg1 == 0) {
            (arg2, arg3)
        } else {
            let v2 = 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::math::checked_mul_div_up(arg2, arg1, arg0);
            let v3 = 0x1::option::is_none<u64>(&v2) || *0x1::option::borrow<u64>(&v2) > arg3;
            if (!v3) {
                (arg2, *0x1::option::borrow<u64>(&v2))
            } else {
                let v4 = 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::math::safe_mul_div_up(arg3, arg0, arg1);
                assert!(v4 > 0, 5);
                assert!(v4 <= arg2, 0);
                (v4, arg3)
            }
        }
    }

    // decompiled from Move bytecode v6
}

