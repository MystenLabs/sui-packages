module 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::adaptive_curve_irm {
    struct AdaptiveCurveIrm has store {
        rate_at_target: 0x2::table::Table<u64, 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::SignedInt>,
    }

    public(friend) fun borrow_rate(arg0: &mut AdaptiveCurveIrm, arg1: u64, arg2: u128, arg3: u128, arg4: u64, arg5: &0x2::clock::Clock) : u128 {
        let (v0, v1) = compute_borrow_rate(arg0, arg1, arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5));
        let v2 = v1;
        let v3 = v0;
        if (0x2::table::contains<u64, 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::SignedInt>(&arg0.rate_at_target, arg1)) {
            *0x2::table::borrow_mut<u64, 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::SignedInt>(&mut arg0.rate_at_target, arg1) = v2;
        } else {
            0x2::table::add<u64, 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::SignedInt>(&mut arg0.rate_at_target, arg1, v2);
        };
        let v4 = 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_value(&v3);
        0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::events::emit_borrow_rate_update(arg1, v4, 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_value(&v2));
        v4
    }

    public(friend) fun borrow_rate_view(arg0: &AdaptiveCurveIrm, arg1: u64, arg2: u128, arg3: u128, arg4: u64, arg5: &0x2::clock::Clock) : u128 {
        let (v0, _) = compute_borrow_rate(arg0, arg1, arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5));
        let v2 = v0;
        0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_value(&v2)
    }

    fun compute_borrow_rate(arg0: &AdaptiveCurveIrm, arg1: u64, arg2: u128, arg3: u128, arg4: u64, arg5: u64) : (0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::SignedInt, 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::SignedInt) {
        let v0 = if (arg2 > 0) {
            0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_from_u128(0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::math::w_div_down(arg3, arg2))
        } else {
            0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_zero()
        };
        let v1 = 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_from_u128(900000000000000000);
        let v2 = if (0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_gte(v0, v1)) {
            0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_from_u128(0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::math::wad() - 900000000000000000)
        } else {
            v1
        };
        let v3 = 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_w_div_to_zero(0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_sub(v0, v1), v2);
        let v4 = if (0x2::table::contains<u64, 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::SignedInt>(&arg0.rate_at_target, arg1)) {
            *0x2::table::borrow<u64, 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::SignedInt>(&arg0.rate_at_target, arg1)
        } else {
            0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_zero()
        };
        let v5 = v4;
        let (v6, v7) = if (0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_value(&v5) == 0) {
            (0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_from_u128(1268391680), 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_from_u128(1268391680))
        } else {
            let v8 = 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_w_mul_to_zero(0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_from_u128(1585489599189), v3);
            let v9 = if (arg4 == 0) {
                0
            } else {
                arg5 - arg4
            };
            let v10 = 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_int(0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_value(&v8) * ((v9 / 1000) as u128), 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_is_negative(&v8));
            if (0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_value(&v10) == 0) {
                (v5, v5)
            } else {
                let v11 = new_rate_at_target(v5, v10);
                let v12 = new_rate_at_target(v5, 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_halve(&v10));
                let v13 = 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_add(0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_add(v5, v11), 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_double(&v12));
                (0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_quarter(&v13), v11)
            }
        };
        (curve(v6, v3), v7)
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : AdaptiveCurveIrm {
        AdaptiveCurveIrm{rate_at_target: 0x2::table::new<u64, 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::SignedInt>(arg0)}
    }

    fun curve(arg0: 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::SignedInt, arg1: 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::SignedInt) : 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::SignedInt {
        let v0 = 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_from_u128(0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::math::wad());
        let v1 = if (0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_is_negative(&arg1)) {
            0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_sub(v0, 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_w_div_to_zero(v0, 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_from_u128(4000000000000000000)))
        } else {
            0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_sub(0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_from_u128(4000000000000000000), v0)
        };
        0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_w_mul_to_zero(0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_add(0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_w_mul_to_zero(v1, arg1), v0), arg0)
    }

    fun new_rate_at_target(arg0: 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::SignedInt, arg1: 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::SignedInt) : 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::SignedInt {
        0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_bound(0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_w_mul_to_zero(arg0, 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::w_exp(arg1)), 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_from_u128(31709792), 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_from_u128(63419583968))
    }

    public(friend) fun rate_at_target_view(arg0: &AdaptiveCurveIrm, arg1: u64) : u128 {
        if (0x2::table::contains<u64, 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::SignedInt>(&arg0.rate_at_target, arg1)) {
            0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::signed_value(0x2::table::borrow<u64, 0x7180185b0b4f322c8dcc3d925e55a59af53d5abdd5158adf2736990b0e9ca904::signed_int::SignedInt>(&arg0.rate_at_target, arg1))
        } else {
            1268391680
        }
    }

    // decompiled from Move bytecode v6
}

