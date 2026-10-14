module 0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::agent_session {
    struct AgentSession has key {
        id: 0x2::object::UID,
        owner: address,
        session_address: address,
        escrow: 0x2::balance::Balance<0x2::sui::SUI>,
        spent: u64,
        spend_cap: u64,
        expiry_ms: u64,
        revoked: bool,
        lifetime_spent: u64,
        lifetime_cap: u64,
        version: u64,
    }

    struct TradeTicket {
        session_id: 0x2::object::ID,
        borrowed: u64,
        kind: u8,
    }

    struct SessionOpened has copy, drop {
        session_id: 0x2::object::ID,
        owner: address,
        session_address: address,
        deposit: u64,
        spend_cap: u64,
        expiry_ms: u64,
        lifetime_cap: u64,
    }

    struct LifetimeCapChanged has copy, drop {
        session_id: 0x2::object::ID,
        old_cap: u64,
        new_cap: u64,
    }

    struct SessionMigrated has copy, drop {
        session_id: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
    }

    struct SessionToppedUp has copy, drop {
        session_id: 0x2::object::ID,
        amount: u64,
        new_escrow: u64,
    }

    struct SessionBuy has copy, drop {
        session_id: 0x2::object::ID,
        sui_spent: u64,
        spent_total: u64,
    }

    struct SessionSell has copy, drop {
        session_id: 0x2::object::ID,
        sui_received: u64,
        new_escrow: u64,
    }

    struct SessionClosed has copy, drop {
        session_id: 0x2::object::ID,
        refunded: u64,
    }

    struct SessionBuyV2 has copy, drop {
        session_id: 0x2::object::ID,
        sui_spent: u64,
        spent_total: u64,
        escrow_after: u64,
        universal: bool,
    }

    struct SessionSellV2 has copy, drop {
        session_id: 0x2::object::ID,
        sui_received: u64,
        spent_total: u64,
        escrow_after: u64,
        universal: bool,
    }

    struct UniversalTradingToggled has copy, drop {
        session_id: 0x2::object::ID,
        enabled: bool,
    }

    struct SessionAttested has copy, drop {
        session_id: 0x2::object::ID,
        session_address: address,
        registry_id: 0x2::object::ID,
    }

    fun assert_can_trade(arg0: &AgentSession, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.session_address, 1);
        assert!(!arg0.revoked, 2);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.expiry_ms, 3);
    }

    fun assert_session_version(arg0: &AgentSession) {
        assert!(arg0.version == 1, 18);
    }

    fun assert_spend_allowed(arg0: &AgentSession, arg1: u64) {
        assert!((arg0.spent as u128) + (arg1 as u128) <= (arg0.spend_cap as u128), 4);
        assert!((arg0.lifetime_spent as u128) + (arg1 as u128) <= (arg0.lifetime_cap as u128), 13);
    }

    public fun borrow_for_buy(arg0: &mut AgentSession, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, TradeTicket) {
        assert_session_version(arg0);
        assert_can_trade(arg0, arg2, arg3);
        assert!(universal_trading_enabled(arg0), 11);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.escrow) >= arg1, 5);
        assert_spend_allowed(arg0, arg1);
        arg0.spent = arg0.spent + arg1;
        arg0.lifetime_spent = arg0.lifetime_spent + arg1;
        let v0 = TradeTicket{
            session_id : 0x2::object::id<AgentSession>(arg0),
            borrowed   : arg1,
            kind       : 0,
        };
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.escrow, arg1), arg3), v0)
    }

    public fun borrow_tokens_for_sell<T0>(arg0: &mut AgentSession, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, TradeTicket) {
        assert_session_version(arg0);
        assert_can_trade(arg0, arg2, arg3);
        assert!(universal_trading_enabled(arg0), 11);
        let v0 = TradeTicket{
            session_id : 0x2::object::id<AgentSession>(arg0),
            borrowed   : arg1,
            kind       : 1,
        };
        (0x2::coin::split<T0>(0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>()), arg1, arg3), v0)
    }

    public fun buy_with_session<T0>(arg0: &mut AgentSession, arg1: &mut 0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>, arg2: u64, arg3: u64, arg4: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::PriceConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_session_version(arg0);
        assert_can_trade(arg0, arg5, arg6);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.escrow) >= arg2, 5);
        assert_spend_allowed(arg0, arg2);
        let (v0, v1) = 0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::buy<T0>(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.escrow, arg2), arg6), arg3, 0x1::option::none<address>(), arg4, arg5, arg6);
        let v2 = v1;
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&v2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.escrow, 0x2::coin::into_balance<0x2::sui::SUI>(v2));
        park_tokens<T0>(arg0, v0);
        arg0.spent = arg0.spent + arg2;
        credit_spent(arg0, v3);
        arg0.lifetime_spent = arg0.lifetime_spent + arg2 - v3;
        let v4 = SessionBuy{
            session_id  : 0x2::object::id<AgentSession>(arg0),
            sui_spent   : arg2 - v3,
            spent_total : arg0.spent,
        };
        0x2::event::emit<SessionBuy>(v4);
        let v5 = SessionBuyV2{
            session_id   : 0x2::object::id<AgentSession>(arg0),
            sui_spent    : arg2 - v3,
            spent_total  : arg0.spent,
            escrow_after : 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow),
            universal    : false,
        };
        0x2::event::emit<SessionBuyV2>(v5);
    }

    public fun close_session(arg0: &mut AgentSession, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 6);
        assert!(!is_closed(arg0), 17);
        arg0.revoked = true;
        arg0.expiry_ms = 0;
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow);
        let v1 = SessionClosed{
            session_id : 0x2::object::id<AgentSession>(arg0),
            refunded   : v0,
        };
        0x2::event::emit<SessionClosed>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.escrow, v0), arg1)
    }

    fun credit_spent(arg0: &mut AgentSession, arg1: u64) {
        let v0 = if (arg1 > arg0.spent) {
            arg0.spent
        } else {
            arg1
        };
        arg0.spent = arg0.spent - v0;
    }

    public fun current_version() : u64 {
        1
    }

    fun default_lifetime_cap(arg0: u64) : u64 {
        let v0 = (arg0 as u128) * (5 as u128);
        let v1 = 18446744073709551615;
        if (v0 > v1) {
            (v1 as u64)
        } else {
            (v0 as u64)
        }
    }

    public fun disable_universal_trading(arg0: &mut AgentSession, arg1: &0x2::tx_context::TxContext) {
        assert_session_version(arg0);
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 6);
        if (0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"universal_trading")) {
            0x2::dynamic_field::remove<vector<u8>, bool>(&mut arg0.id, b"universal_trading");
        };
        let v0 = UniversalTradingToggled{
            session_id : 0x2::object::id<AgentSession>(arg0),
            enabled    : false,
        };
        0x2::event::emit<UniversalTradingToggled>(v0);
    }

    public fun enable_universal_trading(arg0: &mut AgentSession, arg1: &0x2::tx_context::TxContext) {
        assert_session_version(arg0);
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 6);
        if (!0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"universal_trading")) {
            0x2::dynamic_field::add<vector<u8>, bool>(&mut arg0.id, b"universal_trading", true);
        };
        let v0 = UniversalTradingToggled{
            session_id : 0x2::object::id<AgentSession>(arg0),
            enabled    : true,
        };
        0x2::event::emit<UniversalTradingToggled>(v0);
    }

    public fun escrow_value(arg0: &AgentSession) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.escrow)
    }

    public fun expire_refund(arg0: &mut AgentSession, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        if (is_closed(arg0)) {
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.escrow) > 0, 17);
        } else {
            assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expiry_ms, 7);
        };
        arg0.revoked = true;
        arg0.expiry_ms = 0;
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.escrow, v0), arg2), arg0.owner);
        let v1 = SessionClosed{
            session_id : 0x2::object::id<AgentSession>(arg0),
            refunded   : v0,
        };
        0x2::event::emit<SessionClosed>(v1);
    }

    public fun expiry_ms(arg0: &AgentSession) : u64 {
        arg0.expiry_ms
    }

    public fun is_closed(arg0: &AgentSession) : bool {
        arg0.expiry_ms == 0
    }

    public fun lifetime_cap(arg0: &AgentSession) : u64 {
        arg0.lifetime_cap
    }

    public fun lifetime_spent(arg0: &AgentSession) : u64 {
        arg0.lifetime_spent
    }

    public fun migrate_session(arg0: &mut AgentSession) {
        assert!(arg0.version < 1, 18);
        arg0.version = 1;
        let v0 = SessionMigrated{
            session_id   : 0x2::object::id<AgentSession>(arg0),
            from_version : arg0.version,
            to_version   : 1,
        };
        0x2::event::emit<SessionMigrated>(v0);
    }

    public fun open_and_share(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<AgentSession>(open_session(arg0, arg1, arg2, arg3, arg4, arg5, arg6));
    }

    public fun open_and_share_attested(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::enclave_registry::EnclaveRegistry, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::enclave_registry::is_registered(arg5, arg1), 12);
        let v0 = open_session(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        let v1 = SessionAttested{
            session_id      : 0x2::object::id<AgentSession>(&v0),
            session_address : arg1,
            registry_id     : 0x2::object::id<0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::enclave_registry::EnclaveRegistry>(arg5),
        };
        0x2::event::emit<SessionAttested>(v1);
        0x2::transfer::share_object<AgentSession>(v0);
    }

    fun open_session(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : AgentSession {
        assert!(arg3 > 0, 8);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg3 > v0, 16);
        assert!(arg3 <= v0 + 2592000000, 16);
        assert!(arg2 > 0, 15);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v3 = if (arg4 > 0) {
            arg4
        } else {
            default_lifetime_cap(v2)
        };
        let v4 = AgentSession{
            id              : 0x2::object::new(arg6),
            owner           : v1,
            session_address : arg1,
            escrow          : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            spent           : 0,
            spend_cap       : arg2,
            expiry_ms       : arg3,
            revoked         : false,
            lifetime_spent  : 0,
            lifetime_cap    : v3,
            version         : 1,
        };
        let v5 = SessionOpened{
            session_id      : 0x2::object::id<AgentSession>(&v4),
            owner           : v1,
            session_address : arg1,
            deposit         : v2,
            spend_cap       : arg2,
            expiry_ms       : arg3,
            lifetime_cap    : v3,
        };
        0x2::event::emit<SessionOpened>(v5);
        v4
    }

    public fun owner(arg0: &AgentSession) : address {
        arg0.owner
    }

    fun park_tokens<T0>(arg0: &mut AgentSession, arg1: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::dynamic_object_field::exists<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::coin::join<T0>(0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.id, v0), arg1);
        } else {
            0x2::dynamic_object_field::add<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.id, v0, arg1);
        };
    }

    public fun parked_balance<T0>(arg0: &AgentSession) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::dynamic_object_field::exists<0x1::type_name::TypeName>(&arg0.id, v0)) {
            return 0
        };
        0x2::coin::value<T0>(0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&arg0.id, v0))
    }

    public fun revoke_session(arg0: &mut AgentSession, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 6);
        arg0.revoked = true;
    }

    public fun revoked(arg0: &AgentSession) : bool {
        arg0.revoked
    }

    public fun sell_with_session<T0>(arg0: &mut AgentSession, arg1: &mut 0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_session_version(arg0);
        assert_can_trade(arg0, arg4, arg5);
        let v0 = 0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::sell<T0>(arg1, 0x2::coin::split<T0>(0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>()), arg2, arg5), arg3, 0x1::option::none<address>(), arg5);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.escrow, 0x2::coin::into_balance<0x2::sui::SUI>(v0));
        credit_spent(arg0, v1);
        let v2 = SessionSell{
            session_id   : 0x2::object::id<AgentSession>(arg0),
            sui_received : v1,
            new_escrow   : 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow),
        };
        0x2::event::emit<SessionSell>(v2);
        let v3 = SessionSellV2{
            session_id   : 0x2::object::id<AgentSession>(arg0),
            sui_received : v1,
            spent_total  : arg0.spent,
            escrow_after : 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow),
            universal    : false,
        };
        0x2::event::emit<SessionSellV2>(v3);
    }

    public fun session_address(arg0: &AgentSession) : address {
        arg0.session_address
    }

    public fun set_lifetime_cap(arg0: &mut AgentSession, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_session_version(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 6);
        assert!(arg1 >= arg0.lifetime_spent, 14);
        arg0.lifetime_cap = arg1;
        let v0 = LifetimeCapChanged{
            session_id : 0x2::object::id<AgentSession>(arg0),
            old_cap    : arg0.lifetime_cap,
            new_cap    : arg1,
        };
        0x2::event::emit<LifetimeCapChanged>(v0);
    }

    public fun settle_buy<T0>(arg0: &mut AgentSession, arg1: TradeTicket, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_session_version(arg0);
        let TradeTicket {
            session_id : v0,
            borrowed   : v1,
            kind       : v2,
        } = arg1;
        assert!(v0 == 0x2::object::id<AgentSession>(arg0), 9);
        assert!(v2 == 0, 10);
        assert!(!is_closed(arg0), 17);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.escrow, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v4 = if (v3 > v1) {
            v1
        } else {
            v3
        };
        credit_spent(arg0, v4);
        let v5 = if (v4 > arg0.lifetime_spent) {
            arg0.lifetime_spent
        } else {
            v4
        };
        arg0.lifetime_spent = arg0.lifetime_spent - v5;
        park_tokens<T0>(arg0, arg3);
        let v6 = v1 - v4;
        let v7 = SessionBuy{
            session_id  : 0x2::object::id<AgentSession>(arg0),
            sui_spent   : v6,
            spent_total : arg0.spent,
        };
        0x2::event::emit<SessionBuy>(v7);
        let v8 = SessionBuyV2{
            session_id   : 0x2::object::id<AgentSession>(arg0),
            sui_spent    : v6,
            spent_total  : arg0.spent,
            escrow_after : 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow),
            universal    : true,
        };
        0x2::event::emit<SessionBuyV2>(v8);
    }

    public fun settle_sell<T0>(arg0: &mut AgentSession, arg1: TradeTicket, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_session_version(arg0);
        let TradeTicket {
            session_id : v0,
            borrowed   : _,
            kind       : v2,
        } = arg1;
        assert!(v0 == 0x2::object::id<AgentSession>(arg0), 9);
        assert!(v2 == 1, 10);
        assert!(!is_closed(arg0), 17);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.escrow, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        credit_spent(arg0, v3);
        park_tokens<T0>(arg0, arg3);
        let v4 = SessionSell{
            session_id   : 0x2::object::id<AgentSession>(arg0),
            sui_received : v3,
            new_escrow   : 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow),
        };
        0x2::event::emit<SessionSell>(v4);
        let v5 = SessionSellV2{
            session_id   : 0x2::object::id<AgentSession>(arg0),
            sui_received : v3,
            spent_total  : arg0.spent,
            escrow_after : 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow),
            universal    : true,
        };
        0x2::event::emit<SessionSellV2>(v5);
    }

    public fun spend_cap(arg0: &AgentSession) : u64 {
        arg0.spend_cap
    }

    public fun spent(arg0: &AgentSession) : u64 {
        arg0.spent
    }

    public fun sweep_token<T0>(arg0: &mut AgentSession, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::dynamic_object_field::remove<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>()), arg0.owner);
    }

    public fun top_up_session(arg0: &mut AgentSession, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_session_version(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 6);
        assert!(!is_closed(arg0), 17);
        assert!(!arg0.revoked, 2);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.expiry_ms, 3);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.escrow, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = arg0.lifetime_cap;
        let v2 = (v1 as u128) + (default_lifetime_cap(v0) as u128);
        let v3 = 18446744073709551615;
        let v4 = if (v2 > v3) {
            (v3 as u64)
        } else {
            (v2 as u64)
        };
        arg0.lifetime_cap = v4;
        let v5 = LifetimeCapChanged{
            session_id : 0x2::object::id<AgentSession>(arg0),
            old_cap    : v1,
            new_cap    : arg0.lifetime_cap,
        };
        0x2::event::emit<LifetimeCapChanged>(v5);
        let v6 = SessionToppedUp{
            session_id : 0x2::object::id<AgentSession>(arg0),
            amount     : v0,
            new_escrow : 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow),
        };
        0x2::event::emit<SessionToppedUp>(v6);
    }

    public fun universal_trading_enabled(arg0: &AgentSession) : bool {
        0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"universal_trading")
    }

    public fun version(arg0: &AgentSession) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

