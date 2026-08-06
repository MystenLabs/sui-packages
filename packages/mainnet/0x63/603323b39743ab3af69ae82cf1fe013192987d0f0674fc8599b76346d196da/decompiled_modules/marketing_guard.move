module 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_guard {
    struct BorrowDayKey has copy, drop, store {
        executor: address,
        day: u64,
    }

    struct BorrowUserDayKey has copy, drop, store {
        executor: address,
        user: address,
        day: u64,
    }

    struct BorrowKey has copy, drop, store {
        executor: address,
        user: address,
        marker: 0x2::object::ID,
    }

    struct MarketingGuard has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        vault_id: 0x2::object::ID,
        borrow_cap_per_tx: u64,
        borrow_daily_cap: u64,
        borrow_user_daily_cap: u64,
        executor_borrowed_today: 0x2::table::Table<BorrowDayKey, u64>,
        executor_user_borrowed_today: 0x2::table::Table<BorrowUserDayKey, u64>,
        outstanding_borrowed: 0x2::table::Table<BorrowKey, u64>,
    }

    struct BorrowCapsUpdated has copy, drop {
        per_tx: u64,
        daily: u64,
        user_daily: u64,
    }

    struct ExecutorBorrowRecorded has copy, drop {
        executor: address,
        user: address,
        amount: u64,
        day: u64,
    }

    struct ExecutorSettlementRecorded has copy, drop {
        executor: address,
        user: address,
        principal: u64,
        remaining_outstanding: u64,
    }

    public fun id(arg0: &MarketingGuard) : 0x2::object::ID {
        assert_version(arg0);
        0x2::object::id<MarketingGuard>(arg0)
    }

    fun assert_admin(arg0: &MarketingGuard, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 301);
    }

    fun assert_valid_caps(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = if (arg0 > 0) {
            if (arg1 > 0) {
                arg2 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 302);
    }

    fun assert_version(arg0: &MarketingGuard) {
        assert!(arg0.version == 1, 300);
    }

    public fun init_marketing_guard(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::transfer::share_object<MarketingGuard>(new_guard(v0, arg0, arg1, arg2, arg3, arg4));
    }

    public fun migrate_version(arg0: &mut MarketingGuard, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 301);
        assert!(arg0.version == arg1, 300);
        assert!(arg2 == 1 && arg2 >= arg1, 300);
        arg0.version = arg2;
    }

    fun new_guard(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : MarketingGuard {
        assert_valid_caps(arg2, arg3, arg4);
        MarketingGuard{
            id                           : 0x2::object::new(arg5),
            version                      : 1,
            admin                        : arg0,
            vault_id                     : arg1,
            borrow_cap_per_tx            : arg2,
            borrow_daily_cap             : arg3,
            borrow_user_daily_cap        : arg4,
            executor_borrowed_today      : 0x2::table::new<BorrowDayKey, u64>(arg5),
            executor_user_borrowed_today : 0x2::table::new<BorrowUserDayKey, u64>(arg5),
            outstanding_borrowed         : 0x2::table::new<BorrowKey, u64>(arg5),
        }
    }

    public fun outstanding_borrowed(arg0: &MarketingGuard, arg1: address, arg2: address, arg3: 0x2::object::ID) : u64 {
        assert_version(arg0);
        let v0 = BorrowKey{
            executor : arg1,
            user     : arg2,
            marker   : arg3,
        };
        table_value_or_zero<BorrowKey>(&arg0.outstanding_borrowed, v0)
    }

    public(friend) fun record_borrow(arg0: &mut MarketingGuard, arg1: address, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock) {
        assert_version(arg0);
        if (arg0.borrow_cap_per_tx > 0) {
            assert!(arg4 <= arg0.borrow_cap_per_tx, 303);
        };
        let v0 = 0x2::clock::timestamp_ms(arg5) / 86400000;
        let v1 = BorrowDayKey{
            executor : arg1,
            day      : v0,
        };
        let v2 = table_value_or_zero<BorrowDayKey>(&arg0.executor_borrowed_today, v1);
        if (arg0.borrow_daily_cap > 0) {
            assert!(v2 + arg4 <= arg0.borrow_daily_cap, 303);
        };
        let v3 = &mut arg0.executor_borrowed_today;
        set_table_u64<BorrowDayKey>(v3, v1, v2 + arg4);
        let v4 = BorrowUserDayKey{
            executor : arg1,
            user     : arg2,
            day      : v0,
        };
        let v5 = table_value_or_zero<BorrowUserDayKey>(&arg0.executor_user_borrowed_today, v4);
        if (arg0.borrow_user_daily_cap > 0) {
            assert!(v5 + arg4 <= arg0.borrow_user_daily_cap, 303);
        };
        let v6 = &mut arg0.executor_user_borrowed_today;
        set_table_u64<BorrowUserDayKey>(v6, v4, v5 + arg4);
        let v7 = BorrowKey{
            executor : arg1,
            user     : arg2,
            marker   : arg3,
        };
        let v8 = &mut arg0.outstanding_borrowed;
        set_table_u64<BorrowKey>(v8, v7, table_value_or_zero<BorrowKey>(&arg0.outstanding_borrowed, v7) + arg4);
        let v9 = ExecutorBorrowRecorded{
            executor : arg1,
            user     : arg2,
            amount   : arg4,
            day      : v0,
        };
        0x2::event::emit<ExecutorBorrowRecorded>(v9);
    }

    public(friend) fun record_settlement(arg0: &mut MarketingGuard, arg1: address, arg2: address, arg3: 0x2::object::ID, arg4: u64) {
        assert_version(arg0);
        if (arg4 == 0) {
            return
        };
        let v0 = BorrowKey{
            executor : arg1,
            user     : arg2,
            marker   : arg3,
        };
        let v1 = table_value_or_zero<BorrowKey>(&arg0.outstanding_borrowed, v0);
        assert!(arg4 <= v1, 304);
        let v2 = v1 - arg4;
        let v3 = &mut arg0.outstanding_borrowed;
        set_table_u64<BorrowKey>(v3, v0, v2);
        let v4 = ExecutorSettlementRecorded{
            executor              : arg1,
            user                  : arg2,
            principal             : arg4,
            remaining_outstanding : v2,
        };
        0x2::event::emit<ExecutorSettlementRecorded>(v4);
    }

    public fun set_borrow_caps(arg0: &mut MarketingGuard, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg4);
        assert_valid_caps(arg1, arg2, arg3);
        arg0.borrow_cap_per_tx = arg1;
        arg0.borrow_daily_cap = arg2;
        arg0.borrow_user_daily_cap = arg3;
        let v0 = BorrowCapsUpdated{
            per_tx     : arg1,
            daily      : arg2,
            user_daily : arg3,
        };
        0x2::event::emit<BorrowCapsUpdated>(v0);
    }

    fun set_table_u64<T0: copy + drop + store>(arg0: &mut 0x2::table::Table<T0, u64>, arg1: T0, arg2: u64) {
        if (0x2::table::contains<T0, u64>(arg0, arg1)) {
            *0x2::table::borrow_mut<T0, u64>(arg0, arg1) = arg2;
        } else {
            0x2::table::add<T0, u64>(arg0, arg1, arg2);
        };
    }

    fun table_value_or_zero<T0: copy + drop + store>(arg0: &0x2::table::Table<T0, u64>, arg1: T0) : u64 {
        if (0x2::table::contains<T0, u64>(arg0, arg1)) {
            *0x2::table::borrow<T0, u64>(arg0, arg1)
        } else {
            0
        }
    }

    public fun vault_id(arg0: &MarketingGuard) : 0x2::object::ID {
        assert_version(arg0);
        arg0.vault_id
    }

    // decompiled from Move bytecode v7
}

