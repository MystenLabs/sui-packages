module 0xd58511b76ff7a309dc6f395084785c8ccda47d9d869e67aeba3da46b5d08f29e::ledger {
    struct AuditLog has key {
        id: 0x2::object::UID,
        entries: 0x2::table::Table<0x1::ascii::String, TrailConfig>,
        version: u8,
    }

    struct TrailConfig has store {
        owner: address,
        auditor: address,
        status: u8,
        compliant_sink: address,
        exception_sink: address,
        compliance_rate: u8,
        entries: 0x2::table::Table<0x2::object::ID, LogEntry>,
    }

    struct LogEntry has copy, drop, store {
        entry_type: 0x1::ascii::String,
        severity: u64,
        logged: bool,
    }

    struct TrailCreated has copy, drop {
        trail_id: 0x1::ascii::String,
        owner: address,
    }

    struct EntryAdded has copy, drop {
        trail_id: 0x1::ascii::String,
        entry_id: 0x2::object::ID,
        entry_type: 0x1::ascii::String,
        severity: u64,
    }

    struct LoggingCompleted has copy, drop {
        trail_id: 0x1::ascii::String,
        entry_id: 0x2::object::ID,
        result_severity: u64,
    }

    public entry fun add_entry(arg0: &mut AuditLog, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x1::ascii::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, TrailConfig>(&arg0.entries, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, TrailConfig>(&mut arg0.entries, arg1);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.owner || v1 == v0.auditor, 100);
        let v2 = LogEntry{
            entry_type : arg3,
            severity   : arg4,
            logged     : false,
        };
        if (0x2::table::contains<0x2::object::ID, LogEntry>(&v0.entries, arg2)) {
            *0x2::table::borrow_mut<0x2::object::ID, LogEntry>(&mut v0.entries, arg2) = v2;
        } else {
            0x2::table::add<0x2::object::ID, LogEntry>(&mut v0.entries, arg2, v2);
        };
        let v3 = EntryAdded{
            trail_id   : arg1,
            entry_id   : arg2,
            entry_type : arg3,
            severity   : arg4,
        };
        0x2::event::emit<EntryAdded>(v3);
    }

    public fun archive_entry(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut AuditLog, arg2: 0x1::ascii::String, arg3: 0x2::object::ID, arg4: 0x3::staking_pool::StakedSui, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, TrailConfig>(&arg1.entries, arg2), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, TrailConfig>(&mut arg1.entries, arg2);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.auditor, 100);
        if (!(v0.status & 1 != 0)) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, LogEntry>(&v0.entries, arg3)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, LogEntry>(&v0.entries, arg3);
            !v3.logged && v3.severity > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, LogEntry>(&v0.entries, arg3)) {
            0x2::table::borrow_mut<0x2::object::ID, LogEntry>(&mut v0.entries, arg3).logged = true;
        };
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg0, arg4, arg5), arg5);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&v4);
        let v6 = v5 * (v0.compliance_rate as u64) / 100;
        if (v6 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.exception_sink);
        } else if (v6 == v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.compliant_sink);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v6, arg5), v0.compliant_sink);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.exception_sink);
        };
        let v7 = LoggingCompleted{
            trail_id        : arg2,
            entry_id        : arg3,
            result_severity : v5,
        };
        0x2::event::emit<LoggingCompleted>(v7);
    }

    public entry fun create_trail(arg0: &mut AuditLog, arg1: 0x1::ascii::String, arg2: address, arg3: address, arg4: address, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 <= 100, 106);
        let v0 = TrailConfig{
            owner           : 0x2::tx_context::sender(arg6),
            auditor         : arg2,
            status          : 0,
            compliant_sink  : arg3,
            exception_sink  : arg4,
            compliance_rate : arg5,
            entries         : 0x2::table::new<0x2::object::ID, LogEntry>(arg6),
        };
        0x2::table::add<0x1::ascii::String, TrailConfig>(&mut arg0.entries, arg1, v0);
        let v1 = TrailCreated{
            trail_id : arg1,
            owner    : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<TrailCreated>(v1);
    }

    public fun get_entry_info(arg0: &AuditLog, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : (0x1::ascii::String, u64, bool) {
        assert!(0x2::table::contains<0x1::ascii::String, TrailConfig>(&arg0.entries, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, TrailConfig>(&arg0.entries, arg1);
        assert!(0x2::table::contains<0x2::object::ID, LogEntry>(&v0.entries, arg2), 102);
        let v1 = 0x2::table::borrow<0x2::object::ID, LogEntry>(&v0.entries, arg2);
        (v1.entry_type, v1.severity, v1.logged)
    }

    public fun get_entry_severity(arg0: &AuditLog, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : u64 {
        assert!(0x2::table::contains<0x1::ascii::String, TrailConfig>(&arg0.entries, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, TrailConfig>(&arg0.entries, arg1);
        if (v0.status & 1 == 0) {
            return 0
        };
        if (!0x2::table::contains<0x2::object::ID, LogEntry>(&v0.entries, arg2)) {
            return 0
        };
        let v1 = 0x2::table::borrow<0x2::object::ID, LogEntry>(&v0.entries, arg2);
        if (v1.logged) {
            return 0
        };
        v1.severity
    }

    public fun get_trail_info(arg0: &AuditLog, arg1: 0x1::ascii::String) : (address, address, bool, address, address, u8) {
        assert!(0x2::table::contains<0x1::ascii::String, TrailConfig>(&arg0.entries, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, TrailConfig>(&arg0.entries, arg1);
        (v0.owner, v0.auditor, v0.status & 1 != 0, v0.compliant_sink, v0.exception_sink, v0.compliance_rate)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AuditLog{
            id      : 0x2::object::new(arg0),
            entries : 0x2::table::new<0x1::ascii::String, TrailConfig>(arg0),
            version : 1,
        };
        0x2::transfer::share_object<AuditLog>(v0);
    }

    public fun log_batch<T0>(arg0: &mut AuditLog, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, TrailConfig>(&arg0.entries, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, TrailConfig>(&mut arg0.entries, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.auditor, 100);
        let v2 = 0x2::coin::value<T0>(&arg3);
        if (v2 == 0 || !(v0.status & 1 != 0)) {
            if (v2 == 0) {
                0x2::coin::destroy_zero<T0>(arg3);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v1);
            };
            return
        };
        if (0x2::table::contains<0x2::object::ID, LogEntry>(&v0.entries, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, LogEntry>(&mut v0.entries, arg2).logged = true;
        };
        let v3 = v2 * (v0.compliance_rate as u64) / 100;
        if (v3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.exception_sink);
        } else if (v3 == v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.compliant_sink);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v3, arg4), v0.compliant_sink);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.exception_sink);
        };
        let v4 = LoggingCompleted{
            trail_id        : arg1,
            entry_id        : arg2,
            result_severity : v2,
        };
        0x2::event::emit<LoggingCompleted>(v4);
    }

    public fun record_event<T0: store + key>(arg0: &mut AuditLog, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, TrailConfig>(&arg0.entries, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, TrailConfig>(&mut arg0.entries, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.auditor, 100);
        if (!(v0.status & 1 != 0)) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, LogEntry>(&v0.entries, arg2)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, LogEntry>(&v0.entries, arg2);
            !v3.logged && v3.severity > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, LogEntry>(&v0.entries, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, LogEntry>(&mut v0.entries, arg2).logged = true;
        };
        0x2::transfer::public_transfer<T0>(arg3, v0.compliant_sink);
        let v4 = LoggingCompleted{
            trail_id        : arg1,
            entry_id        : arg2,
            result_severity : 1,
        };
        0x2::event::emit<LoggingCompleted>(v4);
    }

    public entry fun seal_trail(arg0: &mut AuditLog, arg1: 0x1::ascii::String, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, TrailConfig>(&arg0.entries, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, TrailConfig>(&mut arg0.entries, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.owner, 100);
        if (arg2) {
            v0.status = v0.status | 1;
        } else {
            v0.status = v0.status & (255 ^ 1);
        };
    }

    public fun should_log(arg0: &AuditLog, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : bool {
        get_entry_severity(arg0, arg1, arg2) > 0
    }

    public entry fun update_severity(arg0: &mut AuditLog, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, TrailConfig>(&arg0.entries, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, TrailConfig>(&mut arg0.entries, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.owner || v1 == v0.auditor, 100);
        assert!(0x2::table::contains<0x2::object::ID, LogEntry>(&v0.entries, arg2), 102);
        0x2::table::borrow_mut<0x2::object::ID, LogEntry>(&mut v0.entries, arg2).severity = arg3;
    }

    // decompiled from Move bytecode v6
}

