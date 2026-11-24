module 0xad10bcbe86821b165c2f40de2d156db16340073567853e66f1fc938da1733474::session {
    struct TradingSessionCap has key {
        id: 0x2::object::UID,
        principal: address,
        account_id: 0x2::object::ID,
        session_signer: address,
        expires_at_ms: u64,
        max_open_notional: u64,
        spent_open_notional: u64,
        max_order_notional: u64,
        can_open: bool,
        can_decrease: bool,
        can_cancel: bool,
        allowed_markets: 0x2::vec_set::VecSet<0x2::object::ID>,
        version: u64,
    }

    struct SessionTicket {
        principal: address,
        account_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        session_id: 0x2::object::ID,
        witness_type: 0x1::type_name::TypeName,
        action: u8,
        order_notional: u64,
    }

    struct SessionCreated has copy, drop {
        session_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        principal: address,
        session_signer: address,
        expires_at_ms: u64,
        max_open_notional: u64,
        max_order_notional: u64,
        can_open: bool,
        can_decrease: bool,
        can_cancel: bool,
        allowed_markets: vector<0x2::object::ID>,
    }

    struct SessionDestroyed has copy, drop {
        session_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        principal: address,
    }

    struct SessionTightened has copy, drop {
        session_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        expires_at_ms: u64,
        max_open_notional: u64,
        max_order_notional: u64,
        can_open: bool,
        can_decrease: bool,
        can_cancel: bool,
        allowed_markets: vector<0x2::object::ID>,
    }

    public fun id(arg0: &TradingSessionCap) : 0x2::object::ID {
        0x2::object::id<TradingSessionCap>(arg0)
    }

    public fun account_id(arg0: &TradingSessionCap) : 0x2::object::ID {
        arg0.account_id
    }

    public fun action_cancel() : u8 {
        2
    }

    public fun action_decrease() : u8 {
        1
    }

    public fun action_open() : u8 {
        0
    }

    public(friend) fun assert_session<T0>(arg0: &mut TradingSessionCap, arg1: address, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u8, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : SessionTicket {
        check_version(arg0);
        assert!(arg0.account_id == arg2, 1);
        assert!(arg0.principal == arg1, 2);
        assert!(0x2::tx_context::sender(arg7) == arg0.session_signer, 3);
        assert!(0x2::clock::timestamp_ms(arg6) < arg0.expires_at_ms, 4);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_markets, &arg3), 5);
        if (arg4 == 0) {
            assert!(arg0.can_open, 7);
            assert!(arg5 <= arg0.max_order_notional, 6);
            assert!(arg5 <= arg0.max_open_notional - arg0.spent_open_notional, 10);
            arg0.spent_open_notional = arg0.spent_open_notional + arg5;
        } else if (arg4 == 1) {
            assert!(arg0.can_decrease, 8);
        } else {
            assert!(arg4 == 2, 12);
            assert!(arg0.can_cancel, 9);
        };
        SessionTicket{
            principal      : arg0.principal,
            account_id     : arg0.account_id,
            market_id      : arg3,
            session_id     : 0x2::object::id<TradingSessionCap>(arg0),
            witness_type   : 0x1::type_name::with_defining_ids<T0>(),
            action         : arg4,
            order_notional : arg5,
        }
    }

    public fun can_cancel(arg0: &TradingSessionCap) : bool {
        arg0.can_cancel
    }

    public fun can_decrease(arg0: &TradingSessionCap) : bool {
        arg0.can_decrease
    }

    public fun can_open(arg0: &TradingSessionCap) : bool {
        arg0.can_open
    }

    fun check_version(arg0: &TradingSessionCap) {
        assert!(arg0.version <= 1, 18);
    }

    public fun destroy_session(arg0: TradingSessionCap, arg1: &0x2::tx_context::TxContext) {
        check_version(&arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.session_signer || v0 == arg0.principal, 13);
        let TradingSessionCap {
            id                  : v1,
            principal           : v2,
            account_id          : v3,
            session_signer      : _,
            expires_at_ms       : _,
            max_open_notional   : _,
            spent_open_notional : _,
            max_order_notional  : _,
            can_open            : _,
            can_decrease        : _,
            can_cancel          : _,
            allowed_markets     : _,
            version             : _,
        } = arg0;
        let v14 = v1;
        let v15 = SessionDestroyed{
            session_id : 0x2::object::uid_to_inner(&v14),
            account_id : v3,
            principal  : v2,
        };
        0x2::event::emit<SessionDestroyed>(v15);
        0x2::object::delete(v14);
    }

    public fun destroy_ticket(arg0: SessionTicket) {
        let SessionTicket {
            principal      : _,
            account_id     : _,
            market_id      : _,
            session_id     : _,
            witness_type   : _,
            action         : _,
            order_notional : _,
        } = arg0;
    }

    public fun expires_at_ms(arg0: &TradingSessionCap) : u64 {
        arg0.expires_at_ms
    }

    public fun is_market_allowed(arg0: &TradingSessionCap, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_markets, &arg1)
    }

    public fun max_open_notional(arg0: &TradingSessionCap) : u64 {
        arg0.max_open_notional
    }

    public fun max_order_notional(arg0: &TradingSessionCap) : u64 {
        arg0.max_order_notional
    }

    public fun migrate(arg0: &mut TradingSessionCap) {
        check_version(arg0);
        arg0.version = 1;
    }

    public(friend) fun new_session(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: vector<0x2::object::ID>, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : TradingSessionCap {
        assert!(arg4 > 0x2::clock::timestamp_ms(arg10), 11);
        let v0 = if (arg7) {
            true
        } else if (arg8) {
            true
        } else {
            arg9
        };
        assert!(v0, 16);
        assert!(!0x1::vector::is_empty<0x2::object::ID>(&arg3), 15);
        let v1 = 0x2::vec_set::empty<0x2::object::ID>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&arg3, v2);
            if (!0x2::vec_set::contains<0x2::object::ID>(&v1, &v3)) {
                0x2::vec_set::insert<0x2::object::ID>(&mut v1, v3);
            };
            v2 = v2 + 1;
        };
        let v4 = 0x2::object::new(arg11);
        let v5 = SessionCreated{
            session_id         : 0x2::object::uid_to_inner(&v4),
            account_id         : arg0,
            principal          : arg1,
            session_signer     : arg2,
            expires_at_ms      : arg4,
            max_open_notional  : arg5,
            max_order_notional : arg6,
            can_open           : arg7,
            can_decrease       : arg8,
            can_cancel         : arg9,
            allowed_markets    : *0x2::vec_set::keys<0x2::object::ID>(&v1),
        };
        0x2::event::emit<SessionCreated>(v5);
        TradingSessionCap{
            id                  : v4,
            principal           : arg1,
            account_id          : arg0,
            session_signer      : arg2,
            expires_at_ms       : arg4,
            max_open_notional   : arg5,
            spent_open_notional : 0,
            max_order_notional  : arg6,
            can_open            : arg7,
            can_decrease        : arg8,
            can_cancel          : arg9,
            allowed_markets     : v1,
            version             : 1,
        }
    }

    public fun package_version() : u64 {
        1
    }

    public fun principal(arg0: &TradingSessionCap) : address {
        arg0.principal
    }

    public fun refund_open_notional(arg0: &mut TradingSessionCap, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.principal, 13);
        assert!(arg1 <= arg0.spent_open_notional, 17);
        arg0.spent_open_notional = arg0.spent_open_notional - arg1;
    }

    public fun session_signer(arg0: &TradingSessionCap) : address {
        arg0.session_signer
    }

    public fun spent_open_notional(arg0: &TradingSessionCap) : u64 {
        arg0.spent_open_notional
    }

    public fun ticket_account_id(arg0: &SessionTicket) : 0x2::object::ID {
        arg0.account_id
    }

    public fun ticket_action(arg0: &SessionTicket) : u8 {
        arg0.action
    }

    public fun ticket_market_id(arg0: &SessionTicket) : 0x2::object::ID {
        arg0.market_id
    }

    public fun ticket_order_notional(arg0: &SessionTicket) : u64 {
        arg0.order_notional
    }

    public fun ticket_principal(arg0: &SessionTicket) : address {
        arg0.principal
    }

    public fun ticket_session_id(arg0: &SessionTicket) : 0x2::object::ID {
        arg0.session_id
    }

    public fun ticket_witness_type(arg0: &SessionTicket) : 0x1::type_name::TypeName {
        arg0.witness_type
    }

    public fun tighten_session(arg0: &mut TradingSessionCap, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: bool, arg7: vector<0x2::object::ID>, arg8: &0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(v0 == arg0.session_signer || v0 == arg0.principal, 13);
        assert!(arg1 <= arg0.expires_at_ms, 14);
        assert!(arg2 <= arg0.max_open_notional, 14);
        assert!(arg3 <= arg0.max_order_notional, 14);
        assert!(!arg4 || arg0.can_open, 14);
        assert!(!arg5 || arg0.can_decrease, 14);
        assert!(!arg6 || arg0.can_cancel, 14);
        assert!(arg0.spent_open_notional <= arg2, 10);
        arg0.expires_at_ms = arg1;
        arg0.max_open_notional = arg2;
        arg0.max_order_notional = arg3;
        arg0.can_open = arg4;
        arg0.can_decrease = arg5;
        arg0.can_cancel = arg6;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg7)) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&arg7, v1);
            if (0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_markets, &v2)) {
                0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allowed_markets, &v2);
            };
            v1 = v1 + 1;
        };
        let v3 = SessionTightened{
            session_id         : 0x2::object::id<TradingSessionCap>(arg0),
            account_id         : arg0.account_id,
            expires_at_ms      : arg0.expires_at_ms,
            max_open_notional  : arg0.max_open_notional,
            max_order_notional : arg0.max_order_notional,
            can_open           : arg0.can_open,
            can_decrease       : arg0.can_decrease,
            can_cancel         : arg0.can_cancel,
            allowed_markets    : *0x2::vec_set::keys<0x2::object::ID>(&arg0.allowed_markets),
        };
        0x2::event::emit<SessionTightened>(v3);
    }

    public(friend) fun transfer_session(arg0: TradingSessionCap, arg1: address) {
        0x2::transfer::transfer<TradingSessionCap>(arg0, arg1);
    }

    public fun version(arg0: &TradingSessionCap) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

