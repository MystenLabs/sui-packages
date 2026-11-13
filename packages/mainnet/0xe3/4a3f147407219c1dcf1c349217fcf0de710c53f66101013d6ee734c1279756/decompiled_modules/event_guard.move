module 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::event_guard {
    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct GuardKey has copy, drop, store {
        market_id: 0x2::object::ID,
    }

    struct EventGuardV1 has copy, drop, store {
        pause_until_ms: u64,
        pause_reason: u8,
        max_leverage: u64,
        lev_until_ms: u64,
        lev_reason: u8,
    }

    struct EventPauseUpdatedEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        until_ms: u64,
        reason: u8,
        sender: address,
        admin: bool,
    }

    struct EventLeverageCapUpdatedEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        max_leverage: u64,
        until_ms: u64,
        reason: u8,
        sender: address,
        admin: bool,
    }

    struct EventCloseArmedEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        reason: u8,
        price_wad: u128,
        ts_ms: u64,
        watermark: u64,
        remaining: u64,
        pause_until_ms: u64,
        sender: address,
    }

    fun empty() : EventGuardV1 {
        EventGuardV1{
            pause_until_ms : 0,
            pause_reason   : 0,
            max_leverage   : 0,
            lev_until_ms   : 0,
            lev_reason     : 0,
        }
    }

    public fun admin_clear<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::AuthorityCap<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::PACKAGE, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::ADMIN>, arg4: &0x2::tx_context::TxContext) {
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_version(arg2);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::assert_admin(0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config>(arg2), arg3);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_exchange<T0>(arg1, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0));
        clear_pause<T0>(arg0, arg1, arg2, arg4, true);
        clear_lev<T0>(arg0, arg1, arg2, arg4, true);
    }

    public fun arm_event_close<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::AuthorityCap<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::PACKAGE, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::MARKET_KEEPER>, arg4: 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::PriceReceipt, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_keeper<T0>(arg1, arg0, arg2, arg3);
        let v0 = guard<T0>(arg1, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg0));
        assert!(v0.pause_until_ms > 0x2::clock::timestamp_ms(arg5), 13836466297749766155);
        assert!(0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::market_id(&arg4) == 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg0), 13836747777021575181);
        assert!(!0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::is_closed(&arg4), 13837029256293384207);
        let v1 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::conf_timestamp_ms(&arg4);
        assert!(v1 > 0, 13837592232016871443);
        let v2 = v1 - 1;
        let v3 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::session_close<T0>(arg0);
        let v4 = 0x1::option::is_some<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::SessionCloseV1>(&v3);
        let v5 = if (v4) {
            let v6 = 0x1::option::borrow<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::SessionCloseV1>(&v3);
            assert!(!0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::session_pending<T0>(arg0), 13837310782809833489);
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::sc_ts_ms(v6)
        } else {
            0
        };
        assert!(0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::timestamp_ms(&arg4) >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::last_oracle_ts_ms<T0>(arg0) && (!v4 || v2 > v5), 13837592283556478995);
        let v7 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::liq<T0>(arg0);
        let v8 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::side_size(v7, true) + 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::side_size(v7, false);
        let v9 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::next_position_id<T0>(arg1);
        let v10 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::price_wad(&arg4);
        let v11 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue_on<T0>(arg2, arg1);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::arm_session_close<T0>(&v11, arg0, v10, v2, 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::sequence(&arg4), v9, v8);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_session_armed_event(&v11, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg0), v10, v2, v9, v8);
        let v12 = EventCloseArmedEventV1{
            market_id      : 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg0),
            reason         : v0.pause_reason,
            price_wad      : v10,
            ts_ms          : v2,
            watermark      : v9,
            remaining      : v8,
            pause_until_ms : v0.pause_until_ms,
            sender         : 0x2::tx_context::sender(arg6),
        };
        let v13 = Event<EventCloseArmedEventV1>{pos0: v12};
        0x2::event::emit<Event<EventCloseArmedEventV1>>(v13);
        0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::oracle::discard_price(arg4);
    }

    fun assert_keeper<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::AuthorityCap<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::PACKAGE, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::MARKET_KEEPER>) {
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_version(arg2);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_version<T0>(arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_version<T0>(arg1);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::assert_role<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::MARKET_KEEPER>(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::uid(arg2), 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config>(arg2), arg3);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::assert_exchange<T0>(arg1, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0));
    }

    public(friend) fun assert_open_allowed<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        assert!(!opens_blocked<T0>(arg0, arg1, arg3), 13835903721458237447);
        assert!(leverage_ok<T0>(arg0, arg1, arg2, arg3), 13836185200730046473);
    }

    fun assert_window(arg0: u8, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg0 <= 3, 13835059360952221697);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1 > v0 && arg1 - v0 <= 86400000, 13835340844518998019);
    }

    public fun clear_event_leverage_cap<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::AuthorityCap<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::PACKAGE, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::MARKET_KEEPER>, arg4: &0x2::tx_context::TxContext) {
        assert_keeper<T0>(arg0, arg1, arg2, arg3);
        clear_lev<T0>(arg0, arg1, arg2, arg4, false);
    }

    public fun clear_event_pause<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::AuthorityCap<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::PACKAGE, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::MARKET_KEEPER>, arg4: &0x2::tx_context::TxContext) {
        assert_keeper<T0>(arg0, arg1, arg2, arg3);
        clear_pause<T0>(arg0, arg1, arg2, arg4, false);
    }

    fun clear_lev<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg3: &0x2::tx_context::TxContext, arg4: bool) {
        let v0 = guard_mut<T0>(arg0, arg1, arg2);
        v0.max_leverage = 0;
        v0.lev_until_ms = 0;
        v0.lev_reason = 0;
        emit_lev<T0>(arg1, 0, 0, 0, arg3, arg4);
    }

    fun clear_pause<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg3: &0x2::tx_context::TxContext, arg4: bool) {
        let v0 = guard_mut<T0>(arg0, arg1, arg2);
        v0.pause_until_ms = 0;
        v0.pause_reason = 0;
        emit_pause<T0>(arg1, 0, 0, arg3, arg4);
    }

    fun emit_lev<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg1: u64, arg2: u64, arg3: u8, arg4: &0x2::tx_context::TxContext, arg5: bool) {
        let v0 = EventLeverageCapUpdatedEventV1{
            market_id    : 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg0),
            max_leverage : arg1,
            until_ms     : arg2,
            reason       : arg3,
            sender       : 0x2::tx_context::sender(arg4),
            admin        : arg5,
        };
        let v1 = Event<EventLeverageCapUpdatedEventV1>{pos0: v0};
        0x2::event::emit<Event<EventLeverageCapUpdatedEventV1>>(v1);
    }

    fun emit_pause<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg1: u64, arg2: u8, arg3: &0x2::tx_context::TxContext, arg4: bool) {
        let v0 = EventPauseUpdatedEventV1{
            market_id : 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg0),
            until_ms  : arg1,
            reason    : arg2,
            sender    : 0x2::tx_context::sender(arg3),
            admin     : arg4,
        };
        let v1 = Event<EventPauseUpdatedEventV1>{pos0: v0};
        0x2::event::emit<Event<EventPauseUpdatedEventV1>>(v1);
    }

    public fun event_leverage_cap<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : 0x1::option::Option<u64> {
        let v0 = guard<T0>(arg0, arg1);
        if (v0.lev_until_ms > 0x2::clock::timestamp_ms(arg2)) {
            0x1::option::some<u64>(v0.max_leverage)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun event_pause_until<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : 0x1::option::Option<u64> {
        let v0 = guard<T0>(arg0, arg1);
        if (v0.pause_until_ms > 0x2::clock::timestamp_ms(arg2)) {
            0x1::option::some<u64>(v0.pause_until_ms)
        } else {
            0x1::option::none<u64>()
        }
    }

    fun guard<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: 0x2::object::ID) : EventGuardV1 {
        let v0 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0);
        let v1 = GuardKey{market_id: arg1};
        if (0x2::dynamic_field::exists_with_type<GuardKey, EventGuardV1>(v0, v1)) {
            *0x2::dynamic_field::borrow<GuardKey, EventGuardV1>(v0, v1)
        } else {
            empty()
        }
    }

    fun guard_mut<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config) : &mut EventGuardV1 {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue_on<T0>(arg2, arg0);
        let v1 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid_mut<T0>(&v0, arg0);
        let v2 = GuardKey{market_id: 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>>(arg1)};
        if (!0x2::dynamic_field::exists_with_type<GuardKey, EventGuardV1>(v1, v2)) {
            0x2::dynamic_field::add<GuardKey, EventGuardV1>(v1, v2, empty());
        };
        0x2::dynamic_field::borrow_mut<GuardKey, EventGuardV1>(v1, v2)
    }

    public fun guard_state<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: 0x2::object::ID) : (u64, u8, u64, u64, u8) {
        let v0 = guard<T0>(arg0, arg1);
        (v0.pause_until_ms, v0.pause_reason, v0.max_leverage, v0.lev_until_ms, v0.lev_reason)
    }

    public(friend) fun leverage_ok<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64) : bool {
        let v0 = guard<T0>(arg0, arg1);
        v0.lev_until_ms <= arg3 || arg2 <= v0.max_leverage
    }

    public fun max_window_ms() : u64 {
        86400000
    }

    public(friend) fun opens_blocked<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: 0x2::object::ID, arg2: u64) : bool {
        let v0 = guard<T0>(arg0, arg1);
        v0.pause_until_ms > arg2
    }

    public fun set_event_leverage_cap<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::AuthorityCap<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::PACKAGE, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::MARKET_KEEPER>, arg4: u64, arg5: u8, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_keeper<T0>(arg0, arg1, arg2, arg3);
        assert_window(arg5, arg6, arg7);
        let v0 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::risk<T0>(arg1);
        let v1 = if (arg4 >= 1) {
            if (arg4 >= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::min_leverage(&v0)) {
                arg4 <= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::max_leverage(&v0)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 13835621688135647237);
        let v2 = guard_mut<T0>(arg0, arg1, arg2);
        v2.max_leverage = arg4;
        v2.lev_until_ms = arg6;
        v2.lev_reason = arg5;
        emit_lev<T0>(arg1, arg4, arg6, arg5, arg8, false);
    }

    public fun set_event_pause<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::AuthorityCap<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::PACKAGE, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::MARKET_KEEPER>, arg4: u8, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_keeper<T0>(arg0, arg1, arg2, arg3);
        assert_window(arg4, arg5, arg6);
        let v0 = guard_mut<T0>(arg0, arg1, arg2);
        v0.pause_until_ms = arg5;
        v0.pause_reason = arg4;
        emit_pause<T0>(arg1, arg5, arg4, arg7, false);
    }

    // decompiled from Move bytecode v7
}

