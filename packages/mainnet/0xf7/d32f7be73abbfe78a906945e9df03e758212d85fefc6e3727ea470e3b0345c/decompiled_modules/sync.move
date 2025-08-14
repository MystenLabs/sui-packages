module 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::sync {
    public fun sync_gauge<T0, T1>(arg0: &mut 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::ve_mmt::VeMMT, arg1: address, arg2: &mut 0x1e90b0d9a2550f817baecce1ecf6e8b6cb1504c13dc85e57ee39f510b2fe92d4::pool::Pool<T0, T1>, arg3: &0x1e90b0d9a2550f817baecce1ecf6e8b6cb1504c13dc85e57ee39f510b2fe92d4::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::ve_mmt::assert_supported_version(arg0);
        let (v0, v1, v2, v3) = 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::ve_mmt::gauge_fields(arg0);
        let v4 = 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::gauge_globals::get_gauge_not_paused(v2, &arg1);
        let v5 = 0x1e90b0d9a2550f817baecce1ecf6e8b6cb1504c13dc85e57ee39f510b2fe92d4::pool::pool_id<T0, T1>(arg2);
        assert!(0x2::object::id_to_address(&v5) == 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::gauge::pool_id(v4), 0);
        let (v6, v7) = 0x1e90b0d9a2550f817baecce1ecf6e8b6cb1504c13dc85e57ee39f510b2fe92d4::ve::collect_protocol_fee_with_cap<T0, T1>(arg2, v3, 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::consts::max_u64(), 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::consts::max_u64(), arg3, arg5);
        let v8 = v7;
        let v9 = v6;
        let v10 = 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::gauge::fee_last_claimed_ms(v4);
        let v11 = 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::epoch::epoch_id(v1, v10);
        let v12 = 0x2::clock::timestamp_ms(arg4);
        let v13 = v12 - v10;
        while (v11 < 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::epoch::epoch_id(v1, v12)) {
            let v14 = 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::epoch::epoch_end(v1, v11);
            0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::gauge::add_fees<T0, T1>(v4, 0x2::balance::split<T0>(&mut v9, 0x1e90b0d9a2550f817baecce1ecf6e8b6cb1504c13dc85e57ee39f510b2fe92d4::full_math_u64::mul_div_floor(0x2::balance::value<T0>(&v9), v14 - v10, v13)), 0x2::balance::split<T1>(&mut v8, 0x1e90b0d9a2550f817baecce1ecf6e8b6cb1504c13dc85e57ee39f510b2fe92d4::full_math_u64::mul_div_floor(0x2::balance::value<T1>(&v8), v14 - v10, v13)), v14);
            0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::gauge::advance_epoch(v4, v0, v1, arg5);
            v11 = v11 + 1;
            v10 = 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::epoch::epoch_start(v1, v11);
        };
        0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::gauge::add_fees<T0, T1>(v4, v9, v8, v12);
    }

    // decompiled from Move bytecode v6
}

