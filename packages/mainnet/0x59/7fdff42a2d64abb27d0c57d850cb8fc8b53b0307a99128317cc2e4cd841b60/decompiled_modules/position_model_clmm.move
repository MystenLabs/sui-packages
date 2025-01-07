module 0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::position_model_clmm {
    struct PositionModel has copy, drop {
        sqrt_pa_x64: u128,
        sqrt_pb_x64: u128,
        l: u128,
        cx: u64,
        cy: u64,
        dx: u64,
        dy: u64,
    }

    public fun assets_x128(arg0: &PositionModel, arg1: u256) : u256 {
        let v0 = (0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::sqrt_u256(arg1) as u128);
        ((x_x64(arg0, v0) as u256) + ((arg0.cx as u256) << 64)) * (arg1 >> 64) + (y_x64(arg0, v0) as u256) + ((arg0.cy as u256) << 64) << 64
    }

    public fun calc_liquidate_col_x(arg0: &PositionModel, arg1: u256, arg2: u64, arg3: u16, arg4: u16, arg5: u16) : (u64, u64) {
        if (!margin_below_threshold(arg0, arg1, arg3)) {
            return (0, 0)
        };
        if (!is_fully_deleveraged(arg0)) {
            return (0, 0)
        };
        if (arg0.cx == 0 || arg2 == 0) {
            return (0, 0)
        };
        let v0 = (arg0.dy as u256) << 64;
        let v1 = (arg0.cx as u256) * (arg1 >> 64);
        let v2 = 0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::min_u256(((arg2 as u256) << 64 << 64) / v0, (calc_max_liq_factor_x64((0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::min_u256((v1 << 64) / v0, (340282366920938463463374607431768211455 as u256)) as u128), arg3, arg4, arg5) as u256)) * v0 >> 64;
        ((0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::min_u256(0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::divide_and_round_up_u256(v2, 18446744073709551616), (arg2 as u256)) as u64), (0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::min_u256(0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::divide_and_round_up_u256((v2 * (18446744073709551616 + ((arg4 as u256) << 64) / 10000) >> 64) * (arg0.cx as u256), v1), (arg0.cx as u256)) as u64))
    }

    public fun calc_liquidate_col_y(arg0: &PositionModel, arg1: u256, arg2: u64, arg3: u16, arg4: u16, arg5: u16) : (u64, u64) {
        if (!margin_below_threshold(arg0, arg1, arg3)) {
            return (0, 0)
        };
        if (!is_fully_deleveraged(arg0)) {
            return (0, 0)
        };
        if (arg0.cy == 0 || arg2 == 0) {
            return (0, 0)
        };
        let v0 = (arg0.dx as u256) * (arg1 >> 64);
        let v1 = 0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::min_u256(((arg2 as u256) << 64) / (arg0.dx as u256), (calc_max_liq_factor_x64((0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::min_u256(((arg0.cy as u256) << 64 << 64) / v0, (340282366920938463463374607431768211455 as u256)) as u128), arg3, arg4, arg5) as u256));
        ((0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::min_u256(0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::divide_and_round_up_u256(v1 * (arg0.dx as u256), 18446744073709551616), (arg2 as u256)) as u64), (0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::min_u256(0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::divide_and_round_up_u256((v1 * v0 >> 64) * (18446744073709551616 + ((arg4 as u256) << 64) / 10000) >> 64, 18446744073709551616), (arg0.cy as u256)) as u64))
    }

    public fun calc_max_deleverage_delta_l(arg0: &PositionModel, arg1: u256, arg2: u16, arg3: u16) : u128 {
        if (arg0.dx == 0 && arg0.dy == 0) {
            return 0
        };
        let v0 = ((arg2 as u128) << 64) / 10000;
        let v1 = margin_x64(arg0, arg1);
        if (v1 >= v0) {
            return 0
        };
        if (v1 <= 18446744073709551616) {
            return arg0.l
        };
        let v2 = ((arg1 >> 64) as u128);
        let v3 = (0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::sqrt_u256(arg1) as u128);
        let v4 = ((((v0 << 64) - (v1 << 64) + 0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::min_u128(((arg3 as u128) << 64) / 10000, 18446744073709551616) * (v1 - 18446744073709551616)) / (v0 - 18446744073709551616)) as u256);
        let v5 = (arg0.dx as u256) * (v2 as u256) + ((arg0.dy as u256) << 64);
        let v6 = 0x2::math::min(arg0.dx, arg0.cx);
        let v7 = 0x2::math::min(arg0.dy, arg0.cy);
        let v8 = (v6 as u256) * (v2 as u256) + ((v7 as u256) << 64);
        if (v8 << 64 >= v5 * v4) {
            return 0
        };
        if (v5 - v8 == 0) {
            return 0
        };
        let v9 = ((arg0.dx - v6) as u128) << 64;
        let v10 = ((arg0.dy - v7) as u128) << 64;
        let v11 = x_x64(arg0, v3);
        let v12 = y_x64(arg0, v3);
        let v13 = ((v11 as u256) * (v2 as u256) >> 64) + (v12 as u256);
        let v14 = 0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::divide_and_round_up_u256((((v9 as u256) * (v2 as u256) >> 64) + (v10 as u256)) * (((v5 * v4 - (v8 << 64)) / (v5 - v8)) as u256), 18446744073709551616);
        let v15 = if (v14 >= v13) {
            arg0.l
        } else {
            (0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::divide_and_round_up_u256((arg0.l as u256) * (v14 << 64) / v13, 18446744073709551616) as u128)
        };
        let v16 = x_by_liquidity_x64(arg0, v3, v15);
        let v17 = y_by_liquidity_x64(arg0, v3, v15);
        if (v16 <= v9 && v17 <= v10) {
            v15
        } else if (v16 >= v9 && v17 >= v10) {
            if (v16 == v9 || v17 == v10) {
                return v15
            };
            let v19 = if (mul_x64(v16, v10) > mul_x64(v17, v9)) {
                0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::saturating_muldiv_round_up_u128(arg0.l, v10, v12)
            } else {
                0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::saturating_muldiv_round_up_u128(arg0.l, v9, v11)
            };
            0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::min_u128(v19, arg0.l)
        } else if (v16 < v9) {
            let v20 = 0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::muldiv_round_up_u128(v17 - v10, 18446744073709551616, v2) + v16;
            if (v20 >= v11 || v11 == 0) {
                return arg0.l
            };
            0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::muldiv_round_up_u128(arg0.l, v20, v11)
        } else {
            let v21 = 0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::muldiv_round_up_u128(v16 - v9, v2, 18446744073709551616) + v17;
            if (v21 >= v12 || v12 == 0) {
                return arg0.l
            };
            0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::muldiv_round_up_u128(arg0.l, v21, v12)
        }
    }

    public fun calc_max_liq_factor_x64(arg0: u128, arg1: u16, arg2: u16, arg3: u16) : u128 {
        let v0 = (arg0 as u256);
        let v1 = (184467440737095516160000 + ((arg2 as u256) << 64)) / 10000;
        let v2 = 0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::max_u256(((arg1 as u256) << 64) / 10000, v1);
        if (v0 >= v2) {
            0
        } else if (v0 < v1) {
            (((v0 << 64) / v1) as u128)
        } else if (v2 - v0 >= v0 - v1) {
            18446744073709551616
        } else {
            ((((v2 << 64) - (v0 << 64) + 0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::min_u256(((arg3 as u256) << 64) / 10000, 18446744073709551616) * (v0 - v1)) / (v2 - v1)) as u128)
        }
    }

    public fun create(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : PositionModel {
        PositionModel{
            sqrt_pa_x64 : arg0,
            sqrt_pb_x64 : arg1,
            l           : arg2,
            cx          : arg3,
            cy          : arg4,
            dx          : arg5,
            dy          : arg6,
        }
    }

    public fun cx(arg0: &PositionModel) : u64 {
        arg0.cx
    }

    public fun cy(arg0: &PositionModel) : u64 {
        arg0.cy
    }

    public fun debt_x128(arg0: &PositionModel, arg1: u256) : u256 {
        ((arg0.dx as u256) << 64) * (arg1 >> 64) + ((arg0.dy as u256) << 128)
    }

    public fun dx(arg0: &PositionModel) : u64 {
        arg0.dx
    }

    public fun dy(arg0: &PositionModel) : u64 {
        arg0.dy
    }

    public fun is_fully_deleveraged(arg0: &PositionModel) : bool {
        if (arg0.l > 0) {
            return false
        };
        if (arg0.dx > 0 && arg0.cx > 0) {
            return false
        };
        if (arg0.dy > 0 && arg0.cy > 0) {
            return false
        };
        true
    }

    public fun l(arg0: &PositionModel) : u128 {
        arg0.l
    }

    public fun margin_below_threshold(arg0: &PositionModel, arg1: u256, arg2: u16) : bool {
        margin_x64(arg0, arg1) < ((arg2 as u128) << 64) / 10000
    }

    public fun margin_x64(arg0: &PositionModel, arg1: u256) : u128 {
        if (arg0.dx == 0 && arg0.dy == 0) {
            return 340282366920938463463374607431768211455
        };
        let v0 = (0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::sqrt_u256(arg1) as u128);
        let v1 = ((arg1 >> 64) as u256);
        (0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::min_u256((((x_x64(arg0, v0) as u256) + ((arg0.cx as u256) << 64)) * v1 + ((y_x64(arg0, v0) as u256) << 64) + ((arg0.cy as u256) << 128)) / (((arg0.dx as u256) << 64) * v1 + ((arg0.dy as u256) << 128) >> 64), (340282366920938463463374607431768211455 as u256)) as u128)
    }

    fun mul_x64(arg0: u128, arg1: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) >> 64) as u128)
    }

    public fun sqrt_pa_x64(arg0: &PositionModel) : u128 {
        arg0.sqrt_pa_x64
    }

    public fun sqrt_pb_x64(arg0: &PositionModel) : u128 {
        arg0.sqrt_pb_x64
    }

    public fun sqrt_ph_x64(arg0: u128, arg1: u16) : u128 {
        mul_x64(arg0, (0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::sqrt_u256(10000 + (arg1 as u256) << 128) as u128)) / 100
    }

    public fun sqrt_pl_x64(arg0: u128, arg1: u16) : u128 {
        mul_x64(arg0, (0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::sqrt_u256(10000 - (arg1 as u256) << 128) as u128)) / 100
    }

    public fun x_by_liquidity_x64(arg0: &PositionModel, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 <= arg0.l, 0);
        if (arg1 >= arg0.sqrt_pb_x64) {
            return 0
        };
        if (arg1 < arg0.sqrt_pa_x64) {
            return x_by_liquidity_x64(arg0, arg0.sqrt_pa_x64, arg2)
        };
        (0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::min_u256((arg2 as u256) * (((arg0.sqrt_pb_x64 - arg1) as u256) << 128) / (arg1 as u256) * (arg0.sqrt_pb_x64 as u256), (340282366920938463463374607431768211455 as u256)) as u128)
    }

    public fun x_x64(arg0: &PositionModel, arg1: u128) : u128 {
        x_by_liquidity_x64(arg0, arg1, arg0.l)
    }

    public fun y_by_liquidity_x64(arg0: &PositionModel, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 <= arg0.l, 0);
        if (arg1 <= arg0.sqrt_pa_x64) {
            return 0
        };
        if (arg1 > arg0.sqrt_pb_x64) {
            return y_by_liquidity_x64(arg0, arg0.sqrt_pb_x64, arg2)
        };
        (0x597fdff42a2d64abb27d0c57d850cb8fc8b53b0307a99128317cc2e4cd841b60::util::min_u256((arg2 as u256) * ((arg1 - arg0.sqrt_pa_x64) as u256), (340282366920938463463374607431768211455 as u256)) as u128)
    }

    public fun y_x64(arg0: &PositionModel, arg1: u128) : u128 {
        y_by_liquidity_x64(arg0, arg1, arg0.l)
    }

    // decompiled from Move bytecode v6
}

