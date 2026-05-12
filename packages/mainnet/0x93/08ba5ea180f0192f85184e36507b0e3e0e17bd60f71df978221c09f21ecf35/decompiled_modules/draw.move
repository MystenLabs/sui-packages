module 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::draw {
    struct DrawExecutedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        draw_id: u64,
        total_prize: u64,
        fee: u64,
        distributed: u64,
        fallback_mode: bool,
        n_depositors: u64,
        timestamp_ms: u64,
    }

    struct DrawSkippedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        reason: u8,
        timestamp_ms: u64,
    }

    fun derive_draw_id<T0>(arg0: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::Pool<T0>) : u64 {
        0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::last_draw_ms<T0>(arg0)
    }

    fun distribute_pro_rata_all<T0>(arg0: &mut 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::Pool<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: vector<address>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::total_principal<T0>(arg0);
        let v1 = 0x2::balance::value<T0>(arg1);
        if (v0 == 0 || v1 == 0) {
            return
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg2)) {
            let v3 = *0x1::vector::borrow<address>(&arg2, v2);
            let v4 = (((0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::user_balance<T0>(arg0, v3) as u128) * (v1 as u128) / (v0 as u128)) as u64);
            if (v4 >= 1 && 0x2::balance::value<T0>(arg1) >= v4) {
                0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::claim::create_record<T0>(0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::id<T0>(arg0), arg3, 10, v3, 0x2::balance::split<T0>(arg1, v4), arg4, arg5);
            };
            v2 = v2 + 1;
        };
    }

    public fun execute_draw_multi_tier<T0>(arg0: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::KeeperCap, arg1: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::KeeperRegistry, arg2: &mut 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::Pool<T0>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::assert_active(arg1, arg0);
        let v0 = 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::id<T0>(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::depositor_count<T0>(arg2);
        let v3 = 0x2::balance::value<T0>(&arg3);
        if (v2 == 0 || v3 == 0) {
            0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::add_fee<T0>(arg2, arg3);
            let v4 = if (v2 == 0) {
                0
            } else {
                1
            };
            let v5 = DrawSkippedEvent{
                pool_id      : v0,
                reason       : v4,
                timestamp_ms : v1,
            };
            0x2::event::emit<DrawSkippedEvent>(v5);
            0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::set_last_draw<T0>(arg2, v1);
            return
        };
        let v6 = (((v3 as u128) * (0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::prize_structure::fee_bps() as u128) / (0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::prize_structure::bps_denom() as u128)) as u64);
        if (v6 > 0) {
            0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::add_fee<T0>(arg2, 0x2::balance::split<T0>(&mut arg3, v6));
        };
        let v7 = derive_draw_id<T0>(arg2);
        let v8 = 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::depositor_list<T0>(arg2);
        let v9 = v2 < 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::prize_structure::small_pool_threshold();
        if (v9) {
            let v10 = &mut arg3;
            distribute_pro_rata_all<T0>(arg2, v10, v8, v7, v1, arg6);
        } else {
            let v11 = &mut arg3;
            distribute_pro_rata_all<T0>(arg2, v11, v8, v7, v1, arg6);
        };
        let v12 = 0x2::balance::value<T0>(&arg3);
        if (v12 > 0) {
            0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::add_fee<T0>(arg2, arg3);
        } else {
            0x2::balance::destroy_zero<T0>(arg3);
        };
        0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool::set_last_draw<T0>(arg2, v1);
        let v13 = DrawExecutedEvent{
            pool_id       : v0,
            draw_id       : v7,
            total_prize   : v3,
            fee           : v6,
            distributed   : 0x2::balance::value<T0>(&arg3) - v12,
            fallback_mode : v9,
            n_depositors  : v2,
            timestamp_ms  : v1,
        };
        0x2::event::emit<DrawExecutedEvent>(v13);
    }

    // decompiled from Move bytecode v7
}

