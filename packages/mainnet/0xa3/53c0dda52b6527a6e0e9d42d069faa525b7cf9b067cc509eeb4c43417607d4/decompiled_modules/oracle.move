module 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::oracle {
    struct PriceReceipt {
        auth: 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::Auth,
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

    public fun note_session_closed<T0>(arg0: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::Market<T0>, arg1: PriceReceipt) {
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::assert_version<T0>(arg0);
        assert!(arg1.market_id == 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::Market<T0>>(arg0), 13838154954337026067);
        assert!(arg1.closed, 13837873483655151633);
        assert!(arg1.timestamp_ms >= 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::last_oracle_ts_ms<T0>(arg0), 13838436437903802389);
        assert!(arg1.timestamp_ms >= 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::closed_seen_ts_ms<T0>(arg0), 13838436442198769685);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::note_session_closed<T0>(&arg1.auth, arg0, arg1.timestamp_ms);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::events::emit_note_session_closed_event(&arg1.auth, 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::Market<T0>>(arg0), arg1.timestamp_ms);
        discard_price(arg1);
    }

    public(friend) fun ask_wad(arg0: &PriceReceipt) : u128 {
        arg0.ask_wad
    }

    fun begin<T0>(arg0: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::Market<T0>, arg2: 0x4b49ecc34f16c410eddb89e7c3507af9a0a99f649cb104541dc3f1e277c734d3::adapter::VerifiedQuote, arg3: &0x2::clock::Clock) : PriceReceipt {
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::assert_version(arg0);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::assert_version<T0>(arg1);
        let v0 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::oracle<T0>(arg1);
        assert!(0x4b49ecc34f16c410eddb89e7c3507af9a0a99f649cb104541dc3f1e277c734d3::adapter::storage_id(&arg2) == 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::storage_id(&v0), 13836465876842840073);
        assert!(0x4b49ecc34f16c410eddb89e7c3507af9a0a99f649cb104541dc3f1e277c734d3::adapter::feed_info_id(&arg2) == 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::feed_info_id(&v0), 13836465881137807369);
        assert!(0x4b49ecc34f16c410eddb89e7c3507af9a0a99f649cb104541dc3f1e277c734d3::adapter::source_id(&arg2) == 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::source_id(&v0), 13836465885432774665);
        assert!(0x4b49ecc34f16c410eddb89e7c3507af9a0a99f649cb104541dc3f1e277c734d3::adapter::feed_id(&arg2) == 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::lazer_feed_id(&v0), 13836465889727741961);
        let v1 = 0x4b49ecc34f16c410eddb89e7c3507af9a0a99f649cb104541dc3f1e277c734d3::adapter::price_wad(&arg2);
        assert!(v1 > 0, 13836184431930769415);
        let v2 = 0x4b49ecc34f16c410eddb89e7c3507af9a0a99f649cb104541dc3f1e277c734d3::adapter::price_timestamp_ms(&arg2);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::max_age_ms(&v0);
        let v5 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::max_future_ms(&v0);
        if (v2 > v3 && !0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::safety::timestamp_accepted(v2, v3, v4, v5)) {
            abort 13835621507747020805
        };
        let v6 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::hours_mode<T0>(arg1) == 1 && !0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::safety::timestamp_accepted(v2, v3, v4, v5);
        if (!v6) {
            check_time(v2, v3, v4, v5, false);
            check_time(0x4b49ecc34f16c410eddb89e7c3507af9a0a99f649cb104541dc3f1e277c734d3::adapter::conf_timestamp_ms(&arg2), v3, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::max_conf_age_ms(&v0), v5, true);
        };
        let v7 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::order_params<T0>(arg1);
        let v8 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::position::charged_spread(v1, 0x4b49ecc34f16c410eddb89e7c3507af9a0a99f649cb104541dc3f1e277c734d3::adapter::conf_wad(&arg2), 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::one_step_spread_bps(&v7));
        assert!(v8 > 0 && v8 < v1, 13836747454898896907);
        let v9 = PriceReceipt{
            auth              : 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::auth::issue(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::uid(arg0)),
            market_id         : 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::Market<T0>>(arg1),
            price_wad         : v1,
            conf_wad          : 0x4b49ecc34f16c410eddb89e7c3507af9a0a99f649cb104541dc3f1e277c734d3::adapter::conf_wad(&arg2),
            spread_wad        : v8,
            twap_wad          : 0x4b49ecc34f16c410eddb89e7c3507af9a0a99f649cb104541dc3f1e277c734d3::adapter::twap_wad(&arg2),
            timestamp_ms      : v2,
            conf_timestamp_ms : 0x4b49ecc34f16c410eddb89e7c3507af9a0a99f649cb104541dc3f1e277c734d3::adapter::conf_timestamp_ms(&arg2),
            ask_wad           : v1 + v8,
            bid_wad           : v1 - v8,
            sequence          : 0x4b49ecc34f16c410eddb89e7c3507af9a0a99f649cb104541dc3f1e277c734d3::adapter::sequence(&arg2),
            slot              : 0x4b49ecc34f16c410eddb89e7c3507af9a0a99f649cb104541dc3f1e277c734d3::adapter::slot(&arg2),
            closed            : v6,
            in_band           : 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::safety::within_signed_band(v1, 0x4b49ecc34f16c410eddb89e7c3507af9a0a99f649cb104541dc3f1e277c734d3::adapter::signed_bid_wad(&arg2), 0x4b49ecc34f16c410eddb89e7c3507af9a0a99f649cb104541dc3f1e277c734d3::adapter::signed_ask_wad(&arg2), 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::min_spread_bps(&v0)),
            signed_mid_wad    : ((((0x4b49ecc34f16c410eddb89e7c3507af9a0a99f649cb104541dc3f1e277c734d3::adapter::signed_bid_wad(&arg2) as u256) + (0x4b49ecc34f16c410eddb89e7c3507af9a0a99f649cb104541dc3f1e277c734d3::adapter::signed_ask_wad(&arg2) as u256)) / 2) as u128),
        };
        0x4b49ecc34f16c410eddb89e7c3507af9a0a99f649cb104541dc3f1e277c734d3::adapter::destroy(arg2);
        v9
    }

    public fun begin_liquidation_price<T0>(arg0: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::Market<T0>, arg2: 0x4b49ecc34f16c410eddb89e7c3507af9a0a99f649cb104541dc3f1e277c734d3::adapter::VerifiedQuote, arg3: &0x2::clock::Clock) : PriceReceipt {
        begin<T0>(arg0, arg1, arg2, arg3)
    }

    public fun begin_price<T0>(arg0: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::market::Market<T0>, arg2: 0x4b49ecc34f16c410eddb89e7c3507af9a0a99f649cb104541dc3f1e277c734d3::adapter::VerifiedQuote, arg3: &0x2::clock::Clock) : PriceReceipt {
        begin<T0>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun bid_wad(arg0: &PriceReceipt) : u128 {
        arg0.bid_wad
    }

    fun check_time(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool) {
        if (0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::safety::timestamp_accepted(arg0, arg1, arg2, arg3)) {
            return
        } else if (arg0 > arg1) {
            assert!(arg4, 13835621885704142853);
            abort 13837592210541772815
        } else {
            assert!(arg4, 13835340419317235715);
            abort 13837310744154865677
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

