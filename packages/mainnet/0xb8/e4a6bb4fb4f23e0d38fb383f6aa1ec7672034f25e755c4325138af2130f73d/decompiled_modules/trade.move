module 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::trade {
    struct PartialCloseEventV1 has copy, drop {
        position_id: u64,
        account_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        exit_wad: u128,
        closed_margin: u64,
        closed_notional: u64,
        closed_exposure: u64,
        margin_left: u64,
        notional_left: u64,
        exposure_left: u64,
        gross: u64,
        net: u64,
        queued: bool,
        builder_amount: u64,
        returned: u64,
    }

    struct Settled has copy, drop {
        loss: u64,
        user_profit: u64,
        loss_fee: u64,
        discount: u64,
        builder_fee: u64,
        retained: u64,
        queued: bool,
        returned: u64,
    }

    public(friend) fun account_notional_ok<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg4: u64, arg5: u64) : bool {
        let v0 = locked_notional<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        if (v0 == 0) {
            return false
        };
        let v1 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::risk<T0>(arg1);
        (0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::open_notional<T0>(arg2) as u128) + v0 <= (0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::max_account_notional(&v1) as u128)
    }

    fun apply_pnl<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Position, arg4: &0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::position::Pnl, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool) : Settled {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue_on<T0>(arg2, arg0);
        let v1 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::position::pnl_loss(arg4);
        let v2 = v1;
        if (v1 > arg7) {
            v2 = arg7;
        };
        let v3 = if (v2 > 0) {
            0
        } else {
            arg6
        };
        let v4 = if (v2 > 0) {
            0
        } else {
            arg5 - v3
        };
        let v5 = arg7 - v2;
        let v6 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::position::pnl_close_toll(arg4);
        let v7 = if (v6 < v4) {
            v6
        } else {
            v4
        };
        let v8 = v6 - v7;
        let v9 = if (v8 < v5) {
            v8
        } else {
            v5
        };
        let v10 = v5 - v9;
        let v11 = v4 - v7;
        let v12 = if (v2 > 0) {
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::realize_loss<T0>(&v0, arg0, v2, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::loss_fee_bps(arg2))
        } else {
            0
        };
        let v13 = 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>>(arg1);
        let v14 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::owner<T0>(arg1);
        let v15 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_builder_id(arg3);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::credit_account_free<T0>(&v0, arg0, v13, v10);
        let v16 = v3 + v4;
        let v17 = if (v2 > 0) {
            0
        } else {
            0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::builder::on_top_fee(v16, (0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::builder::close_fee_bps<T0>(arg0, arg2, v15, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_builder_fee(arg3)) as u64))
        };
        let v18 = if (v17 > v11) {
            v11
        } else {
            v17
        };
        let v19 = v11 - v18;
        0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::mint_cap::note_pnl<T0>(&v0, arg0, arg8, v2 - v12, v16);
        let v20 = if (v16 > 0) {
            if (!0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::queue_nonempty<T0>(arg0)) {
                0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::lp_cash<T0>(arg0) >= v16
            } else {
                false
            }
        } else {
            false
        };
        let v21 = v9;
        let v22 = false;
        if (v20) {
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::debit_lp<T0>(&v0, arg0, v16);
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::debit_tracked<T0>(&v0, arg0, v16);
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::credit_account_free<T0>(&v0, arg0, v13, v19);
            if (v18 > 0 && 0x1::option::is_some<u32>(&v15)) {
                0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::builder::pay_on_top<T0>(arg0, *0x1::option::borrow<u32>(&v15), v14, v13, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_id(arg3), v16, v18);
            };
            v21 = v9 + v7 + v3;
        } else if (v16 > 0) {
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::enqueue_with_split<T0>(&v0, arg0, arg2, v14, v13, v19, v3 + v7, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_id(arg3), v15, v18, v16, arg9, v9);
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::debit_tracked<T0>(&v0, arg0, v16);
            v22 = true;
        };
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::add_fee<T0>(&v0, arg0, v21);
        let v23 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::referral::quote<T0>(arg0, v14, v21, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::referral_accrual_live(arg2), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::referee_discount_bps(arg2), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::referral_fee_bps(arg2), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::second_level_fee_bps(arg2));
        let v24 = v21 - 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::referral::charged(&v23);
        if (v24 > 0) {
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::debit_fee_lp<T0>(&v0, arg0, v24);
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::credit_account_free<T0>(&v0, arg0, v13, v24);
        };
        let v25 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::referral::protocol_remainder(&v23);
        0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::referral::pay_open_rewards<T0>(arg0, v23);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::route_retained<T0>(&v0, arg0, arg2, v25 + v12);
        Settled{
            loss        : v2,
            user_profit : v19,
            loss_fee    : v12,
            discount    : v24,
            builder_fee : v18,
            retained    : v25 + v12,
            queued      : v22,
            returned    : v10 + v19 + v24,
        }
    }

    public(friend) fun assert_open_risk<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: u64, arg3: u64) {
        let v0 = open_risk_code<T0>(arg0, arg1, arg2, arg3);
        assert!(v0 != 1, 13836185084765929481);
        assert!(v0 != 2, 13841814588597731377);
        assert!(v0 != 3 && v0 != 4, 13836466568332705803);
    }

    fun assert_positions_unpaused<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config) {
        assert!(!0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::oracle_killed<T0>(arg0), 13840693657967525929);
    }

    fun assert_reconcile_unpaused<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config) {
        assert!(!0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::oracle_killed<T0>(arg0), 13840692219153481769);
    }

    fun bps_part(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun check_market<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::ReserveCheck, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg2: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg4: 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::PriceReceipt) {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue_on<T0>(arg3, arg1);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_version(arg3);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_version<T0>(arg1);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_version<T0>(arg2);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_exchange<T0>(arg2, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg1));
        assert!(!0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::session_pending<T0>(arg2), 13844915885699104835);
        assert!(0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::market_id(&arg4) == 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg2), 13839849340411183139);
        assert!(!0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::oracle_killed<T0>(arg2), 13840693778226610217);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_unpaused(arg3, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::pause_lp());
        assert!(!0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::is_closed(&arg4), 13842101161700753459);
        let v1 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::timestamp_ms(&arg4);
        let v2 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::sequence(&arg4);
        assert!(v1 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::last_oracle_ts_ms<T0>(arg2) && v2 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::last_oracle_sequence<T0>(arg2), 13835908725095137287);
        let v3 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::price_wad(&arg4);
        refresh_reserve<T0>(arg1, arg2, arg3, v3);
        stamp<T0>(&v0, arg2, v3, v1, v2, 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::slot(&arg4));
        0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::discard_price(arg4);
        if (0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::in_oi_set<T0>(arg1, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg2))) {
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::note_checked(&v0, arg0, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg1), 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg2));
        };
    }

    public fun close_at_cap<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg4: u64, arg5: 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::is_order_keeper(arg3, 0x2::tx_context::sender(arg7)), 13845757475951214665);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::assert_version<T0>(arg2);
        0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::fees::discard_zero_loss(close_part_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 0, 2, 10000, arg6, arg7));
    }

    public(friend) fun close_inner<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg4: u64, arg5: 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::PriceReceipt, arg6: u128, arg7: u8, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::fees::LossTicket {
        close_part_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 10000, arg8, arg9)
    }

    public(friend) fun close_part_inner<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg4: u64, arg5: 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::PriceReceipt, arg6: u128, arg7: u8, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::fees::LossTicket {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue_on<T0>(arg3, arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_version(arg3);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_version<T0>(arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_version<T0>(arg1);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_exchange<T0>(arg1, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0));
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::assert_exchange<T0>(arg2, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0));
        guarded_reconcile<T0>(&v0, arg1, arg2, arg3);
        assert_positions_unpaused<T0>(arg1, arg3);
        assert!(!0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::session_pending<T0>(arg1), 13844912252156772419);
        let v1 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::status<T0>(arg1);
        assert!(v1 == 1 || v1 == 2, 13835623586511192069);
        assert!(0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::market_id(&arg5) == 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg1), 13839845715458785315);
        assert!(!0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::is_closed(&arg5), 13842097519568486451);
        let v2 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::remove_position<T0>(&v0, arg2, arg4);
        assert!(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_market(&v2) == 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg1), 13839845728343687203);
        let v3 = 0x2::clock::timestamp_ms(arg9);
        assert!(v3 != 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_opened_at(&v2), 13838438362049413145);
        let v4 = if (arg7 == 1) {
            true
        } else {
            let v5 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::timing<T0>(arg1);
            v3 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_opened_at(&v2) + 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::min_hold_ms(&v5)
        };
        assert!(v4, 13838719858501091355);
        let v6 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::timestamp_ms(&arg5);
        let v7 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::sequence(&arg5);
        let v8 = arg7 != 1;
        assert!(v6 > 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_oracle_ts(&v2) && (!v8 || v6 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::last_oracle_ts_ms<T0>(arg1)), 13835905130207510535);
        assert!(v7 > 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_oracle_sequence(&v2) && (!v8 || v7 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::last_oracle_sequence<T0>(arg1)), 13835905134502477831);
        let v9 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::price_wad(&arg5);
        assert!(!0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::position::crossed_bust(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_is_long(&v2), v9, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_bust(&v2)), 13839001367837671453);
        let v10 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_is_long(&v2);
        let v11 = if (v10) {
            0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::bid_wad(&arg5)
        } else {
            0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::ask_wad(&arg5)
        };
        assert!(exit_within(v10, v11, arg6), 13844067930305462333);
        let (v12, _) = reserve_mark<T0>(arg1, v9, v6, v7);
        let (v14, v15) = split_off<T0>(&v0, arg1, arg2, v2, arg8, v9, v6);
        let v16 = if (v15) {
            3
        } else if (arg7 == 2) {
            4
        } else {
            0
        };
        let v17 = settle_close<T0>(arg0, arg1, arg2, arg3, v14, 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::ask_wad(&arg5), 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::bid_wad(&arg5), v12, v3, v16, arg10);
        refresh_reserve<T0>(arg0, arg1, arg3, v12);
        stamp_max<T0>(&v0, arg1, 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::price_wad(&arg5), v6, v7, 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::slot(&arg5));
        0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::discard_price(arg5);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_identity<T0>(arg0);
        v17
    }

    public fun close_retired<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::AccountCap, arg4: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg5: u64, arg6: 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::PriceReceipt, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::fees::LossTicket {
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::assert_cap<T0>(arg2, arg3);
        close_retired_inner<T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8)
    }

    public fun close_retired_as_delegate<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg4: u64, arg5: 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::fees::LossTicket {
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::assert_close_delegate<T0>(arg2, 0x2::tx_context::sender(arg7), 0x2::clock::timestamp_ms(arg6));
        close_retired_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    fun close_retired_inner<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg4: u64, arg5: 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::fees::LossTicket {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue_on<T0>(arg3, arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_version(arg3);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_version<T0>(arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_version<T0>(arg1);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_exchange<T0>(arg1, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0));
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::assert_version<T0>(arg2);
        assert!(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::status<T0>(arg1) == 3, 13840409004714885159);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::assert_exchange<T0>(arg2, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0));
        guarded_reconcile<T0>(&v0, arg1, arg2, arg3);
        assert_positions_unpaused<T0>(arg1, arg3);
        assert!(!0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::session_pending<T0>(arg1), 13844912621523959875);
        assert!(0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::market_id(&arg5) == 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg1), 13839846076236038179);
        assert!(!0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::is_closed(&arg5), 13842097880345739315);
        let v1 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::remove_position<T0>(&v0, arg2, arg4);
        assert!(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_market(&v1) == 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg1), 13839846089120940067);
        let v2 = 0x2::clock::timestamp_ms(arg6);
        assert!(v2 != 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_opened_at(&v1), 13838438722826666009);
        let v3 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::timing<T0>(arg1);
        assert!(v2 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_opened_at(&v1) + 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::min_hold_ms(&v3), 13838720202098475035);
        let v4 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::timestamp_ms(&arg5);
        let v5 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::sequence(&arg5);
        assert!(v4 > 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_oracle_ts(&v1) && v5 > 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_oracle_sequence(&v1), 13835905465214959623);
        assert!(v4 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::last_oracle_ts_ms<T0>(arg1) && v5 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::last_oracle_sequence<T0>(arg1), 13835905469509926919);
        assert!(!0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::position::crossed_bust(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_is_long(&v1), 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::price_wad(&arg5), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_bust(&v1)), 13839001711435055133);
        let v6 = settle_close<T0>(arg0, arg1, arg2, arg3, v1, 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::ask_wad(&arg5), 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::bid_wad(&arg5), 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::price_wad(&arg5), v2, 0, arg7);
        refresh_reserve<T0>(arg0, arg1, arg3, 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::price_wad(&arg5));
        stamp<T0>(&v0, arg1, 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::price_wad(&arg5), v4, v5, 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::slot(&arg5));
        0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::discard_price(arg5);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_identity<T0>(arg0);
        v6
    }

    public fun emergency_close<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg4: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::AuthorityCap<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::PACKAGE, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::ADMIN>, arg5: u64, arg6: 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::PriceReceipt, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::fees::LossTicket {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue_on<T0>(arg3, arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_version(arg3);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_version<T0>(arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::assert_version<T0>(arg2);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::assert_admin(0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config>(arg3), arg4);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_version<T0>(arg1);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_exchange<T0>(arg1, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0));
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::assert_exchange<T0>(arg2, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0));
        assert!(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::status<T0>(arg1) == 3, 13840409232348151847);
        guarded_reconcile<T0>(&v0, arg1, arg2, arg3);
        assert_positions_unpaused<T0>(arg1, arg3);
        assert!(!0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::session_pending<T0>(arg1), 13844912849157226563);
        assert!(0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::market_id(&arg6) == 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg1), 13839846303869304867);
        assert!(!0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::is_closed(&arg6), 13842098107979006003);
        let v1 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::remove_position<T0>(&v0, arg2, arg5);
        assert!(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_market(&v1) == 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg1), 13839846316754206755);
        let v2 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::timestamp_ms(&arg6);
        let v3 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::sequence(&arg6);
        assert!(v2 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::last_oracle_ts_ms<T0>(arg1) && v3 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::last_oracle_sequence<T0>(arg1), 13835905679963324423);
        assert!(v2 > 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_oracle_ts(&v1) && v3 > 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_oracle_sequence(&v1), 13835905684258291719);
        assert!(!0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::position::crossed_bust(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_is_long(&v1), 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::price_wad(&arg6), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_bust(&v1)), 13839001926183419933);
        let v4 = settle_close<T0>(arg0, arg1, arg2, arg3, v1, 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::ask_wad(&arg6), 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::bid_wad(&arg6), 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::price_wad(&arg6), 0x2::clock::timestamp_ms(arg7), 0, arg8);
        refresh_reserve<T0>(arg0, arg1, arg3, 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::price_wad(&arg6));
        stamp<T0>(&v0, arg1, 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::price_wad(&arg6), v2, v3, 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::slot(&arg6));
        0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::discard_price(arg6);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_admin_action(&v0, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg1), 14);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_identity<T0>(arg0);
        v4
    }

    public(friend) fun entry_within(arg0: bool, arg1: u128, arg2: u128) : bool {
        arg2 == 0 || arg0 && arg1 <= arg2 || arg1 >= arg2
    }

    public(friend) fun exit_within(arg0: bool, arg1: u128, arg2: u128) : bool {
        arg2 == 0 || arg0 && arg1 >= arg2 || arg1 <= arg2
    }

    public fun flag_liquidatable<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg3: u64, arg4: 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::PriceReceipt, arg5: &0x2::clock::Clock) : bool {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue_on<T0>(arg2, arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_version(arg2);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_version<T0>(arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_version<T0>(arg1);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_exchange<T0>(arg1, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0));
        assert!(!0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::oracle_killed<T0>(arg1), 13840691587793289257);
        assert!(0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::market_id(&arg4) == 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg1), 13839847167157731363);
        assert!(!0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::is_closed(&arg4), 13842098971267432499);
        let v1 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::timestamp_ms(&arg4);
        let v2 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::sequence(&arg4);
        assert!(v1 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::last_oracle_ts_ms<T0>(arg1) && v2 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::last_oracle_sequence<T0>(arg1), 13835906534661816327);
        assert!(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::contains(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq<T0>(arg1), arg3), 13842943413377695799);
        let v3 = *0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::borrow_record(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq<T0>(arg1), arg3);
        assert!(v1 > 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_oracle_ts(&v3) && v2 > 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_oracle_sequence(&v3), 13835906547546718215);
        let v4 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::price_wad(&arg4);
        let v5 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::position::crossed_bust(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_is_long(&v3), v4, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_bust(&v3));
        0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::discard_price(arg4);
        let v6 = 0x2::clock::timestamp_ms(arg5);
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::observe(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq_mut<T0>(&v0, arg1), v4, v1);
        if (v5) {
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_liquidatable_flag_event(&v0, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg1), arg3, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_account_id(&v3), true, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::flag_since(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq_mut<T0>(&v0, arg1), arg3, v6, v1), v6);
        } else if (0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::clear_since(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq_mut<T0>(&v0, arg1), arg3)) {
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_liquidatable_flag_event(&v0, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg1), arg3, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_account_id(&v3), false, 0, v6);
        };
        v5
    }

    public fun force_close_session<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg4: vector<u64>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::fees::LossTicket, 0x2::coin::Coin<T0>) {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue_on<T0>(arg3, arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_version(arg3);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_version<T0>(arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_version<T0>(arg1);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::assert_version<T0>(arg2);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_exchange<T0>(arg1, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0));
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::assert_exchange<T0>(arg2, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0));
        assert!(0x1::vector::length<u64>(&arg4) <= 128, 13844633882441285697);
        let v1 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::status<T0>(arg1);
        let v2 = if (v1 == 1) {
            true
        } else if (v1 == 2) {
            true
        } else {
            v1 == 3
        };
        assert!(v2, 13835626691772547077);
        let v3 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::session_close<T0>(arg1);
        assert!(0x1::option::is_some<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::SessionCloseV1>(&v3), 13844352420349345855);
        if (!0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::session_pending<T0>(arg1)) {
            return (0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::fees::ticket(0, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>>(arg2)), 0x2::coin::zero<T0>(arg6))
        };
        reconcile_inner<T0>(&v0, arg1, arg2);
        let v4 = 0x1::option::destroy_some<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::SessionCloseV1>(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::session_close<T0>(arg1));
        let v5 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::sc_price_wad(&v4);
        let v6 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::sc_ts_ms(&v4);
        let v7 = 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg1);
        let v8 = 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>>(arg2);
        let v9 = 0x2::clock::timestamp_ms(arg5);
        let v10 = 0x2::tx_context::sender(arg6);
        let v11 = v10 == 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::owner<T0>(arg2) || 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::is_delegate<T0>(arg2, v10);
        let v12 = if (0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::is_order_keeper(arg3, v10)) {
            0
        } else {
            1
        };
        let v13 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::safety::liq_kind(v12, v11);
        let v14 = 0;
        let v15 = 0x2::coin::zero<T0>(arg6);
        let v16 = 0;
        while (v16 < 0x1::vector::length<u64>(&arg4)) {
            let v17 = *0x1::vector::borrow<u64>(&arg4, v16);
            v16 = v16 + 1;
            if (!0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::session_pending<T0>(arg1)) {
                break
            };
            if (!0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::safety::session_eligible(v17, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::sc_watermark(&v4)) || !0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::has_position<T0>(arg2, v17)) {
                continue
            };
            if (!0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::contains(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq<T0>(arg1), v17)) {
                continue
            };
            let v18 = *0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::borrow_record(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq<T0>(arg1), v17);
            if (0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_account_id(&v18) != v8) {
                continue
            };
            let v19 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::position::crossed_bust(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_is_long(&v18), v5, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_bust(&v18));
            if (v19) {
                let v20 = if (v13 == 1 && !grace_elapsed<T0>(arg1, arg3, v17, v9)) {
                    3
                } else {
                    v13
                };
                let v21 = liquidate_record<T0>(arg0, arg1, arg3, v17, v5, v5, v6, v9, v10, v20, false, arg6);
                if (v21 > 0) {
                    0x2::coin::join<T0>(&mut v15, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::split_out<T0>(&v0, arg0, v21, arg6));
                };
                reconcile_inner<T0>(&v0, arg1, arg2);
            } else {
                let v22 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::remove_position<T0>(&v0, arg2, v17);
                let v23 = settle_close<T0>(arg0, arg1, arg2, arg3, v22, v5, v5, v5, v9, 2, arg6);
                v14 = v14 + 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::fees::settle_loss_ticket(v23);
            };
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_session_force_closed_event(&v0, v17, v7, v8, v5, v6, v19, 0x2::tx_context::sender(arg6));
            if (0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::note_session_force_closed<T0>(&v0, arg1, v17, arg6)) {
                let v24 = 0x1::option::destroy_some<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::SessionCloseV1>(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::session_close<T0>(arg1));
                0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_session_drained_event(&v0, v7, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::sc_closed_count(&v24));
            };
        };
        refresh_reserve<T0>(arg0, arg1, arg3, v5);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_identity<T0>(arg0);
        (0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::fees::ticket(v14, v8), v15)
    }

    public fun grace_elapsed<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: u64, arg3: u64) : bool {
        let v0 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::liq_since(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq<T0>(arg0), arg2);
        0x1::option::is_some<u64>(&v0) && arg3 >= *0x1::option::borrow<u64>(&v0) + 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::liq_grace_ms(arg1)
    }

    fun guarded_reconcile<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::access::Auth, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config) {
        if (0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::pending_count(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq<T0>(arg1), 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>>(arg2)) == 0) {
            return
        };
        assert_reconcile_unpaused<T0>(arg1, arg3);
        reconcile_inner<T0>(arg0, arg1, arg2);
    }

    public(friend) fun liq_kind_keeper() : u8 {
        0
    }

    public(friend) fun liquidatable_at<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg1: u64, arg2: u128) : bool {
        if (!0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::contains(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq<T0>(arg0), arg1)) {
            return false
        };
        let v0 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::borrow_record(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq<T0>(arg0), arg1);
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::position::crossed_bust(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_is_long(v0), arg2, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_bust(v0))
    }

    public fun liquidatable_since<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg1: u64) : 0x1::option::Option<u64> {
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::liq_since(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq<T0>(arg0), arg1)
    }

    public fun liquidate<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg3: u64, arg4: 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::PriceReceipt, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_version(arg2);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_version<T0>(arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_version<T0>(arg1);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_exchange<T0>(arg1, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0));
        assert!(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::is_order_keeper(arg2, 0x2::tx_context::sender(arg6)), 13845194766515699781);
        liquidate_receipt_mode<T0>(arg0, arg1, arg2, arg3, arg4, 0, 0, arg5, arg6)
    }

    public fun liquidate_after_grace<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg4: u64, arg5: 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_version(arg2);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_version<T0>(arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_version<T0>(arg1);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_exchange<T0>(arg1, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0));
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::assert_exchange<T0>(arg3, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0));
        assert!(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::contains(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq<T0>(arg1), arg4), 13842943172859527223);
        assert!(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_account_id(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::borrow_record(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq<T0>(arg1), arg4)) == 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>>(arg3), 13845476451945939015);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::is_order_keeper(arg2, v0);
        if (!v1) {
            assert!(grace_elapsed<T0>(arg1, arg2, arg4, 0x2::clock::timestamp_ms(arg6)), 13845194994148966469);
        };
        let v2 = v0 == 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::owner<T0>(arg3) || 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::is_delegate<T0>(arg3, v0);
        let v3 = if (v1) {
            0
        } else {
            1
        };
        liquidate_receipt_mode<T0>(arg0, arg1, arg2, arg4, arg5, 0, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::safety::liq_kind(v3, v2), arg6, arg7)
    }

    public(friend) fun liquidate_receipt_mode<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg3: u64, arg4: 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::PriceReceipt, arg5: u8, arg6: u8, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue_on<T0>(arg2, arg0);
        assert!(!0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::oracle_killed<T0>(arg1), 13840691781066817577);
        assert!(!0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::session_pending<T0>(arg1), 13844913910014148675);
        assert!(0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::market_id(&arg4) == 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg1), 13839847364726226979);
        assert!(!0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::is_closed(&arg4), 13842099168835928115);
        let v1 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::timestamp_ms(&arg4);
        let v2 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::sequence(&arg4);
        if (arg5 == 0) {
            assert!(v1 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::last_oracle_ts_ms<T0>(arg1), 13835906736525279239);
            assert!(v2 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::last_oracle_sequence<T0>(arg1), 13835906740820246535);
        };
        let v3 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::price_wad(&arg4);
        assert!(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::contains(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq<T0>(arg1), arg3), 13842943628126060599);
        let v4 = *0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::borrow_record(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq<T0>(arg1), arg3);
        assert!(v1 > 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_oracle_ts(&v4) && v2 > 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_oracle_sequence(&v4), 13835906762295083015);
        assert!(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::position::crossed_bust(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_is_long(&v4), v3, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_bust(&v4)), 13839284474902085663);
        let (v5, v6) = reserve_mark<T0>(arg1, v3, v1, v2);
        let v7 = 0x2::tx_context::sender(arg8);
        let v8 = liquidate_record<T0>(arg0, arg1, arg2, arg3, v3, v5, v1, 0x2::clock::timestamp_ms(arg7), v7, arg6, false, arg8);
        if (!v6) {
            refresh_reserve<T0>(arg0, arg1, arg2, v5);
        } else {
            refresh_reserve<T0>(arg0, arg1, arg2, v3);
        };
        stamp_max<T0>(&v0, arg1, v3, v1, v2, 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::slot(&arg4));
        0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::discard_price(arg4);
        let v9 = if (v8 > 0) {
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::split_out<T0>(&v0, arg0, v8, arg8)
        } else {
            0x2::coin::zero<T0>(arg8)
        };
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_identity<T0>(arg0);
        v9
    }

    fun liquidate_record<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg3: u64, arg4: u128, arg5: u128, arg6: u64, arg7: u64, arg8: address, arg9: u8, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue_on<T0>(arg2, arg0);
        let v1 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::remove(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq_mut<T0>(&v0, arg1), arg3);
        0xde3c36d56dab5b3f030dd39e4210d5db14a4858858825a5cded1707cf8aaea3::payout_cap::release<T0>(&v0, arg0, arg3);
        0xde3c36d56dab5b3f030dd39e4210d5db14a4858858825a5cded1707cf8aaea3::win_curve::release<T0>(&v0, arg0, arg3);
        let v2 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_is_long(&v1);
        let v3 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_margin(&v1);
        let v4 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_notional(&v1);
        let v5 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_exposure(&v1);
        let v6 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_account_id(&v1);
        let v7 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::holder_book::owner_of(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), v6, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_owner(&v1));
        let v8 = 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg1);
        let v9 = if (0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::is_hedged(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq<T0>(arg1), 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_account_id(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::borrow_record(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq<T0>(arg1), arg3)))) {
            true
        } else if (0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_wash(&v1)) {
            true
        } else {
            0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::opposite_notional(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq<T0>(arg1), v6, v2) > 0
        };
        let v10 = arg8 == v7 || 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::is_account_delegate<T0>(arg0, v6, arg8);
        let v11 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::safety::liq_kind(arg9, v10);
        let v12 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::risk<T0>(arg1);
        let v13 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::safety::bps_of(v3, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq_bounty_bps(&v12));
        let v14 = if (v13 < 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::liq_bounty_cap(arg2)) {
            v13
        } else {
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::liq_bounty_cap(arg2)
        };
        let v15 = if (0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::safety::liq_bounty_paid(v11)) {
            v14
        } else {
            0
        };
        let v16 = v3 - v15;
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::sub_oi<T0>(&v0, arg1, v2, v4);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::sub_locked<T0>(&v0, arg1, v2, v5);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::sub_qty<T0>(&v0, arg1, v2, v5, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_entry(&v1));
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::sub_open_exposure<T0>(&v0, arg0, v5);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::unlock_all<T0>(&v0, arg0, v3);
        refresh_reserve<T0>(arg0, arg1, arg2, arg5);
        let v17 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::realize_loss<T0>(&v0, arg0, v16, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::loss_fee_bps(arg2));
        0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::mint_cap::note_pnl<T0>(&v0, arg0, arg7, v16 - v17, 0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::route_retained<T0>(&v0, arg0, arg2, v17);
        let v18 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::safety::liq_mint_basis(v11, v3, v3 - v14, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::position::adverse_loss(v2, v4, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_entry(&v1), arg4), v9);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::note_minted_loss<T0>(&v0, arg0, v18);
        0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::fee_mint::park<T0>(&v0, arg0, v6, v18, arg7);
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::push_pending(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq_mut<T0>(&v0, arg1), v6, arg3, arg11);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_position_exit_event(&v0, arg3, v8, 1, v2, arg4, arg6);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_liquidate_position_event(&v0, arg3, v6, v15, v16);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_liquidation_detail_event(&v0, arg3, v8, v6, arg8, v15, v16, v17, arg10);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_liquidation_kind_event(&v0, arg3, v8, arg8, v11, v18, v15);
        0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::game::on_loss<T0>(arg0, arg2, v7, v3, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::safety::achievement_fee_basis(v17, 0, 0, v9, v11 == 2, true), arg7);
        v15
    }

    public fun liquidate_retired<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg3: u64, arg4: 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::PriceReceipt, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_version(arg2);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_version<T0>(arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_version<T0>(arg1);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_exchange<T0>(arg1, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0));
        assert!(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::status<T0>(arg1) == 3, 13840409769219063847);
        assert!(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::is_order_keeper(arg2, 0x2::tx_context::sender(arg6)), 13845194848120078405);
        liquidate_receipt_mode<T0>(arg0, arg1, arg2, arg3, arg4, 0, 0, arg5, arg6)
    }

    public(friend) fun liquidations_paused<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config) : bool {
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::oracle_killed<T0>(arg0)
    }

    fun locked_notional<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg4: u64, arg5: u64) : u128 {
        let v0 = (arg4 as u128) * (arg5 as u128) * (taker_bps<T0>(arg1, arg3) as u128) / 10000;
        if (v0 >= (arg4 as u128)) {
            return 0
        };
        let v1 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::referral::quote<T0>(arg0, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::owner<T0>(arg2), (v0 as u64), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::referral_accrual_live(arg3), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::referee_discount_bps(arg3), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::referral_fee_bps(arg3), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::second_level_fee_bps(arg3));
        ((arg4 - 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::referral::charged(&v1)) as u128) * (arg5 as u128)
    }

    public(friend) fun mode_one_step() : u8 {
        0
    }

    public(friend) fun mode_two_step() : u8 {
        1
    }

    public fun no_price_bound() : u128 {
        0
    }

    public(friend) fun open_inner<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg4: 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::PriceReceipt, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: u64, arg10: u128, arg11: 0x1::option::Option<u32>, arg12: u8, arg13: u16, arg14: bool, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue_on<T0>(arg3, arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_version(arg3);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_version<T0>(arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_version<T0>(arg1);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_exchange<T0>(arg1, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0));
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::assert_version<T0>(arg2);
        assert!(!arg8, 13840126163938443301);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::assert_exchange<T0>(arg2, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0));
        guarded_reconcile<T0>(&v0, arg1, arg2, arg3);
        let (v1, v2) = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::builder::snapshot<T0>(arg0, arg3, arg11, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>>(arg2), arg13, arg14);
        let v3 = v1;
        let v4 = if (0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::is_paused(arg3)) {
            true
        } else if (0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::opens_paused<T0>(arg1)) {
            true
        } else if (0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::closes_paused(arg3)) {
            true
        } else {
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::closes_paused<T0>(arg1)
        };
        assert!(!0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::safety::trading_blocked(v4), 13835341136576774147);
        assert!(!0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::session_pending<T0>(arg1), 13844911294379065411);
        0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::event_guard::assert_open_allowed<T0>(arg0, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg1), arg6, 0x2::clock::timestamp_ms(arg15));
        assert!(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::enabled<T0>(arg1), 13840970653293477931);
        assert!(!0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::oracle_killed<T0>(arg1), 13840689182611603497);
        assert!(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::status<T0>(arg1) == 1, 13835622637323419653);
        assert!(0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::market_id(&arg4) == 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg1), 13839844766271012899);
        assert!(!0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::is_closed(&arg4), 13842096570380714035);
        let v5 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::timestamp_ms(&arg4);
        let v6 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::sequence(&arg4);
        if (arg12 == 0) {
            assert!(v5 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::last_oracle_ts_ms<T0>(arg1), 13835904142365032455);
            assert!(v6 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::last_oracle_sequence<T0>(arg1), 13835904146659999751);
        };
        let (v7, _) = reserve_mark<T0>(arg1, 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::price_wad(&arg4), v5, v6);
        let v9 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::risk<T0>(arg1);
        assert!(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::safety::leverage_within(arg6, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::max_leverage(&v9)), 13836185638816710665);
        assert!(arg6 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::min_leverage(&v9), 13841815146943479857);
        let v10 = if (0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::taker_fee_is_set(arg3)) {
            0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::safety::tighter_bps(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::taker_fee_bps<T0>(arg1), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::taker_fee_bps(arg3))
        } else {
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::taker_fee_bps<T0>(arg1)
        };
        let v11 = (arg5 as u128) * (arg6 as u128) * (v10 as u128) / 10000;
        assert!(v11 < (arg5 as u128), 13838156010899243031);
        let v12 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::referral::quote<T0>(arg0, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::owner<T0>(arg2), (v11 as u64), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::referral_accrual_live(arg3), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::referee_discount_bps(arg3), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::referral_fee_bps(arg3), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::second_level_fee_bps(arg3));
        let v13 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::referral::charged(&v12);
        let v14 = arg5 - v13;
        assert!(v14 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::min_margin(&v9), 13836467216872767499);
        let v15 = (v14 as u128) * (arg6 as u128);
        assert!(v15 <= 18446744073709551615, 13836467225462702091);
        let v16 = (v15 as u64);
        assert!(v16 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::min_notional(&v9) && v16 <= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::max_position_notional(&v9), 13836467234052636683);
        let (v17, v18) = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::charge_notional<T0>(&v0, arg1, v16, 0x2::clock::timestamp_ms(arg15), *0x2::tx_context::digest(arg16));
        assert!(v17, 13836748730504314893);
        assert!(v18, 13837030209776123919);
        assert!(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::open_notional<T0>(arg2) + v16 <= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::max_account_notional(&v9), 13837311689047932945);
        let v19 = 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>>(arg2);
        assert!(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::free_balance<T0>(arg0, v19) >= arg5, 13838156122568392727);
        let v20 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::impact<T0>(arg1);
        let v21 = if (arg7) {
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::long_oi<T0>(arg1)
        } else {
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::short_oi<T0>(arg1)
        };
        let v22 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::safety::marginal_exposure(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::effective_depth(&v20), v21, v16);
        let v23 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::safety::factor_bps(v22, v16);
        if (arg6 == 1) {
            assert!(v22 == v16, 13841533848060297263);
        } else {
            assert!(v22 > 0, 13841533856650231855);
        };
        if (arg9 > 0) {
            assert!(v23 >= arg9, 13841533869535133743);
        };
        assert!(v23 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::min_payout_factor_bps(arg3), 13841533882420035631);
        let (v24, v25) = if (arg7) {
            (0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::long_locked_exposure<T0>(arg1), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::max_long_exposure<T0>(arg1))
        } else {
            (0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::short_locked_exposure<T0>(arg1), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::max_short_exposure<T0>(arg1))
        };
        assert!((v24 as u128) + (v22 as u128) <= (v25 as u128), 13837593262809022483);
        let (v26, v27) = if (arg7) {
            (0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::max_long_oi<T0>(arg1), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::long_oi<T0>(arg1))
        } else {
            (0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::max_short_oi<T0>(arg1), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::short_oi<T0>(arg1))
        };
        assert!((v27 as u128) + (v16 as u128) <= (v26 as u128), 13843222792410497081);
        let v28 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::safety::tighter_bps(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::win_fee_bps<T0>(arg1), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::win_fee_bps(arg3));
        let v29 = if (arg7) {
            0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::ask_wad(&arg4)
        } else {
            0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::bid_wad(&arg4)
        };
        assert!(entry_within(arg7, v29, arg10), 13843785755248951355);
        let v30 = if (arg7) {
            0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::position::bust_long(v29, arg6, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::safety::effective_bust_buffer(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::bust_buffer_wad(&v9), arg6))
        } else {
            0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::position::bust_short(v29, arg6, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::safety::effective_bust_buffer(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::bust_buffer_wad(&v9), arg6))
        };
        assert!(!0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::position::crossed_bust(arg7, 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::price_wad(&arg4), v30), 13842659893996421173);
        let v31 = 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg1);
        let v32 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::opposite_open<T0>(arg2, v31, arg7);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::debit_account_free<T0>(&v0, arg0, v19, arg5);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::lock_open<T0>(&v0, arg0, arg5, v13);
        0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::referral::pay_open_rewards<T0>(arg0, v12);
        let v33 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::alloc_position_id<T0>(&v0, arg0);
        0xde3c36d56dab5b3f030dd39e4210d5db14a4858858825a5cded1707cf8aaea3::payout_cap::on_open<T0>(&v0, arg0, arg3, v31, v19, v33, arg7, arg6, v14);
        0xde3c36d56dab5b3f030dd39e4210d5db14a4858858825a5cded1707cf8aaea3::win_curve::on_open<T0>(&v0, arg0, arg1, v33);
        let v34 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::referral::protocol_remainder(&v12);
        refresh_reserve<T0>(arg0, arg1, arg3, v7);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::route_retained<T0>(&v0, arg0, arg3, v34);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::add_open_exposure<T0>(&v0, arg0, v22);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::add_open_notional<T0>(&v0, arg2, v16);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::add_side<T0>(&v0, arg2, v31, arg7, v16);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::note_hedge_if_two_sided<T0>(&v0, arg2, v31);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::add_oi<T0>(&v0, arg1, arg7, v16);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::add_locked<T0>(&v0, arg1, arg7, v22);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::add_qty<T0>(&v0, arg1, arg7, v22, v29);
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::insert(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq_mut<T0>(&v0, arg1), v33, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::record(v19, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::owner<T0>(arg2), arg7, v14, v16, v22, v29, v30, v5, v6, v32));
        stamp_max<T0>(&v0, arg1, 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::price_wad(&arg4), v5, v6, 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::slot(&arg4));
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_open_position_event(&v0, v33, v19, v31, arg7, 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::price_wad(&arg4), 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::conf_wad(&arg4), v29, v30, v14, v16, v23, v22, v28, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::deadband_ppm(&v20), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::close_fee_ppm(&v20), v3);
        if (0x1::option::is_some<u32>(&v3)) {
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_builder_position_snap_event(&v0, v33, v19, *0x1::option::borrow<u32>(&v3), v2);
        };
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::insert_position<T0>(&v0, arg2, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::new_position(&v0, v33, v31, arg7, v29, v14, arg6, v16, v30, 0x2::clock::timestamp_ms(arg15), v5, v6, v22, v23, v28, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::deadband_ppm(&v20), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::close_fee_ppm(&v20), v34, v32, v3, v2));
        refresh_reserve<T0>(arg0, arg1, arg3, v7);
        0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::discard_price(arg4);
        0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::game::on_open<T0>(arg0, arg3, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::owner<T0>(arg2), v31, v13, 0x2::clock::timestamp_ms(arg15));
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_identity<T0>(arg0);
        v33
    }

    public(friend) fun open_risk_code<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: u64, arg3: u64) : u8 {
        let v0 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::risk<T0>(arg0);
        if (!0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::safety::leverage_within(arg3, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::max_leverage(&v0))) {
            return 1
        };
        if (arg3 < 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::min_leverage(&v0)) {
            return 2
        };
        let v1 = (arg2 as u128) * (arg3 as u128) * (taker_bps<T0>(arg0, arg1) as u128) / 10000;
        if (v1 >= (arg2 as u128)) {
            return 4
        };
        let v2 = arg2 - (v1 as u64);
        if (v2 < 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::min_margin(&v0)) {
            return 4
        };
        if ((v2 as u128) * (arg3 as u128) < (0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::min_notional(&v0) as u128)) {
            return 3
        };
        if ((arg2 as u128) * (arg3 as u128) > (0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::max_position_notional(&v0) as u128)) {
            return 3
        };
        0
    }

    public(friend) fun partial_fits<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg1: u64, arg2: u64, arg3: u64) : bool {
        let v0 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::risk<T0>(arg0);
        let v1 = bps_part(arg1, arg3);
        let v2 = bps_part(arg2, arg3);
        if (arg3 < 10000) {
            if (v1 > 0) {
                if (v2 > 0) {
                    if (arg1 - v1 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::min_margin(&v0)) {
                        arg2 - v2 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::min_notional(&v0)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun positions_paused<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config) : bool {
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::oracle_killed<T0>(arg0)
    }

    public fun reconcile<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config) {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue_on<T0>(arg3, arg2);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_version<T0>(arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::assert_version<T0>(arg1);
        guarded_reconcile<T0>(&v0, arg0, arg1, arg3);
    }

    public(friend) fun reconcile_halted<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config) : bool {
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::oracle_killed<T0>(arg0)
    }

    public(friend) fun reconcile_inner<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::access::Auth, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>) {
        let v0 = 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>>(arg2);
        if (0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::pending_count(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq<T0>(arg1), v0) == 0) {
            return
        };
        let v1 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::take_pending(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq_mut<T0>(arg0, arg1), v0, 32);
        let v2 = 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg1);
        let v3 = vector[];
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&v1)) {
            let v5 = *0x1::vector::borrow<u64>(&v1, v4);
            if (0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::has_position<T0>(arg2, v5)) {
                let v6 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::remove_position<T0>(arg0, arg2, v5);
                0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::sub_open_notional<T0>(arg0, arg2, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_notional(&v6));
                0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::sub_side<T0>(arg0, arg2, v2, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_is_long(&v6), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_notional(&v6));
                0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::clear_hedge_if_flat<T0>(arg0, arg2, v2);
                0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::destroy_position(arg0, v6);
                0x1::vector::push_back<u64>(&mut v3, v5);
            };
            v4 = v4 + 1;
        };
        if (!0x1::vector::is_empty<u64>(&v3)) {
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_positions_reconciled_event(arg0, v0, v2, v3);
        };
    }

    fun refresh_reserve<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg3: u128) {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue_on<T0>(arg2, arg0);
        let (v1, v2) = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::reserve_at<T0>(arg1, arg3, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::trim_max_share_bps(arg2));
        let (v3, v4) = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::swap_snapshot<T0>(&v0, arg1, v1, v2);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::adjust_reserve<T0>(&v0, arg0, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg1), v3, v4, v1, v2, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::has_oi<T0>(arg1));
    }

    fun reserve_mark<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg1: u128, arg2: u64, arg3: u64) : (u128, bool) {
        if (arg2 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::last_oracle_ts_ms<T0>(arg0) && arg3 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::last_oracle_sequence<T0>(arg0)) {
            (arg1, true)
        } else {
            (0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::last_mark_wad<T0>(arg0), false)
        }
    }

    fun resized(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::access::Auth, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Position, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Position {
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::new_position(arg0, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_id(arg1), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_market(arg1), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_is_long(arg1), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_entry(arg1), arg2, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_leverage(arg1), arg3, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_bust(arg1), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_opened_at(arg1), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_oracle_ts(arg1), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_oracle_sequence(arg1), arg4, arg6, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_win_fee_bps(arg1), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_deadband_ppm(arg1), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_close_fee_ppm(arg1), arg5, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_wash(arg1), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_builder_id(arg1), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_builder_fee(arg1))
    }

    public fun retire_market<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::AuthorityCap<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::PACKAGE, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::ADMIN>, arg4: 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::PriceReceipt) {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue_on<T0>(arg2, arg1);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_version(arg2);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_version<T0>(arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::assert_admin(0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config>(arg2), arg3);
        assert!(0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::market_id(&arg4) == 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg0), 13839849464965234723);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::set_status<T0>(&v0, arg0, 3, 0x1::option::none<u128>());
        0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::discard_price(arg4);
    }

    public fun set_payout_cap(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::AuthorityCap<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::PACKAGE, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::ADMIN>, arg2: bool, arg3: vector<u64>, arg4: vector<u64>, arg5: u64, arg6: u64) {
        assert!(!arg2 || 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::sole_version(arg0), 13846039054007271499);
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::uid(arg0));
        0xde3c36d56dab5b3f030dd39e4210d5db14a4858858825a5cded1707cf8aaea3::payout_cap::set_params(&v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun settle_close<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg4: 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Position, arg5: u128, arg6: u128, arg7: u128, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) : 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::fees::LossTicket {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue_on<T0>(arg3, arg0);
        let v1 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_is_long(&arg4);
        let v2 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_margin(&arg4);
        let v3 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_notional(&arg4);
        let v4 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_entry(&arg4);
        let v5 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_exposure(&arg4);
        let v6 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_id(&arg4);
        let v7 = if (v1) {
            arg6
        } else {
            arg5
        };
        let v8 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::position::settle(v1, v3, v5, v4, v7, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_deadband_ppm(&arg4), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_close_fee_ppm(&arg4), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_win_fee_bps(&arg4), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::trim_max_share_bps(arg3));
        let v9 = 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg1);
        let v10 = if (0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_wash(&arg4)) {
            true
        } else if (0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::is_hedged<T0>(arg2, v9)) {
            true
        } else {
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::closed_opposite_same_checkpoint<T0>(arg2, v9, v1, arg8)
        };
        let v11 = arg9 == 3;
        if (!v11) {
            0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::remove(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq_mut<T0>(&v0, arg1), v6);
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::sub_qty<T0>(&v0, arg1, v1, v5, v4);
        };
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::sub_oi<T0>(&v0, arg1, v1, v3);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::sub_locked<T0>(&v0, arg1, v1, v5);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::sub_open_exposure<T0>(&v0, arg0, v5);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::sub_open_notional<T0>(&v0, arg2, v3);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::sub_side<T0>(&v0, arg2, v9, v1, v3);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::clear_hedge_if_flat<T0>(&v0, arg2, v9);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::note_close<T0>(&v0, arg2, v9, v1, arg8);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::unlock_all<T0>(&v0, arg0, v2);
        refresh_reserve<T0>(arg0, arg1, arg3, arg7);
        let v12 = if (v11) {
            0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_margin(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::borrow_record(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq<T0>(arg1), v6))
        } else {
            0
        };
        let (v13, v14, v15) = 0xde3c36d56dab5b3f030dd39e4210d5db14a4858858825a5cded1707cf8aaea3::win_curve::on_settle<T0>(&v0, arg0, &arg4, &v8, v7, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::trim_max_share_bps(arg3), v12);
        let (v16, v17) = 0xde3c36d56dab5b3f030dd39e4210d5db14a4858858825a5cded1707cf8aaea3::payout_cap::on_settle<T0>(&v0, arg0, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>>(arg2), v6, v2, v12, v14, v15, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_win_fee_bps(&arg4), arg9 == 4);
        let v18 = apply_pnl<T0>(arg0, arg2, arg3, &arg4, &v8, v16, v17, v2, arg8, v10);
        let v19 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::safety::loss_mint_basis(v18.loss, v10, false);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::note_minted_loss<T0>(&v0, arg0, v19);
        let v20 = if (v18.loss > 0) {
            v18.loss
        } else {
            v16
        };
        if (!v11) {
            let v21 = if (arg9 == 4) {
                0
            } else {
                arg9
            };
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_position_exit_event(&v0, v6, v9, v21, v1, v7, arg8);
        };
        let v22 = if (v18.loss > 0) {
            0
        } else {
            v17
        };
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_close_fees_event(&v0, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0), 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>>(arg2), v6, v13, v13 - v16, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::position::pnl_close_toll(&v8), v22, v18.loss_fee, v18.discount, v18.retained);
        let v23 = if (v18.loss > 0) {
            0
        } else {
            v13 - v18.user_profit
        };
        if (v11) {
            let v24 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::borrow_record(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq<T0>(arg1), v6);
            let v25 = PartialCloseEventV1{
                position_id     : v6,
                account_id      : 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>>(arg2),
                market_id       : v9,
                exit_wad        : v7,
                closed_margin   : v2,
                closed_notional : v3,
                closed_exposure : v5,
                margin_left     : 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_margin(v24),
                notional_left   : 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_notional(v24),
                exposure_left   : 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_exposure(v24),
                gross           : v20,
                net             : v18.user_profit,
                queued          : v18.queued,
                builder_amount  : v18.builder_fee,
                returned        : v18.returned,
            };
            0x2::event::emit<PartialCloseEventV1>(v25);
        } else {
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_close_position_event(&v0, v6, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>>(arg2), v20, v23, v17, v18.user_profit, v18.queued, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_builder_id(&arg4), v18.builder_fee);
        };
        let v26 = 18446744073709551615;
        let v27 = if (v4 == 0) {
            v3
        } else {
            (0x1::u256::min((v3 as u256) * (v7 as u256) / (v4 as u256), (v26 as u256)) as u64)
        };
        let v28 = if (v18.loss > 0) {
            0
        } else {
            (0x1::u128::min((v18.user_profit as u128) + (v18.discount as u128), v26) as u64)
        };
        if (v11) {
            0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::game::on_partial_close<T0>(arg0, arg3, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::owner<T0>(arg2), v9, v3, v27, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_opened_at(&arg4), v2, v18.loss, v18.returned, v10, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::safety::achievement_fee_basis(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_open_fee(&arg4), v18.retained, 0, v10, false, false), arg8);
        } else {
            0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::game::on_close<T0>(arg0, arg3, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::owner<T0>(arg2), v6, v9, v3, v27, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_opened_at(&arg4), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_leverage(&arg4), v2, v18.loss, v18.user_profit, v28, v18.returned, v10, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::safety::achievement_fee_basis(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_open_fee(&arg4), v18.retained, 0, v10, false, false), arg8);
        };
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::destroy_position(&v0, arg4);
        0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::fees::ticket(v19, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>>(arg2))
    }

    fun split_off<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::access::Auth, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg3: 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Position, arg4: u64, arg5: u128, arg6: u64) : (0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Position, bool) {
        let v0 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_margin(&arg3);
        let v1 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_notional(&arg3);
        if (!partial_fits<T0>(arg1, v0, v1, arg4) || 0xde3c36d56dab5b3f030dd39e4210d5db14a4858858825a5cded1707cf8aaea3::liq_resize::flagged(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq_mut<T0>(arg0, arg1), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_id(&arg3), arg5, arg6)) {
            return (arg3, false)
        };
        let v2 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_exposure(&arg3);
        let v3 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_open_fee(&arg3);
        let v4 = bps_part(v0, arg4);
        let v5 = bps_part(v1, arg4);
        let v6 = bps_part(v2, arg4);
        let v7 = bps_part(v3, arg4);
        let v8 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_is_long(&arg3);
        let v9 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_entry(&arg3);
        let v10 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::safety::factor_bps(v2, v1);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::destroy_position(arg0, arg3);
        0xde3c36d56dab5b3f030dd39e4210d5db14a4858858825a5cded1707cf8aaea3::liq_resize::resize(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq_mut<T0>(arg0, arg1), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::position_id(&arg3), v0 - v4, v1 - v5, v2 - v6);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::sub_qty<T0>(arg0, arg1, v8, v2, v9);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::add_qty<T0>(arg0, arg1, v8, v2 - v6, v9);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::insert_position<T0>(arg0, arg2, resized(arg0, &arg3, v0 - v4, v1 - v5, v2 - v6, v3 - v7, v10));
        (resized(arg0, &arg3, v4, v5, v6, v7, v10), true)
    }

    fun stamp<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::access::Auth, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: u128, arg3: u64, arg4: u64, arg5: u64) {
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::observe(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq_mut<T0>(arg0, arg1), arg2, arg3);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::stamp_oracle<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun stamp_max<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::access::Auth, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: u128, arg3: u64, arg4: u64, arg5: u64) {
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::observe(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq_mut<T0>(arg0, arg1), arg2, arg3);
        if (arg3 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::last_oracle_ts_ms<T0>(arg1) && arg4 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::last_oracle_sequence<T0>(arg1)) {
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::stamp_oracle<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        };
    }

    public fun sweep<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg3: 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::PriceReceipt, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue_on<T0>(arg2, arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_version(arg2);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_version<T0>(arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_version<T0>(arg1);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_exchange<T0>(arg1, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0));
        assert!(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::is_order_keeper(arg2, 0x2::tx_context::sender(arg6)), 13845195616919224389);
        assert!(!0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::oracle_killed<T0>(arg1), 13840692021584986153);
        assert!(!0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::session_pending<T0>(arg1), 13844914150532317251);
        assert!(0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::market_id(&arg3) == 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg1), 13839847605244395555);
        assert!(!0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::is_closed(&arg3), 13842099409354096691);
        let v1 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::timestamp_ms(&arg3);
        let v2 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::sequence(&arg3);
        assert!(v1 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::last_oracle_ts_ms<T0>(arg1) && v2 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::last_oracle_sequence<T0>(arg1), 13835906972748480519);
        let v3 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::price_wad(&arg3);
        let v4 = if (arg4 < 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::sweep_max(arg2)) {
            arg4
        } else {
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::sweep_max(arg2)
        };
        let v5 = 0x2::tx_context::sender(arg6);
        let (_, v7) = sweep_inner<T0>(arg0, arg1, arg2, v5, v3, v1, v2, 0x2::clock::timestamp_ms(arg5), v4, arg6);
        refresh_reserve<T0>(arg0, arg1, arg2, v3);
        stamp<T0>(&v0, arg1, v3, v1, v2, 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::slot(&arg3));
        0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::discard_price(arg3);
        let v8 = if (v7 > 0) {
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::split_out<T0>(&v0, arg0, v7, arg6)
        } else {
            0x2::coin::zero<T0>(arg6)
        };
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_identity<T0>(arg0);
        v8
    }

    fun sweep_candidate<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg1: bool, arg2: u128, arg3: u64, arg4: u64) : (bool, bool, u64, u128) {
        let v0 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::peek(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq<T0>(arg0), arg1);
        if (0x1::option::is_none<0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::HeapEntry>(&v0)) {
            return (false, false, 0, 0)
        };
        let v1 = 0x1::option::destroy_some<0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::HeapEntry>(v0);
        let v2 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::entry_position_id(&v1);
        let v3 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::entry_bust(&v1);
        if (!0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::position::crossed_bust(arg1, arg2, v3)) {
            return (false, false, v2, v3)
        };
        let v4 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::borrow_record(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq<T0>(arg0), v2);
        let v5 = arg3 > 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_oracle_ts(v4) && arg4 > 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_oracle_sequence(v4);
        (true, v5, v2, v3)
    }

    fun sweep_inner<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg3: address, arg4: u128, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue_on<T0>(arg2, arg0);
        let v1 = 0;
        let v2 = 0;
        let v3 = true;
        let v4 = true;
        let v5 = 0x1::vector::empty<0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::HeapEntry>();
        let v6 = 0x1::vector::empty<0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::HeapEntry>();
        while (v1 < arg8) {
            let (v7, v8, v9) = if (v3) {
                let v10 = &mut v5;
                sweep_side_candidate<T0>(&v0, arg1, true, arg4, arg5, arg6, v10)
            } else {
                (false, 0, 0)
            };
            let (v11, v12, v13) = if (v4) {
                let v14 = &mut v6;
                sweep_side_candidate<T0>(&v0, arg1, false, arg4, arg5, arg6, v14)
            } else {
                (false, 0, 0)
            };
            v3 = v7;
            v4 = v11;
            if (!v7 && !v11) {
                break
            };
            let v15 = if (v7 && v11 && ((v9 - arg4) as u256) * (v13 as u256) >= ((arg4 - v13) as u256) * (v9 as u256) || v7) {
                v8
            } else {
                v12
            };
            let v16 = liquidate_record<T0>(arg0, arg1, arg2, v15, arg4, arg4, arg5, arg7, arg3, 0, true, arg9);
            v2 = v2 + v16;
            v1 = v1 + 1;
        };
        while (!0x1::vector::is_empty<0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::HeapEntry>(&v5)) {
            0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::reinsert(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq_mut<T0>(&v0, arg1), 0x1::vector::pop_back<0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::HeapEntry>(&mut v5));
        };
        while (!0x1::vector::is_empty<0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::HeapEntry>(&v6)) {
            0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::reinsert(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq_mut<T0>(&v0, arg1), 0x1::vector::pop_back<0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::HeapEntry>(&mut v6));
        };
        (v1, v2)
    }

    fun sweep_side_candidate<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::access::Auth, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: bool, arg3: u128, arg4: u64, arg5: u64, arg6: &mut vector<0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::HeapEntry>) : (bool, u64, u128) {
        let v0;
        let v1;
        loop {
            let (v2, v3, v0, v1) = sweep_candidate<T0>(arg1, arg2, arg3, arg4, arg5);
            if (!v2 || v3) {
                return (v3, v0, v1)
            };
            if (0x1::vector::length<0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::HeapEntry>(arg6) >= 2) {
                break
            };
            0x1::vector::push_back<0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::HeapEntry>(arg6, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::pop_top(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq_mut<T0>(arg0, arg1), arg2));
        };
        (false, v0, v1)
    }

    public(friend) fun taker_bps<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config) : u64 {
        if (0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::taker_fee_is_set(arg1)) {
            0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::safety::tighter_bps(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::taker_fee_bps<T0>(arg0), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::taker_fee_bps(arg1))
        } else {
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::taker_fee_bps<T0>(arg0)
        }
    }

    public(friend) fun tx_notional_ok<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg4: u64, arg5: u64) : bool {
        let v0 = locked_notional<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        if (v0 > 0) {
            let v2 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::risk<T0>(arg1);
            v0 <= (0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::max_tx_notional(&v2) as u128)
        } else {
            false
        }
    }

    // decompiled from Move bytecode v7
}

