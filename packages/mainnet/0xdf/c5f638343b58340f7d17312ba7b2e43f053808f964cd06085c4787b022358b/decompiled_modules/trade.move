module 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::trade {
    struct Settled has copy, drop {
        loss: u64,
        user_profit: u64,
        loss_fee: u64,
        discount: u64,
        builder_cut: u64,
        retained: u64,
        queued: bool,
    }

    fun apply_pnl<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg3: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Position, arg4: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::position::Pnl, arg5: u64) : Settled {
        let v0 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::auth::issue(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::uid(arg2));
        let v1 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::position::pnl_loss(arg4);
        let v2 = v1;
        if (v1 > arg5) {
            v2 = arg5;
        };
        let v3 = if (v2 > 0) {
            0
        } else {
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::position::pnl_net(arg4)
        };
        let v4 = arg5 - v2;
        let v5 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::position::pnl_close_toll(arg4);
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
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::realize_loss<T0>(&v0, arg0, v2, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::loss_fee_bps(arg2))
        } else {
            0
        };
        let v11 = 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>>(arg1);
        let v12 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::owner<T0>(arg1);
        let v13 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_id(arg3);
        let v14 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_builder_id(arg3);
        let v15 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_builder_share(arg3);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::credit_account_free<T0>(&v0, arg0, v11, v4 - v8);
        let v16 = if (v2 > 0) {
            0
        } else {
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::position::pnl_win_fee(arg4)
        };
        let v17 = if (v2 > 0) {
            0
        } else {
            v16 + v3
        };
        let v18 = if (v17 > 0) {
            if (!0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::queue_nonempty<T0>(arg0)) {
                0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::lp_cash<T0>(arg0) >= v17
            } else {
                false
            }
        } else {
            false
        };
        let v19 = v8;
        let v20 = false;
        if (v18) {
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::debit_lp<T0>(&v0, arg0, v17);
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::credit_account_free<T0>(&v0, arg0, v11, v9);
            v19 = v8 + v6 + v16;
        } else if (v17 > 0) {
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::enqueue_with_builder<T0>(&v0, arg0, v12, v11, v9, v16 + v6, v13, v14, v15);
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::debit_tracked<T0>(&v0, arg0, v17);
            v20 = true;
        };
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::add_fee<T0>(&v0, arg0, v19);
        let v21 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::referral::quote<T0>(arg0, v12, v19, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::referral_enabled(arg2), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::referee_discount_bps(arg2), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::referral_fee_bps(arg2), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::second_level_fee_bps(arg2));
        let v22 = v19 - 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::referral::charged(&v21);
        if (v22 > 0) {
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::debit_fee_lp<T0>(&v0, arg0, v22);
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::credit_account_free<T0>(&v0, arg0, v11, v22);
        };
        let v23 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::referral::protocol_remainder(&v21);
        0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::referral::pay_open_rewards<T0>(arg0, v21);
        let v24 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::builder::accrue<T0>(arg0, v23, v23, v12, v11, v13, v14, v15, 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::builder::kind_close_toll());
        let v25 = v23 - v24;
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::route_retained<T0>(&v0, arg0, arg2, v25 + v10);
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

    public fun check_market<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::ReserveCheck, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg2: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg3: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg4: 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::PriceReceipt) {
        let v0 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::auth::issue(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::uid(arg3));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg3);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::assert_version<T0>(arg1);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::assert_version<T0>(arg2);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::assert_exchange<T0>(arg2, 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>>(arg1));
        assert!(0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::market_id(&arg4) == 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>>(arg2), 13839847059783548963);
        assert!(!0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::is_closed(&arg4), 13842098863893250099);
        assert!(0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::in_band(&arg4), 13842380343165059125);
        assert!(0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::twap_ok(&arg4), 13843506247367393341);
        let v1 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::timestamp_ms(&arg4);
        let v2 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::sequence(&arg4);
        assert!(v1 >= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::last_oracle_ts_ms<T0>(arg2) && v2 >= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::last_oracle_sequence<T0>(arg2), 13835906435877568519);
        let v3 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::price_wad(&arg4);
        refresh_reserve<T0>(arg1, arg2, arg3, v3);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::stamp_oracle<T0>(&v0, arg2, v3, v1, v2, 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::slot(&arg4));
        0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::discard_price(arg4);
        if (0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::in_oi_set<T0>(arg1, 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>>(arg2))) {
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::note_checked(&v0, arg0, 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>>(arg1), 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>>(arg2));
        };
    }

    public fun close<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg2: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>, arg3: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::AccountCap, arg4: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg5: u64, arg6: 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::PriceReceipt, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::fees::LossTicket {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::assert_cap<T0>(arg2, arg3);
        close_inner<T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun close_as_delegate<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg2: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>, arg3: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg4: u64, arg5: 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::PriceReceipt, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::fees::LossTicket {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::assert_delegate<T0>(arg2, 0x2::tx_context::sender(arg8), 0x2::clock::timestamp_ms(arg7));
        close_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    fun close_inner<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg2: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>, arg3: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg4: u64, arg5: 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::PriceReceipt, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::fees::LossTicket {
        let v0 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::auth::issue(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::uid(arg3));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg3);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::assert_version<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::assert_version<T0>(arg1);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::assert_exchange<T0>(arg1, 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>>(arg0));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::assert_exchange<T0>(arg2, 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>>(arg0));
        reconcile_inner<T0>(&v0, arg1, arg2);
        let v1 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::closes_paused(arg3) || 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::closes_paused<T0>(arg1);
        assert!(!0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::trading_blocked(v1), 13841252145450188845);
        assert!(!0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::oracle_killed<T0>(arg1), 13840689199791472681);
        let v2 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::status<T0>(arg1);
        assert!(v2 == 1 || v2 == 2, 13835622658798256133);
        assert!(0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::market_id(&arg5) == 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>>(arg1), 13839844787745849379);
        assert!(!0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::is_closed(&arg5), 13842096591855550515);
        assert!(0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::in_band(&arg5), 13842378071127359541);
        assert!(0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::twap_ok(&arg5), 13843503975329693757);
        let v3 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::remove_position<T0>(&v0, arg2, arg4);
        assert!(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_market(&v3) == 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>>(arg1), 13839844809220685859);
        let v4 = 0x2::clock::timestamp_ms(arg7);
        assert!(v4 != 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_opened_at(&v3), 13838437442926411801);
        let v5 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::timing<T0>(arg1);
        assert!(v4 >= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_opened_at(&v3) + 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::min_hold_ms(&v5), 13838718922198220827);
        let v6 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::timestamp_ms(&arg5);
        let v7 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::sequence(&arg5);
        assert!(v6 > 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_oracle_ts(&v3) && v6 >= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::last_oracle_ts_ms<T0>(arg1), 13835904185314705415);
        assert!(v7 > 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_oracle_sequence(&v3) && v7 >= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::last_oracle_sequence<T0>(arg1), 13835904189609672711);
        let v8 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::price_wad(&arg5);
        assert!(!0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::position::crossed_bust(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_is_long(&v3), v8, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_bust(&v3)), 13839000422944866333);
        let v9 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_is_long(&v3);
        let v10 = if (v9) {
            0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::bid_wad(&arg5)
        } else {
            0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::ask_wad(&arg5)
        };
        assert!(exit_within(v9, v10, arg6), 13844066985412919361);
        let v11 = settle_close<T0>(arg0, arg1, arg2, arg3, v3, 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::ask_wad(&arg5), 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::bid_wad(&arg5), v8, v4, arg8);
        touch_sweep<T0>(arg0, arg1, arg3, 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>>(arg2), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::owner<T0>(arg2), v8, v6, v7, arg8);
        refresh_reserve<T0>(arg0, arg1, arg3, v8);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::stamp_oracle<T0>(&v0, arg1, 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::price_wad(&arg5), v6, v7, 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::slot(&arg5));
        0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::discard_price(arg5);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::assert_identity<T0>(arg0);
        v11
    }

    public fun close_retired<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg2: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>, arg3: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::AccountCap, arg4: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg5: u64, arg6: 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::PriceReceipt, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::fees::LossTicket {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::assert_cap<T0>(arg2, arg3);
        close_retired_inner<T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8)
    }

    public fun close_retired_as_delegate<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg2: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>, arg3: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg4: u64, arg5: 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::fees::LossTicket {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::assert_delegate<T0>(arg2, 0x2::tx_context::sender(arg7), 0x2::clock::timestamp_ms(arg6));
        close_retired_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    fun close_retired_inner<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg2: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>, arg3: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg4: u64, arg5: 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::PriceReceipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::fees::LossTicket {
        let v0 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::auth::issue(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::uid(arg3));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg3);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::assert_version<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::assert_version<T0>(arg1);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::assert_exchange<T0>(arg1, 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>>(arg0));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::assert_version<T0>(arg2);
        assert!(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::status<T0>(arg1) == 3, 13840408055527112743);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::assert_exchange<T0>(arg2, 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>>(arg0));
        reconcile_inner<T0>(&v0, arg1, arg2);
        assert!(0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::market_id(&arg5) == 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>>(arg1), 13839845118458331171);
        assert!(!0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::is_closed(&arg5), 13842096922568032307);
        assert!(0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::in_band(&arg5), 13842378401839841333);
        assert!(0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::twap_ok(&arg5), 13843504306042175549);
        let v1 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::remove_position<T0>(&v0, arg2, arg4);
        assert!(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_market(&v1) == 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>>(arg1), 13839845139933167651);
        let v2 = 0x2::clock::timestamp_ms(arg6);
        assert!(v2 != 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_opened_at(&v1), 13838437773638893593);
        let v3 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::timing<T0>(arg1);
        assert!(v2 >= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_opened_at(&v1) + 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::min_hold_ms(&v3), 13838719252910702619);
        let v4 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::timestamp_ms(&arg5);
        let v5 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::sequence(&arg5);
        assert!(v4 > 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_oracle_ts(&v1) && v5 > 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_oracle_sequence(&v1), 13835904516027187207);
        assert!(v4 >= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::last_oracle_ts_ms<T0>(arg1) && v5 >= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::last_oracle_sequence<T0>(arg1), 13835904520322154503);
        assert!(!0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::position::crossed_bust(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_is_long(&v1), 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::price_wad(&arg5), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_bust(&v1)), 13839000762247282717);
        let v6 = settle_close<T0>(arg0, arg1, arg2, arg3, v1, 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::ask_wad(&arg5), 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::bid_wad(&arg5), 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::price_wad(&arg5), v2, arg7);
        refresh_reserve<T0>(arg0, arg1, arg3, 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::price_wad(&arg5));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::stamp_oracle<T0>(&v0, arg1, 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::price_wad(&arg5), v4, v5, 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::slot(&arg5));
        0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::discard_price(arg5);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::assert_identity<T0>(arg0);
        v6
    }

    public fun emergency_close<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg2: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>, arg3: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg4: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg5: u64, arg6: 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::PriceReceipt, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::fees::LossTicket {
        let v0 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::auth::issue(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::uid(arg3));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg3);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::assert_version<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::assert_version<T0>(arg2);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config>(arg3), arg4);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::assert_version<T0>(arg1);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::assert_exchange<T0>(arg1, 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>>(arg0));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::assert_exchange<T0>(arg2, 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>>(arg0));
        assert!(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::status<T0>(arg1) == 3, 13840408278865412135);
        reconcile_inner<T0>(&v0, arg1, arg2);
        assert!(0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::market_id(&arg6) == 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>>(arg1), 13839845337501663267);
        assert!(!0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::is_closed(&arg6), 13842097141611364403);
        assert!(0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::in_band(&arg6), 13842378620883173429);
        assert!(0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::twap_ok(&arg6), 13843504525085507645);
        let v1 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::remove_position<T0>(&v0, arg2, arg5);
        assert!(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_market(&v1) == 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>>(arg1), 13839845358976499747);
        let v2 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::timestamp_ms(&arg6);
        let v3 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::sequence(&arg6);
        assert!(v2 >= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::last_oracle_ts_ms<T0>(arg1) && v3 >= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::last_oracle_sequence<T0>(arg1), 13835904722185617415);
        assert!(v2 > 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_oracle_ts(&v1) && v3 > 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_oracle_sequence(&v1), 13835904726480584711);
        let v4 = settle_close<T0>(arg0, arg1, arg2, arg3, v1, 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::ask_wad(&arg6), 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::bid_wad(&arg6), 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::price_wad(&arg6), 0x2::clock::timestamp_ms(arg7), arg8);
        refresh_reserve<T0>(arg0, arg1, arg3, 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::price_wad(&arg6));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::stamp_oracle<T0>(&v0, arg1, 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::price_wad(&arg6), v2, v3, 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::slot(&arg6));
        0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::discard_price(arg6);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v0, 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>>(arg1), 14);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::assert_identity<T0>(arg0);
        v4
    }

    fun entry_within(arg0: bool, arg1: u128, arg2: u128) : bool {
        arg2 == 0 || arg0 && arg1 <= arg2 || arg1 >= arg2
    }

    fun exit_within(arg0: bool, arg1: u128, arg2: u128) : bool {
        arg2 == 0 || arg0 && arg1 >= arg2 || arg1 <= arg2
    }

    public fun liquidate<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg3: u64, arg4: 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::PriceReceipt, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg2);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::assert_version<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::assert_version<T0>(arg1);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::assert_exchange<T0>(arg1, 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>>(arg0));
        liquidate_receipt<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    fun liquidate_receipt<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg3: u64, arg4: 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::PriceReceipt, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::auth::issue(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::uid(arg2));
        assert!(0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::market_id(&arg4) == 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>>(arg1), 13839845642444341283);
        assert!(!0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::is_closed(&arg4), 13842097446554042419);
        let v1 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::timestamp_ms(&arg4);
        let v2 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::sequence(&arg4);
        assert!(v1 >= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::last_oracle_ts_ms<T0>(arg1), 13835905009948426247);
        assert!(v2 >= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::last_oracle_sequence<T0>(arg1), 13835905014243393543);
        let v3 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::price_wad(&arg4);
        assert!(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::contains(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::liq<T0>(arg1), arg3), 13842941897254371385);
        let v4 = *0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::borrow_record(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::liq<T0>(arg1), arg3);
        assert!(v1 > 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::r_oracle_ts(&v4) && v2 > 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::r_oracle_sequence(&v4), 13835905031423262727);
        let v5 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::r_is_long(&v4);
        assert!(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::position::crossed_bust(v5, v3, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::r_bust(&v4)), 13839282739735298079);
        assert!(0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::in_band(&arg4) || 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::position::crossed_bust(v5, 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::signed_mid_wad(&arg4), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::r_bust(&v4)), 13839282752620199967);
        let v6 = liquidate_record<T0>(arg0, arg1, arg2, arg3, v3, v1, 0x2::tx_context::sender(arg5), false, 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::in_band(&arg4));
        if (0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::in_band(&arg4)) {
            refresh_reserve<T0>(arg0, arg1, arg2, v3);
        };
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::stamp_oracle<T0>(&v0, arg1, v3, v1, v2, 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::slot(&arg4));
        0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::discard_price(arg4);
        let v7 = if (v6 > 0) {
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::split_out<T0>(&v0, arg0, v6, arg5)
        } else {
            0x2::coin::zero<T0>(arg5)
        };
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::assert_identity<T0>(arg0);
        v7
    }

    fun liquidate_record<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg3: u64, arg4: u128, arg5: u64, arg6: address, arg7: bool, arg8: bool) : u64 {
        let v0 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::auth::issue(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::uid(arg2));
        let v1 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::remove(&v0, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::liq_mut<T0>(&v0, arg1), arg3);
        let v2 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::r_is_long(&v1);
        let v3 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::r_margin(&v1);
        let v4 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::r_exposure(&v1);
        let v5 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::r_account_id(&v1);
        let v6 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::r_owner(&v1);
        let v7 = 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>>(arg1);
        let v8 = if (0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::r_wash(&v1)) {
            true
        } else {
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::opposite_notional(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::liq<T0>(arg1), v5, v2) > 0
        };
        let v9 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::risk<T0>(arg1);
        let v10 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::bps_of(v3, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::liq_bounty_bps(&v9));
        let v11 = if (v10 < 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::liq_bounty_cap(arg2)) {
            v10
        } else {
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::liq_bounty_cap(arg2)
        };
        let v12 = v3 - v11;
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::sub_oi<T0>(&v0, arg1, v2, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::r_notional(&v1));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::sub_locked<T0>(&v0, arg1, v2, v4);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::sub_qty<T0>(&v0, arg1, v2, v4, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::r_entry(&v1));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::sub_open_exposure<T0>(&v0, arg0, v4);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::unlock_all<T0>(&v0, arg0, v3);
        refresh_before_routing<T0>(arg0, arg1, arg2, arg4, arg8);
        let v13 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::realize_loss<T0>(&v0, arg0, v12, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::loss_fee_bps(arg2));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::route_retained<T0>(&v0, arg0, arg2, v13);
        let v14 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::fee_mint_basis(v13, 0, 0, v8, arg6 == v6, true);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::add_pending_basis<T0>(&v0, arg0, v5, v14);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::push_pending(&v0, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::liq_mut<T0>(&v0, arg1), v5, arg3);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_position_exit_event(&v0, arg3, v7, 1, v2, arg4, arg5);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_liquidate_position_event(&v0, arg3, v5, v11, v12);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_liquidation_detail_event(&v0, arg3, v7, v5, arg6, v11, v12, v13, arg7);
        0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::game::on_loss<T0>(arg0, arg2, v6, v14, arg5);
        v11
    }

    public fun liquidate_retired<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg3: u64, arg4: 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::PriceReceipt, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg2);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::assert_version<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::assert_version<T0>(arg1);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::assert_exchange<T0>(arg1, 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>>(arg0));
        assert!(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::status<T0>(arg1) == 3, 13840408536563449895);
        liquidate_receipt<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun no_price_bound() : u128 {
        0
    }

    public fun open<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg2: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>, arg3: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::AccountCap, arg4: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg5: 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::PriceReceipt, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: u64, arg11: u128, arg12: 0x2::coin::Coin<T0>, arg13: 0x1::option::Option<u32>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::assert_cap<T0>(arg2, arg3);
        if (0x2::coin::value<T0>(&arg12) > 0) {
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::deposit<T0>(arg0, arg2, arg3, arg12);
        } else {
            0x2::coin::destroy_zero<T0>(arg12);
        };
        open_inner<T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg13, arg14, arg15);
    }

    public fun open_as_delegate<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg2: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>, arg3: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg4: 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::PriceReceipt, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: u64, arg10: u128, arg11: 0x1::option::Option<u32>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::assert_delegate<T0>(arg2, 0x2::tx_context::sender(arg13), 0x2::clock::timestamp_ms(arg12));
        open_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    fun open_inner<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg2: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>, arg3: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg4: 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::PriceReceipt, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: u64, arg10: u128, arg11: 0x1::option::Option<u32>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::auth::issue(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::uid(arg3));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg3);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::assert_version<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::assert_version<T0>(arg1);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::assert_exchange<T0>(arg1, 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>>(arg0));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::assert_version<T0>(arg2);
        assert!(!arg8, 13840125373664460837);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::assert_exchange<T0>(arg2, 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>>(arg0));
        reconcile_inner<T0>(&v0, arg1, arg2);
        let (v1, v2) = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::builder::snapshot<T0>(arg0, arg3, arg11);
        let v3 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::is_paused(arg3) || 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::opens_paused<T0>(arg1);
        assert!(!0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::trading_blocked(v3), 13835340316238020611);
        assert!(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::enabled<T0>(arg1), 13840969820069822507);
        assert!(!0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::oracle_killed<T0>(arg1), 13840688349387948073);
        assert!(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::status<T0>(arg1) == 1, 13835621804099764229);
        assert!(0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::market_id(&arg4) == 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>>(arg1), 13839843933047357475);
        assert!(!0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::is_closed(&arg4), 13842095737157058611);
        assert!(0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::in_band(&arg4), 13842377216428867637);
        assert!(0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::twap_ok(&arg4), 13843503120631201853);
        let v4 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::timestamp_ms(&arg4);
        let v5 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::sequence(&arg4);
        assert!(v4 >= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::last_oracle_ts_ms<T0>(arg1), 13835903309141377031);
        assert!(v5 >= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::last_oracle_sequence<T0>(arg1), 13835903313436344327);
        let v6 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::risk<T0>(arg1);
        assert!(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::leverage_within(arg6, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::max_leverage(&v6)), 13836184797003120649);
        assert!(arg6 >= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::min_leverage(&v6), 13841814305129889841);
        let v7 = if (0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::taker_fee_is_set(arg3)) {
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::tighter_bps(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::taker_fee_bps<T0>(arg1), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::taker_fee_bps(arg3))
        } else {
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::taker_fee_bps<T0>(arg1)
        };
        let v8 = (arg5 as u128) * (arg6 as u128) * (v7 as u128) / 10000;
        assert!(v8 < (arg5 as u128), 13838155169085653015);
        let v9 = (v8 as u64);
        let v10 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::referral::quote<T0>(arg0, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::owner<T0>(arg2), v9, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::referral_enabled(arg3), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::referee_discount_bps(arg3), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::referral_fee_bps(arg3), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::second_level_fee_bps(arg3));
        let v11 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::referral::charged(&v10);
        let v12 = arg5 - v11;
        assert!(v12 >= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::min_margin(&v6), 13836466375059177483);
        let v13 = (v12 as u128) * (arg6 as u128);
        assert!(v13 <= 18446744073709551615, 13836466383649112075);
        let v14 = (v13 as u64);
        assert!(v14 >= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::min_notional(&v6) && v14 <= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::max_position_notional(&v6), 13836466392239046667);
        let (v15, v16) = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::charge_notional<T0>(&v0, arg1, v14, 0x2::clock::timestamp_ms(arg12), *0x2::tx_context::digest(arg13));
        assert!(v15, 13836747888690724877);
        assert!(v16, 13837029367962533903);
        assert!(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::open_notional<T0>(arg2) + v14 <= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::max_account_notional(&v6), 13837310847234342929);
        let v17 = 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>>(arg2);
        assert!(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::free_balance<T0>(arg0, v17) >= arg5, 13838155280754802711);
        let v18 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::impact<T0>(arg1);
        let v19 = if (arg7) {
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::long_oi<T0>(arg1)
        } else {
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::short_oi<T0>(arg1)
        };
        let v20 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::marginal_exposure(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::effective_depth(&v18), v19, v14);
        let v21 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::factor_bps(v20, v14);
        if (arg6 == 1) {
            assert!(v20 == v14, 13841533006246707247);
        } else {
            assert!(v20 > 0, 13841533014836641839);
        };
        if (arg9 > 0) {
            assert!(v21 >= arg9, 13841533027721543727);
        };
        assert!(v21 >= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::min_payout_factor_bps(arg3), 13841533040606445615);
        let (v22, v23) = if (arg7) {
            (0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::long_locked_exposure<T0>(arg1), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::max_long_exposure<T0>(arg1))
        } else {
            (0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::short_locked_exposure<T0>(arg1), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::max_short_exposure<T0>(arg1))
        };
        assert!((v22 as u128) + (v20 as u128) <= (v23 as u128), 13837592420995432467);
        let (v24, v25) = if (arg7) {
            (0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::max_long_oi<T0>(arg1), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::long_oi<T0>(arg1))
        } else {
            (0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::max_short_oi<T0>(arg1), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::short_oi<T0>(arg1))
        };
        assert!((v25 as u128) + (v14 as u128) <= (v24 as u128), 13843221950597038139);
        let v26 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::tighter_bps(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::win_fee_bps<T0>(arg1), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::win_fee_bps(arg3));
        let v27 = if (arg7) {
            0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::ask_wad(&arg4)
        } else {
            0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::bid_wad(&arg4)
        };
        assert!(entry_within(arg7, v27, arg10), 13843784913435623487);
        let v28 = if (arg7) {
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::position::bust_long(v27, arg6, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::effective_bust_buffer(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::bust_buffer_wad(&v6), arg6))
        } else {
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::position::bust_short(v27, arg6, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::effective_bust_buffer(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::bust_buffer_wad(&v6), arg6))
        };
        assert!(!0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::position::crossed_bust(arg7, 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::price_wad(&arg4), v28), 13842659052182962231);
        let v29 = 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>>(arg1);
        let v30 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::opposite_open<T0>(arg2, v29, arg7);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::debit_account_free<T0>(&v0, arg0, v17, arg5);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::lock_open<T0>(&v0, arg0, arg5, v11);
        0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::referral::pay_open_rewards<T0>(arg0, v10);
        let v31 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::alloc_position_id<T0>(&v0, arg0);
        let v32 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::builder::accrue<T0>(arg0, v9, 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::referral::protocol_remainder(&v10), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::owner<T0>(arg2), v17, v31, v1, v2, 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::builder::kind_open());
        let v33 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::referral::protocol_remainder(&v10) - v32;
        refresh_before_routing<T0>(arg0, arg1, arg3, 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::price_wad(&arg4), true);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::route_retained<T0>(&v0, arg0, arg3, v33);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::add_open_exposure<T0>(&v0, arg0, v20);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::add_open_notional<T0>(&v0, arg2, v14);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::add_side<T0>(&v0, arg2, v29, arg7, v14);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::note_hedge_if_two_sided<T0>(&v0, arg2, v29);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::add_oi<T0>(&v0, arg1, arg7, v14);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::add_locked<T0>(&v0, arg1, arg7, v20);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::add_qty<T0>(&v0, arg1, arg7, v20, v27);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::insert(&v0, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::liq_mut<T0>(&v0, arg1), v31, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::record(&v0, v17, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::owner<T0>(arg2), arg7, v12, v14, v20, v27, v28, v4, v5, v30));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::stamp_oracle<T0>(&v0, arg1, 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::price_wad(&arg4), v4, v5, 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::slot(&arg4));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_open_position_event(&v0, v31, v17, v29, arg7, 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::price_wad(&arg4), 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::conf_wad(&arg4), v27, v28, v12, v14, v21, v20, v26, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::deadband_ppm(&v18), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::close_fee_ppm(&v18), v1, v32);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::insert_position<T0>(&v0, arg2, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::new_position(&v0, v31, v29, arg7, v27, v12, arg6, v14, v28, 0x2::clock::timestamp_ms(arg12), v4, v5, v20, v21, v26, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::deadband_ppm(&v18), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::close_fee_ppm(&v18), v33, v30, v1, v2));
        let v34 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::price_wad(&arg4);
        touch_sweep<T0>(arg0, arg1, arg3, v17, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::owner<T0>(arg2), v34, v4, v5, arg13);
        refresh_reserve<T0>(arg0, arg1, arg3, v34);
        0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::discard_price(arg4);
        0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::game::on_open<T0>(arg0, arg3, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::owner<T0>(arg2), v29, v14, 0x2::clock::timestamp_ms(arg12));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::assert_identity<T0>(arg0);
    }

    public fun reconcile<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config) {
        let v0 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::auth::issue(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::uid(arg2));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::assert_version<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::assert_version<T0>(arg1);
        reconcile_inner<T0>(&v0, arg0, arg1);
    }

    fun reconcile_inner<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg2: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>) {
        let v0 = 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>>(arg2);
        if (0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::pending_count(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::liq<T0>(arg1), v0) == 0) {
            return
        };
        let v1 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::take_pending(arg0, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::liq_mut<T0>(arg0, arg1), v0, 32);
        let v2 = 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>>(arg1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v1)) {
            let v4 = *0x1::vector::borrow<u64>(&v1, v3);
            if (0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::has_position<T0>(arg2, v4)) {
                let v5 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::remove_position<T0>(arg0, arg2, v4);
                0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::sub_open_notional<T0>(arg0, arg2, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_notional(&v5));
                0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::sub_side<T0>(arg0, arg2, v2, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_is_long(&v5), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_notional(&v5));
                0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::clear_hedge_if_flat<T0>(arg0, arg2, v2);
                0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::destroy_position(arg0, v5);
                0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_position_reconciled_event(arg0, v0, v4);
            };
            v3 = v3 + 1;
        };
    }

    fun refresh_before_routing<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg3: u128, arg4: bool) {
        refresh_reserve_with<T0>(arg0, arg1, arg2, arg3, arg4, false);
    }

    fun refresh_reserve<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg3: u128) {
        refresh_reserve_with<T0>(arg0, arg1, arg2, arg3, true, true);
    }

    fun refresh_reserve_with<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg3: u128, arg4: bool, arg5: bool) {
        let v0 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::auth::issue(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::uid(arg2));
        let (v1, v2) = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::reserve_at<T0>(arg1, arg3, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::trim_max_share_bps(arg2));
        let (v3, v4) = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::swap_snapshot<T0>(&v0, arg1, v1, v2);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::adjust_reserve<T0>(&v0, arg0, arg2, 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>>(arg1), v3, v4, v1, v2, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::has_oi<T0>(arg1), arg4, arg5);
    }

    public fun retire_market<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg3: 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::PriceReceipt) {
        let v0 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::auth::issue(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::uid(arg1));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg1);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::assert_version<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config>(arg1), arg2);
        assert!(0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::market_id(&arg3) == 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>>(arg0), 13839847171452698659);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::set_status<T0>(&v0, arg0, 3, 0x1::option::none<u128>());
        0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::discard_price(arg3);
    }

    fun settle_close<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg2: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>, arg3: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg4: 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Position, arg5: u128, arg6: u128, arg7: u128, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::fees::LossTicket {
        let v0 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::auth::issue(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::uid(arg3));
        let v1 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_is_long(&arg4);
        let v2 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_margin(&arg4);
        let v3 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_notional(&arg4);
        let v4 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_entry(&arg4);
        let v5 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_exposure(&arg4);
        let v6 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_id(&arg4);
        let v7 = if (v1) {
            arg6
        } else {
            arg5
        };
        let v8 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::position::settle(v1, v3, v5, v4, v7, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_deadband_ppm(&arg4), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_close_fee_ppm(&arg4), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_win_fee_bps(&arg4), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::trim_max_share_bps(arg3), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::trim_c_ppm(arg3));
        let v9 = 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>>(arg1);
        let v10 = if (0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_wash(&arg4)) {
            true
        } else if (0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::is_hedged<T0>(arg2, v9)) {
            true
        } else {
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::closed_opposite_same_checkpoint<T0>(arg2, v9, v1, arg8)
        };
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::remove(&v0, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::liq_mut<T0>(&v0, arg1), v6);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::sub_oi<T0>(&v0, arg1, v1, v3);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::sub_locked<T0>(&v0, arg1, v1, v5);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::sub_qty<T0>(&v0, arg1, v1, v5, v4);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::sub_open_exposure<T0>(&v0, arg0, v5);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::sub_open_notional<T0>(&v0, arg2, v3);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::sub_side<T0>(&v0, arg2, v9, v1, v3);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::clear_hedge_if_flat<T0>(&v0, arg2, v9);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::note_close<T0>(&v0, arg2, v9, v1, arg8);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::unlock_all<T0>(&v0, arg0, v2);
        refresh_before_routing<T0>(arg0, arg1, arg3, arg7, true);
        let v11 = apply_pnl<T0>(arg0, arg2, arg3, &arg4, &v8, v2);
        let v12 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::fee_mint_basis(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_open_fee(&arg4), v11.retained, 0, v10, false, false);
        let v13 = if (v11.loss > 0) {
            v11.loss
        } else {
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::position::pnl_adjusted(&v8)
        };
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_position_exit_event(&v0, v6, v9, 0, v1, v7, arg8);
        let v14 = if (v11.loss > 0) {
            0
        } else {
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::position::pnl_win_fee(&v8)
        };
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_close_fees_event(&v0, v6, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::position::pnl_raw(&v8), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::position::pnl_raw(&v8) - 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::position::pnl_adjusted(&v8), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::position::pnl_close_toll(&v8), v14, v11.loss_fee, v11.discount, v11.retained);
        let v15 = if (v11.loss > 0) {
            0
        } else {
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::position::pnl_raw(&v8) - v11.user_profit
        };
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_close_position_event(&v0, v6, 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>>(arg2), v13, v15, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::position::pnl_win_fee(&v8), v11.user_profit, v11.queued, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_builder_id(&arg4), v11.builder_cut);
        0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::game::on_close<T0>(arg0, arg3, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::owner<T0>(arg2), v9, v3, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::position_leverage(&arg4), v2, v11.loss, v11.user_profit, v10, v12, arg8);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::destroy_position(&v0, arg4);
        0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::fees::ticket(v12, 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>>(arg2))
    }

    public fun sweep<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg3: 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::PriceReceipt, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::auth::issue(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::uid(arg2));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg2);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::assert_version<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::assert_version<T0>(arg1);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::assert_exchange<T0>(arg1, 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>>(arg0));
        assert!(0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::market_id(&arg3) == 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>>(arg1), 13839845848602771491);
        assert!(!0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::is_closed(&arg3), 13842097652712472627);
        assert!(0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::in_band(&arg3), 13842379131984281653);
        let v1 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::timestamp_ms(&arg3);
        let v2 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::sequence(&arg3);
        assert!(v1 >= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::last_oracle_ts_ms<T0>(arg1) && v2 >= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::last_oracle_sequence<T0>(arg1), 13835905220401823751);
        let v3 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::price_wad(&arg3);
        let v4 = if (arg4 < 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::sweep_max(arg2)) {
            arg4
        } else {
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::sweep_max(arg2)
        };
        let (_, v6) = sweep_inner<T0>(arg0, arg1, arg2, 0x1::option::none<0x2::object::ID>(), 0x2::tx_context::sender(arg5), v3, v1, v2, v4);
        refresh_reserve<T0>(arg0, arg1, arg2, v3);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::stamp_oracle<T0>(&v0, arg1, v3, v1, v2, 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::slot(&arg3));
        0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle::discard_price(arg3);
        let v7 = if (v6 > 0) {
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::split_out<T0>(&v0, arg0, v6, arg5)
        } else {
            0x2::coin::zero<T0>(arg5)
        };
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::assert_identity<T0>(arg0);
        v7
    }

    fun sweep_candidate<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg1: bool, arg2: u128, arg3: u64, arg4: u64) : (bool, bool, u64, u128) {
        let v0 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::peek(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::liq<T0>(arg0), arg1);
        if (0x1::option::is_none<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::HeapEntry>(&v0)) {
            return (false, false, 0, 0)
        };
        let v1 = 0x1::option::destroy_some<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::HeapEntry>(v0);
        let v2 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::entry_position_id(&v1);
        let v3 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::entry_bust(&v1);
        if (!0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::position::crossed_bust(arg1, arg2, v3)) {
            return (false, false, v2, v3)
        };
        let v4 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::borrow_record(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::liq<T0>(arg0), v2);
        let v5 = arg3 > 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::r_oracle_ts(v4) && arg4 > 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::r_oracle_sequence(v4);
        (true, v5, v2, v3)
    }

    fun sweep_inner<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg3: 0x1::option::Option<0x2::object::ID>, arg4: address, arg5: u128, arg6: u64, arg7: u64, arg8: u64) : (u64, u64) {
        let v0 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::auth::issue(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::uid(arg2));
        let v1 = 0;
        let v2 = 0;
        let v3 = true;
        let v4 = true;
        let v5 = 0x1::vector::empty<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::HeapEntry>();
        let v6 = 0x1::vector::empty<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::HeapEntry>();
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
            let v16 = liquidate_record<T0>(arg0, arg1, arg2, v15, arg5, arg6, arg4, true, true);
            if (0x1::option::is_some<0x2::object::ID>(&arg3)) {
                0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::credit_account_free<T0>(&v0, arg0, *0x1::option::borrow<0x2::object::ID>(&arg3), v16);
            } else {
                v2 = v2 + v16;
            };
            v1 = v1 + 1;
        };
        while (!0x1::vector::is_empty<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::HeapEntry>(&v5)) {
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::reinsert(&v0, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::liq_mut<T0>(&v0, arg1), 0x1::vector::pop_back<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::HeapEntry>(&mut v5));
        };
        while (!0x1::vector::is_empty<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::HeapEntry>(&v6)) {
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::reinsert(&v0, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::liq_mut<T0>(&v0, arg1), 0x1::vector::pop_back<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::HeapEntry>(&mut v6));
        };
        (v1, v2)
    }

    fun sweep_side_candidate<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg2: bool, arg3: u128, arg4: u64, arg5: u64, arg6: &mut vector<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::HeapEntry>) : (bool, u64, u128) {
        let v0;
        let v1;
        loop {
            let (v2, v3, v0, v1) = sweep_candidate<T0>(arg1, arg2, arg3, arg4, arg5);
            if (!v2 || v3) {
                return (v3, v0, v1)
            };
            if (0x1::vector::length<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::HeapEntry>(arg6) >= 2) {
                break
            };
            0x1::vector::push_back<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::HeapEntry>(arg6, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::liq_book::pop_top(arg0, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::liq_mut<T0>(arg0, arg1), arg2));
        };
        (false, v0, v1)
    }

    fun touch_sweep<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg3: 0x2::object::ID, arg4: address, arg5: u128, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::sweep_max(arg2);
        if (v0 == 0) {
            return
        };
        let (_, _) = sweep_inner<T0>(arg0, arg1, arg2, 0x1::option::some<0x2::object::ID>(arg3), arg4, arg5, arg6, arg7, v0);
    }

    // decompiled from Move bytecode v7
}

