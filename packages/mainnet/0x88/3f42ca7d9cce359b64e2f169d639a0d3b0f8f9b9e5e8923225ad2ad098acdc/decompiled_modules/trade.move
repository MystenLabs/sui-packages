module 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::trade {
    struct Settled has copy, drop {
        loss: u64,
        user_profit: u64,
        loss_fee: u64,
        discount: u64,
        builder_cut: u64,
        retained: u64,
        queued: bool,
    }

    public(friend) fun account_notional_ok<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: u64, arg5: u64) : bool {
        let v0 = locked_notional<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        if (v0 == 0) {
            return false
        };
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::risk<T0>(arg1);
        (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::open_notional<T0>(arg2) as u128) + v0 <= (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::max_account_notional(&v1) as u128)
    }

    fun apply_pnl<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Position, arg4: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::Pnl, arg5: u64, arg6: u64) : Settled {
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg2, arg0);
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::pnl_loss(arg4);
        let v2 = v1;
        if (v1 > arg5) {
            v2 = arg5;
        };
        let v3 = if (v2 > 0) {
            0
        } else {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::pnl_net(arg4)
        };
        let v4 = arg5 - v2;
        let v5 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::pnl_close_toll(arg4);
        let v6 = if (v5 < v3) {
            v5
        } else {
            v3
        };
        let v7 = v5 - v6;
        let v8 = if (v7 < v4) {
            v7
        } else {
            v4
        };
        let v9 = v3 - v6;
        let v10 = if (v2 > 0) {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::realize_loss<T0>(&v0, arg0, v2, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::loss_fee_bps(arg2))
        } else {
            0
        };
        let v11 = 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg1);
        let v12 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::owner<T0>(arg1);
        let v13 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_id(arg3);
        let v14 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_builder_id(arg3);
        let v15 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::effective_builder_share(arg2, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_builder_share(arg3));
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::credit_account_free<T0>(&v0, arg0, v11, v4 - v8);
        let v16 = if (v2 > 0) {
            0
        } else {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::pnl_win_fee(arg4)
        };
        let v17 = if (v2 > 0) {
            0
        } else {
            v16 + v3
        };
        0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::mint_cap::note_pnl<T0>(&v0, arg0, arg6, v2 - v10, v17);
        let v18 = if (v17 > 0) {
            if (!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::queue_nonempty<T0>(arg0)) {
                0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::lp_cash<T0>(arg0) >= v17
            } else {
                false
            }
        } else {
            false
        };
        let v19 = v8;
        let v20 = false;
        if (v18) {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::debit_lp<T0>(&v0, arg0, v17);
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::debit_tracked<T0>(&v0, arg0, v17);
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::credit_account_free<T0>(&v0, arg0, v11, v9);
            v19 = v8 + v6 + v16;
        } else if (v17 > 0) {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::enqueue_with_builder<T0>(&v0, arg0, v12, v11, v9, v16 + v6, v13, v14, v15);
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::debit_tracked<T0>(&v0, arg0, v17);
            v20 = true;
        };
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::add_fee<T0>(&v0, arg0, v19);
        let v21 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::referral::quote<T0>(arg0, v12, v19, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::referral_enabled(arg2), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::referee_discount_bps(arg2), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::referral_fee_bps(arg2), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::second_level_fee_bps(arg2));
        let v22 = v19 - 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::referral::charged(&v21);
        if (v22 > 0) {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::debit_fee_lp<T0>(&v0, arg0, v22);
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::credit_account_free<T0>(&v0, arg0, v11, v22);
        };
        let v23 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::referral::protocol_remainder(&v21);
        0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::referral::pay_open_rewards<T0>(arg0, v21);
        let v24 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::builder::accrue<T0>(arg0, v23, v23, v12, v11, v13, v14, v15, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::builder::kind_close_toll());
        let v25 = v23 - v24;
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::route_retained<T0>(&v0, arg0, arg2, v25 + v10);
        Settled{
            loss        : v2,
            user_profit : v9,
            loss_fee    : v10,
            discount    : v22,
            builder_cut : v24,
            retained    : v25 + v10,
            queued      : v20,
        }
    }

    public(friend) fun assert_open_risk<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: u64, arg3: u64) {
        let v0 = open_risk_code<T0>(arg0, arg1, arg2, arg3);
        assert!(v0 != 1, 13836185024636387337);
        assert!(v0 != 2, 13841814528468189233);
        assert!(v0 != 3 && v0 != 4, 13836466508203163659);
    }

    fun assert_positions_unpaused<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config) {
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::oracle_killed<T0>(arg0), 13840693215585894441);
    }

    fun assert_reconcile_unpaused<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config) {
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::oracle_killed<T0>(arg0), 13840691832606425129);
    }

    public fun check_market<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::ReserveCheck, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt) {
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg3, arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg3);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_version<T0>(arg2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_exchange<T0>(arg2, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg1));
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::session_pending<T0>(arg2), 13844915443317473347);
        assert!(0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::market_id(&arg4) == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg2), 13839848898029551651);
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::oracle_killed<T0>(arg2), 13840693335844978729);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_unpaused(arg3, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::pause_lp());
        assert!(!0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::is_closed(&arg4), 13842100719319121971);
        let v1 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::timestamp_ms(&arg4);
        let v2 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::sequence(&arg4);
        assert!(v1 >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::last_oracle_ts_ms<T0>(arg2) && v2 >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::last_oracle_sequence<T0>(arg2), 13835908282713505799);
        let v3 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(&arg4);
        refresh_reserve<T0>(arg1, arg2, arg3, v3);
        stamp<T0>(&v0, arg2, v3, v1, v2, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::slot(&arg4));
        0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::discard_price(arg4);
        if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::in_oi_set<T0>(arg1, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg2))) {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::note_checked(&v0, arg0, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg1), 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg2));
        };
    }

    public(friend) fun close_inner<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: u64, arg5: 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt, arg6: u128, arg7: u8, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees::LossTicket {
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg3, arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg3);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_version<T0>(arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_exchange<T0>(arg1, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0));
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_exchange<T0>(arg2, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0));
        guarded_reconcile<T0>(&v0, arg1, arg2, arg3);
        assert_positions_unpaused<T0>(arg1, arg3);
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::session_pending<T0>(arg1), 13844912097537949763);
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::status<T0>(arg1);
        assert!(v1 == 1 || v1 == 2, 13835623431892369413);
        assert!(0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::market_id(&arg5) == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1), 13839845560839962659);
        assert!(!0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::is_closed(&arg5), 13842097364949663795);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::remove_position<T0>(&v0, arg2, arg4);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_market(&v2) == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1), 13839845573724864547);
        let v3 = 0x2::clock::timestamp_ms(arg8);
        assert!(v3 != 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_opened_at(&v2), 13838438207430590489);
        let v4 = if (arg7 == 1) {
            true
        } else {
            let v5 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::timing<T0>(arg1);
            v3 >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_opened_at(&v2) + 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::min_hold_ms(&v5)
        };
        assert!(v4, 13838719703882268699);
        let v6 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::timestamp_ms(&arg5);
        let v7 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::sequence(&arg5);
        let v8 = arg7 == 0;
        assert!(v6 > 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_oracle_ts(&v2) && (!v8 || v6 >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::last_oracle_ts_ms<T0>(arg1)), 13835904975588687879);
        assert!(v7 > 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_oracle_sequence(&v2) && (!v8 || v7 >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::last_oracle_sequence<T0>(arg1)), 13835904979883655175);
        let v9 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(&arg5);
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::crossed_bust(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_is_long(&v2), v9, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_bust(&v2)), 13839001213218848797);
        let v10 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_is_long(&v2);
        let v11 = if (v10) {
            0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::bid_wad(&arg5)
        } else {
            0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::ask_wad(&arg5)
        };
        assert!(exit_within(v10, v11, arg6), 13844067775686639677);
        let (v12, _) = reserve_mark<T0>(arg1, v9, v6, v7);
        let v14 = settle_close<T0>(arg0, arg1, arg2, arg3, v2, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::ask_wad(&arg5), 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::bid_wad(&arg5), v12, v3, 0, arg9);
        refresh_reserve<T0>(arg0, arg1, arg3, v12);
        stamp_max<T0>(&v0, arg1, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(&arg5), v6, v7, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::slot(&arg5));
        0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::discard_price(arg5);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_identity<T0>(arg0);
        v14
    }

    public fun close_retired<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::AccountCap, arg4: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg5: u64, arg6: 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees::LossTicket {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_cap<T0>(arg2, arg3);
        close_retired_inner<T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8)
    }

    public fun close_retired_as_delegate<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: u64, arg5: 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees::LossTicket {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_delegate<T0>(arg2, 0x2::tx_context::sender(arg7), 0x2::clock::timestamp_ms(arg6));
        close_retired_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    fun close_retired_inner<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: u64, arg5: 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees::LossTicket {
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg3, arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg3);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_version<T0>(arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_exchange<T0>(arg1, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0));
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_version<T0>(arg2);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::status<T0>(arg1) == 3, 13840408841506127911);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_exchange<T0>(arg2, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0));
        guarded_reconcile<T0>(&v0, arg1, arg2, arg3);
        assert_positions_unpaused<T0>(arg1, arg3);
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::session_pending<T0>(arg1), 13844912458315202627);
        assert!(0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::market_id(&arg5) == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1), 13839845913027280931);
        assert!(!0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::is_closed(&arg5), 13842097717136982067);
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::remove_position<T0>(&v0, arg2, arg4);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_market(&v1) == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1), 13839845925912182819);
        let v2 = 0x2::clock::timestamp_ms(arg6);
        assert!(v2 != 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_opened_at(&v1), 13838438559617908761);
        let v3 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::timing<T0>(arg1);
        assert!(v2 >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_opened_at(&v1) + 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::min_hold_ms(&v3), 13838720038889717787);
        let v4 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::timestamp_ms(&arg5);
        let v5 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::sequence(&arg5);
        assert!(v4 > 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_oracle_ts(&v1) && v5 > 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_oracle_sequence(&v1), 13835905302006202375);
        assert!(v4 >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::last_oracle_ts_ms<T0>(arg1) && v5 >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::last_oracle_sequence<T0>(arg1), 13835905306301169671);
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::crossed_bust(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_is_long(&v1), 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(&arg5), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_bust(&v1)), 13839001548226297885);
        let v6 = settle_close<T0>(arg0, arg1, arg2, arg3, v1, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::ask_wad(&arg5), 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::bid_wad(&arg5), 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(&arg5), v2, 0, arg7);
        refresh_reserve<T0>(arg0, arg1, arg3, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(&arg5));
        stamp<T0>(&v0, arg1, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(&arg5), v4, v5, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::slot(&arg5));
        0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::discard_price(arg5);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_identity<T0>(arg0);
        v6
    }

    public fun emergency_close<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg5: u64, arg6: 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees::LossTicket {
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg3, arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg3);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_version<T0>(arg2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config>(arg3), arg4);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_version<T0>(arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_exchange<T0>(arg1, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0));
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_exchange<T0>(arg2, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0));
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::status<T0>(arg1) == 3, 13840409069139394599);
        guarded_reconcile<T0>(&v0, arg1, arg2, arg3);
        assert_positions_unpaused<T0>(arg1, arg3);
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::session_pending<T0>(arg1), 13844912685948469315);
        assert!(0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::market_id(&arg6) == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1), 13839846140660547619);
        assert!(!0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::is_closed(&arg6), 13842097944770248755);
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::remove_position<T0>(&v0, arg2, arg5);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_market(&v1) == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1), 13839846153545449507);
        let v2 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::timestamp_ms(&arg6);
        let v3 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::sequence(&arg6);
        assert!(v2 >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::last_oracle_ts_ms<T0>(arg1) && v3 >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::last_oracle_sequence<T0>(arg1), 13835905516754567175);
        assert!(v2 > 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_oracle_ts(&v1) && v3 > 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_oracle_sequence(&v1), 13835905521049534471);
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::crossed_bust(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_is_long(&v1), 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(&arg6), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_bust(&v1)), 13839001762974662685);
        let v4 = settle_close<T0>(arg0, arg1, arg2, arg3, v1, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::ask_wad(&arg6), 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::bid_wad(&arg6), 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(&arg6), 0x2::clock::timestamp_ms(arg7), 0, arg8);
        refresh_reserve<T0>(arg0, arg1, arg3, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(&arg6));
        stamp<T0>(&v0, arg1, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(&arg6), v2, v3, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::slot(&arg6));
        0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::discard_price(arg6);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_admin_action(&v0, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1), 14);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_identity<T0>(arg0);
        v4
    }

    public(friend) fun entry_within(arg0: bool, arg1: u128, arg2: u128) : bool {
        arg2 == 0 || arg0 && arg1 <= arg2 || arg1 >= arg2
    }

    public(friend) fun exit_within(arg0: bool, arg1: u128, arg2: u128) : bool {
        arg2 == 0 || arg0 && arg1 >= arg2 || arg1 <= arg2
    }

    public fun flag_liquidatable<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg3: u64, arg4: 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt, arg5: &0x2::clock::Clock) : bool {
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg2, arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_version<T0>(arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_exchange<T0>(arg1, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0));
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::oracle_killed<T0>(arg1), 13840691201246232617);
        assert!(0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::market_id(&arg4) == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1), 13839846780610674723);
        assert!(!0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::is_closed(&arg4), 13842098584720375859);
        let v1 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::timestamp_ms(&arg4);
        let v2 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::sequence(&arg4);
        assert!(v1 >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::last_oracle_ts_ms<T0>(arg1) && v2 >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::last_oracle_sequence<T0>(arg1), 13835906148114759687);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::contains(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq<T0>(arg1), arg3), 13842943026830639159);
        let v3 = *0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::borrow_record(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq<T0>(arg1), arg3);
        assert!(v1 > 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_oracle_ts(&v3) && v2 > 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_oracle_sequence(&v3), 13835906160999661575);
        let v4 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(&arg4);
        let v5 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::crossed_bust(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_is_long(&v3), v4, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_bust(&v3));
        0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::discard_price(arg4);
        let v6 = 0x2::clock::timestamp_ms(arg5);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::observe(&v0, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq_mut<T0>(&v0, arg1), v4, v1);
        if (v5) {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_liquidatable_flag_event(&v0, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1), arg3, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_account_id(&v3), true, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::flag_since(&v0, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq_mut<T0>(&v0, arg1), arg3, v6, v1), v6);
        } else if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::clear_since(&v0, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq_mut<T0>(&v0, arg1), arg3)) {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_liquidatable_flag_event(&v0, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1), arg3, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_account_id(&v3), false, 0, v6);
        };
        v5
    }

    public fun force_close_session<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: vector<u64>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees::LossTicket, 0x2::coin::Coin<T0>) {
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg3, arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg3);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_version<T0>(arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_version<T0>(arg2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_exchange<T0>(arg1, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0));
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_exchange<T0>(arg2, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0));
        assert!(0x1::vector::length<u64>(&arg4) <= 128, 13844633448649588801);
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::status<T0>(arg1);
        let v2 = if (v1 == 1) {
            true
        } else if (v1 == 2) {
            true
        } else {
            v1 == 3
        };
        assert!(v2, 13835626257980850181);
        let v3 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::session_close<T0>(arg1);
        assert!(0x1::option::is_some<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::SessionCloseV1>(&v3), 13844351986557648959);
        if (!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::session_pending<T0>(arg1)) {
            return (0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees::ticket(0, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg2)), 0x2::coin::zero<T0>(arg6))
        };
        reconcile_inner<T0>(&v0, arg1, arg2);
        let v4 = 0x1::option::destroy_some<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::SessionCloseV1>(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::session_close<T0>(arg1));
        let v5 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::sc_price_wad(&v4);
        let v6 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::sc_ts_ms(&v4);
        let v7 = 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1);
        let v8 = 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg2);
        let v9 = 0x2::clock::timestamp_ms(arg5);
        let v10 = 0x2::tx_context::sender(arg6);
        let v11 = v10 == 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::owner<T0>(arg2) || 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::is_delegate<T0>(arg2, v10);
        let v12 = if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::is_order_keeper(arg3, v10)) {
            0
        } else {
            1
        };
        let v13 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::liq_kind(v12, v11);
        let v14 = 0;
        let v15 = 0;
        let v16 = 0;
        while (v16 < 0x1::vector::length<u64>(&arg4)) {
            let v17 = *0x1::vector::borrow<u64>(&arg4, v16);
            v16 = v16 + 1;
            if (!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::session_pending<T0>(arg1)) {
                break
            };
            if (!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::session_eligible(v17, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::sc_watermark(&v4)) || !0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::has_position<T0>(arg2, v17)) {
                continue
            };
            if (!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::contains(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq<T0>(arg1), v17)) {
                continue
            };
            let v18 = *0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::borrow_record(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq<T0>(arg1), v17);
            if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_account_id(&v18) != v8) {
                continue
            };
            let v19 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::crossed_bust(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_is_long(&v18), v5, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_bust(&v18));
            if (v19) {
                let v20 = if (v13 == 1 && !grace_elapsed<T0>(arg1, arg3, v17, v9)) {
                    3
                } else {
                    v13
                };
                let v21 = liquidate_record<T0>(arg0, arg1, arg3, v17, v5, v5, v6, v9, v10, v20, false);
                v15 = v15 + v21;
                reconcile_inner<T0>(&v0, arg1, arg2);
            } else {
                let v22 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::remove_position<T0>(&v0, arg2, v17);
                let v23 = settle_close<T0>(arg0, arg1, arg2, arg3, v22, v5, v5, v5, v9, 2, arg6);
                v14 = v14 + 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees::settle_loss_ticket(v23);
            };
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_session_force_closed_event(&v0, v17, v7, v8, v5, v6, v19, 0x2::tx_context::sender(arg6));
            if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::note_session_force_closed<T0>(&v0, arg1, v17, arg6)) {
                let v24 = 0x1::option::destroy_some<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::SessionCloseV1>(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::session_close<T0>(arg1));
                0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_session_drained_event(&v0, v7, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::sc_closed_count(&v24));
            };
        };
        refresh_reserve<T0>(arg0, arg1, arg3, v5);
        let v25 = if (v15 > 0) {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::split_out<T0>(&v0, arg0, v15, arg6)
        } else {
            0x2::coin::zero<T0>(arg6)
        };
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_identity<T0>(arg0);
        (0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees::ticket(v14, v8), v25)
    }

    public fun grace_elapsed<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: u64, arg3: u64) : bool {
        let v0 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::liq_since(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq<T0>(arg0), arg2);
        0x1::option::is_some<u64>(&v0) && arg3 >= *0x1::option::borrow<u64>(&v0) + 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::liq_grace_ms(arg1)
    }

    fun guarded_reconcile<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config) {
        if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::pending_count(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq<T0>(arg1), 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg2)) == 0) {
            return
        };
        assert_reconcile_unpaused<T0>(arg1, arg3);
        reconcile_inner<T0>(arg0, arg1, arg2);
    }

    public(friend) fun liq_kind_keeper() : u8 {
        0
    }

    public(friend) fun liquidatable_at<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg1: u64, arg2: u128) : bool {
        if (!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::contains(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq<T0>(arg0), arg1)) {
            return false
        };
        let v0 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::borrow_record(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq<T0>(arg0), arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::crossed_bust(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_is_long(v0), arg2, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_bust(v0))
    }

    public fun liquidatable_since<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg1: u64) : 0x1::option::Option<u64> {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::liq_since(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq<T0>(arg0), arg1)
    }

    public fun liquidate<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg3: u64, arg4: 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_version<T0>(arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_exchange<T0>(arg1, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0));
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::is_order_keeper(arg2, 0x2::tx_context::sender(arg6)), 13845194379968643141);
        liquidate_receipt_mode<T0>(arg0, arg1, arg2, arg3, arg4, 0, 0, arg5, arg6)
    }

    public fun liquidate_after_grace<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg4: u64, arg5: 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_version<T0>(arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_exchange<T0>(arg1, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0));
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_exchange<T0>(arg3, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0));
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::contains(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq<T0>(arg1), arg4), 13842942786312470583);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_account_id(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::borrow_record(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq<T0>(arg1), arg4)) == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg3), 13845476065398882375);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::is_order_keeper(arg2, v0);
        if (!v1) {
            assert!(grace_elapsed<T0>(arg1, arg2, arg4, 0x2::clock::timestamp_ms(arg6)), 13845194607601909829);
        };
        let v2 = v0 == 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::owner<T0>(arg3) || 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::is_delegate<T0>(arg3, v0);
        let v3 = if (v1) {
            0
        } else {
            1
        };
        liquidate_receipt_mode<T0>(arg0, arg1, arg2, arg4, arg5, 0, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::liq_kind(v3, v2), arg6, arg7)
    }

    public(friend) fun liquidate_receipt_mode<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg3: u64, arg4: 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt, arg5: u8, arg6: u8, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg2, arg0);
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::oracle_killed<T0>(arg1), 13840691394519760937);
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::session_pending<T0>(arg1), 13844913523467092035);
        assert!(0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::market_id(&arg4) == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1), 13839846978179170339);
        assert!(!0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::is_closed(&arg4), 13842098782288871475);
        let v1 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::timestamp_ms(&arg4);
        let v2 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::sequence(&arg4);
        if (arg5 == 0) {
            assert!(v1 >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::last_oracle_ts_ms<T0>(arg1), 13835906349978222599);
            assert!(v2 >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::last_oracle_sequence<T0>(arg1), 13835906354273189895);
        };
        let v3 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(&arg4);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::contains(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq<T0>(arg1), arg3), 13842943241579003959);
        let v4 = *0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::borrow_record(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq<T0>(arg1), arg3);
        assert!(v1 > 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_oracle_ts(&v4) && v2 > 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_oracle_sequence(&v4), 13835906375748026375);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::crossed_bust(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_is_long(&v4), v3, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_bust(&v4)), 13839284088355029023);
        let (v5, v6) = reserve_mark<T0>(arg1, v3, v1, v2);
        let v7 = liquidate_record<T0>(arg0, arg1, arg2, arg3, v3, v5, v1, 0x2::clock::timestamp_ms(arg7), 0x2::tx_context::sender(arg8), arg6, false);
        if (!v6) {
            refresh_reserve<T0>(arg0, arg1, arg2, v5);
        } else {
            refresh_reserve<T0>(arg0, arg1, arg2, v3);
        };
        stamp_max<T0>(&v0, arg1, v3, v1, v2, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::slot(&arg4));
        0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::discard_price(arg4);
        let v8 = if (v7 > 0) {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::split_out<T0>(&v0, arg0, v7, arg8)
        } else {
            0x2::coin::zero<T0>(arg8)
        };
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_identity<T0>(arg0);
        v8
    }

    fun liquidate_record<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg3: u64, arg4: u128, arg5: u128, arg6: u64, arg7: u64, arg8: address, arg9: u8, arg10: bool) : u64 {
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg2, arg0);
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::remove(&v0, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq_mut<T0>(&v0, arg1), arg3);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_is_long(&v1);
        let v3 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_margin(&v1);
        let v4 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_notional(&v1);
        let v5 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_exposure(&v1);
        let v6 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_account_id(&v1);
        let v7 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_owner(&v1);
        let v8 = 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1);
        let v9 = if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::is_hedged(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq<T0>(arg1), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_account_id(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::borrow_record(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq<T0>(arg1), arg3)))) {
            true
        } else if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_wash(&v1)) {
            true
        } else {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::opposite_notional(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq<T0>(arg1), v6, v2) > 0
        };
        let v10 = arg8 == v7 || 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::is_account_delegate<T0>(arg0, v6, arg8);
        let v11 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::liq_kind(arg9, v10);
        let v12 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::risk<T0>(arg1);
        let v13 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::bps_of(v3, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq_bounty_bps(&v12));
        let v14 = if (v13 < 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::liq_bounty_cap(arg2)) {
            v13
        } else {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::liq_bounty_cap(arg2)
        };
        let v15 = if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::liq_bounty_paid(v11)) {
            v14
        } else {
            0
        };
        let v16 = v3 - v15;
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::sub_oi<T0>(&v0, arg1, v2, v4);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::sub_locked<T0>(&v0, arg1, v2, v5);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::sub_qty<T0>(&v0, arg1, v2, v5, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_entry(&v1));
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::sub_open_exposure<T0>(&v0, arg0, v5);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::unlock_all<T0>(&v0, arg0, v3);
        refresh_reserve<T0>(arg0, arg1, arg2, arg5);
        let v17 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::realize_loss<T0>(&v0, arg0, v16, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::loss_fee_bps(arg2));
        0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::mint_cap::note_pnl<T0>(&v0, arg0, arg7, v16 - v17, 0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::route_retained<T0>(&v0, arg0, arg2, v17);
        let v18 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::liq_mint_basis(v11, v3, v3 - v14, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::adverse_loss(v2, v4, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_entry(&v1), arg4), v9);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::note_minted_loss<T0>(&v0, arg0, v18);
        0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fee_mint::park<T0>(&v0, arg0, v6, v18, arg7);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::push_pending(&v0, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq_mut<T0>(&v0, arg1), v6, arg3);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_position_exit_event(&v0, arg3, v8, 1, v2, arg4, arg6);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_liquidate_position_event(&v0, arg3, v6, v15, v16);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_liquidation_detail_event(&v0, arg3, v8, v6, arg8, v15, v16, v17, arg10);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_liquidation_kind_event(&v0, arg3, v8, arg8, v11, v18, v15);
        0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::game::on_loss<T0>(arg0, arg2, v7, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::achievement_fee_basis(v17, 0, 0, v9, v11 == 2, true), arg6);
        v15
    }

    public fun liquidate_retired<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg3: u64, arg4: 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_version<T0>(arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_exchange<T0>(arg1, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0));
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::status<T0>(arg1) == 3, 13840409382672007207);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::is_order_keeper(arg2, 0x2::tx_context::sender(arg6)), 13845194461573021765);
        liquidate_receipt_mode<T0>(arg0, arg1, arg2, arg3, arg4, 0, 0, arg5, arg6)
    }

    public(friend) fun liquidations_paused<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config) : bool {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::oracle_killed<T0>(arg0)
    }

    fun locked_notional<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: u64, arg5: u64) : u128 {
        let v0 = (arg4 as u128) * (arg5 as u128) * (taker_bps<T0>(arg1, arg3) as u128) / 10000;
        if (v0 >= (arg4 as u128)) {
            return 0
        };
        let v1 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::referral::quote<T0>(arg0, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::owner<T0>(arg2), (v0 as u64), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::referral_enabled(arg3), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::referee_discount_bps(arg3), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::referral_fee_bps(arg3), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::second_level_fee_bps(arg3));
        ((arg4 - 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::referral::charged(&v1)) as u128) * (arg5 as u128)
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

    public(friend) fun open_inner<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: u64, arg10: u128, arg11: 0x1::option::Option<u32>, arg12: u8, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg3, arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg3);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_version<T0>(arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_exchange<T0>(arg1, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0));
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_version<T0>(arg2);
        assert!(!arg8, 13840126095218966565);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_exchange<T0>(arg2, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0));
        guarded_reconcile<T0>(&v0, arg1, arg2, arg3);
        let (v1, v2) = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::builder::snapshot<T0>(arg0, arg3, arg11);
        let v3 = if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::is_paused(arg3)) {
            true
        } else if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::opens_paused<T0>(arg1)) {
            true
        } else if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::closes_paused(arg3)) {
            true
        } else {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::closes_paused<T0>(arg1)
        };
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::trading_blocked(v3), 13835341059267362819);
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::session_pending<T0>(arg1), 13844911217069654083);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::enabled<T0>(arg1), 13840970571689099307);
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::oracle_killed<T0>(arg1), 13840689101007224873);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::status<T0>(arg1) == 1, 13835622555719041029);
        assert!(0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::market_id(&arg4) == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1), 13839844684666634275);
        assert!(!0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::is_closed(&arg4), 13842096488776335411);
        let v4 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::timestamp_ms(&arg4);
        let v5 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::sequence(&arg4);
        if (arg12 == 0) {
            assert!(v4 >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::last_oracle_ts_ms<T0>(arg1), 13835904060760653831);
            assert!(v5 >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::last_oracle_sequence<T0>(arg1), 13835904065055621127);
        };
        let (v6, _) = reserve_mark<T0>(arg1, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(&arg4), v4, v5);
        let v8 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::risk<T0>(arg1);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::leverage_within(arg6, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::max_leverage(&v8)), 13836185557212332041);
        assert!(arg6 >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::min_leverage(&v8), 13841815065339101233);
        let v9 = if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::taker_fee_is_set(arg3)) {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::tighter_bps(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::taker_fee_bps<T0>(arg1), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::taker_fee_bps(arg3))
        } else {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::taker_fee_bps<T0>(arg1)
        };
        let v10 = (arg5 as u128) * (arg6 as u128) * (v9 as u128) / 10000;
        assert!(v10 < (arg5 as u128), 13838155929294864407);
        let v11 = (v10 as u64);
        let v12 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::referral::quote<T0>(arg0, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::owner<T0>(arg2), v11, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::referral_enabled(arg3), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::referee_discount_bps(arg3), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::referral_fee_bps(arg3), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::second_level_fee_bps(arg3));
        let v13 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::referral::charged(&v12);
        let v14 = arg5 - v13;
        assert!(v14 >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::min_margin(&v8), 13836467135268388875);
        let v15 = (v14 as u128) * (arg6 as u128);
        assert!(v15 <= 18446744073709551615, 13836467143858323467);
        let v16 = (v15 as u64);
        assert!(v16 >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::min_notional(&v8) && v16 <= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::max_position_notional(&v8), 13836467152448258059);
        let (v17, v18) = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::charge_notional<T0>(&v0, arg1, v16, 0x2::clock::timestamp_ms(arg13), *0x2::tx_context::digest(arg14));
        assert!(v17, 13836748648899936269);
        assert!(v18, 13837030128171745295);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::open_notional<T0>(arg2) + v16 <= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::max_account_notional(&v8), 13837311607443554321);
        let v19 = 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg2);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::free_balance<T0>(arg0, v19) >= arg5, 13838156040964014103);
        let v20 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::impact<T0>(arg1);
        let v21 = if (arg7) {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::long_oi<T0>(arg1)
        } else {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::short_oi<T0>(arg1)
        };
        let v22 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::marginal_exposure(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::effective_depth(&v20), v21, v16);
        let v23 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::factor_bps(v22, v16);
        if (arg6 == 1) {
            assert!(v22 == v16, 13841533766455918639);
        } else {
            assert!(v22 > 0, 13841533775045853231);
        };
        if (arg9 > 0) {
            assert!(v23 >= arg9, 13841533787930755119);
        };
        assert!(v23 >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::min_payout_factor_bps(arg3), 13841533800815657007);
        let (v24, v25) = if (arg7) {
            (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::long_locked_exposure<T0>(arg1), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::max_long_exposure<T0>(arg1))
        } else {
            (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::short_locked_exposure<T0>(arg1), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::max_short_exposure<T0>(arg1))
        };
        assert!((v24 as u128) + (v22 as u128) <= (v25 as u128), 13837593181204643859);
        let (v26, v27) = if (arg7) {
            (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::max_long_oi<T0>(arg1), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::long_oi<T0>(arg1))
        } else {
            (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::max_short_oi<T0>(arg1), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::short_oi<T0>(arg1))
        };
        assert!((v27 as u128) + (v16 as u128) <= (v26 as u128), 13843222710806118457);
        let v28 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::tighter_bps(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::win_fee_bps<T0>(arg1), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::win_fee_bps(arg3));
        let v29 = if (arg7) {
            0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::ask_wad(&arg4)
        } else {
            0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::bid_wad(&arg4)
        };
        assert!(entry_within(arg7, v29, arg10), 13843785673644572731);
        let v30 = if (arg7) {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::bust_long(v29, arg6, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::effective_bust_buffer(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::bust_buffer_wad(&v8), arg6))
        } else {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::bust_short(v29, arg6, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::effective_bust_buffer(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::bust_buffer_wad(&v8), arg6))
        };
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::crossed_bust(arg7, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(&arg4), v30), 13842659812392042549);
        let v31 = 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1);
        let v32 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::opposite_open<T0>(arg2, v31, arg7);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::debit_account_free<T0>(&v0, arg0, v19, arg5);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::lock_open<T0>(&v0, arg0, arg5, v13);
        0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::referral::pay_open_rewards<T0>(arg0, v12);
        let v33 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::alloc_position_id<T0>(&v0, arg0);
        let v34 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::builder::accrue<T0>(arg0, v11, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::referral::protocol_remainder(&v12), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::owner<T0>(arg2), v19, v33, v1, v2, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::builder::kind_open());
        let v35 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::referral::protocol_remainder(&v12) - v34;
        refresh_reserve<T0>(arg0, arg1, arg3, v6);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::route_retained<T0>(&v0, arg0, arg3, v35);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::add_open_exposure<T0>(&v0, arg0, v22);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::add_open_notional<T0>(&v0, arg2, v16);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::add_side<T0>(&v0, arg2, v31, arg7, v16);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::note_hedge_if_two_sided<T0>(&v0, arg2, v31);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::add_oi<T0>(&v0, arg1, arg7, v16);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::add_locked<T0>(&v0, arg1, arg7, v22);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::add_qty<T0>(&v0, arg1, arg7, v22, v29);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::insert(&v0, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq_mut<T0>(&v0, arg1), v33, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::record(&v0, v19, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::owner<T0>(arg2), arg7, v14, v16, v22, v29, v30, v4, v5, v32));
        stamp_max<T0>(&v0, arg1, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(&arg4), v4, v5, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::slot(&arg4));
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_open_position_event(&v0, v33, v19, v31, arg7, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(&arg4), 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::conf_wad(&arg4), v29, v30, v14, v16, v23, v22, v28, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::deadband_ppm(&v20), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::close_fee_ppm(&v20), v1, v34);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::insert_position<T0>(&v0, arg2, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::new_position(&v0, v33, v31, arg7, v29, v14, arg6, v16, v30, 0x2::clock::timestamp_ms(arg13), v4, v5, v22, v23, v28, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::deadband_ppm(&v20), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::close_fee_ppm(&v20), v35, v32, v1, v2));
        refresh_reserve<T0>(arg0, arg1, arg3, v6);
        0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::discard_price(arg4);
        0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::game::on_open<T0>(arg0, arg3, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::owner<T0>(arg2), v31, v16, 0x2::clock::timestamp_ms(arg13));
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_identity<T0>(arg0);
        v33
    }

    public(friend) fun open_risk_code<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: u64, arg3: u64) : u8 {
        let v0 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::risk<T0>(arg0);
        if (!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::leverage_within(arg3, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::max_leverage(&v0))) {
            return 1
        };
        if (arg3 < 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::min_leverage(&v0)) {
            return 2
        };
        let v1 = (arg2 as u128) * (arg3 as u128) * (taker_bps<T0>(arg0, arg1) as u128) / 10000;
        if (v1 >= (arg2 as u128)) {
            return 4
        };
        let v2 = arg2 - (v1 as u64);
        if (v2 < 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::min_margin(&v0)) {
            return 4
        };
        if ((v2 as u128) * (arg3 as u128) < (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::min_notional(&v0) as u128)) {
            return 3
        };
        if ((arg2 as u128) * (arg3 as u128) > (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::max_position_notional(&v0) as u128)) {
            return 3
        };
        0
    }

    public(friend) fun positions_paused<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config) : bool {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::oracle_killed<T0>(arg0)
    }

    public fun reconcile<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config) {
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg3, arg2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::assert_version<T0>(arg1);
        guarded_reconcile<T0>(&v0, arg0, arg1, arg3);
    }

    public(friend) fun reconcile_halted<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config) : bool {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::oracle_killed<T0>(arg0)
    }

    public(friend) fun reconcile_inner<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>) {
        let v0 = 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg2);
        if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::pending_count(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq<T0>(arg1), v0) == 0) {
            return
        };
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::take_pending(arg0, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq_mut<T0>(arg0, arg1), v0, 32);
        let v2 = 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v1)) {
            let v4 = *0x1::vector::borrow<u64>(&v1, v3);
            if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::has_position<T0>(arg2, v4)) {
                let v5 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::remove_position<T0>(arg0, arg2, v4);
                0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::sub_open_notional<T0>(arg0, arg2, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_notional(&v5));
                0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::sub_side<T0>(arg0, arg2, v2, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_is_long(&v5), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_notional(&v5));
                0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::clear_hedge_if_flat<T0>(arg0, arg2, v2);
                0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::destroy_position(arg0, v5);
                0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_position_reconciled_event(arg0, v0, v4);
            };
            v3 = v3 + 1;
        };
    }

    fun refresh_reserve<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg3: u128) {
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg2, arg0);
        let (v1, v2) = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::reserve_at<T0>(arg1, arg3, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::trim_max_share_bps(arg2));
        let (v3, v4) = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::swap_snapshot<T0>(&v0, arg1, v1, v2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::adjust_reserve<T0>(&v0, arg0, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1), v3, v4, v1, v2, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::has_oi<T0>(arg1));
    }

    fun reserve_mark<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg1: u128, arg2: u64, arg3: u64) : (u128, bool) {
        if (arg2 >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::last_oracle_ts_ms<T0>(arg0) && arg3 >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::last_oracle_sequence<T0>(arg0)) {
            (arg1, true)
        } else {
            (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::last_mark_wad<T0>(arg0), false)
        }
    }

    public fun retire_market<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg4: 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt) {
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg2, arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config>(arg2), arg3);
        assert!(0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::market_id(&arg4) == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg0), 13839849022583603235);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::set_status<T0>(&v0, arg0, 3, 0x1::option::none<u128>());
        0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::discard_price(arg4);
    }

    fun settle_close<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Position, arg5: u128, arg6: u128, arg7: u128, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) : 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees::LossTicket {
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg3, arg0);
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_is_long(&arg4);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_margin(&arg4);
        let v3 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_notional(&arg4);
        let v4 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_entry(&arg4);
        let v5 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_exposure(&arg4);
        let v6 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_id(&arg4);
        let v7 = if (v1) {
            arg6
        } else {
            arg5
        };
        let v8 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::settle(v1, v3, v5, v4, v7, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_deadband_ppm(&arg4), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_close_fee_ppm(&arg4), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_win_fee_bps(&arg4), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::trim_max_share_bps(arg3));
        let v9 = 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1);
        let v10 = if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_wash(&arg4)) {
            true
        } else if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::is_hedged<T0>(arg2, v9)) {
            true
        } else {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::closed_opposite_same_checkpoint<T0>(arg2, v9, v1, arg8)
        };
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::remove(&v0, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq_mut<T0>(&v0, arg1), v6);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::sub_oi<T0>(&v0, arg1, v1, v3);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::sub_locked<T0>(&v0, arg1, v1, v5);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::sub_qty<T0>(&v0, arg1, v1, v5, v4);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::sub_open_exposure<T0>(&v0, arg0, v5);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::sub_open_notional<T0>(&v0, arg2, v3);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::sub_side<T0>(&v0, arg2, v9, v1, v3);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::clear_hedge_if_flat<T0>(&v0, arg2, v9);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::note_close<T0>(&v0, arg2, v9, v1, arg8);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::unlock_all<T0>(&v0, arg0, v2);
        refresh_reserve<T0>(arg0, arg1, arg3, arg7);
        let v11 = apply_pnl<T0>(arg0, arg2, arg3, &arg4, &v8, v2, arg8);
        let v12 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::loss_mint_basis(v11.loss, v10, false);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::note_minted_loss<T0>(&v0, arg0, v12);
        let v13 = if (v11.loss > 0) {
            v11.loss
        } else {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::pnl_adjusted(&v8)
        };
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_position_exit_event(&v0, v6, v9, arg9, v1, v7, arg8);
        let v14 = if (v11.loss > 0) {
            0
        } else {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::pnl_win_fee(&v8)
        };
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_close_fees_event(&v0, v6, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::pnl_raw(&v8), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::pnl_raw(&v8) - 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::pnl_adjusted(&v8), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::pnl_close_toll(&v8), v14, v11.loss_fee, v11.discount, v11.retained);
        let v15 = if (v11.loss > 0) {
            0
        } else {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::pnl_raw(&v8) - v11.user_profit
        };
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_close_position_event(&v0, v6, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg2), v13, v15, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::pnl_win_fee(&v8), v11.user_profit, v11.queued, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_builder_id(&arg4), v11.builder_cut);
        0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::game::on_close<T0>(arg0, arg3, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::owner<T0>(arg2), v9, v3, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_leverage(&arg4), v2, v11.loss, v11.user_profit, v10, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::achievement_fee_basis(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::position_open_fee(&arg4), v11.retained, 0, v10, false, false), arg8);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::destroy_position(&v0, arg4);
        0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::fees::ticket(v12, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>>(arg2))
    }

    fun stamp<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: u128, arg3: u64, arg4: u64, arg5: u64) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::observe(arg0, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq_mut<T0>(arg0, arg1), arg2, arg3);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::stamp_oracle<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun stamp_max<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: u128, arg3: u64, arg4: u64, arg5: u64) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::observe(arg0, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq_mut<T0>(arg0, arg1), arg2, arg3);
        if (arg3 >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::last_oracle_ts_ms<T0>(arg1) && arg4 >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::last_oracle_sequence<T0>(arg1)) {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::stamp_oracle<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        };
    }

    public fun sweep<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg3: 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::PriceReceipt, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg2, arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_version<T0>(arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_exchange<T0>(arg1, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0));
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::is_order_keeper(arg2, 0x2::tx_context::sender(arg6)), 13845195230372167749);
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::oracle_killed<T0>(arg1), 13840691635037929513);
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::session_pending<T0>(arg1), 13844913763985260611);
        assert!(0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::market_id(&arg3) == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1), 13839847218697338915);
        assert!(!0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::is_closed(&arg3), 13842099022807040051);
        let v1 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::timestamp_ms(&arg3);
        let v2 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::sequence(&arg3);
        assert!(v1 >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::last_oracle_ts_ms<T0>(arg1) && v2 >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::last_oracle_sequence<T0>(arg1), 13835906586201423879);
        let v3 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::price_wad(&arg3);
        let v4 = if (arg4 < 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::sweep_max(arg2)) {
            arg4
        } else {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::sweep_max(arg2)
        };
        let (_, v6) = sweep_inner<T0>(arg0, arg1, arg2, 0x2::tx_context::sender(arg6), v3, v1, v2, 0x2::clock::timestamp_ms(arg5), v4);
        refresh_reserve<T0>(arg0, arg1, arg2, v3);
        stamp<T0>(&v0, arg1, v3, v1, v2, 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::slot(&arg3));
        0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle::discard_price(arg3);
        let v7 = if (v6 > 0) {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::split_out<T0>(&v0, arg0, v6, arg6)
        } else {
            0x2::coin::zero<T0>(arg6)
        };
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_identity<T0>(arg0);
        v7
    }

    fun sweep_candidate<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg1: bool, arg2: u128, arg3: u64, arg4: u64) : (bool, bool, u64, u128) {
        let v0 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::peek(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq<T0>(arg0), arg1);
        if (0x1::option::is_none<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::HeapEntry>(&v0)) {
            return (false, false, 0, 0)
        };
        let v1 = 0x1::option::destroy_some<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::HeapEntry>(v0);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::entry_position_id(&v1);
        let v3 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::entry_bust(&v1);
        if (!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::crossed_bust(arg1, arg2, v3)) {
            return (false, false, v2, v3)
        };
        let v4 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::borrow_record(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq<T0>(arg0), v2);
        let v5 = arg3 > 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_oracle_ts(v4) && arg4 > 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::r_oracle_sequence(v4);
        (true, v5, v2, v3)
    }

    fun sweep_inner<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg3: address, arg4: u128, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : (u64, u64) {
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg2, arg0);
        let v1 = 0;
        let v2 = 0;
        let v3 = true;
        let v4 = true;
        let v5 = 0x1::vector::empty<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::HeapEntry>();
        let v6 = 0x1::vector::empty<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::HeapEntry>();
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
            let v16 = liquidate_record<T0>(arg0, arg1, arg2, v15, arg4, arg4, arg5, arg7, arg3, 0, true);
            v2 = v2 + v16;
            v1 = v1 + 1;
        };
        while (!0x1::vector::is_empty<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::HeapEntry>(&v5)) {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::reinsert(&v0, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq_mut<T0>(&v0, arg1), 0x1::vector::pop_back<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::HeapEntry>(&mut v5));
        };
        while (!0x1::vector::is_empty<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::HeapEntry>(&v6)) {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::reinsert(&v0, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq_mut<T0>(&v0, arg1), 0x1::vector::pop_back<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::HeapEntry>(&mut v6));
        };
        (v1, v2)
    }

    fun sweep_side_candidate<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: bool, arg3: u128, arg4: u64, arg5: u64, arg6: &mut vector<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::HeapEntry>) : (bool, u64, u128) {
        let v0;
        let v1;
        loop {
            let (v2, v3, v0, v1) = sweep_candidate<T0>(arg1, arg2, arg3, arg4, arg5);
            if (!v2 || v3) {
                return (v3, v0, v1)
            };
            if (0x1::vector::length<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::HeapEntry>(arg6) >= 2) {
                break
            };
            0x1::vector::push_back<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::HeapEntry>(arg6, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::pop_top(arg0, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq_mut<T0>(arg0, arg1), arg2));
        };
        (false, v0, v1)
    }

    public(friend) fun taker_bps<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config) : u64 {
        if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::taker_fee_is_set(arg1)) {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::tighter_bps(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::taker_fee_bps<T0>(arg0), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::taker_fee_bps(arg1))
        } else {
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::taker_fee_bps<T0>(arg0)
        }
    }

    public(friend) fun tx_notional_ok<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg4: u64, arg5: u64) : bool {
        let v0 = locked_notional<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        if (v0 > 0) {
            let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::risk<T0>(arg1);
            v0 <= (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::max_tx_notional(&v2) as u128)
        } else {
            false
        }
    }

    // decompiled from Move bytecode v7
}

