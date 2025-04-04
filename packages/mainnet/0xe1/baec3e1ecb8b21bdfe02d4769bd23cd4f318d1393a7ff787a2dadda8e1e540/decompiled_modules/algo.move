module 0xe1baec3e1ecb8b21bdfe02d4769bd23cd4f318d1393a7ff787a2dadda8e1e540::algo {
    public fun convert_current_price(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 327687);
        assert!(arg1 > 0 && arg2 > 0, 327688);
        (((arg0 as u128) * (arg2 as u128) / (arg1 as u128)) as u64)
    }

    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 327681);
        assert!(arg1 > 0 && arg2 > 0, 327682);
        (((arg0 as u128) * (arg2 as u128) / ((arg1 as u128) + (arg0 as u128))) as u64)
    }

    public fun get_coinx_coiny_by_lp_coin(arg0: u64, arg1: u64, arg2: u64, arg3: u128) : (u64, u64) {
        let v0 = (arg0 as u128) * (arg1 as u128) / arg3;
        let v1 = (arg0 as u128) * (arg2 as u128) / arg3;
        assert!(v0 > 0 && v1 > 0, 327684);
        ((v0 as u64), (v1 as u64))
    }

    public fun get_fee(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg1 as u128) * (arg0 as u128) / (arg2 as u128)) as u64)
    }

    public fun get_lp_coin_by_coinx_coiny_amount(arg0: u64, arg1: u64, arg2: u128, arg3: u64, arg4: u64, arg5: u64) : u64 {
        if (arg2 == 0) {
            let v1 = (0x2::math::sqrt_u128((arg0 as u128) * (arg1 as u128)) as u64);
            assert!(v1 > arg5, 327686);
            v1
        } else {
            0x2::math::min((((arg0 as u128) * arg2 / (arg3 as u128)) as u64), (((arg1 as u128) * arg2 / (arg4 as u128)) as u64))
        }
    }

    public fun get_no_loss_values(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64) {
        if (arg4 == 0 && arg5 == 0) {
            return (arg0, arg1)
        };
        let v0 = convert_current_price(arg0, arg4, arg5);
        if (v0 <= arg1) {
            assert!(v0 >= arg3, 327689);
            return (arg0, v0)
        };
        let v1 = convert_current_price(arg1, arg5, arg4);
        assert!(v1 <= arg0, 327697);
        assert!(v1 >= arg2, 327696);
        (v1, arg1)
    }

    // decompiled from Move bytecode v6
}

