module 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::oracle {
    struct PriceReceipt {
        auth: 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth,
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

    struct FillPrice {
        receipt: PriceReceipt,
    }

    struct ExpiryPrice {
        receipt: PriceReceipt,
        signed: bool,
    }

    public(friend) fun timestamp_ms(arg0: &PriceReceipt) : u64 {
        arg0.timestamp_ms
    }

    fun arm_inner<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: PriceReceipt, arg4: &0x2::clock::Clock, arg5: bool) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::assert_version<T0>(arg0);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg1);
        assert!(arg3.market_id == 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(arg0), 13838156204172509203);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::assert_exchange<T0>(arg0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>>(arg1));
        assert!(arg3.closed, 13837874737785602065);
        let v0 = arg3.timestamp_ms;
        let v1 = arg3.conf_timestamp_ms;
        let v2 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::last_oracle_ts_ms<T0>(arg0);
        assert!(0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::safety::session_snapshot_monotonic(v0, v2, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::closed_seen_ts_ms<T0>(arg0), false, 0), 13838437717804056597);
        assert!(v0 >= v1, 13838437734983925781);
        assert!(message_timestamp_ms(&arg3) >= v2, 13838437739278893077);
        let v3 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::session_close<T0>(arg0);
        let v4 = 0x1::option::is_some<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::SessionCloseV1>(&v3);
        let v5 = if (v4) {
            let v6 = 0x1::option::borrow<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::SessionCloseV1>(&v3);
            assert!(!0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::safety::session_pending(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::sc_armed(v6), 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::sc_remaining(v6)), 13839000710707413017);
            0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::sc_ts_ms(v6)
        } else {
            0
        };
        assert!(0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::safety::session_snapshot_monotonic(v1, 0, 0, v4, v5), 13838437773638631445);
        let v7 = 0x2::clock::timestamp_ms(arg4);
        assert!(0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::safety::session_gap_ok(v1, v7, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::force_close_min_gap_ms(arg2)), 13838719257205407767);
        let v8 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::liq<T0>(arg0);
        let v9 = 0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::liq_book::side_size(v8, true) + 0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::liq_book::side_size(v8, false);
        let v10 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::next_position_id<T0>(arg1);
        let v11 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::oracle<T0>(arg0);
        assert!(!arg5 || 0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::safety::timestamp_accepted(message_timestamp_ms(&arg3), v7, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::max_conf_age_ms(&v11), 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::max_future_ms(&v11)), 13837311916680937485);
        let v12 = arg3.price_wad;
        let v13 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue_on<T0>(arg2, arg1);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::arm_session_close<T0>(&v13, arg0, v12, v1, arg3.sequence, v10, v9);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::note_session_closed<T0>(&v13, arg0, v0);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_session_armed_event(&v13, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(arg0), v12, v1, v10, v9);
        discard_price(arg3);
    }

    public fun arm_session_close<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: PriceReceipt, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg2);
        assert!(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::is_order_keeper(arg2, 0x2::tx_context::sender(arg5)), 13839563351423451165);
        arm_inner<T0>(arg0, arg1, arg2, arg3, arg4, true);
    }

    public fun arm_session_close_admin<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg4: PriceReceipt, arg5: &0x2::clock::Clock) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg2);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::assert_admin(0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg2), arg3);
        arm_inner<T0>(arg0, arg1, arg2, arg4, arg5, false);
    }

    public(friend) fun ask_wad(arg0: &PriceReceipt) : u128 {
        arg0.price_wad + one_step_spread(arg0)
    }

    fun begin<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: 0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::VerifiedQuote, arg3: &0x2::clock::Clock) : PriceReceipt {
        assert!(!0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::timestamp_window(&arg2), 13840406973194960929);
        let v0 = bind<T0>(arg0, arg1, arg2, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0)), true);
        assert!(v0.price_wad > 0, 13836184857132531719);
        let v1 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::oracle<T0>(arg1);
        let v2 = v0.timestamp_ms;
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::max_age_ms(&v1);
        let v5 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::max_future_ms(&v1);
        if (v2 > v3 && !0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::safety::timestamp_accepted(v2, v3, v4, v5)) {
            abort 13835621937243750405
        };
        if (!v0.closed) {
            check_time(v2, v3, v4, v5, false);
            check_time(v0.conf_timestamp_ms, v3, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::max_conf_age_ms(&v1), v5, true);
        };
        v0
    }

    public fun begin_expiry_price<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: 0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::VerifiedQuote) : ExpiryPrice {
        ExpiryPrice{
            receipt : bind<T0>(arg0, arg1, arg2, 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue_refund_for_market<T0>(arg0, arg1), false),
            signed  : true,
        }
    }

    public fun begin_expiry_price_storage<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage) : ExpiryPrice {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg0);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::assert_version<T0>(arg1);
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::oracle<T0>(arg1);
        let v1 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::source_id(&v0);
        let (v2, v3, v4) = 0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::read_storage(arg2, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::storage_id(&v0), v1);
        assert!(0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::from(0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::price_feed(arg2, (v1 as u16))) == 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::feed_info_id(&v0), 13836466774491004937);
        let v5 = PriceReceipt{
            auth              : 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue_refund_for_market<T0>(arg0, arg1),
            market_id         : 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(arg1),
            price_wad         : v2,
            conf_wad          : 0,
            spread_wad        : 0,
            twap_wad          : v3,
            timestamp_ms      : v4,
            conf_timestamp_ms : v4,
            at_mid            : true,
            sequence          : 0,
            slot              : v4,
            closed            : false,
        };
        ExpiryPrice{
            receipt : v5,
            signed  : false,
        }
    }

    public fun begin_fill_price<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: 0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::SignedQuote, arg3: &0x2::clock::Clock) : FillPrice {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg0);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::assert_version<T0>(arg1);
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::oracle<T0>(arg1);
        assert!(0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::signed_storage_id(&arg2) == 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::storage_id(&v0), 13836465941267349513);
        assert!(0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::signed_feed_info_id(&arg2) == 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::feed_info_id(&v0), 13836465945562316809);
        assert!(0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::signed_source_id(&arg2) == 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::source_id(&v0), 13836465949857284105);
        assert!(0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::signed_feed_id(&arg2) == 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::lazer_feed_id(&v0), 13836465954152251401);
        let v1 = 0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::signed_price_wad(&arg2);
        assert!(v1 > 0, 13836184487765344263);
        let v2 = 0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::signed_price_timestamp_ms(&arg2);
        let v3 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::hours_mode<T0>(arg1) == 1;
        assert!(!v3 || 0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::signed_session_present(&arg2), 13840688100279451683);
        let v4 = v3 && 0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::signed_session_closed(&arg2);
        if (!v4) {
            check_time(v2, 0x2::clock::timestamp_ms(arg3), 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::max_age_ms(&v0), 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::max_future_ms(&v0), false);
        };
        let v5 = PriceReceipt{
            auth              : 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0)),
            market_id         : 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(arg1),
            price_wad         : v1,
            conf_wad          : 0x1::option::destroy_with_default<u128>(0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::signed_conf_wad(&arg2), 0),
            spread_wad        : 0,
            twap_wad          : 0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::signed_twap_wad(&arg2),
            timestamp_ms      : v2,
            conf_timestamp_ms : v2,
            at_mid            : true,
            sequence          : 0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::signed_sequence(&arg2),
            slot              : 0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::signed_storage_timestamp_ms(&arg2),
            closed            : v4,
        };
        0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::destroy_signed(arg2);
        FillPrice{receipt: v5}
    }

    public fun begin_liquidation_price<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: 0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::VerifiedQuote, arg3: &0x2::clock::Clock) : PriceReceipt {
        begin<T0>(arg0, arg1, arg2, arg3)
    }

    public fun begin_price<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: 0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::VerifiedQuote, arg3: &0x2::clock::Clock) : PriceReceipt {
        begin<T0>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun bid_wad(arg0: &PriceReceipt) : u128 {
        arg0.price_wad - one_step_spread(arg0)
    }

    fun bind<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg2: 0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::VerifiedQuote, arg3: 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg4: bool) : PriceReceipt {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg0);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::assert_version<T0>(arg1);
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::oracle<T0>(arg1);
        assert!(0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::storage_id(&arg2) == 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::storage_id(&v0), 13836466465253359625);
        assert!(0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::feed_info_id(&arg2) == 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::feed_info_id(&v0), 13836466469548326921);
        assert!(0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::source_id(&arg2) == 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::source_id(&v0), 13836466473843294217);
        assert!(0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::feed_id(&arg2) == 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::lazer_feed_id(&v0), 13836466478138261513);
        let v1 = 0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::price_wad(&arg2);
        let v2 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::hours_mode<T0>(arg1) == 1;
        let v3 = if (!arg4) {
            true
        } else if (!v2) {
            true
        } else {
            0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::session_present(&arg2)
        };
        assert!(v3, 13840688615675527203);
        let v4 = v2 && 0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::session_closed(&arg2);
        let v5 = 0x1::option::destroy_with_default<u128>(0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::conf_wad(&arg2), 0);
        let v6 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::order_params<T0>(arg1);
        let v7 = PriceReceipt{
            auth              : arg3,
            market_id         : 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(arg1),
            price_wad         : v1,
            conf_wad          : v5,
            spread_wad        : 0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::position::charged_spread(v1, v5, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::one_step_spread_bps(&v6)),
            twap_wad          : 0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::twap_wad(&arg2),
            timestamp_ms      : 0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::price_timestamp_ms(&arg2),
            conf_timestamp_ms : 0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::conf_timestamp_ms(&arg2),
            at_mid            : false,
            sequence          : 0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::sequence(&arg2),
            slot              : 0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::slot(&arg2),
            closed            : v4,
        };
        0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter::destroy(arg2);
        v7
    }

    fun check_time(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool) {
        if (0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::safety::timestamp_accepted(arg0, arg1, arg2, arg3)) {
            return
        } else if (arg0 > arg1) {
            assert!(arg4, 13835623388942696453);
            abort 13837593713780326415
        } else {
            assert!(arg4, 13835341922555789315);
            abort 13837312247393419277
        };
    }

    public(friend) fun conf_timestamp_ms(arg0: &PriceReceipt) : u64 {
        arg0.conf_timestamp_ms
    }

    public(friend) fun conf_wad(arg0: &PriceReceipt) : u128 {
        arg0.conf_wad
    }

    public fun disarm_session_close<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg2);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::assert_admin(0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg2), arg3);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::assert_version<T0>(arg0);
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue_on<T0>(arg2, arg1);
        let v1 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::disarm_session_close<T0>(&v0, arg0);
        if (0x1::option::is_some<u64>(&v1)) {
            let v2 = 0x1::option::destroy_some<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::SessionCloseV1>(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::session_close<T0>(arg0));
            0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_session_disarmed_event(&v0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(arg0), 0x1::option::destroy_some<u64>(v1), 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::sc_closed_count(&v2));
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
            at_mid            : _,
            sequence          : _,
            slot              : _,
            closed            : _,
        } = arg0;
    }

    public(friend) fun expiry_is_signed(arg0: &ExpiryPrice) : bool {
        arg0.signed
    }

    public(friend) fun expiry_receipt(arg0: ExpiryPrice) : PriceReceipt {
        let ExpiryPrice {
            receipt : v0,
            signed  : _,
        } = arg0;
        v0
    }

    public(friend) fun fill_receipt(arg0: FillPrice) : PriceReceipt {
        let FillPrice { receipt: v0 } = arg0;
        v0
    }

    public(friend) fun is_closed(arg0: &PriceReceipt) : bool {
        arg0.closed
    }

    public(friend) fun market_id(arg0: &PriceReceipt) : 0x2::object::ID {
        arg0.market_id
    }

    public(friend) fun message_ms(arg0: &PriceReceipt) : u64 {
        message_timestamp_ms(arg0)
    }

    fun message_timestamp_ms(arg0: &PriceReceipt) : u64 {
        arg0.sequence / 1000
    }

    public fun note_session_closed<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: PriceReceipt) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::assert_version<T0>(arg0);
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue_on<T0>(arg2, arg1);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_unpaused(arg2, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::pause_closes());
        assert!(!0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::closes_paused<T0>(arg0), 13839844671781470239);
        assert!(!0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::oracle_killed<T0>(arg0), 13839281726122754075);
        assert!(arg3.market_id == 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(arg0), 13838155830510354451);
        assert!(arg3.closed, 13837874359828480017);
        assert!(arg3.timestamp_ms >= 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::last_oracle_ts_ms<T0>(arg0), 13838437314077130773);
        assert!(arg3.timestamp_ms >= 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::closed_seen_ts_ms<T0>(arg0), 13838437318372098069);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::note_session_closed<T0>(&v0, arg0, arg3.timestamp_ms);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_note_session_closed_event(&v0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>>(arg0), arg3.timestamp_ms);
        discard_price(arg3);
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

