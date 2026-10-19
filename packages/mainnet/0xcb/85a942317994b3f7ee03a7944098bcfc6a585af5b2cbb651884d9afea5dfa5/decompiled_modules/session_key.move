module 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::session_key {
    struct GrantKey has copy, drop, store {
        owner: address,
    }

    struct Grant has copy, drop, store {
        session: address,
        expires_at_ms: u64,
        max_margin: u64,
        max_total_margin: u64,
        used_margin: u64,
        max_leverage: u64,
        nonce: u64,
        active: bool,
    }

    struct SessionAuthorizedV1 has copy, drop {
        meta: 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::Meta,
        owner: address,
        session: address,
        expires_at_ms: u64,
        max_margin: u64,
        max_total_margin: u64,
        max_leverage: u64,
        nonce: u64,
    }

    struct SessionRevokedV1 has copy, drop {
        meta: 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::Meta,
        owner: address,
        session: address,
        nonce: u64,
        expires_at_ms: u64,
    }

    struct SessionOrderV1 has copy, drop {
        engine: 0x2::object::ID,
        order: u64,
        owner: address,
        session: address,
        nonce: u64,
        closing: bool,
    }

    public(friend) fun assert_session<T0>(arg0: &0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::Exchange<T0>, arg1: address, arg2: address, arg3: &0x2::clock::Clock) : Grant {
        assert!(arg2 != arg1, 304);
        let v0 = grant_of<T0>(arg0, arg1);
        assert!(0x1::option::is_some<Grant>(&v0), 300);
        let v1 = 0x1::option::destroy_some<Grant>(v0);
        assert!(v1.active && v1.session == arg2, 300);
        assert!(0x2::clock::timestamp_ms(arg3) < v1.expires_at_ms, 301);
        v1
    }

    public fun authorize<T0>(arg0: &mut 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::Exchange<T0>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        assert!(arg1 != @0x0 && arg1 != v0, 303);
        assert!(arg2 > v1 && arg2 - v1 <= 2592000000, 303);
        let v2 = if (arg3 >= 1000000) {
            if (arg4 >= arg3) {
                if (arg5 >= 10) {
                    arg5 <= 1000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 302);
        let v3 = 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::session_uid_mut<T0>(arg0);
        let v4 = GrantKey{owner: v0};
        let v5 = if (0x2::dynamic_field::exists<GrantKey>(v3, v4)) {
            let v6 = 0x2::dynamic_field::remove<GrantKey, Grant>(v3, v4);
            v6.nonce + 1
        } else {
            1
        };
        let v7 = Grant{
            session          : arg1,
            expires_at_ms    : arg2,
            max_margin       : arg3,
            max_total_margin : arg4,
            used_margin      : 0,
            max_leverage     : arg5,
            nonce            : v5,
            active           : true,
        };
        0x2::dynamic_field::add<GrantKey, Grant>(v3, v4, v7);
        let v8 = SessionAuthorizedV1{
            meta             : 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::session_meta<T0>(arg0),
            owner            : v0,
            session          : arg1,
            expires_at_ms    : arg2,
            max_margin       : arg3,
            max_total_margin : arg4,
            max_leverage     : arg5,
            nonce            : v5,
        };
        0x2::event::emit<SessionAuthorizedV1>(v8);
    }

    public(friend) fun consume_open<T0>(arg0: &mut 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::Exchange<T0>, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : Grant {
        let v0 = assert_session<T0>(arg0, arg1, arg2, arg5);
        assert!(arg3 <= v0.max_margin && arg4 <= v0.max_leverage, 302);
        assert!(arg3 <= v0.max_total_margin - v0.used_margin, 302);
        let v1 = GrantKey{owner: arg1};
        let v2 = 0x2::dynamic_field::borrow_mut<GrantKey, Grant>(0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::session_uid_mut<T0>(arg0), v1);
        v2.used_margin = v2.used_margin + arg3;
        *v2
    }

    public(friend) fun emit_order(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: &Grant, arg4: bool) {
        let v0 = SessionOrderV1{
            engine  : arg0,
            order   : arg1,
            owner   : arg2,
            session : arg3.session,
            nonce   : arg3.nonce,
            closing : arg4,
        };
        0x2::event::emit<SessionOrderV1>(v0);
    }

    public fun grant_active(arg0: &Grant) : bool {
        arg0.active
    }

    public fun grant_expires_at_ms(arg0: &Grant) : u64 {
        arg0.expires_at_ms
    }

    public fun grant_max_leverage(arg0: &Grant) : u64 {
        arg0.max_leverage
    }

    public fun grant_max_margin(arg0: &Grant) : u64 {
        arg0.max_margin
    }

    public fun grant_max_total_margin(arg0: &Grant) : u64 {
        arg0.max_total_margin
    }

    public fun grant_nonce(arg0: &Grant) : u64 {
        arg0.nonce
    }

    public fun grant_of<T0>(arg0: &0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::Exchange<T0>, arg1: address) : 0x1::option::Option<Grant> {
        let v0 = 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::session_uid<T0>(arg0);
        let v1 = GrantKey{owner: arg1};
        if (0x2::dynamic_field::exists<GrantKey>(v0, v1)) {
            0x1::option::some<Grant>(*0x2::dynamic_field::borrow<GrantKey, Grant>(v0, v1))
        } else {
            0x1::option::none<Grant>()
        }
    }

    public fun grant_session(arg0: &Grant) : address {
        arg0.session
    }

    public fun grant_used_margin(arg0: &Grant) : u64 {
        arg0.used_margin
    }

    public fun is_authorized<T0>(arg0: &0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::Exchange<T0>, arg1: address, arg2: address, arg3: &0x2::clock::Clock) : bool {
        let v0 = grant_of<T0>(arg0, arg1);
        0x1::option::is_some<Grant>(&v0) && usable(0x1::option::borrow<Grant>(&v0), arg2, 0x2::clock::timestamp_ms(arg3))
    }

    public fun revoke<T0>(arg0: &mut 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::Exchange<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::session_uid_mut<T0>(arg0);
        let v2 = GrantKey{owner: v0};
        assert!(0x2::dynamic_field::exists<GrantKey>(v1, v2), 300);
        let v3 = 0x2::dynamic_field::borrow_mut<GrantKey, Grant>(v1, v2);
        assert!(v3.active, 300);
        v3.active = false;
        let v4 = SessionRevokedV1{
            meta          : 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange::session_meta<T0>(arg0),
            owner         : v0,
            session       : v3.session,
            nonce         : v3.nonce,
            expires_at_ms : v3.expires_at_ms,
        };
        0x2::event::emit<SessionRevokedV1>(v4);
    }

    fun usable(arg0: &Grant, arg1: address, arg2: u64) : bool {
        if (arg0.active) {
            if (arg0.session == arg1) {
                arg2 < arg0.expires_at_ms
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v7
}

