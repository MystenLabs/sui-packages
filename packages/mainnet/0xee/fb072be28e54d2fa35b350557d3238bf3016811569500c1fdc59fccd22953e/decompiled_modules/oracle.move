module 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::oracle {
    struct PriceReceipt {
        auth: 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth,
        market_id: 0x2::object::ID,
        price_wad: u128,
        conf_wad: u128,
        spread_wad: u128,
        twap_wad: u128,
        timestamp_ms: u64,
        conf_timestamp_ms: u64,
        ask_wad: u128,
        bid_wad: u128,
        sequence: u64,
        slot: u64,
        closed: bool,
        in_band: bool,
        signed_mid_wad: u128,
    }

    public(friend) fun timestamp_ms(arg0: &PriceReceipt) : u64 {
        arg0.timestamp_ms
    }

    public(friend) fun conf_timestamp_ms(arg0: &PriceReceipt) : u64 {
        arg0.conf_timestamp_ms
    }

    public(friend) fun conf_wad(arg0: &PriceReceipt) : u128 {
        arg0.conf_wad
    }

    public(friend) fun price_wad(arg0: &PriceReceipt) : u128 {
        arg0.price_wad
    }

    public(friend) fun sequence(arg0: &PriceReceipt) : u64 {
        arg0.sequence
    }

    public(friend) fun slot(arg0: &PriceReceipt) : u64 {
        arg0.slot
    }

    public fun arm_session_close<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg3: PriceReceipt, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg2);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::is_order_keeper(arg2, 0x2::tx_context::sender(arg5)), 13839562501019926557);
        arm_inner<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun note_session_closed<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: PriceReceipt) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_version<T0>(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_unpaused(arg1, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::pause_closes());
        assert!(!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::closes_paused<T0>(arg0), 13839843860032651295);
        assert!(!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::oracle_killed<T0>(arg0), 13839280914373935131);
        assert!(arg2.market_id == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg0), 13838155018761535507);
        assert!(arg2.closed, 13837873548079661073);
        assert!(arg2.timestamp_ms >= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::last_oracle_ts_ms<T0>(arg0), 13838436502328311829);
        assert!(arg2.timestamp_ms >= 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::closed_seen_ts_ms<T0>(arg0), 13838436506623279125);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::note_session_closed<T0>(&arg2.auth, arg0, arg2.timestamp_ms);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_note_session_closed_event(&arg2.auth, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg0), arg2.timestamp_ms);
        discard_price(arg2);
    }

    fun arm_inner<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg3: PriceReceipt, arg4: &0x2::clock::Clock) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_version<T0>(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg1);
        assert!(arg3.market_id == 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg0), 13838155242099834899);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_exchange<T0>(arg0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>>(arg1));
        assert!(arg3.closed, 13837873775712927761);
        let v0 = arg3.timestamp_ms;
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::last_oracle_ts_ms<T0>(arg0);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::closed_seen_ts_ms<T0>(arg0);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::session_snapshot_monotonic(v0, v1, v2, false, 0), 13838436742846480405);
        let v3 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::session_close<T0>(arg0);
        let v4 = 0x1::option::is_some<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::SessionCloseV1>(&v3);
        let v5 = if (v4) {
            let v6 = 0x1::option::borrow<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::SessionCloseV1>(&v3);
            assert!(!0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::session_pending(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::sc_armed(v6), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::sc_remaining(v6)), 13838999714275000345);
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::sc_ts_ms(v6)
        } else {
            0
        };
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::session_snapshot_monotonic(v0, v1, v2, v4, v5), 13838436777206218773);
        assert!(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::session_gap_ok(v0, 0x2::clock::timestamp_ms(arg4), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::force_close_min_gap_ms(arg2)), 13838718256478027799);
        let v7 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::liq<T0>(arg0);
        let v8 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::side_size(v7, true) + 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::side_size(v7, false);
        let v9 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::next_position_id<T0>(arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::arm_session_close<T0>(&arg3.auth, arg0, arg3.price_wad, v0, arg3.sequence, v9, v8);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::note_session_closed<T0>(&arg3.auth, arg0, v0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_session_armed_event(&arg3.auth, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg0), arg3.price_wad, v0, v9, v8);
        discard_price(arg3);
    }

    public fun arm_session_close_admin<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg4: PriceReceipt, arg5: &0x2::clock::Clock) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg2), arg3);
        arm_inner<T0>(arg0, arg1, arg2, arg4, arg5);
    }

    public(friend) fun ask_wad(arg0: &PriceReceipt) : u128 {
        arg0.ask_wad
    }

    fun begin<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: 0x28bac7b4d54044f1d821f973d2657f0b9ab8a71bc4661f073df61070917cb2e2::adapter::VerifiedQuote, arg3: &0x2::clock::Clock) : PriceReceipt {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::assert_version<T0>(arg1);
        let v0 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::oracle<T0>(arg1);
        assert!(0x28bac7b4d54044f1d821f973d2657f0b9ab8a71bc4661f073df61070917cb2e2::adapter::storage_id(&arg2) == 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::storage_id(&v0), 13836465919792513033);
        assert!(0x28bac7b4d54044f1d821f973d2657f0b9ab8a71bc4661f073df61070917cb2e2::adapter::feed_info_id(&arg2) == 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::feed_info_id(&v0), 13836465924087480329);
        assert!(0x28bac7b4d54044f1d821f973d2657f0b9ab8a71bc4661f073df61070917cb2e2::adapter::source_id(&arg2) == 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::source_id(&v0), 13836465928382447625);
        assert!(0x28bac7b4d54044f1d821f973d2657f0b9ab8a71bc4661f073df61070917cb2e2::adapter::feed_id(&arg2) == 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::lazer_feed_id(&v0), 13836465932677414921);
        let v1 = 0x28bac7b4d54044f1d821f973d2657f0b9ab8a71bc4661f073df61070917cb2e2::adapter::price_wad(&arg2);
        assert!(v1 > 0, 13836184474880442375);
        let v2 = 0x28bac7b4d54044f1d821f973d2657f0b9ab8a71bc4661f073df61070917cb2e2::adapter::price_timestamp_ms(&arg2);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::max_age_ms(&v0);
        let v5 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::max_future_ms(&v0);
        if (v2 > v3 && !0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::timestamp_accepted(v2, v3, v4, v5)) {
            abort 13835621550696693765
        };
        let v6 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::hours_mode<T0>(arg1) == 1 && !0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::timestamp_accepted(v2, v3, v4, v5);
        if (!v6) {
            check_time(v2, v3, v4, v5, false);
            check_time(0x28bac7b4d54044f1d821f973d2657f0b9ab8a71bc4661f073df61070917cb2e2::adapter::conf_timestamp_ms(&arg2), v3, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::max_conf_age_ms(&v0), v5, true);
        };
        let v7 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::order_params<T0>(arg1);
        let v8 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::charged_spread(v1, 0x28bac7b4d54044f1d821f973d2657f0b9ab8a71bc4661f073df61070917cb2e2::adapter::conf_wad(&arg2), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::one_step_spread_bps(&v7));
        assert!(v8 > 0 && v8 < v1, 13836747497848569867);
        let v9 = PriceReceipt{
            auth              : 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0)),
            market_id         : 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>>(arg1),
            price_wad         : v1,
            conf_wad          : 0x28bac7b4d54044f1d821f973d2657f0b9ab8a71bc4661f073df61070917cb2e2::adapter::conf_wad(&arg2),
            spread_wad        : v8,
            twap_wad          : 0x28bac7b4d54044f1d821f973d2657f0b9ab8a71bc4661f073df61070917cb2e2::adapter::twap_wad(&arg2),
            timestamp_ms      : v2,
            conf_timestamp_ms : 0x28bac7b4d54044f1d821f973d2657f0b9ab8a71bc4661f073df61070917cb2e2::adapter::conf_timestamp_ms(&arg2),
            ask_wad           : v1 + v8,
            bid_wad           : v1 - v8,
            sequence          : 0x28bac7b4d54044f1d821f973d2657f0b9ab8a71bc4661f073df61070917cb2e2::adapter::sequence(&arg2),
            slot              : 0x28bac7b4d54044f1d821f973d2657f0b9ab8a71bc4661f073df61070917cb2e2::adapter::slot(&arg2),
            closed            : v6,
            in_band           : 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::within_signed_band(v1, 0x28bac7b4d54044f1d821f973d2657f0b9ab8a71bc4661f073df61070917cb2e2::adapter::signed_bid_wad(&arg2), 0x28bac7b4d54044f1d821f973d2657f0b9ab8a71bc4661f073df61070917cb2e2::adapter::signed_ask_wad(&arg2), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::min_spread_bps(&v0)),
            signed_mid_wad    : ((((0x28bac7b4d54044f1d821f973d2657f0b9ab8a71bc4661f073df61070917cb2e2::adapter::signed_bid_wad(&arg2) as u256) + (0x28bac7b4d54044f1d821f973d2657f0b9ab8a71bc4661f073df61070917cb2e2::adapter::signed_ask_wad(&arg2) as u256)) / 2) as u128),
        };
        0x28bac7b4d54044f1d821f973d2657f0b9ab8a71bc4661f073df61070917cb2e2::adapter::destroy(arg2);
        v9
    }

    public fun begin_liquidation_price<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: 0x28bac7b4d54044f1d821f973d2657f0b9ab8a71bc4661f073df61070917cb2e2::adapter::VerifiedQuote, arg3: &0x2::clock::Clock) : PriceReceipt {
        begin<T0>(arg0, arg1, arg2, arg3)
    }

    public fun begin_price<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market::Market<T0>, arg2: 0x28bac7b4d54044f1d821f973d2657f0b9ab8a71bc4661f073df61070917cb2e2::adapter::VerifiedQuote, arg3: &0x2::clock::Clock) : PriceReceipt {
        begin<T0>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun bid_wad(arg0: &PriceReceipt) : u128 {
        arg0.bid_wad
    }

    fun check_time(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool) {
        if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::timestamp_accepted(arg0, arg1, arg2, arg3)) {
            return
        } else if (arg0 > arg1) {
            assert!(arg4, 13835622242186428421);
            abort 13837592567024058383
        } else {
            assert!(arg4, 13835340775799521283);
            abort 13837311100637151245
        };
    }

    public fun discard_price(arg0: PriceReceipt) {
        let PriceReceipt {
            auth              : _,
            market_id         : _,
            price_wad         : _,
            conf_wad          : _,
            spread_wad        : _,
            twap_wad          : _,
            timestamp_ms      : _,
            conf_timestamp_ms : _,
            ask_wad           : _,
            bid_wad           : _,
            sequence          : _,
            slot              : _,
            closed            : _,
            in_band           : _,
            signed_mid_wad    : _,
        } = arg0;
    }

    public(friend) fun in_band(arg0: &PriceReceipt) : bool {
        arg0.in_band
    }

    public(friend) fun is_closed(arg0: &PriceReceipt) : bool {
        arg0.closed
    }

    public(friend) fun market_id(arg0: &PriceReceipt) : 0x2::object::ID {
        arg0.market_id
    }

    public(friend) fun signed_mid_wad(arg0: &PriceReceipt) : u128 {
        arg0.signed_mid_wad
    }

    public(friend) fun spread_wad(arg0: &PriceReceipt) : u128 {
        arg0.spread_wad
    }

    public(friend) fun to_mid(arg0: PriceReceipt) : PriceReceipt {
        arg0.spread_wad = 0;
        arg0.ask_wad = arg0.price_wad;
        arg0.bid_wad = arg0.price_wad;
        arg0
    }

    public(friend) fun unpack(arg0: PriceReceipt) : PriceReceipt {
        arg0
    }

    // decompiled from Move bytecode v7
}

