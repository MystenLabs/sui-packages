module 0x8efc8d86ac5a8302b075738f173c402136c72caf190a6e4639ef4da0d49d5ded::trading_account {
    struct TradingAccount has key {
        id: 0x2::object::UID,
        owner: address,
        balances: 0x2::bag::Bag,
        sessions: 0x2::table::Table<0x2::object::ID, Session>,
        session_epoch: u64,
        recovery: 0x1::option::Option<address>,
        recovery_requested_at: u64,
    }

    struct Session has store {
        epoch: u64,
        expires_ms: u64,
        daily_limit: u64,
        spent_today: u64,
        day: u64,
        revoked: bool,
    }

    struct StandingOrder has drop, store {
        in_type: 0x1::type_name::TypeName,
        out_type: 0x1::type_name::TypeName,
        remaining_in: u64,
        min_rate: u128,
        expires_ms: u64,
    }

    struct OrderKey has copy, drop, store {
        n: u64,
    }

    struct OrderSeqKey has copy, drop, store {
        dummy_field: bool,
    }

    struct OrdersOnlyKey has copy, drop, store {
        session: 0x2::object::ID,
    }

    struct OrderPlaced has copy, drop {
        account: 0x2::object::ID,
        order: u64,
        in_type: 0x1::type_name::TypeName,
        out_type: 0x1::type_name::TypeName,
        max_in: u64,
        min_rate: u128,
        expires_ms: u64,
    }

    struct OrderCancelled has copy, drop {
        account: 0x2::object::ID,
        order: u64,
    }

    struct OrderRetuned has copy, drop {
        account: 0x2::object::ID,
        order: u64,
        min_rate: u128,
        expires_ms: u64,
    }

    struct OrderFilled has copy, drop {
        account: 0x2::object::ID,
        order: u64,
        session: 0x2::object::ID,
        amount: u64,
        min_out: u64,
        remaining_in: u64,
    }

    struct SessionRestricted has copy, drop {
        account: 0x2::object::ID,
        session: 0x2::object::ID,
    }

    struct SessionCap has store, key {
        id: 0x2::object::UID,
        account: 0x2::object::ID,
    }

    struct TradeTicket {
        account: 0x2::object::ID,
        session: 0x1::option::Option<0x2::object::ID>,
        in_type: 0x1::type_name::TypeName,
        in_amount: u64,
        out_type: 0x1::type_name::TypeName,
        min_out: u64,
        fee_bps: u64,
        fee_paid: u64,
    }

    struct AccountCreated has copy, drop {
        account: 0x2::object::ID,
        owner: address,
    }

    struct Deposited has copy, drop {
        account: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Withdrawn has copy, drop {
        account: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct SessionOpened has copy, drop {
        account: 0x2::object::ID,
        session: 0x2::object::ID,
        holder: address,
        expires_ms: u64,
        daily_limit: u64,
    }

    struct SessionRevoked has copy, drop {
        account: 0x2::object::ID,
        session: 0x2::object::ID,
    }

    struct Traded has copy, drop {
        account: 0x2::object::ID,
        session: 0x1::option::Option<0x2::object::ID>,
        in_type: 0x1::type_name::TypeName,
        in_amount: u64,
        out_type: 0x1::type_name::TypeName,
        out_amount: u64,
        fee: u64,
        fee_type: 0x1::type_name::TypeName,
    }

    struct GasReimbursed has copy, drop {
        account: 0x2::object::ID,
        session: 0x2::object::ID,
        amount: u64,
        to: address,
    }

    struct RecoveryRequested has copy, drop {
        account: 0x2::object::ID,
        by: address,
        at_ms: u64,
    }

    struct Recovered has copy, drop {
        account: 0x2::object::ID,
        new_owner: address,
    }

    struct ObjectTicket {
        account: 0x2::object::ID,
        session: 0x1::option::Option<0x2::object::ID>,
        object: 0x2::object::ID,
        out_type: 0x1::type_name::TypeName,
        min_out: u64,
    }

    struct ObjectStored has copy, drop {
        account: 0x2::object::ID,
        object: 0x2::object::ID,
        kind: 0x1::type_name::TypeName,
    }

    struct ObjectTaken has copy, drop {
        account: 0x2::object::ID,
        object: 0x2::object::ID,
        session: 0x1::option::Option<0x2::object::ID>,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new_internal(arg0);
        0x2::transfer::share_object<TradingAccount>(v0);
        0x2::object::id<TradingAccount>(&v0)
    }

    fun assert_owner(arg0: &TradingAccount, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
    }

    public fun balance_of<T0>(arg0: &TradingAccount) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    public fun cancel_order(arg0: &mut TradingAccount, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        let v0 = OrderKey{n: arg1};
        assert!(0x2::dynamic_field::exists<OrderKey>(&arg0.id, v0), 19);
        let v1 = OrderKey{n: arg1};
        0x2::dynamic_field::remove<OrderKey, StandingOrder>(&mut arg0.id, v1);
        let v2 = OrderCancelled{
            account : 0x2::object::id<TradingAccount>(arg0),
            order   : arg1,
        };
        0x2::event::emit<OrderCancelled>(v2);
    }

    public fun cancel_recovery(arg0: &mut TradingAccount, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        arg0.recovery_requested_at = 0;
    }

    public fun deposit<T0>(arg0: &mut TradingAccount, arg1: 0x2::coin::Coin<T0>) {
        put<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
        let v0 = Deposited{
            account   : 0x2::object::id<TradingAccount>(arg0),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<Deposited>(v0);
    }

    public fun execute_recovery(arg0: &mut TradingAccount, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg0.recovery) && *0x1::option::borrow<address>(&arg0.recovery) == 0x2::tx_context::sender(arg2), 9);
        assert!(arg0.recovery_requested_at > 0, 10);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.recovery_requested_at + 604800000, 10);
        arg0.owner = 0x2::tx_context::sender(arg2);
        arg0.recovery = 0x1::option::none<address>();
        arg0.recovery_requested_at = 0;
        arg0.session_epoch = arg0.session_epoch + 1;
        let v0 = Recovered{
            account   : 0x2::object::id<TradingAccount>(arg0),
            new_owner : arg0.owner,
        };
        0x2::event::emit<Recovered>(v0);
    }

    public fun has_object(arg0: &TradingAccount, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists<0x2::object::ID>(&arg0.id, arg1)
    }

    public fun has_order(arg0: &TradingAccount, arg1: u64) : bool {
        let v0 = OrderKey{n: arg1};
        0x2::dynamic_field::exists<OrderKey>(&arg0.id, v0)
    }

    public fun is_orders_only(arg0: &TradingAccount, arg1: 0x2::object::ID) : bool {
        let v0 = OrdersOnlyKey{session: arg1};
        0x2::dynamic_field::exists<OrdersOnlyKey>(&arg0.id, v0)
    }

    fun new_internal(arg0: &mut 0x2::tx_context::TxContext) : TradingAccount {
        let v0 = TradingAccount{
            id                    : 0x2::object::new(arg0),
            owner                 : 0x2::tx_context::sender(arg0),
            balances              : 0x2::bag::new(arg0),
            sessions              : 0x2::table::new<0x2::object::ID, Session>(arg0),
            session_epoch         : 0,
            recovery              : 0x1::option::none<address>(),
            recovery_requested_at : 0,
        };
        let v1 = AccountCreated{
            account : 0x2::object::id<TradingAccount>(&v0),
            owner   : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<AccountCreated>(v1);
        v0
    }

    fun next_order(arg0: &mut TradingAccount) : u64 {
        let v0 = OrderSeqKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<OrderSeqKey>(&arg0.id, v0)) {
            let v1 = OrderSeqKey{dummy_field: false};
            0x2::dynamic_field::add<OrderSeqKey, u64>(&mut arg0.id, v1, 0);
        };
        let v2 = OrderSeqKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<OrderSeqKey, u64>(&mut arg0.id, v2);
        let v4 = *v3;
        *v3 = v4 + 1;
        v4
    }

    public fun open_account<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new_internal(arg4);
        let v1 = &mut v0;
        deposit<T0>(v1, arg0);
        let v2 = &mut v0;
        open_session(v2, arg1, arg2, arg3, arg4);
        0x2::transfer::share_object<TradingAccount>(v0);
        0x2::object::id<TradingAccount>(&v0)
    }

    public fun open_session(arg0: &mut TradingAccount, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg4);
        let v0 = SessionCap{
            id      : 0x2::object::new(arg4),
            account : 0x2::object::id<TradingAccount>(arg0),
        };
        let v1 = 0x2::object::id<SessionCap>(&v0);
        let v2 = Session{
            epoch       : arg0.session_epoch,
            expires_ms  : arg2,
            daily_limit : arg3,
            spent_today : 0,
            day         : 0,
            revoked     : false,
        };
        0x2::table::add<0x2::object::ID, Session>(&mut arg0.sessions, v1, v2);
        let v3 = SessionOpened{
            account     : 0x2::object::id<TradingAccount>(arg0),
            session     : v1,
            holder      : arg1,
            expires_ms  : arg2,
            daily_limit : arg3,
        };
        0x2::event::emit<SessionOpened>(v3);
        0x2::transfer::transfer<SessionCap>(v0, arg1);
    }

    public fun open_session_for_orders(arg0: &mut TradingAccount, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_owner(arg0, arg4);
        let v0 = SessionCap{
            id      : 0x2::object::new(arg4),
            account : 0x2::object::id<TradingAccount>(arg0),
        };
        let v1 = 0x2::object::id<SessionCap>(&v0);
        let v2 = Session{
            epoch       : arg0.session_epoch,
            expires_ms  : arg2,
            daily_limit : arg3,
            spent_today : 0,
            day         : 0,
            revoked     : false,
        };
        0x2::table::add<0x2::object::ID, Session>(&mut arg0.sessions, v1, v2);
        let v3 = OrdersOnlyKey{session: v1};
        0x2::dynamic_field::add<OrdersOnlyKey, bool>(&mut arg0.id, v3, true);
        let v4 = SessionOpened{
            account     : 0x2::object::id<TradingAccount>(arg0),
            session     : v1,
            holder      : arg1,
            expires_ms  : arg2,
            daily_limit : arg3,
        };
        0x2::event::emit<SessionOpened>(v4);
        let v5 = SessionRestricted{
            account : 0x2::object::id<TradingAccount>(arg0),
            session : v1,
        };
        0x2::event::emit<SessionRestricted>(v5);
        0x2::transfer::transfer<SessionCap>(v0, arg1);
        v1
    }

    public fun owner(arg0: &TradingAccount) : address {
        arg0.owner
    }

    public fun place_order<T0, T1>(arg0: &mut TradingAccount, arg1: u64, arg2: u128, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        assert_owner(arg0, arg4);
        assert!(arg1 > 0, 8);
        let v0 = next_order(arg0);
        let v1 = OrderKey{n: v0};
        let v2 = StandingOrder{
            in_type      : 0x1::type_name::with_defining_ids<T0>(),
            out_type     : 0x1::type_name::with_defining_ids<T1>(),
            remaining_in : arg1,
            min_rate     : arg2,
            expires_ms   : arg3,
        };
        0x2::dynamic_field::add<OrderKey, StandingOrder>(&mut arg0.id, v1, v2);
        let v3 = OrderPlaced{
            account    : 0x2::object::id<TradingAccount>(arg0),
            order      : v0,
            in_type    : 0x1::type_name::with_defining_ids<T0>(),
            out_type   : 0x1::type_name::with_defining_ids<T1>(),
            max_in     : arg1,
            min_rate   : arg2,
            expires_ms : arg3,
        };
        0x2::event::emit<OrderPlaced>(v3);
        v0
    }

    fun put<T0>(arg0: &mut TradingAccount, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    public fun request_recovery(arg0: &mut TradingAccount, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg0.recovery) && *0x1::option::borrow<address>(&arg0.recovery) == 0x2::tx_context::sender(arg2), 9);
        arg0.recovery_requested_at = 0x2::clock::timestamp_ms(arg1);
        let v0 = RecoveryRequested{
            account : 0x2::object::id<TradingAccount>(arg0),
            by      : 0x2::tx_context::sender(arg2),
            at_ms   : arg0.recovery_requested_at,
        };
        0x2::event::emit<RecoveryRequested>(v0);
    }

    public fun restrict_session_to_orders(arg0: &mut TradingAccount, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert!(0x2::table::contains<0x2::object::ID, Session>(&arg0.sessions, arg1), 11);
        let v0 = OrdersOnlyKey{session: arg1};
        if (!0x2::dynamic_field::exists<OrdersOnlyKey>(&arg0.id, v0)) {
            let v1 = OrdersOnlyKey{session: arg1};
            0x2::dynamic_field::add<OrdersOnlyKey, bool>(&mut arg0.id, v1, true);
        };
        let v2 = SessionRestricted{
            account : 0x2::object::id<TradingAccount>(arg0),
            session : arg1,
        };
        0x2::event::emit<SessionRestricted>(v2);
    }

    public fun retune_order(arg0: &mut TradingAccount, arg1: u64, arg2: u128, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg4);
        let v0 = OrderKey{n: arg1};
        assert!(0x2::dynamic_field::exists<OrderKey>(&arg0.id, v0), 19);
        let v1 = OrderKey{n: arg1};
        let v2 = 0x2::dynamic_field::borrow_mut<OrderKey, StandingOrder>(&mut arg0.id, v1);
        v2.min_rate = arg2;
        v2.expires_ms = arg3;
        let v3 = OrderRetuned{
            account    : 0x2::object::id<TradingAccount>(arg0),
            order      : arg1,
            min_rate   : arg2,
            expires_ms : arg3,
        };
        0x2::event::emit<OrderRetuned>(v3);
    }

    public fun revoke_session(arg0: &mut TradingAccount, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert!(0x2::table::contains<0x2::object::ID, Session>(&arg0.sessions, arg1), 11);
        0x2::table::borrow_mut<0x2::object::ID, Session>(&mut arg0.sessions, arg1).revoked = true;
        let v0 = SessionRevoked{
            account : 0x2::object::id<TradingAccount>(arg0),
            session : arg1,
        };
        0x2::event::emit<SessionRevoked>(v0);
    }

    fun session_spend(arg0: &mut TradingAccount, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Session>(&mut arg0.sessions, arg1);
        assert!(v0.epoch == arg0.session_epoch, 13);
        assert!(!v0.revoked, 3);
        assert!(arg2 < v0.expires_ms, 2);
        if (arg3 > 0) {
            let v1 = arg2 / 86400000;
            if (v1 != v0.day) {
                v0.day = v1;
                v0.spent_today = 0;
            };
            assert!(v0.spent_today + arg3 <= v0.daily_limit, 4);
            v0.spent_today = v0.spent_today + arg3;
        };
    }

    public fun set_recovery(arg0: &mut TradingAccount, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        arg0.recovery = 0x1::option::some<address>(arg1);
        arg0.recovery_requested_at = 0;
    }

    public fun settle<T0>(arg0: &mut TradingAccount, arg1: &mut 0x8efc8d86ac5a8302b075738f173c402136c72caf190a6e4639ef4da0d49d5ded::terminal_config::Config, arg2: TradeTicket, arg3: 0x2::coin::Coin<T0>) {
        let TradeTicket {
            account   : v0,
            session   : v1,
            in_type   : v2,
            in_amount : v3,
            out_type  : v4,
            min_out   : v5,
            fee_bps   : v6,
            fee_paid  : v7,
        } = arg2;
        assert!(v0 == 0x2::object::id<TradingAccount>(arg0), 5);
        assert!(v4 == 0x1::type_name::with_defining_ids<T0>(), 6);
        let v8 = 0x2::coin::value<T0>(&arg3);
        assert!(v8 >= v5, 7);
        let v9 = 0x2::coin::into_balance<T0>(arg3);
        let v10 = v7;
        let v11 = v2;
        if (v7 == 0) {
            let v12 = v8 * v6 / 10000;
            if (v12 > 0) {
                0x8efc8d86ac5a8302b075738f173c402136c72caf190a6e4639ef4da0d49d5ded::terminal_config::put_fee<T0>(arg1, 0x2::balance::split<T0>(&mut v9, v12));
                v10 = v12;
                v11 = v4;
            };
        };
        put<T0>(arg0, v9);
        let v13 = Traded{
            account    : v0,
            session    : v1,
            in_type    : v2,
            in_amount  : v3,
            out_type   : v4,
            out_amount : 0x2::balance::value<T0>(&v9),
            fee        : v10,
            fee_type   : v11,
        };
        0x2::event::emit<Traded>(v13);
    }

    public fun settle_and_reimburse<T0>(arg0: &mut TradingAccount, arg1: &mut 0x8efc8d86ac5a8302b075738f173c402136c72caf190a6e4639ef4da0d49d5ded::terminal_config::Config, arg2: TradeTicket, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg2.session), 16);
        let v0 = *0x1::option::borrow<0x2::object::ID>(&arg2.session);
        assert!(arg4 <= 0x2::tx_context::gas_price(arg6) * 20000 + 10000000, 15);
        settle<T0>(arg0, arg1, arg2, arg3);
        if (arg4 == 0) {
            return
        };
        session_spend(arg0, v0, 0x2::clock::timestamp_ms(arg5), arg4);
        let v1 = take<0x2::sui::SUI>(arg0, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg6), 0x2::tx_context::sender(arg6));
        let v2 = GasReimbursed{
            account : 0x2::object::id<TradingAccount>(arg0),
            session : v0,
            amount  : arg4,
            to      : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<GasReimbursed>(v2);
    }

    public fun settle_object_proceeds<T0>(arg0: &mut TradingAccount, arg1: &mut 0x8efc8d86ac5a8302b075738f173c402136c72caf190a6e4639ef4da0d49d5ded::terminal_config::Config, arg2: ObjectTicket, arg3: 0x2::coin::Coin<T0>) {
        let ObjectTicket {
            account  : v0,
            session  : _,
            object   : _,
            out_type : v3,
            min_out  : v4,
        } = arg2;
        assert!(v0 == 0x2::object::id<TradingAccount>(arg0), 5);
        assert!(v3 == 0x1::type_name::with_defining_ids<T0>(), 6);
        let v5 = 0x2::coin::value<T0>(&arg3);
        assert!(v5 >= v4, 7);
        let v6 = 0x2::coin::into_balance<T0>(arg3);
        let v7 = v5 * 0x8efc8d86ac5a8302b075738f173c402136c72caf190a6e4639ef4da0d49d5ded::terminal_config::fee_bps(arg1) / 10000;
        if (v7 > 0) {
            0x8efc8d86ac5a8302b075738f173c402136c72caf190a6e4639ef4da0d49d5ded::terminal_config::put_fee<T0>(arg1, 0x2::balance::split<T0>(&mut v6, v7));
        };
        put<T0>(arg0, v6);
    }

    public fun settle_object_return<T0: store + key>(arg0: &mut TradingAccount, arg1: ObjectTicket, arg2: T0) {
        let ObjectTicket {
            account  : v0,
            session  : _,
            object   : v2,
            out_type : _,
            min_out  : _,
        } = arg1;
        assert!(v0 == 0x2::object::id<TradingAccount>(arg0), 5);
        assert!(0x2::object::id<T0>(&arg2) == v2, 17);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v2, arg2);
    }

    public fun settle_with_object<T0: store + key>(arg0: &mut TradingAccount, arg1: TradeTicket, arg2: T0) {
        let TradeTicket {
            account   : v0,
            session   : _,
            in_type   : _,
            in_amount : _,
            out_type  : _,
            min_out   : _,
            fee_bps   : _,
            fee_paid  : v7,
        } = arg1;
        assert!(v0 == 0x2::object::id<TradingAccount>(arg0), 5);
        assert!(v7 > 0, 18);
        store_object<T0>(arg0, arg2);
    }

    public fun store_object<T0: store + key>(arg0: &mut TradingAccount, arg1: T0) {
        let v0 = 0x2::object::id<T0>(&arg1);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v0, arg1);
        let v1 = ObjectStored{
            account : 0x2::object::id<TradingAccount>(arg0),
            object  : v0,
            kind    : 0x1::type_name::with_defining_ids<T0>(),
        };
        0x2::event::emit<ObjectStored>(v1);
    }

    fun take<T0>(arg0: &mut TradingAccount, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 1);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 1);
        0x2::balance::split<T0>(v1, arg1)
    }

    public fun take_for_order<T0, T1>(arg0: &mut TradingAccount, arg1: &mut 0x8efc8d86ac5a8302b075738f173c402136c72caf190a6e4639ef4da0d49d5ded::terminal_config::Config, arg2: &SessionCap, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, TradeTicket) {
        assert!(arg2.account == 0x2::object::id<TradingAccount>(arg0), 12);
        let v0 = 0x2::object::id<SessionCap>(arg2);
        assert!(0x2::table::contains<0x2::object::ID, Session>(&arg0.sessions, v0), 11);
        let v1 = OrderKey{n: arg3};
        assert!(0x2::dynamic_field::exists<OrderKey>(&arg0.id, v1), 19);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        let v3 = OrderKey{n: arg3};
        let v4 = 0x2::dynamic_field::borrow_mut<OrderKey, StandingOrder>(&mut arg0.id, v3);
        assert!(v2 < v4.expires_ms, 20);
        assert!(v4.in_type == 0x1::type_name::with_defining_ids<T0>() && v4.out_type == 0x1::type_name::with_defining_ids<T1>(), 23);
        assert!(arg4 > 0 && arg4 <= v4.remaining_in, 22);
        v4.remaining_in = v4.remaining_in - arg4;
        let v5 = (arg4 as u128) * v4.min_rate / 1000000000000;
        assert!(v5 <= 18446744073709551615, 25);
        let v6 = (v5 as u64);
        let v7 = v4.remaining_in;
        if (v7 == 0) {
            let v8 = OrderKey{n: arg3};
            0x2::dynamic_field::remove<OrderKey, StandingOrder>(&mut arg0.id, v8);
        };
        let v9 = if (0x8efc8d86ac5a8302b075738f173c402136c72caf190a6e4639ef4da0d49d5ded::terminal_config::is_quote<T0>(arg1)) {
            arg4
        } else {
            0
        };
        session_spend(arg0, v0, v2, v9);
        let v10 = OrderFilled{
            account      : 0x2::object::id<TradingAccount>(arg0),
            order        : arg3,
            session      : v0,
            amount       : arg4,
            min_out      : v6,
            remaining_in : v7,
        };
        0x2::event::emit<OrderFilled>(v10);
        take_internal<T0, T1>(arg0, arg1, 0x1::option::some<0x2::object::ID>(v0), arg4, v6, arg6)
    }

    public fun take_for_trade<T0, T1>(arg0: &mut TradingAccount, arg1: &mut 0x8efc8d86ac5a8302b075738f173c402136c72caf190a6e4639ef4da0d49d5ded::terminal_config::Config, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, TradeTicket) {
        assert_owner(arg0, arg4);
        take_internal<T0, T1>(arg0, arg1, 0x1::option::none<0x2::object::ID>(), arg2, arg3, arg4)
    }

    public fun take_for_trade_with_session<T0, T1>(arg0: &mut TradingAccount, arg1: &mut 0x8efc8d86ac5a8302b075738f173c402136c72caf190a6e4639ef4da0d49d5ded::terminal_config::Config, arg2: &SessionCap, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, TradeTicket) {
        assert!(arg2.account == 0x2::object::id<TradingAccount>(arg0), 12);
        let v0 = 0x2::object::id<SessionCap>(arg2);
        assert!(0x2::table::contains<0x2::object::ID, Session>(&arg0.sessions, v0), 11);
        assert!(!is_orders_only(arg0, v0), 24);
        let v1 = 0x8efc8d86ac5a8302b075738f173c402136c72caf190a6e4639ef4da0d49d5ded::terminal_config::is_quote<T0>(arg1);
        assert!(v1 || 0x8efc8d86ac5a8302b075738f173c402136c72caf190a6e4639ef4da0d49d5ded::terminal_config::is_quote<T1>(arg1), 14);
        let v2 = if (v1) {
            arg3
        } else {
            0
        };
        session_spend(arg0, v0, 0x2::clock::timestamp_ms(arg5), v2);
        take_internal<T0, T1>(arg0, arg1, 0x1::option::some<0x2::object::ID>(v0), arg3, arg4, arg6)
    }

    fun take_internal<T0, T1>(arg0: &mut TradingAccount, arg1: &mut 0x8efc8d86ac5a8302b075738f173c402136c72caf190a6e4639ef4da0d49d5ded::terminal_config::Config, arg2: 0x1::option::Option<0x2::object::ID>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, TradeTicket) {
        0x8efc8d86ac5a8302b075738f173c402136c72caf190a6e4639ef4da0d49d5ded::terminal_config::assert_active(arg1);
        assert!(arg3 > 0, 8);
        let v0 = take<T0>(arg0, arg3);
        let v1 = 0x8efc8d86ac5a8302b075738f173c402136c72caf190a6e4639ef4da0d49d5ded::terminal_config::fee_bps(arg1);
        let v2 = 0;
        if (0x8efc8d86ac5a8302b075738f173c402136c72caf190a6e4639ef4da0d49d5ded::terminal_config::is_quote<T0>(arg1)) {
            let v3 = arg3 * v1 / 10000;
            if (v3 > 0) {
                0x8efc8d86ac5a8302b075738f173c402136c72caf190a6e4639ef4da0d49d5ded::terminal_config::put_fee<T0>(arg1, 0x2::balance::split<T0>(&mut v0, v3));
                v2 = v3;
            };
        };
        let v4 = TradeTicket{
            account   : 0x2::object::id<TradingAccount>(arg0),
            session   : arg2,
            in_type   : 0x1::type_name::with_defining_ids<T0>(),
            in_amount : arg3,
            out_type  : 0x1::type_name::with_defining_ids<T1>(),
            min_out   : arg4,
            fee_bps   : v1,
            fee_paid  : v2,
        };
        (0x2::coin::from_balance<T0>(v0, arg5), v4)
    }

    public fun take_object_with_session<T0: store + key, T1>(arg0: &mut TradingAccount, arg1: &mut 0x8efc8d86ac5a8302b075738f173c402136c72caf190a6e4639ef4da0d49d5ded::terminal_config::Config, arg2: &SessionCap, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (T0, ObjectTicket) {
        0x8efc8d86ac5a8302b075738f173c402136c72caf190a6e4639ef4da0d49d5ded::terminal_config::assert_active(arg1);
        assert!(arg2.account == 0x2::object::id<TradingAccount>(arg0), 12);
        let v0 = 0x2::object::id<SessionCap>(arg2);
        assert!(0x2::table::contains<0x2::object::ID, Session>(&arg0.sessions, v0), 11);
        assert!(0x8efc8d86ac5a8302b075738f173c402136c72caf190a6e4639ef4da0d49d5ded::terminal_config::is_quote<T1>(arg1), 14);
        assert!(!is_orders_only(arg0, v0), 24);
        session_spend(arg0, v0, 0x2::clock::timestamp_ms(arg5), 0);
        let v1 = ObjectTaken{
            account : 0x2::object::id<TradingAccount>(arg0),
            object  : arg3,
            session : 0x1::option::some<0x2::object::ID>(v0),
        };
        0x2::event::emit<ObjectTaken>(v1);
        let v2 = ObjectTicket{
            account  : 0x2::object::id<TradingAccount>(arg0),
            session  : 0x1::option::some<0x2::object::ID>(v0),
            object   : arg3,
            out_type : 0x1::type_name::with_defining_ids<T1>(),
            min_out  : arg4,
        };
        (0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg3), v2)
    }

    public fun withdraw<T0>(arg0: &mut TradingAccount, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_owner(arg0, arg2);
        let v0 = take<T0>(arg0, arg1);
        let v1 = Withdrawn{
            account   : 0x2::object::id<TradingAccount>(arg0),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : arg1,
        };
        0x2::event::emit<Withdrawn>(v1);
        0x2::coin::from_balance<T0>(v0, arg2)
    }

    public fun withdraw_object<T0: store + key>(arg0: &mut TradingAccount, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : T0 {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1)
    }

    // decompiled from Move bytecode v7
}

