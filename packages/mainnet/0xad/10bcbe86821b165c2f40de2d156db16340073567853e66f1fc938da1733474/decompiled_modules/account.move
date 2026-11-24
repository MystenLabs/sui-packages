module 0xad10bcbe86821b165c2f40de2d156db16340073567853e66f1fc938da1733474::account {
    struct TradingAccount has key {
        id: 0x2::object::UID,
        principal: address,
        revoked_sessions: 0x2::table::Table<0x2::object::ID, bool>,
        market_witnesses: 0x2::table::Table<MarketAuthorizationKey, bool>,
        version: u64,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct MarketAuthorizationKey has copy, drop, store {
        witness_type: 0x1::type_name::TypeName,
        market_id: 0x2::object::ID,
    }

    struct AccountCreated has copy, drop {
        account_id: 0x2::object::ID,
        principal: address,
    }

    struct Deposited has copy, drop {
        account_id: 0x2::object::ID,
        principal: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        depositor: address,
    }

    struct Withdrawn has copy, drop {
        account_id: 0x2::object::ID,
        principal: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Taken has copy, drop {
        account_id: 0x2::object::ID,
        principal: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        session_id: 0x2::object::ID,
    }

    struct Credited has copy, drop {
        account_id: 0x2::object::ID,
        principal: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct SessionRevoked has copy, drop {
        account_id: 0x2::object::ID,
        principal: address,
        session_id: 0x2::object::ID,
    }

    struct MarketAuthorizationChanged has copy, drop {
        account_id: 0x2::object::ID,
        principal: address,
        market_id: 0x2::object::ID,
        witness_type: 0x1::type_name::TypeName,
        authorized: bool,
    }

    public fun id(arg0: &TradingAccount) : 0x2::object::ID {
        0x2::object::id<TradingAccount>(arg0)
    }

    fun assert_market<T0: drop>(arg0: &TradingAccount, arg1: 0x2::object::ID) {
        assert!(is_market_authorized<T0>(arg0, arg1), 7);
    }

    fun assert_principal(arg0: &TradingAccount, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.principal, 1);
    }

    public fun assert_session<T0: drop>(arg0: T0, arg1: &TradingAccount, arg2: &mut 0xad10bcbe86821b165c2f40de2d156db16340073567853e66f1fc938da1733474::session::TradingSessionCap, arg3: 0x2::object::ID, arg4: u8, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0xad10bcbe86821b165c2f40de2d156db16340073567853e66f1fc938da1733474::session::SessionTicket {
        check_version(arg1);
        assert_market<T0>(arg1, arg3);
        assert!(!is_session_revoked(arg1, 0x2::object::id<0xad10bcbe86821b165c2f40de2d156db16340073567853e66f1fc938da1733474::session::TradingSessionCap>(arg2)), 6);
        0xad10bcbe86821b165c2f40de2d156db16340073567853e66f1fc938da1733474::session::assert_session<T0>(arg2, arg1.principal, 0x2::object::id<TradingAccount>(arg1), arg3, arg4, arg5, arg6, arg7)
    }

    public fun authorize_market<T0: drop>(arg0: &mut TradingAccount, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        assert_principal(arg0, arg2);
        let v0 = market_key<T0>(arg1);
        if (!0x2::table::contains<MarketAuthorizationKey, bool>(&arg0.market_witnesses, v0)) {
            0x2::table::add<MarketAuthorizationKey, bool>(&mut arg0.market_witnesses, v0, true);
        };
        emit_market_authorization<T0>(arg0, arg1, true);
    }

    public fun balance_of<T0>(arg0: &TradingAccount) : u64 {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists<BalanceKey<T0>>(&arg0.id, v0)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        } else {
            0
        }
    }

    fun check_version(arg0: &TradingAccount) {
        assert!(arg0.version <= 0xad10bcbe86821b165c2f40de2d156db16340073567853e66f1fc938da1733474::session::package_version(), 9);
    }

    public fun create_account(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::tx_context::sender(arg0);
        let v2 = TradingAccount{
            id               : v0,
            principal        : v1,
            revoked_sessions : 0x2::table::new<0x2::object::ID, bool>(arg0),
            market_witnesses : 0x2::table::new<MarketAuthorizationKey, bool>(arg0),
            version          : 0xad10bcbe86821b165c2f40de2d156db16340073567853e66f1fc938da1733474::session::package_version(),
        };
        let v3 = AccountCreated{
            account_id : 0x2::object::uid_to_inner(&v0),
            principal  : v1,
        };
        0x2::event::emit<AccountCreated>(v3);
        0x2::transfer::share_object<TradingAccount>(v2);
    }

    public fun create_session(arg0: &TradingAccount, arg1: address, arg2: vector<0x2::object::ID>, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: bool, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert_principal(arg0, arg10);
        0xad10bcbe86821b165c2f40de2d156db16340073567853e66f1fc938da1733474::session::transfer_session(0xad10bcbe86821b165c2f40de2d156db16340073567853e66f1fc938da1733474::session::new_session(0x2::object::id<TradingAccount>(arg0), arg0.principal, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10), arg1);
    }

    public fun credit<T0>(arg0: &mut TradingAccount, arg1: address, arg2: 0x2::balance::Balance<T0>) {
        check_version(arg0);
        assert!(arg1 == arg0.principal, 5);
        let v0 = 0x2::balance::value<T0>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return
        };
        join_balance<T0>(arg0, arg2);
        let v1 = Credited{
            account_id : 0x2::object::id<TradingAccount>(arg0),
            principal  : arg0.principal,
            coin_type  : 0x1::type_name::with_defining_ids<T0>(),
            amount     : v0,
        };
        0x2::event::emit<Credited>(v1);
    }

    public fun deauthorize_market<T0: drop>(arg0: &mut TradingAccount, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        assert_principal(arg0, arg2);
        let v0 = market_key<T0>(arg1);
        if (0x2::table::contains<MarketAuthorizationKey, bool>(&arg0.market_witnesses, v0)) {
            0x2::table::remove<MarketAuthorizationKey, bool>(&mut arg0.market_witnesses, v0);
        };
        emit_market_authorization<T0>(arg0, arg1, false);
    }

    public fun deposit<T0>(arg0: &mut TradingAccount, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        join_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
        let v1 = Deposited{
            account_id : 0x2::object::id<TradingAccount>(arg0),
            principal  : arg0.principal,
            coin_type  : 0x1::type_name::with_defining_ids<T0>(),
            amount     : v0,
            depositor  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Deposited>(v1);
    }

    fun emit_market_authorization<T0>(arg0: &TradingAccount, arg1: 0x2::object::ID, arg2: bool) {
        let v0 = MarketAuthorizationChanged{
            account_id   : 0x2::object::id<TradingAccount>(arg0),
            principal    : arg0.principal,
            market_id    : arg1,
            witness_type : 0x1::type_name::with_defining_ids<T0>(),
            authorized   : arg2,
        };
        0x2::event::emit<MarketAuthorizationChanged>(v0);
    }

    public fun is_market_authorized<T0: drop>(arg0: &TradingAccount, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<MarketAuthorizationKey, bool>(&arg0.market_witnesses, market_key<T0>(arg1))
    }

    public fun is_session_revoked(arg0: &TradingAccount, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.revoked_sessions, arg1)
    }

    fun join_balance<T0>(arg0: &mut TradingAccount, arg1: 0x2::balance::Balance<T0>) {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists<BalanceKey<T0>>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
        } else {
            0x2::dynamic_field::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, arg1);
        };
    }

    fun market_key<T0>(arg0: 0x2::object::ID) : MarketAuthorizationKey {
        MarketAuthorizationKey{
            witness_type : 0x1::type_name::with_defining_ids<T0>(),
            market_id    : arg0,
        }
    }

    public fun migrate(arg0: &mut TradingAccount) {
        check_version(arg0);
        arg0.version = 0xad10bcbe86821b165c2f40de2d156db16340073567853e66f1fc938da1733474::session::package_version();
    }

    public fun principal(arg0: &TradingAccount) : address {
        arg0.principal
    }

    public fun revoke_session_id(arg0: &mut TradingAccount, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        assert_principal(arg0, arg2);
        if (!0x2::table::contains<0x2::object::ID, bool>(&arg0.revoked_sessions, arg1)) {
            0x2::table::add<0x2::object::ID, bool>(&mut arg0.revoked_sessions, arg1, true);
        };
        let v0 = SessionRevoked{
            account_id : 0x2::object::id<TradingAccount>(arg0),
            principal  : arg0.principal,
            session_id : arg1,
        };
        0x2::event::emit<SessionRevoked>(v0);
    }

    fun split_balance<T0>(arg0: &mut TradingAccount, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = BalanceKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<BalanceKey<T0>>(&arg0.id, v0), 3);
        let v1 = 0x2::dynamic_field::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 3);
        if (0x2::balance::value<T0>(v1) == 0) {
            0x2::balance::destroy_zero<T0>(0x2::dynamic_field::remove<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0));
        };
        0x2::balance::split<T0>(v1, arg1)
    }

    public fun take<T0, T1: drop>(arg0: T1, arg1: &mut TradingAccount, arg2: &0xad10bcbe86821b165c2f40de2d156db16340073567853e66f1fc938da1733474::session::TradingSessionCap, arg3: &0xad10bcbe86821b165c2f40de2d156db16340073567853e66f1fc938da1733474::session::SessionTicket, arg4: u64) : 0x2::balance::Balance<T0> {
        check_version(arg1);
        assert_market<T1>(arg1, 0xad10bcbe86821b165c2f40de2d156db16340073567853e66f1fc938da1733474::session::ticket_market_id(arg3));
        assert!(0xad10bcbe86821b165c2f40de2d156db16340073567853e66f1fc938da1733474::session::ticket_witness_type(arg3) == 0x1::type_name::with_defining_ids<T1>(), 7);
        assert!(0xad10bcbe86821b165c2f40de2d156db16340073567853e66f1fc938da1733474::session::ticket_session_id(arg3) == 0x2::object::id<0xad10bcbe86821b165c2f40de2d156db16340073567853e66f1fc938da1733474::session::TradingSessionCap>(arg2), 8);
        assert!(!is_session_revoked(arg1, 0x2::object::id<0xad10bcbe86821b165c2f40de2d156db16340073567853e66f1fc938da1733474::session::TradingSessionCap>(arg2)), 6);
        assert!(0xad10bcbe86821b165c2f40de2d156db16340073567853e66f1fc938da1733474::session::ticket_account_id(arg3) == 0x2::object::id<TradingAccount>(arg1), 4);
        assert!(0xad10bcbe86821b165c2f40de2d156db16340073567853e66f1fc938da1733474::session::ticket_account_id(arg3) == 0xad10bcbe86821b165c2f40de2d156db16340073567853e66f1fc938da1733474::session::account_id(arg2), 4);
        assert!(0xad10bcbe86821b165c2f40de2d156db16340073567853e66f1fc938da1733474::session::ticket_principal(arg3) == arg1.principal, 5);
        assert!(0xad10bcbe86821b165c2f40de2d156db16340073567853e66f1fc938da1733474::session::principal(arg2) == arg1.principal, 5);
        assert!(arg4 > 0, 2);
        let v0 = split_balance<T0>(arg1, arg4);
        let v1 = Taken{
            account_id : 0x2::object::id<TradingAccount>(arg1),
            principal  : arg1.principal,
            coin_type  : 0x1::type_name::with_defining_ids<T0>(),
            amount     : arg4,
            session_id : 0x2::object::id<0xad10bcbe86821b165c2f40de2d156db16340073567853e66f1fc938da1733474::session::TradingSessionCap>(arg2),
        };
        0x2::event::emit<Taken>(v1);
        v0
    }

    public fun version(arg0: &TradingAccount) : u64 {
        arg0.version
    }

    public fun withdraw<T0>(arg0: &mut TradingAccount, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_version(arg0);
        assert_principal(arg0, arg2);
        assert!(arg1 > 0, 2);
        let v0 = split_balance<T0>(arg0, arg1);
        let v1 = Withdrawn{
            account_id : 0x2::object::id<TradingAccount>(arg0),
            principal  : arg0.principal,
            coin_type  : 0x1::type_name::with_defining_ids<T0>(),
            amount     : arg1,
        };
        0x2::event::emit<Withdrawn>(v1);
        0x2::coin::from_balance<T0>(v0, arg2)
    }

    // decompiled from Move bytecode v7
}

