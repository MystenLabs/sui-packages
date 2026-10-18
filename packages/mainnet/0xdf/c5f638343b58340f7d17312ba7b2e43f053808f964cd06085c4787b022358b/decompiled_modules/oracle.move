module 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::oracle {
    struct PriceReceipt {
        auth: 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::Auth,
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
        twap_ok: bool,
    }

    public(friend) fun timestamp_ms(arg0: &PriceReceipt) : u64 {
        arg0.timestamp_ms
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

    public fun note_session_closed<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg1: PriceReceipt) {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::assert_version<T0>(arg0);
        assert!(arg1.market_id == 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>>(arg0), 13838155001581797397);
        assert!(arg1.closed, 13837873530899922963);
        assert!(arg1.timestamp_ms >= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::last_oracle_ts_ms<T0>(arg0), 13838436485148573719);
        assert!(arg1.timestamp_ms >= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::closed_seen_ts_ms<T0>(arg0), 13838436489443541015);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::note_session_closed<T0>(&arg1.auth, arg0, arg1.timestamp_ms);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_note_session_closed_event(&arg1.auth, 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>>(arg0), arg1.timestamp_ms);
        discard_price(arg1);
    }

    public(friend) fun ask_wad(arg0: &PriceReceipt) : u128 {
        arg0.ask_wad
    }

    fun begin<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg2: 0x131f43e1589f2b88f7e6617a8dc6387499d883089972b6a51946087e66901a84::adapter::VerifiedQuote, arg3: &0x2::clock::Clock, arg4: bool) : PriceReceipt {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::assert_version<T0>(arg1);
        let v0 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::oracle<T0>(arg1);
        assert!(0x131f43e1589f2b88f7e6617a8dc6387499d883089972b6a51946087e66901a84::adapter::storage_id(&arg2) == 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::storage_id(&v0), 13836465902612774923);
        assert!(0x131f43e1589f2b88f7e6617a8dc6387499d883089972b6a51946087e66901a84::adapter::feed_info_id(&arg2) == 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::feed_info_id(&v0), 13836465906907742219);
        assert!(0x131f43e1589f2b88f7e6617a8dc6387499d883089972b6a51946087e66901a84::adapter::source_id(&arg2) == 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::source_id(&v0), 13836465911202709515);
        assert!(0x131f43e1589f2b88f7e6617a8dc6387499d883089972b6a51946087e66901a84::adapter::feed_id(&arg2) == 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::lazer_feed_id(&v0), 13836465915497676811);
        let v1 = 0x131f43e1589f2b88f7e6617a8dc6387499d883089972b6a51946087e66901a84::adapter::price_wad(&arg2);
        let v2 = 0x131f43e1589f2b88f7e6617a8dc6387499d883089972b6a51946087e66901a84::adapter::twap_wad(&arg2);
        assert!(v1 > 0 && v2 > 0, 13836184453405736969);
        let v3 = 0x131f43e1589f2b88f7e6617a8dc6387499d883089972b6a51946087e66901a84::adapter::price_timestamp_ms(&arg2);
        let v4 = 0x2::clock::timestamp_ms(arg3);
        let v5 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::max_age_ms(&v0);
        let v6 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::max_future_ms(&v0);
        if (v3 > v4 && !0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::timestamp_accepted(v3, v4, v5, v6)) {
            abort 13835621529221857285
        };
        let v7 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::hours_mode<T0>(arg1) == 1;
        let v8 = v7 && !0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::timestamp_accepted(v3, v4, v5, v6);
        let v9 = true;
        if (!v8) {
            check_time(v3, v4, v5, v6, false);
            check_time(0x131f43e1589f2b88f7e6617a8dc6387499d883089972b6a51946087e66901a84::adapter::conf_timestamp_ms(&arg2), v4, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::max_conf_age_ms(&v0), v6, true);
            let v10 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::closed_seen_ts_ms<T0>(arg1);
            let v11 = if (v7) {
                if (v10 != 0) {
                    v3 > v10
                } else {
                    false
                }
            } else {
                false
            };
            if (!v11) {
                let v12 = within_twap(v1, v2, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::max_twap_dev_bps(&v0));
                v9 = v12;
                assert!(v12 || arg4, 13835903060033273863);
            };
        };
        let v13 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::position::charged_spread(v1, 0x131f43e1589f2b88f7e6617a8dc6387499d883089972b6a51946087e66901a84::adapter::conf_wad(&arg2), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::min_spread_bps(&v0));
        assert!(v13 > 0 && v13 < v1, 13836747502143668237);
        let v14 = PriceReceipt{
            auth              : 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::auth::issue(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::uid(arg0)),
            market_id         : 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>>(arg1),
            price_wad         : v1,
            conf_wad          : 0x131f43e1589f2b88f7e6617a8dc6387499d883089972b6a51946087e66901a84::adapter::conf_wad(&arg2),
            spread_wad        : v13,
            twap_wad          : v2,
            timestamp_ms      : v3,
            conf_timestamp_ms : 0x131f43e1589f2b88f7e6617a8dc6387499d883089972b6a51946087e66901a84::adapter::conf_timestamp_ms(&arg2),
            ask_wad           : v1 + v13,
            bid_wad           : v1 - v13,
            sequence          : 0x131f43e1589f2b88f7e6617a8dc6387499d883089972b6a51946087e66901a84::adapter::sequence(&arg2),
            slot              : 0x131f43e1589f2b88f7e6617a8dc6387499d883089972b6a51946087e66901a84::adapter::slot(&arg2),
            closed            : v8,
            in_band           : 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::within_signed_band(v1, 0x131f43e1589f2b88f7e6617a8dc6387499d883089972b6a51946087e66901a84::adapter::signed_bid_wad(&arg2), 0x131f43e1589f2b88f7e6617a8dc6387499d883089972b6a51946087e66901a84::adapter::signed_ask_wad(&arg2), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::min_spread_bps(&v0)),
            signed_mid_wad    : ((((0x131f43e1589f2b88f7e6617a8dc6387499d883089972b6a51946087e66901a84::adapter::signed_bid_wad(&arg2) as u256) + (0x131f43e1589f2b88f7e6617a8dc6387499d883089972b6a51946087e66901a84::adapter::signed_ask_wad(&arg2) as u256)) / 2) as u128),
            twap_ok           : v9,
        };
        0x131f43e1589f2b88f7e6617a8dc6387499d883089972b6a51946087e66901a84::adapter::destroy(arg2);
        v14
    }

    public fun begin_liquidation_price<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg2: 0x131f43e1589f2b88f7e6617a8dc6387499d883089972b6a51946087e66901a84::adapter::VerifiedQuote, arg3: &0x2::clock::Clock) : PriceReceipt {
        begin<T0>(arg0, arg1, arg2, arg3, true)
    }

    public fun begin_price<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::Market<T0>, arg2: 0x131f43e1589f2b88f7e6617a8dc6387499d883089972b6a51946087e66901a84::adapter::VerifiedQuote, arg3: &0x2::clock::Clock) : PriceReceipt {
        begin<T0>(arg0, arg1, arg2, arg3, false)
    }

    public(friend) fun bid_wad(arg0: &PriceReceipt) : u128 {
        arg0.bid_wad
    }

    fun check_time(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool) {
        if (0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::timestamp_accepted(arg0, arg1, arg2, arg3)) {
            return
        } else if (arg0 > arg1) {
            assert!(arg4, 13835621894294077445);
            abort 13837592219131838481
        } else {
            assert!(arg4, 13835340427907170307);
            abort 13837310752744931343
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
            twap_ok           : _,
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

    public(friend) fun twap_ok(arg0: &PriceReceipt) : bool {
        arg0.twap_ok
    }

    public(friend) fun unpack(arg0: PriceReceipt) : PriceReceipt {
        arg0
    }

    fun within_twap(arg0: u128, arg1: u128, arg2: u64) : bool {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = if (v0 > v1) {
            v0 - v1
        } else {
            v1 - v0
        };
        v2 * 10000 <= v1 * (arg2 as u256)
    }

    // decompiled from Move bytecode v7
}

