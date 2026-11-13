module 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::win_curve {
    struct PositionKey has copy, drop, store {
        pos0: u64,
    }

    struct PositionCurveV1 has copy, drop, store {
        c_ppm: u64,
    }

    fun mul_div_below(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 200;
        while (v2 > 0) {
            v2 = v2 - 1;
            v1 = v1 * 2;
            let v3 = v0 * 2;
            v0 = v3;
            if (arg1 >> (v2 as u8) & 1 == 1) {
                v0 = v3 + arg0;
            };
            while (v0 >= arg2) {
                v0 = v0 - arg2;
                v1 = v1 + 1;
            };
        };
        v1
    }

    public fun on_open<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg3: u64) {
        let v0 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::win_curve_c_ppm<T0>(arg2);
        if (v0 == 0) {
            return
        };
        let v1 = PositionKey{pos0: arg3};
        let v2 = PositionCurveV1{c_ppm: v0};
        0x2::dynamic_field::add<PositionKey, PositionCurveV1>(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1), v1, v2);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_events::emit_set_win_curve_event(0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>>(arg1), arg3, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>>(arg2), v0);
    }

    public fun on_settle<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Position, arg3: &0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::position::Pnl, arg4: u128, arg5: u64, arg6: u64) : (u64, u64, u64) {
        let v0 = PositionKey{pos0: 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::position_id(arg2)};
        let v1 = 0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::position::pnl_raw(arg3);
        if (!0x2::dynamic_field::exists<PositionKey>(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg1), v0)) {
            return (v1, 0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::position::pnl_adjusted(arg3), 0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::position::pnl_win_fee(arg3))
        };
        let v2 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1);
        let PositionCurveV1 { c_ppm: v3 } = *0x2::dynamic_field::borrow<PositionKey, PositionCurveV1>(v2, v0);
        if (arg6 == 0) {
            0x2::dynamic_field::remove<PositionKey, PositionCurveV1>(v2, v0);
        };
        if (v1 == 0) {
            return (v1, 0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::position::pnl_adjusted(arg3), 0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::position::pnl_win_fee(arg3))
        };
        let v4 = raw_profit(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::position_is_long(arg2), 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::position_exposure(arg2), 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::position_entry(arg2), arg4, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::position_deadband_ppm(arg2), v3);
        let v5 = 0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::safety::trim_profit(v4, arg5);
        (v4, v5, (((v5 as u256) * (0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::position_win_fee_bps(arg2) as u256) / 10000) as u64))
    }

    public fun position_c_ppm<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: u64) : u64 {
        let v0 = PositionKey{pos0: arg1};
        if (0x2::dynamic_field::exists<PositionKey>(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg0), v0)) {
            0x2::dynamic_field::borrow<PositionKey, PositionCurveV1>(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg0), v0).c_ppm
        } else {
            0
        }
    }

    public fun raw_profit(arg0: bool, arg1: u64, arg2: u128, arg3: u128, arg4: u64, arg5: u64) : u64 {
        let v0 = arg0 && arg3 > arg2 || arg2 > arg3;
        if (!v0) {
            return 0
        };
        let v1 = (arg2 as u256);
        let v2 = if (arg0) {
            ((arg3 - arg2) as u256)
        } else {
            ((arg2 - arg3) as u256)
        };
        let v3 = v1 * (arg4 as u256) / 1000000;
        if (v2 <= v3) {
            return 0
        };
        let v4 = v2 - v3;
        let v5 = 18446744073709551615;
        let v6 = (arg1 as u256) * v4 / v1;
        if (arg5 == 0) {
            return (0x1::u256::min(v6, v5) as u64)
        };
        let v7 = v4 * 1000000;
        let v8 = v7 + (arg5 as u256) * v1;
        if (v6 <= v5) {
            return ((v6 * v7 / v8) as u64)
        };
        let v9 = v6 / v8;
        if (v9 > v5 / v7) {
            return (v5 as u64)
        };
        (0x1::u256::min(v9 * v7 + mul_div_below(v6 % v8, v7, v8), v5) as u64)
    }

    public fun release<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: u64) {
        let v0 = PositionKey{pos0: arg2};
        if (!0x2::dynamic_field::exists<PositionKey>(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg1), v0)) {
            return
        };
        0x2::dynamic_field::remove<PositionKey, PositionCurveV1>(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1), v0);
    }

    // decompiled from Move bytecode v7
}

