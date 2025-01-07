module 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::core_amm {
    public fun convert_current_price(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 327685);
        assert!(arg1 > 0 && arg2 > 0, 327686);
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
        assert!(v0 > 0 && v1 > 0, 327683);
        ((v0 as u64), (v1 as u64))
    }

    public fun get_fee(arg0: u64, arg1: u64) : u64 {
        (((arg1 as u128) * (arg0 as u128) / (0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::constants::get_fee_base_of_percentage() as u128)) as u64)
    }

    public fun get_fee_exact_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg1 as u128) * (arg0 as u128) / ((0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::constants::get_fee_base_of_percentage() - arg2) as u128)) as u64)
    }

    public fun get_lp_coin_by_coinx_coiny_amount(arg0: u64, arg1: u64, arg2: u128, arg3: u64, arg4: u64) : u64 {
        if (arg2 == 0) {
            let v1 = (0x2::math::sqrt_u128((arg0 as u128) * (arg1 as u128)) as u64);
            assert!(v1 > 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::constants::get_min_lp_value(), 327684);
            v1
        } else {
            0x2::math::min(((arg2 * (arg0 as u128) / (arg3 as u128)) as u64), ((arg2 * (arg1 as u128) / (arg4 as u128)) as u64))
        }
    }

    public fun get_no_loss_values(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64) {
        if (arg5 == 0 && arg4 == 0) {
            (arg0, arg1)
        } else {
            let v2 = convert_current_price(arg0, arg5, arg4);
            if (v2 <= arg1) {
                assert!(v2 >= arg3, 327688);
                (arg0, v2)
            } else {
                let v3 = convert_current_price(arg1, arg4, arg5);
                assert!(v3 <= arg0, 327689);
                assert!(v3 >= arg2, 327687);
                (v3, arg1)
            }
        }
    }

    // decompiled from Move bytecode v6
}

