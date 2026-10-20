module 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::trade {
    struct Settled has copy, drop {
        loss: u64,
        user_profit: u64,
        loss_fee: u64,
        discount: u64,
        builder_cut: u64,
        retained: u64,
        queued: bool,
    }

    public(friend) fun liquidations_paused<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config) : bool {
        let v0 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::closes_paused(arg1) || 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::closes_paused<T0>(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::liquidation_paused(v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::oracle_killed<T0>(arg0), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::liquidations_paused(arg1))
    }

    public(friend) fun account_notional_ok<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: u64, arg5: u64) : bool {
        let v0 = locked_notional<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        if (v0 == 0) {
            return false
        };
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::risk<T0>(arg1);
        (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::open_notional<T0>(arg2) as u128) + v0 <= (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::max_account_notional(&v1) as u128)
    }

    fun apply_pnl<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Position, arg4: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::Pnl, arg5: u64) : Settled {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg2));
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::pnl_loss(arg4);
        let v2 = v1;
        if (v1 > arg5) {
            v2 = arg5;
        };
        let v3 = if (v2 > 0) {
            0
        } else {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::pnl_net(arg4)
        };
        let v4 = arg5 - v2;
        let v5 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::pnl_close_toll(arg4);
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
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::realize_loss<T0>(&v0, arg0, v2, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::loss_fee_bps(arg2))
        } else {
            0
        };
        let v11 = 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>>(arg1);
        let v12 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::owner<T0>(arg1);
        let v13 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_id(arg3);
        let v14 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_builder_id(arg3);
        let v15 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::effective_builder_share(arg2, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_builder_share(arg3));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::credit_account_free<T0>(&v0, arg0, v11, v4 - v8);
        let v16 = if (v2 > 0) {
            0
        } else {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::pnl_win_fee(arg4)
        };
        let v17 = if (v2 > 0) {
            0
        } else {
            v16 + v3
        };
        let v18 = if (v17 > 0) {
            if (!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::queue_nonempty<T0>(arg0)) {
                0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::lp_cash<T0>(arg0) >= v17
            } else {
                false
            }
        } else {
            false
        };
        let v19 = v8;
        let v20 = false;
        if (v18) {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::debit_lp<T0>(&v0, arg0, v17);
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::debit_tracked<T0>(&v0, arg0, v17);
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::credit_account_free<T0>(&v0, arg0, v11, v9);
            v19 = v8 + v6 + v16;
        } else if (v17 > 0) {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::enqueue_with_builder<T0>(&v0, arg0, v12, v11, v9, v16 + v6, v13, v14, v15);
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::debit_tracked<T0>(&v0, arg0, v17);
            v20 = true;
        };
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::add_fee<T0>(&v0, arg0, v19);
        let v21 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::referral::quote<T0>(arg0, v12, v19, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::referral_enabled(arg2), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::referee_discount_bps(arg2), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::referral_fee_bps(arg2), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::second_level_fee_bps(arg2));
        let v22 = v19 - 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::referral::charged(&v21);
        if (v22 > 0) {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::debit_fee_lp<T0>(&v0, arg0, v22);
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::credit_account_free<T0>(&v0, arg0, v11, v22);
        };
        let v23 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::referral::protocol_remainder(&v21);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::referral::pay_open_rewards<T0>(arg0, v21);
        let v24 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::builder::accrue<T0>(arg0, v23, v23, v12, v11, v13, v14, v15, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::builder::kind_close_toll());
        let v25 = v23 - v24;
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::route_retained<T0>(&v0, arg0, arg2, v25 + v10);
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

    public(friend) fun assert_open_risk<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: u64, arg3: u64) {
        let v0 = open_risk_code<T0>(arg0, arg1, arg2, arg3);
        assert!(v0 != 1, 13836184921557172233);
        assert!(v0 != 2, 13841814425388974129);
        assert!(v0 != 3 && v0 != 4, 13836466405123948555);
    }

    fun assert_positions_unpaused<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config) {
        let v0 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::closes_paused(arg1) || 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::closes_paused<T0>(arg0);
        assert!(!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::trading_blocked(v0), 13841255813352259629);
        assert!(!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::oracle_killed<T0>(arg0), 13840692867693543465);
    }

    fun assert_reconcile_unpaused<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_unpaused(arg1, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::pause_liquidations());
        assert!(!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::oracle_killed<T0>(arg0), 13840691381634859049);
        assert!(!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::closes_paused(arg1) && !0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::closes_paused<T0>(arg0), 13841254335883509805);
    }

    public fun check_market<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::ReserveCheck, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg3));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg3);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_version<T0>(arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_exchange<T0>(arg2, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>>(arg1));
        assert!(!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::session_pending<T0>(arg2), 13844915095425253445);
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::market_id(&arg4) == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg2), 13839848550137200675);
        assert!(!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::oracle_killed<T0>(arg2), 13840692987952627753);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_unpaused(arg3, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::pause_lp());
        assert!(!0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::is_closed(&arg4), 13842100371426770995);
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::in_band(&arg4), 13842381850698580021);
        let v1 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::timestamp_ms(&arg4);
        let v2 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::sequence(&arg4);
        assert!(v1 >= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::last_oracle_ts_ms<T0>(arg2) && v2 >= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::last_oracle_sequence<T0>(arg2), 13835907939116122119);
        let v3 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&arg4);
        refresh_reserve<T0>(arg1, arg2, arg3, v3);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::stamp_oracle<T0>(&v0, arg2, v3, v1, v2, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::slot(&arg4));
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::discard_price(arg4);
        if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::in_oi_set<T0>(arg1, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg2))) {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::note_checked(&v0, arg0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>>(arg1), 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg2));
        };
    }

    public(friend) fun close_inner<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: u64, arg5: 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt, arg6: u128, arg7: u8, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::LossTicket {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg3));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg3);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_version<T0>(arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_exchange<T0>(arg1, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>>(arg0));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_exchange<T0>(arg2, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>>(arg0));
        guarded_reconcile<T0>(&v0, arg1, arg2, arg3);
        assert_positions_unpaused<T0>(arg1, arg3);
        assert!(!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::session_pending<T0>(arg1), 13844912058883375173);
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::status<T0>(arg1);
        assert!(v1 == 1 || v1 == 2, 13835623393237663749);
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::market_id(&arg5) == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg1), 13839845522185256995);
        assert!(!0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::is_closed(&arg5), 13842097326294958131);
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::in_band(&arg5), 13842378805566767157);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::remove_position<T0>(&v0, arg2, arg4);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_market(&v2) == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg1), 13839845539365126179);
        let v3 = 0x2::clock::timestamp_ms(arg8);
        assert!(v3 != 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_opened_at(&v2), 13838438173070852121);
        let v4 = if (arg7 == 1) {
            true
        } else {
            let v5 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::timing<T0>(arg1);
            v3 >= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_opened_at(&v2) + 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::min_hold_ms(&v5)
        };
        assert!(v4, 13838719669522530331);
        let v6 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::timestamp_ms(&arg5);
        let v7 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::sequence(&arg5);
        let v8 = arg7 == 0;
        assert!(v6 > 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_oracle_ts(&v2) && (!v8 || v6 >= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::last_oracle_ts_ms<T0>(arg1)), 13835904941228949511);
        assert!(v7 > 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_oracle_sequence(&v2) && (!v8 || v7 >= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::last_oracle_sequence<T0>(arg1)), 13835904945523916807);
        let v9 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&arg5);
        assert!(!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::crossed_bust(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_is_long(&v2), v9, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_bust(&v2)), 13839001178859110429);
        let v10 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_is_long(&v2);
        let v11 = if (v10) {
            0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::bid_wad(&arg5)
        } else {
            0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::ask_wad(&arg5)
        };
        assert!(exit_within(v10, v11, arg6), 13844067741327032383);
        let (v12, v13) = reserve_mark<T0>(arg1, v9, v6, v7);
        let v14 = settle_close<T0>(arg0, arg1, arg2, arg3, v2, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::ask_wad(&arg5), 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::bid_wad(&arg5), v12, v3, 0, arg9);
        if (v13) {
            touch_sweep<T0>(arg0, arg1, arg3, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>>(arg2), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::owner<T0>(arg2), v9, v6, v7, arg9);
        };
        refresh_reserve_with<T0>(arg0, arg1, arg3, v12, true, v13);
        stamp_max<T0>(&v0, arg1, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&arg5), v6, v7, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::slot(&arg5));
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::discard_price(arg5);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_identity<T0>(arg0);
        v14
    }

    public fun close_retired<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::AccountCap, arg4: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg5: u64, arg6: 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::LossTicket {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_cap<T0>(arg2, arg3);
        close_retired_inner<T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8)
    }

    public fun close_retired_as_delegate<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: u64, arg5: 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::LossTicket {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_delegate<T0>(arg2, 0x2::tx_context::sender(arg7), 0x2::clock::timestamp_ms(arg6));
        close_retired_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    fun close_retired_inner<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: u64, arg5: 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::LossTicket {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg3));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg3);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_version<T0>(arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_exchange<T0>(arg1, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>>(arg0));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_version<T0>(arg2);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::status<T0>(arg1) == 3, 13840408824326258727);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_exchange<T0>(arg2, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>>(arg0));
        guarded_reconcile<T0>(&v0, arg1, arg2, arg3);
        assert_positions_unpaused<T0>(arg1, arg3);
        assert!(!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::session_pending<T0>(arg1), 13844912441135464517);
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::market_id(&arg5) == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg1), 13839845895847411747);
        assert!(!0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::is_closed(&arg5), 13842097699957112883);
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::in_band(&arg5), 13842379179228921909);
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::remove_position<T0>(&v0, arg2, arg4);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_market(&v1) == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg1), 13839845913027280931);
        let v2 = 0x2::clock::timestamp_ms(arg6);
        assert!(v2 != 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_opened_at(&v1), 13838438546733006873);
        let v3 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::timing<T0>(arg1);
        assert!(v2 >= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_opened_at(&v1) + 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::min_hold_ms(&v3), 13838720026004815899);
        let v4 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::timestamp_ms(&arg5);
        let v5 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::sequence(&arg5);
        assert!(v4 > 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_oracle_ts(&v1) && v5 > 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_oracle_sequence(&v1), 13835905289121300487);
        assert!(v4 >= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::last_oracle_ts_ms<T0>(arg1) && v5 >= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::last_oracle_sequence<T0>(arg1), 13835905293416267783);
        assert!(!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::crossed_bust(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_is_long(&v1), 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&arg5), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_bust(&v1)), 13839001535341395997);
        let v6 = settle_close<T0>(arg0, arg1, arg2, arg3, v1, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::ask_wad(&arg5), 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::bid_wad(&arg5), 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&arg5), v2, 0, arg7);
        refresh_reserve<T0>(arg0, arg1, arg3, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&arg5));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::stamp_oracle<T0>(&v0, arg1, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&arg5), v4, v5, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::slot(&arg5));
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::discard_price(arg5);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_identity<T0>(arg0);
        v6
    }

    public fun emergency_close<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg5: u64, arg6: 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::LossTicket {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg3));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg3);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_version<T0>(arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg3), arg4);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_version<T0>(arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_exchange<T0>(arg1, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>>(arg0));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_exchange<T0>(arg2, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>>(arg0));
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::status<T0>(arg1) == 3, 13840409051959525415);
        guarded_reconcile<T0>(&v0, arg1, arg2, arg3);
        assert_positions_unpaused<T0>(arg1, arg3);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_unpaused(arg3, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::pause_force_close());
        assert!(!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::session_pending<T0>(arg1), 13844912668768731205);
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::market_id(&arg6) == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg1), 13839846123480678435);
        assert!(!0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::is_closed(&arg6), 13842097927590379571);
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::in_band(&arg6), 13842379406862188597);
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::remove_position<T0>(&v0, arg2, arg5);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_market(&v1) == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg1), 13839846140660547619);
        let v2 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::timestamp_ms(&arg6);
        let v3 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::sequence(&arg6);
        assert!(v2 >= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::last_oracle_ts_ms<T0>(arg1) && v3 >= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::last_oracle_sequence<T0>(arg1), 13835905503869665287);
        assert!(v2 > 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_oracle_ts(&v1) && v3 > 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_oracle_sequence(&v1), 13835905508164632583);
        let v4 = settle_close<T0>(arg0, arg1, arg2, arg3, v1, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::ask_wad(&arg6), 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::bid_wad(&arg6), 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&arg6), 0x2::clock::timestamp_ms(arg7), 0, arg8);
        refresh_reserve<T0>(arg0, arg1, arg3, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&arg6));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::stamp_oracle<T0>(&v0, arg1, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&arg6), v2, v3, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::slot(&arg6));
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::discard_price(arg6);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg1), 14);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_identity<T0>(arg0);
        v4
    }

    public(friend) fun entry_within(arg0: bool, arg1: u128, arg2: u128) : bool {
        arg2 == 0 || arg0 && arg1 <= arg2 || arg1 >= arg2
    }

    public(friend) fun exit_within(arg0: bool, arg1: u128, arg2: u128) : bool {
        arg2 == 0 || arg0 && arg1 >= arg2 || arg1 <= arg2
    }

    public fun force_close_session<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: vector<u64>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::LossTicket, 0x2::coin::Coin<T0>) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg3));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg3);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_version<T0>(arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_version<T0>(arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_exchange<T0>(arg1, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>>(arg0));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_exchange<T0>(arg2, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>>(arg0));
        assert!(0x1::vector::length<u64>(&arg4) <= 128, 13844633053512728643);
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::status<T0>(arg1);
        let v2 = if (v1 == 1) {
            true
        } else if (v1 == 2) {
            true
        } else {
            v1 == 3
        };
        assert!(v2, 13835625862843858949);
        let v3 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::session_close<T0>(arg1);
        assert!(0x1::option::is_some<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::SessionCloseV1>(&v3), 13844351591420788801);
        if (!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::session_pending<T0>(arg1)) {
            return (0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::ticket(0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>>(arg2)), 0x2::coin::zero<T0>(arg6))
        };
        reconcile_inner<T0>(&v0, arg1, arg2);
        let v4 = 0x1::option::destroy_some<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::SessionCloseV1>(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::session_close<T0>(arg1));
        let v5 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::sc_price_wad(&v4);
        let v6 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::sc_ts_ms(&v4);
        let v7 = 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg1);
        let v8 = 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>>(arg2);
        let v9 = 0;
        let v10 = 0;
        let v11 = 0;
        while (v11 < 0x1::vector::length<u64>(&arg4)) {
            let v12 = *0x1::vector::borrow<u64>(&arg4, v11);
            v11 = v11 + 1;
            if (!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::session_pending<T0>(arg1)) {
                break
            };
            if (!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::session_eligible(v12, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::sc_watermark(&v4)) || !0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::has_position<T0>(arg2, v12)) {
                continue
            };
            if (!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::contains(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq<T0>(arg1), v12)) {
                continue
            };
            let v13 = *0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::borrow_record(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq<T0>(arg1), v12);
            if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::r_account_id(&v13) != v8) {
                continue
            };
            let v14 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::crossed_bust(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::r_is_long(&v13), v5, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::r_bust(&v13));
            if (v14) {
                let v15 = liquidate_record<T0>(arg0, arg1, arg3, v12, v5, v5, v6, 0x2::tx_context::sender(arg6), false, true);
                v10 = v10 + v15;
                reconcile_inner<T0>(&v0, arg1, arg2);
            } else {
                let v16 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::remove_position<T0>(&v0, arg2, v12);
                let v17 = settle_close<T0>(arg0, arg1, arg2, arg3, v16, v5, v5, v5, 0x2::clock::timestamp_ms(arg5), 2, arg6);
                v9 = v9 + 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::settle_loss_ticket(v17);
            };
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_session_force_closed_event(&v0, v12, v7, v8, v5, v6, v14, 0x2::tx_context::sender(arg6));
            if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::note_session_force_closed<T0>(&v0, arg1)) {
                let v18 = 0x1::option::destroy_some<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::SessionCloseV1>(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::session_close<T0>(arg1));
                0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_session_drained_event(&v0, v7, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::sc_closed_count(&v18));
            };
        };
        refresh_reserve<T0>(arg0, arg1, arg3, v5);
        let v19 = if (v10 > 0) {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::split_out<T0>(&v0, arg0, v10, arg6)
        } else {
            0x2::coin::zero<T0>(arg6)
        };
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_identity<T0>(arg0);
        (0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::ticket(v9, v8), v19)
    }

    fun guarded_reconcile<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config) {
        if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::pending_count(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq<T0>(arg1), 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>>(arg2)) == 0) {
            return
        };
        assert_reconcile_unpaused<T0>(arg1, arg3);
        reconcile_inner<T0>(arg0, arg1, arg2);
    }

    public(friend) fun liquidatable_at<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg1: u64, arg2: u128) : bool {
        if (!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::contains(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq<T0>(arg0), arg1)) {
            return false
        };
        let v0 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::borrow_record(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq<T0>(arg0), arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::crossed_bust(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::r_is_long(v0), arg2, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::r_bust(v0))
    }

    public(friend) fun liquidatable_receipt<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg1: u64, arg2: &0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt) : bool {
        if (!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::contains(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq<T0>(arg0), arg1)) {
            return false
        };
        let v0 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::borrow_record(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq<T0>(arg0), arg1);
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::r_is_long(v0);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::r_bust(v0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::crossed_bust(v1, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(arg2), v2) && (0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::in_band(arg2) || 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::crossed_bust(v1, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::signed_mid_wad(arg2), v2))
    }

    public fun liquidate<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg3: u64, arg4: 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_version<T0>(arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_exchange<T0>(arg1, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>>(arg0));
        liquidate_receipt<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public(friend) fun liquidate_receipt<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg3: u64, arg4: 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        liquidate_receipt_mode<T0>(arg0, arg1, arg2, arg3, arg4, 0, arg5)
    }

    public(friend) fun liquidate_receipt_mode<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg3: u64, arg4: 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg2));
        assert_positions_unpaused<T0>(arg1, arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_unpaused(arg2, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::pause_liquidations());
        assert!(!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::session_pending<T0>(arg1), 13844913059610755141);
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::market_id(&arg4) == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg1), 13839846514322702371);
        assert!(!0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::is_closed(&arg4), 13842098318432403507);
        let v1 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::timestamp_ms(&arg4);
        let v2 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::sequence(&arg4);
        if (arg5 == 0) {
            assert!(v1 >= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::last_oracle_ts_ms<T0>(arg1), 13835905886121754631);
            assert!(v2 >= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::last_oracle_sequence<T0>(arg1), 13835905890416721927);
        };
        let v3 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&arg4);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::contains(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq<T0>(arg1), arg3), 13842942777722667065);
        let v4 = *0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::borrow_record(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq<T0>(arg1), arg3);
        assert!(v1 > 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::r_oracle_ts(&v4) && v2 > 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::r_oracle_sequence(&v4), 13835905911891558407);
        let v5 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::r_is_long(&v4);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::crossed_bust(v5, v3, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::r_bust(&v4)), 13839283620203593759);
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::in_band(&arg4) || 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::crossed_bust(v5, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::signed_mid_wad(&arg4), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::r_bust(&v4)), 13839283633088495647);
        let (v6, v7) = reserve_mark<T0>(arg1, v3, v1, v2);
        let v8 = liquidate_record<T0>(arg0, arg1, arg2, arg3, v3, v6, v1, 0x2::tx_context::sender(arg6), false, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::in_band(&arg4));
        if (!v7) {
            refresh_reserve_with<T0>(arg0, arg1, arg2, v6, true, false);
        } else if (0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::in_band(&arg4)) {
            refresh_reserve<T0>(arg0, arg1, arg2, v3);
        };
        stamp_max<T0>(&v0, arg1, v3, v1, v2, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::slot(&arg4));
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::discard_price(arg4);
        let v9 = if (v8 > 0) {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::split_out<T0>(&v0, arg0, v8, arg6)
        } else {
            0x2::coin::zero<T0>(arg6)
        };
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_identity<T0>(arg0);
        v9
    }

    fun liquidate_record<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg3: u64, arg4: u128, arg5: u128, arg6: u64, arg7: address, arg8: bool, arg9: bool) : u64 {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg2));
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::remove(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq_mut<T0>(&v0, arg1), arg3);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::r_is_long(&v1);
        let v3 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::r_margin(&v1);
        let v4 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::r_exposure(&v1);
        let v5 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::r_account_id(&v1);
        let v6 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::r_owner(&v1);
        let v7 = 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg1);
        let v8 = if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::is_hedged(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq<T0>(arg1), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::r_account_id(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::borrow_record(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq<T0>(arg1), arg3)))) {
            true
        } else if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::r_wash(&v1)) {
            true
        } else {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::opposite_notional(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq<T0>(arg1), v5, v2) > 0
        };
        let v9 = arg7 == v6;
        let v10 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::risk<T0>(arg1);
        let v11 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::bps_of(v3, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq_bounty_bps(&v10));
        let v12 = if (v11 < 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::liq_bounty_cap(arg2)) {
            v11
        } else {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::liq_bounty_cap(arg2)
        };
        let v13 = v3 - v12;
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::sub_oi<T0>(&v0, arg1, v2, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::r_notional(&v1));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::sub_locked<T0>(&v0, arg1, v2, v4);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::sub_qty<T0>(&v0, arg1, v2, v4, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::r_entry(&v1));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::sub_open_exposure<T0>(&v0, arg0, v4);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::unlock_all<T0>(&v0, arg0, v3);
        refresh_before_routing<T0>(arg0, arg1, arg2, arg5, arg9);
        let v14 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::realize_loss<T0>(&v0, arg0, v13, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::loss_fee_bps(arg2));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::route_retained<T0>(&v0, arg0, arg2, v14);
        let v15 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::loss_mint_basis(v3, v8, v9);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::note_minted_loss<T0>(&v0, arg0, v15);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::add_pending_basis<T0>(&v0, arg0, v5, v15);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::push_pending(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq_mut<T0>(&v0, arg1), v5, arg3);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_position_exit_event(&v0, arg3, v7, 1, v2, arg4, arg6);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_liquidate_position_event(&v0, arg3, v5, v12, v13);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_liquidation_detail_event(&v0, arg3, v7, v5, arg7, v12, v13, v14, arg8);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game::on_loss<T0>(arg0, arg2, v6, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::achievement_fee_basis(v14, 0, 0, v8, v9, true), arg6);
        v12
    }

    public fun liquidate_retired<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg3: u64, arg4: 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_version<T0>(arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_exchange<T0>(arg1, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>>(arg0));
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::status<T0>(arg1) == 3, 13840409326837432359);
        liquidate_receipt<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    fun locked_notional<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: u64, arg5: u64) : u128 {
        let v0 = (arg4 as u128) * (arg5 as u128) * (taker_bps<T0>(arg1, arg3) as u128) / 10000;
        if (v0 >= (arg4 as u128)) {
            return 0
        };
        let v1 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::referral::quote<T0>(arg0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::owner<T0>(arg2), (v0 as u64), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::referral_enabled(arg3), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::referee_discount_bps(arg3), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::referral_fee_bps(arg3), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::second_level_fee_bps(arg3));
        ((arg4 - 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::referral::charged(&v1)) as u128) * (arg5 as u128)
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

    public(friend) fun open_inner<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: u64, arg10: u128, arg11: 0x1::option::Option<u32>, arg12: u8, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg3));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg3);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_version<T0>(arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_exchange<T0>(arg1, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>>(arg0));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_version<T0>(arg2);
        assert!(!arg8, 13840126035089424421);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_exchange<T0>(arg2, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>>(arg0));
        guarded_reconcile<T0>(&v0, arg1, arg2, arg3);
        let (v1, v2) = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::builder::snapshot<T0>(arg0, arg3, arg11);
        let v3 = if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::is_paused(arg3)) {
            true
        } else if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::opens_paused<T0>(arg1)) {
            true
        } else if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::closes_paused(arg3)) {
            true
        } else {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::closes_paused<T0>(arg1)
        };
        assert!(!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::trading_blocked(v3), 13835340999137820675);
        assert!(!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::session_pending<T0>(arg1), 13844911156940243013);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::enabled<T0>(arg1), 13840970511559557163);
        assert!(!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::oracle_killed<T0>(arg1), 13840689040877682729);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::status<T0>(arg1) == 1, 13835622495589498885);
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::market_id(&arg4) == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg1), 13839844624537092131);
        assert!(!0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::is_closed(&arg4), 13842096428646793267);
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::in_band(&arg4), 13842377907918602293);
        let v4 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::timestamp_ms(&arg4);
        let v5 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::sequence(&arg4);
        if (arg12 == 0) {
            assert!(v4 >= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::last_oracle_ts_ms<T0>(arg1), 13835904004926078983);
            assert!(v5 >= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::last_oracle_sequence<T0>(arg1), 13835904009221046279);
        };
        let (v6, v7) = reserve_mark<T0>(arg1, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&arg4), v4, v5);
        let v8 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::risk<T0>(arg1);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::leverage_within(arg6, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::max_leverage(&v8)), 13836185501377757193);
        assert!(arg6 >= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::min_leverage(&v8), 13841815009504526385);
        let v9 = if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::taker_fee_is_set(arg3)) {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::tighter_bps(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::taker_fee_bps<T0>(arg1), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::taker_fee_bps(arg3))
        } else {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::taker_fee_bps<T0>(arg1)
        };
        let v10 = (arg5 as u128) * (arg6 as u128) * (v9 as u128) / 10000;
        assert!(v10 < (arg5 as u128), 13838155873460289559);
        let v11 = (v10 as u64);
        let v12 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::referral::quote<T0>(arg0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::owner<T0>(arg2), v11, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::referral_enabled(arg3), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::referee_discount_bps(arg3), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::referral_fee_bps(arg3), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::second_level_fee_bps(arg3));
        let v13 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::referral::charged(&v12);
        let v14 = arg5 - v13;
        assert!(v14 >= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::min_margin(&v8), 13836467079433814027);
        let v15 = (v14 as u128) * (arg6 as u128);
        assert!(v15 <= 18446744073709551615, 13836467088023748619);
        let v16 = (v15 as u64);
        assert!(v16 >= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::min_notional(&v8) && v16 <= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::max_position_notional(&v8), 13836467096613683211);
        let (v17, v18) = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::charge_notional<T0>(&v0, arg1, v16, 0x2::clock::timestamp_ms(arg13), *0x2::tx_context::digest(arg14));
        assert!(v17, 13836748593065361421);
        assert!(v18, 13837030072337170447);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::open_notional<T0>(arg2) + v16 <= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::max_account_notional(&v8), 13837311551608979473);
        let v19 = 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>>(arg2);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::free_balance<T0>(arg0, v19) >= arg5, 13838155985129439255);
        let v20 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::impact<T0>(arg1);
        let v21 = if (arg7) {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::long_oi<T0>(arg1)
        } else {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::short_oi<T0>(arg1)
        };
        let v22 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::marginal_exposure(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::effective_depth(&v20), v21, v16);
        let v23 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::factor_bps(v22, v16);
        if (arg6 == 1) {
            assert!(v22 == v16, 13841533710621343791);
        } else {
            assert!(v22 > 0, 13841533719211278383);
        };
        if (arg9 > 0) {
            assert!(v23 >= arg9, 13841533732096180271);
        };
        assert!(v23 >= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::min_payout_factor_bps(arg3), 13841533744981082159);
        let (v24, v25) = if (arg7) {
            (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::long_locked_exposure<T0>(arg1), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::max_long_exposure<T0>(arg1))
        } else {
            (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::short_locked_exposure<T0>(arg1), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::max_short_exposure<T0>(arg1))
        };
        assert!((v24 as u128) + (v22 as u128) <= (v25 as u128), 13837593125370069011);
        let (v26, v27) = if (arg7) {
            (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::max_long_oi<T0>(arg1), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::long_oi<T0>(arg1))
        } else {
            (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::max_short_oi<T0>(arg1), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::short_oi<T0>(arg1))
        };
        assert!((v27 as u128) + (v16 as u128) <= (v26 as u128), 13843222654971674683);
        let v28 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::tighter_bps(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::win_fee_bps<T0>(arg1), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::win_fee_bps(arg3));
        let v29 = if (arg7) {
            0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::ask_wad(&arg4)
        } else {
            0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::bid_wad(&arg4)
        };
        assert!(entry_within(arg7, v29, arg10), 13843785617810128957);
        let v30 = if (arg7) {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::bust_long(v29, arg6, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::effective_bust_buffer(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::bust_buffer_wad(&v8), arg6))
        } else {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::bust_short(v29, arg6, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::effective_bust_buffer(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::bust_buffer_wad(&v8), arg6))
        };
        assert!(!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::crossed_bust(arg7, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&arg4), v30), 13842659756557598775);
        let v31 = 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg1);
        let v32 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::opposite_open<T0>(arg2, v31, arg7);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::debit_account_free<T0>(&v0, arg0, v19, arg5);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::lock_open<T0>(&v0, arg0, arg5, v13);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::referral::pay_open_rewards<T0>(arg0, v12);
        let v33 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::alloc_position_id<T0>(&v0, arg0);
        let v34 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::builder::accrue<T0>(arg0, v11, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::referral::protocol_remainder(&v12), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::owner<T0>(arg2), v19, v33, v1, v2, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::builder::kind_open());
        let v35 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::referral::protocol_remainder(&v12) - v34;
        refresh_before_routing<T0>(arg0, arg1, arg3, v6, true);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::route_retained<T0>(&v0, arg0, arg3, v35);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::add_open_exposure<T0>(&v0, arg0, v22);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::add_open_notional<T0>(&v0, arg2, v16);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::add_side<T0>(&v0, arg2, v31, arg7, v16);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::note_hedge_if_two_sided<T0>(&v0, arg2, v31);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::add_oi<T0>(&v0, arg1, arg7, v16);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::add_locked<T0>(&v0, arg1, arg7, v22);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::add_qty<T0>(&v0, arg1, arg7, v22, v29);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::insert(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq_mut<T0>(&v0, arg1), v33, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::record(&v0, v19, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::owner<T0>(arg2), arg7, v14, v16, v22, v29, v30, v4, v5, v32));
        stamp_max<T0>(&v0, arg1, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&arg4), v4, v5, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::slot(&arg4));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_open_position_event(&v0, v33, v19, v31, arg7, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&arg4), 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::conf_wad(&arg4), v29, v30, v14, v16, v23, v22, v28, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::deadband_ppm(&v20), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::close_fee_ppm(&v20), v1, v34);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::insert_position<T0>(&v0, arg2, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::new_position(&v0, v33, v31, arg7, v29, v14, arg6, v16, v30, 0x2::clock::timestamp_ms(arg13), v4, v5, v22, v23, v28, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::deadband_ppm(&v20), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::close_fee_ppm(&v20), v35, v32, v1, v2));
        if (v7) {
            touch_sweep<T0>(arg0, arg1, arg3, v19, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::owner<T0>(arg2), 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&arg4), v4, v5, arg14);
        };
        refresh_reserve_with<T0>(arg0, arg1, arg3, v6, true, v7);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::discard_price(arg4);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game::on_open<T0>(arg0, arg3, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::owner<T0>(arg2), v31, v16, 0x2::clock::timestamp_ms(arg13));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_identity<T0>(arg0);
        v33
    }

    public(friend) fun open_risk_code<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: u64, arg3: u64) : u8 {
        let v0 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::risk<T0>(arg0);
        if (!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::leverage_within(arg3, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::max_leverage(&v0))) {
            return 1
        };
        if (arg3 < 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::min_leverage(&v0)) {
            return 2
        };
        let v1 = (arg2 as u128) * (arg3 as u128) * (taker_bps<T0>(arg0, arg1) as u128) / 10000;
        if (v1 >= (arg2 as u128)) {
            return 4
        };
        let v2 = arg2 - (v1 as u64);
        if (v2 < 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::min_margin(&v0)) {
            return 4
        };
        if ((v2 as u128) * (arg3 as u128) < (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::min_notional(&v0) as u128)) {
            return 3
        };
        if ((arg2 as u128) * (arg3 as u128) > (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::max_position_notional(&v0) as u128)) {
            return 3
        };
        0
    }

    public(friend) fun positions_paused<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config) : bool {
        let v0 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::closes_paused(arg1) || 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::closes_paused<T0>(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::liquidation_blocked(v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::oracle_killed<T0>(arg0))
    }

    public fun reconcile<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg2));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_version<T0>(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_version<T0>(arg1);
        guarded_reconcile<T0>(&v0, arg0, arg1, arg2);
    }

    public(friend) fun reconcile_halted<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config) : bool {
        if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::liquidations_paused(arg1)) {
            true
        } else if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::oracle_killed<T0>(arg0)) {
            true
        } else if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::closes_paused(arg1)) {
            true
        } else {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::closes_paused<T0>(arg0)
        }
    }

    public(friend) fun reconcile_inner<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>) {
        let v0 = 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>>(arg2);
        if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::pending_count(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq<T0>(arg1), v0) == 0) {
            return
        };
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::take_pending(arg0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq_mut<T0>(arg0, arg1), v0, 32);
        let v2 = 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v1)) {
            let v4 = *0x1::vector::borrow<u64>(&v1, v3);
            if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::has_position<T0>(arg2, v4)) {
                let v5 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::remove_position<T0>(arg0, arg2, v4);
                0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::sub_open_notional<T0>(arg0, arg2, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_notional(&v5));
                0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::sub_side<T0>(arg0, arg2, v2, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_is_long(&v5), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_notional(&v5));
                0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::clear_hedge_if_flat<T0>(arg0, arg2, v2);
                0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::destroy_position(arg0, v5);
                0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_position_reconciled_event(arg0, v0, v4);
            };
            v3 = v3 + 1;
        };
    }

    fun refresh_before_routing<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg3: u128, arg4: bool) {
        refresh_reserve_with<T0>(arg0, arg1, arg2, arg3, arg4, false);
    }

    fun refresh_reserve<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg3: u128) {
        refresh_reserve_with<T0>(arg0, arg1, arg2, arg3, true, true);
    }

    fun refresh_reserve_with<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg3: u128, arg4: bool, arg5: bool) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg2));
        let (v1, v2) = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::reserve_at<T0>(arg1, arg3, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::trim_max_share_bps(arg2));
        let (v3, v4) = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::swap_snapshot<T0>(&v0, arg1, v1, v2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::adjust_reserve<T0>(&v0, arg0, arg2, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg1), v3, v4, v1, v2, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::has_oi<T0>(arg1), arg4, arg5);
    }

    fun reserve_mark<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg1: u128, arg2: u64, arg3: u64) : (u128, bool) {
        if (arg2 >= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::last_oracle_ts_ms<T0>(arg0) && arg3 >= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::last_oracle_sequence<T0>(arg0)) {
            (arg1, true)
        } else {
            (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::last_mark_wad<T0>(arg0), false)
        }
    }

    public fun retire_market<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_version<T0>(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg1), arg2);
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::market_id(&arg3) == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg0), 13839848674691252259);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::set_status<T0>(&v0, arg0, 3, 0x1::option::none<u128>());
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::discard_price(arg3);
    }

    fun settle_close<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Position, arg5: u128, arg6: u128, arg7: u128, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) : 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::LossTicket {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg3));
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_is_long(&arg4);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_margin(&arg4);
        let v3 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_notional(&arg4);
        let v4 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_entry(&arg4);
        let v5 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_exposure(&arg4);
        let v6 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_id(&arg4);
        let v7 = if (v1) {
            arg6
        } else {
            arg5
        };
        let v8 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::settle(v1, v3, v5, v4, v7, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_deadband_ppm(&arg4), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_close_fee_ppm(&arg4), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_win_fee_bps(&arg4), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::trim_max_share_bps(arg3), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::trim_c_ppm(arg3));
        let v9 = 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg1);
        let v10 = if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_wash(&arg4)) {
            true
        } else if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::is_hedged<T0>(arg2, v9)) {
            true
        } else {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::closed_opposite_same_checkpoint<T0>(arg2, v9, v1, arg8)
        };
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::remove(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq_mut<T0>(&v0, arg1), v6);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::sub_oi<T0>(&v0, arg1, v1, v3);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::sub_locked<T0>(&v0, arg1, v1, v5);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::sub_qty<T0>(&v0, arg1, v1, v5, v4);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::sub_open_exposure<T0>(&v0, arg0, v5);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::sub_open_notional<T0>(&v0, arg2, v3);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::sub_side<T0>(&v0, arg2, v9, v1, v3);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::clear_hedge_if_flat<T0>(&v0, arg2, v9);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::note_close<T0>(&v0, arg2, v9, v1, arg8);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::unlock_all<T0>(&v0, arg0, v2);
        refresh_before_routing<T0>(arg0, arg1, arg3, arg7, true);
        let v11 = apply_pnl<T0>(arg0, arg2, arg3, &arg4, &v8, v2);
        let v12 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::loss_mint_basis(v11.loss, v10, false);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::note_minted_loss<T0>(&v0, arg0, v12);
        let v13 = if (v11.loss > 0) {
            v11.loss
        } else {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::pnl_adjusted(&v8)
        };
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_position_exit_event(&v0, v6, v9, arg9, v1, v7, arg8);
        let v14 = if (v11.loss > 0) {
            0
        } else {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::pnl_win_fee(&v8)
        };
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_close_fees_event(&v0, v6, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::pnl_raw(&v8), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::pnl_raw(&v8) - 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::pnl_adjusted(&v8), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::pnl_close_toll(&v8), v14, v11.loss_fee, v11.discount, v11.retained);
        let v15 = if (v11.loss > 0) {
            0
        } else {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::pnl_raw(&v8) - v11.user_profit
        };
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_close_position_event(&v0, v6, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>>(arg2), v13, v15, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::pnl_win_fee(&v8), v11.user_profit, v11.queued, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_builder_id(&arg4), v11.builder_cut);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game::on_close<T0>(arg0, arg3, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::owner<T0>(arg2), v9, v3, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_leverage(&arg4), v2, v11.loss, v11.user_profit, v10, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::achievement_fee_basis(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::position_open_fee(&arg4), v11.retained, 0, v10, false, false), arg8);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::destroy_position(&v0, arg4);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::ticket(v12, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>>(arg2))
    }

    fun stamp_max<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: u128, arg3: u64, arg4: u64, arg5: u64) {
        if (arg3 >= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::last_oracle_ts_ms<T0>(arg1) && arg4 >= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::last_oracle_sequence<T0>(arg1)) {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::stamp_oracle<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        };
    }

    public fun sweep<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg3: 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::PriceReceipt, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg2));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_version<T0>(arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_exchange<T0>(arg1, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>>(arg0));
        assert_positions_unpaused<T0>(arg1, arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_unpaused(arg2, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::pause_liquidations());
        assert!(!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::session_pending<T0>(arg1), 13844913308718858309);
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::market_id(&arg3) == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg1), 13839846763430805539);
        assert!(!0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::is_closed(&arg3), 13842098567540506675);
        assert!(0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::in_band(&arg3), 13842380046812315701);
        let v1 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::timestamp_ms(&arg3);
        let v2 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::sequence(&arg3);
        assert!(v1 >= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::last_oracle_ts_ms<T0>(arg1) && v2 >= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::last_oracle_sequence<T0>(arg1), 13835906135229857799);
        let v3 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::price_wad(&arg3);
        let v4 = if (arg4 < 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::sweep_max(arg2)) {
            arg4
        } else {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::sweep_max(arg2)
        };
        let (_, v6) = sweep_inner<T0>(arg0, arg1, arg2, 0x1::option::none<0x2::object::ID>(), 0x2::tx_context::sender(arg5), v3, v1, v2, v4);
        refresh_reserve<T0>(arg0, arg1, arg2, v3);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::stamp_oracle<T0>(&v0, arg1, v3, v1, v2, 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::slot(&arg3));
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle::discard_price(arg3);
        let v7 = if (v6 > 0) {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::split_out<T0>(&v0, arg0, v6, arg5)
        } else {
            0x2::coin::zero<T0>(arg5)
        };
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_identity<T0>(arg0);
        v7
    }

    fun sweep_candidate<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg1: bool, arg2: u128, arg3: u64, arg4: u64) : (bool, bool, u64, u128) {
        let v0 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::peek(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq<T0>(arg0), arg1);
        if (0x1::option::is_none<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::HeapEntry>(&v0)) {
            return (false, false, 0, 0)
        };
        let v1 = 0x1::option::destroy_some<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::HeapEntry>(v0);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::entry_position_id(&v1);
        let v3 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::entry_bust(&v1);
        if (!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::crossed_bust(arg1, arg2, v3)) {
            return (false, false, v2, v3)
        };
        let v4 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::borrow_record(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq<T0>(arg0), v2);
        let v5 = arg3 > 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::r_oracle_ts(v4) && arg4 > 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::r_oracle_sequence(v4);
        (true, v5, v2, v3)
    }

    fun sweep_inner<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg3: 0x1::option::Option<0x2::object::ID>, arg4: address, arg5: u128, arg6: u64, arg7: u64, arg8: u64) : (u64, u64) {
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg2));
        let v1 = 0;
        let v2 = 0;
        let v3 = true;
        let v4 = true;
        let v5 = 0x1::vector::empty<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::HeapEntry>();
        let v6 = 0x1::vector::empty<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::HeapEntry>();
        while (v1 < arg8) {
            let (v7, v8, v9) = if (v3) {
                let v10 = &mut v5;
                sweep_side_candidate<T0>(&v0, arg1, true, arg5, arg6, arg7, v10)
            } else {
                (false, 0, 0)
            };
            let (v11, v12, v13) = if (v4) {
                let v14 = &mut v6;
                sweep_side_candidate<T0>(&v0, arg1, false, arg5, arg6, arg7, v14)
            } else {
                (false, 0, 0)
            };
            v3 = v7;
            v4 = v11;
            if (!v7 && !v11) {
                break
            };
            let v15 = if (v7 && v11 && ((v9 - arg5) as u256) * (v13 as u256) >= ((arg5 - v13) as u256) * (v9 as u256) || v7) {
                v8
            } else {
                v12
            };
            let v16 = liquidate_record<T0>(arg0, arg1, arg2, v15, arg5, arg5, arg6, arg4, true, true);
            if (0x1::option::is_some<0x2::object::ID>(&arg3)) {
                0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::credit_account_free<T0>(&v0, arg0, *0x1::option::borrow<0x2::object::ID>(&arg3), v16);
            } else {
                v2 = v2 + v16;
            };
            v1 = v1 + 1;
        };
        while (!0x1::vector::is_empty<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::HeapEntry>(&v5)) {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::reinsert(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq_mut<T0>(&v0, arg1), 0x1::vector::pop_back<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::HeapEntry>(&mut v5));
        };
        while (!0x1::vector::is_empty<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::HeapEntry>(&v6)) {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::reinsert(&v0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq_mut<T0>(&v0, arg1), 0x1::vector::pop_back<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::HeapEntry>(&mut v6));
        };
        (v1, v2)
    }

    fun sweep_side_candidate<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: bool, arg3: u128, arg4: u64, arg5: u64, arg6: &mut vector<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::HeapEntry>) : (bool, u64, u128) {
        let v0;
        let v1;
        loop {
            let (v2, v3, v1, v0) = sweep_candidate<T0>(arg1, arg2, arg3, arg4, arg5);
            if (!v2 || v3) {
                return (v3, v1, v0)
            };
            if (0x1::vector::length<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::HeapEntry>(arg6) >= 2) {
                break
            };
            0x1::vector::push_back<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::HeapEntry>(arg6, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::pop_top(arg0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq_mut<T0>(arg0, arg1), arg2));
        };
        (false, v1, v0)
    }

    public(friend) fun taker_bps<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config) : u64 {
        if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::taker_fee_is_set(arg1)) {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::tighter_bps(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::taker_fee_bps<T0>(arg0), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::taker_fee_bps(arg1))
        } else {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::taker_fee_bps<T0>(arg0)
        }
    }

    fun touch_sweep<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg3: 0x2::object::ID, arg4: address, arg5: u128, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::sweep_max(arg2);
        if (v0 == 0 || liquidations_paused<T0>(arg1, arg2)) {
            return
        };
        let (_, _) = sweep_inner<T0>(arg0, arg1, arg2, 0x1::option::some<0x2::object::ID>(arg3), arg4, arg5, arg6, arg7, v0);
    }

    public(friend) fun tx_notional_ok<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg4: u64, arg5: u64) : bool {
        let v0 = locked_notional<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        if (v0 > 0) {
            let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::risk<T0>(arg1);
            v0 <= (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::max_tx_notional(&v2) as u128)
        } else {
            false
        }
    }

    // decompiled from Move bytecode v7
}

