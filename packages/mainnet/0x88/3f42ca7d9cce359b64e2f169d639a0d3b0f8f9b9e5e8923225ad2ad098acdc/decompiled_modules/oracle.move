module 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::oracle {
    struct PriceReceipt {
        auth: 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth,
        market_id: 0x2::object::ID,
        price_wad: u128,
        conf_wad: u128,
        spread_wad: u128,
        twap_wad: u128,
        timestamp_ms: u64,
        conf_timestamp_ms: u64,
        at_mid: bool,
        sequence: u64,
        slot: u64,
        closed: bool,
    }

    public(friend) fun timestamp_ms(arg0: &PriceReceipt) : u64 {
        arg0.timestamp_ms
    }

    public fun arm_session_close<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg3: PriceReceipt, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg2);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::is_order_keeper(arg2, 0x2::tx_context::sender(arg5)), 13839562548264566813);
        arm_inner<T0>(arg0, arg1, arg2, arg3, arg4, true);
    }

    public fun disarm_session_close<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config>(arg2), arg3);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_version<T0>(arg0);
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg2, arg1);
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::disarm_session_close<T0>(&v0, arg0);
        if (0x1::option::is_some<u64>(&v1)) {
            let v2 = 0x1::option::destroy_some<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::SessionCloseV1>(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::session_close<T0>(arg0));
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_session_disarmed_event(&v0, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg0), 0x1::option::destroy_some<u64>(v1), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::sc_closed_count(&v2));
        };
    }

    public fun note_session_closed<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg3: PriceReceipt) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_version<T0>(arg0);
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg2, arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_unpaused(arg2, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::pause_closes());
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::closes_paused<T0>(arg0), 13839843902982324255);
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::oracle_killed<T0>(arg0), 13839280957323608091);
        assert!(arg3.market_id == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg0), 13838155061711208467);
        assert!(arg3.closed, 13837873591029334033);
        assert!(arg3.timestamp_ms >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::last_oracle_ts_ms<T0>(arg0), 13838436545277984789);
        assert!(arg3.timestamp_ms >= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::closed_seen_ts_ms<T0>(arg0), 13838436549572952085);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::note_session_closed<T0>(&v0, arg0, arg3.timestamp_ms);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_note_session_closed_event(&v0, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg0), arg3.timestamp_ms);
        discard_price(arg3);
    }

    fun arm_inner<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg3: PriceReceipt, arg4: &0x2::clock::Clock, arg5: bool) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg1);
        assert!(arg3.market_id == 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg0), 13838155396718657555);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_exchange<T0>(arg0, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg1));
        assert!(arg3.closed, 13837873930331750417);
        let v0 = arg3.timestamp_ms;
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::last_oracle_ts_ms<T0>(arg0);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::closed_seen_ts_ms<T0>(arg0);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::session_snapshot_monotonic(v0, v1, v2, false, 0), 13838436897465303061);
        let v3 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::session_close<T0>(arg0);
        let v4 = 0x1::option::is_some<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::SessionCloseV1>(&v3);
        let v5 = if (v4) {
            let v6 = 0x1::option::borrow<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::SessionCloseV1>(&v3);
            assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::session_pending(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::sc_armed(v6), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::sc_remaining(v6)), 13838999868893823001);
            0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::sc_ts_ms(v6)
        } else {
            0
        };
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::session_snapshot_monotonic(v0, v1, v2, v4, v5), 13838436931825041429);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::session_gap_ok(v0, 0x2::clock::timestamp_ms(arg4), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::force_close_min_gap_ms(arg2)), 13838718411096850455);
        let v7 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::liq<T0>(arg0);
        let v8 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::side_size(v7, true) + 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::liq_book::side_size(v7, false);
        let v9 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::next_position_id<T0>(arg1);
        let v10 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::oracle<T0>(arg0);
        assert!(!arg5 || 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::timestamp_accepted(arg3.conf_timestamp_ms, 0x2::clock::timestamp_ms(arg4), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::max_conf_age_ms(&v10), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::max_future_ms(&v10)), 13837311079162314765);
        let v11 = arg3.price_wad;
        let v12 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg2, arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::arm_session_close<T0>(&v12, arg0, v11, v0, arg3.sequence, v9, v8);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::note_session_closed<T0>(&v12, arg0, v0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_session_armed_event(&v12, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg0), v11, v0, v9, v8);
        discard_price(arg3);
    }

    public fun arm_session_close_admin<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg3: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg4: PriceReceipt, arg5: &0x2::clock::Clock) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config>(arg2), arg3);
        arm_inner<T0>(arg0, arg1, arg2, arg4, arg5, false);
    }

    public(friend) fun ask_wad(arg0: &PriceReceipt) : u128 {
        arg0.price_wad + one_step_spread(arg0)
    }

    fun begin<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: 0x8c93822a4b93178568a3e3edbe45a63984c3b8d39f4984a85d9add3cb45c9be7::adapter::VerifiedQuote, arg3: &0x2::clock::Clock) : PriceReceipt {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::assert_version<T0>(arg1);
        let v0 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::oracle<T0>(arg1);
        assert!(0x8c93822a4b93178568a3e3edbe45a63984c3b8d39f4984a85d9add3cb45c9be7::adapter::storage_id(&arg2) == 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::storage_id(&v0), 13836465949857284105);
        assert!(0x8c93822a4b93178568a3e3edbe45a63984c3b8d39f4984a85d9add3cb45c9be7::adapter::feed_info_id(&arg2) == 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::feed_info_id(&v0), 13836465954152251401);
        assert!(0x8c93822a4b93178568a3e3edbe45a63984c3b8d39f4984a85d9add3cb45c9be7::adapter::source_id(&arg2) == 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::source_id(&v0), 13836465958447218697);
        assert!(0x8c93822a4b93178568a3e3edbe45a63984c3b8d39f4984a85d9add3cb45c9be7::adapter::feed_id(&arg2) == 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::lazer_feed_id(&v0), 13836465962742185993);
        let v1 = 0x8c93822a4b93178568a3e3edbe45a63984c3b8d39f4984a85d9add3cb45c9be7::adapter::price_wad(&arg2);
        assert!(v1 > 0, 13836184504945213447);
        let v2 = 0x8c93822a4b93178568a3e3edbe45a63984c3b8d39f4984a85d9add3cb45c9be7::adapter::price_timestamp_ms(&arg2);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::max_age_ms(&v0);
        let v5 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::max_future_ms(&v0);
        if (v2 > v3 && !0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::timestamp_accepted(v2, v3, v4, v5)) {
            abort 13835621580761464837
        };
        let v6 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::hours_mode<T0>(arg1) == 1 && !0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::timestamp_accepted(v2, v3, v4, v5);
        if (!v6) {
            check_time(v2, v3, v4, v5, false);
            check_time(0x8c93822a4b93178568a3e3edbe45a63984c3b8d39f4984a85d9add3cb45c9be7::adapter::conf_timestamp_ms(&arg2), v3, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::max_conf_age_ms(&v0), v5, true);
        };
        let v7 = 0x1::option::destroy_with_default<u128>(0x8c93822a4b93178568a3e3edbe45a63984c3b8d39f4984a85d9add3cb45c9be7::adapter::conf_wad(&arg2), 0);
        let v8 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::order_params<T0>(arg1);
        let v9 = PriceReceipt{
            auth              : 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::uid(arg0)),
            market_id         : 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>>(arg1),
            price_wad         : v1,
            conf_wad          : v7,
            spread_wad        : 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::position::charged_spread(v1, v7, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::one_step_spread_bps(&v8)),
            twap_wad          : 0x8c93822a4b93178568a3e3edbe45a63984c3b8d39f4984a85d9add3cb45c9be7::adapter::twap_wad(&arg2),
            timestamp_ms      : v2,
            conf_timestamp_ms : 0x8c93822a4b93178568a3e3edbe45a63984c3b8d39f4984a85d9add3cb45c9be7::adapter::conf_timestamp_ms(&arg2),
            at_mid            : false,
            sequence          : 0x8c93822a4b93178568a3e3edbe45a63984c3b8d39f4984a85d9add3cb45c9be7::adapter::sequence(&arg2),
            slot              : 0x8c93822a4b93178568a3e3edbe45a63984c3b8d39f4984a85d9add3cb45c9be7::adapter::slot(&arg2),
            closed            : v6,
        };
        0x8c93822a4b93178568a3e3edbe45a63984c3b8d39f4984a85d9add3cb45c9be7::adapter::destroy(arg2);
        v9
    }

    public fun begin_liquidation_price<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: 0x8c93822a4b93178568a3e3edbe45a63984c3b8d39f4984a85d9add3cb45c9be7::adapter::VerifiedQuote, arg3: &0x2::clock::Clock) : PriceReceipt {
        begin<T0>(arg0, arg1, arg2, arg3)
    }

    public fun begin_price<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::market::Market<T0>, arg2: 0x8c93822a4b93178568a3e3edbe45a63984c3b8d39f4984a85d9add3cb45c9be7::adapter::VerifiedQuote, arg3: &0x2::clock::Clock) : PriceReceipt {
        begin<T0>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun bid_wad(arg0: &PriceReceipt) : u128 {
        arg0.price_wad - one_step_spread(arg0)
    }

    fun check_time(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool) {
        if (0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::timestamp_accepted(arg0, arg1, arg2, arg3)) {
            return
        } else if (arg0 > arg1) {
            assert!(arg4, 13835622534244204549);
            abort 13837592859081834511
        } else {
            assert!(arg4, 13835341067857297411);
            abort 13837311392694927373
        };
    }

    public(friend) fun conf_timestamp_ms(arg0: &PriceReceipt) : u64 {
        arg0.conf_timestamp_ms
    }

    public(friend) fun conf_wad(arg0: &PriceReceipt) : u128 {
        arg0.conf_wad
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
            at_mid            : _,
            sequence          : _,
            slot              : _,
            closed            : _,
        } = arg0;
    }

    public(friend) fun is_closed(arg0: &PriceReceipt) : bool {
        arg0.closed
    }

    public(friend) fun market_id(arg0: &PriceReceipt) : 0x2::object::ID {
        arg0.market_id
    }

    fun one_step_spread(arg0: &PriceReceipt) : u128 {
        if (arg0.at_mid) {
            return 0
        };
        0x1::u128::min(arg0.spread_wad, arg0.price_wad - 1)
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

    public(friend) fun spread_wad(arg0: &PriceReceipt) : u128 {
        arg0.spread_wad
    }

    public(friend) fun to_mid(arg0: PriceReceipt) : PriceReceipt {
        arg0.spread_wad = 0;
        arg0.at_mid = true;
        arg0
    }

    public(friend) fun unpack(arg0: PriceReceipt) : PriceReceipt {
        arg0
    }

    // decompiled from Move bytecode v7
}

