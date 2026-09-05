module 0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss {
    struct SS has drop {
        dummy_field: bool,
    }

    struct ProtocolTreasury has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<SS>,
        post_genesis_minted_raw: u128,
        post_genesis_burned_raw: u128,
        supply_rollover_activated: bool,
        supply_rollover_current_day: u64,
    }

    struct SupplyDayKey has copy, drop, store {
        day: u64,
    }

    struct SupplyDayRecord has copy, drop, store {
        minted_raw: u128,
        burned_raw: u128,
        closed: bool,
    }

    struct ProtocolAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GenesisReserve has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<SS>,
    }

    struct ProtocolTreasuryV3 has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<SS>,
        post_genesis_minted_raw: u128,
        post_genesis_burned_raw: u128,
        supply_rollover_activated: bool,
        supply_rollover_current_day: u64,
        version: u64,
        legacy_treasury_id: 0x2::object::ID,
        settlement_book_id: 0x2::object::ID,
    }

    struct TreasuryMigrationScan has key {
        id: 0x2::object::UID,
        legacy_treasury_id: 0x2::object::ID,
        settlement_book_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        clock_day: u64,
        next_day: u64,
        minted_raw: u128,
        burned_raw: u128,
        rollover_day: u64,
        supply_raw: u64,
        ledger_days: vector<u64>,
    }

    struct TreasuryMigrationScanProgress has copy, drop {
        scan_id: 0x2::object::ID,
        legacy_treasury_id: 0x2::object::ID,
        next_day: u64,
        through_day: u64,
        ledger_count: u64,
        complete: bool,
    }

    struct ProtocolTreasuryMigratedV3 has copy, drop {
        old_treasury_id: 0x2::object::ID,
        new_treasury_id: 0x2::object::ID,
        settlement_book_id: 0x2::object::ID,
        records_migrated: u64,
        scanned_through_day: u64,
        minted_raw: u128,
        burned_raw: u128,
        total_supply_raw: u64,
    }

    public fun total_supply(arg0: &ProtocolTreasury) : u64 {
        0x2::coin::total_supply<SS>(&arg0.treasury_cap)
    }

    public(friend) fun activate_supply_rollover_cursor(arg0: &mut ProtocolTreasury, arg1: &0x2::clock::Clock) : u64 {
        assert!(!arg0.supply_rollover_activated, 30101);
        assert!(arg0.post_genesis_minted_raw == 0, 30102);
        assert!(arg0.post_genesis_burned_raw == 0, 30102);
        assert!(total_supply(arg0) == 1000000000000000, 30102);
        let v0 = 0x2::clock::timestamp_ms(arg1) / 86400000;
        arg0.supply_rollover_activated = true;
        arg0.supply_rollover_current_day = v0;
        v0
    }

    public(friend) fun activate_supply_rollover_cursor_v3(arg0: &mut ProtocolTreasuryV3, arg1: &0x2::clock::Clock) : u64 {
        assert_treasury_v3(arg0);
        assert!(!arg0.supply_rollover_activated, 30101);
        assert!(arg0.post_genesis_minted_raw == 0, 30102);
        assert!(arg0.post_genesis_burned_raw == 0, 30102);
        assert!(total_supply_v3(arg0) == 1000000000000000, 30102);
        let v0 = 0x2::clock::timestamp_ms(arg1) / 86400000;
        arg0.supply_rollover_activated = true;
        arg0.supply_rollover_current_day = v0;
        v0
    }

    public(friend) fun advance_treasury_migration_scan(arg0: &mut TreasuryMigrationScan, arg1: &ProtocolTreasury, arg2: &0x2::clock::Clock, arg3: u64) {
        assert_migration_scan_unchanged(arg0, arg1, arg2);
        let v0 = if (arg3 > 0) {
            if (arg3 <= 512) {
                arg0.next_day <= arg0.clock_day
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 31003);
        let v1 = arg0.next_day + arg3;
        let v2 = if (v1 < arg0.clock_day + 1) {
            v1
        } else {
            arg0.clock_day + 1
        };
        while (arg0.next_day < v2) {
            let v3 = arg0.next_day;
            let v4 = SupplyDayKey{day: v3};
            if (0x2::dynamic_field::exists<SupplyDayKey>(&arg1.id, v4)) {
                assert!(0x1::vector::length<u64>(&arg0.ledger_days) < 128, 31003);
                0x1::vector::push_back<u64>(&mut arg0.ledger_days, v3);
            };
            arg0.next_day = v3 + 1;
        };
        let v5 = TreasuryMigrationScanProgress{
            scan_id            : 0x2::object::id<TreasuryMigrationScan>(arg0),
            legacy_treasury_id : arg0.legacy_treasury_id,
            next_day           : arg0.next_day,
            through_day        : arg0.clock_day,
            ledger_count       : 0x1::vector::length<u64>(&arg0.ledger_days),
            complete           : arg0.next_day == arg0.clock_day + 1,
        };
        0x2::event::emit<TreasuryMigrationScanProgress>(v5);
    }

    fun assert_migration_scan_unchanged(arg0: &TreasuryMigrationScan, arg1: &ProtocolTreasury, arg2: &0x2::clock::Clock) {
        let v0 = if (arg0.legacy_treasury_id == 0x2::object::id<ProtocolTreasury>(arg1)) {
            if (arg1.supply_rollover_activated) {
                if (arg0.clock_day == 0x2::clock::timestamp_ms(arg2) / 86400000) {
                    if (arg0.minted_raw == arg1.post_genesis_minted_raw) {
                        if (arg0.burned_raw == arg1.post_genesis_burned_raw) {
                            if (arg0.rollover_day == arg1.supply_rollover_current_day) {
                                arg0.supply_raw == 0x2::coin::total_supply<SS>(&arg1.treasury_cap)
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 31004);
    }

    fun assert_treasury_v3(arg0: &ProtocolTreasuryV3) {
        assert!(arg0.version == 3, 31000);
    }

    public(friend) fun begin_treasury_migration_scan(arg0: &ProtocolAdminCap, arg1: &ProtocolTreasury, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : TreasuryMigrationScan {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 86400000;
        let v1 = if (v0 <= 100000) {
            if (arg1.supply_rollover_activated) {
                arg1.supply_rollover_current_day <= v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 31002);
        TreasuryMigrationScan{
            id                 : 0x2::object::new(arg4),
            legacy_treasury_id : 0x2::object::id<ProtocolTreasury>(arg1),
            settlement_book_id : arg2,
            admin_cap_id       : 0x2::object::id<ProtocolAdminCap>(arg0),
            clock_day          : v0,
            next_day           : 0,
            minted_raw         : arg1.post_genesis_minted_raw,
            burned_raw         : arg1.post_genesis_burned_raw,
            rollover_day       : arg1.supply_rollover_current_day,
            supply_raw         : 0x2::coin::total_supply<SS>(&arg1.treasury_cap),
            ledger_days        : vector[],
        }
    }

    fun burn_protocol_coin(arg0: &mut ProtocolTreasury, arg1: 0x2::coin::Coin<SS>) : u64 {
        let v0 = 0x2::coin::burn<SS>(&mut arg0.treasury_cap, arg1);
        arg0.post_genesis_burned_raw = arg0.post_genesis_burned_raw + (v0 as u128);
        v0
    }

    public(friend) fun burn_protocol_coin_current_day(arg0: &mut ProtocolTreasury, arg1: 0x2::coin::Coin<SS>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = burn_protocol_coin(arg0, arg1);
        record_supply_day_burn(arg0, 0x2::clock::timestamp_ms(arg2) / 86400000, (v0 as u128));
        v0
    }

    public(friend) fun burn_protocol_coin_current_day_v3(arg0: &mut ProtocolTreasuryV3, arg1: 0x2::coin::Coin<SS>, arg2: &0x2::clock::Clock) : u64 {
        assert_treasury_v3(arg0);
        let v0 = burn_protocol_coin_v3(arg0, arg1);
        record_supply_day_burn_v3(arg0, 0x2::clock::timestamp_ms(arg2) / 86400000, (v0 as u128));
        v0
    }

    fun burn_protocol_coin_v3(arg0: &mut ProtocolTreasuryV3, arg1: 0x2::coin::Coin<SS>) : u64 {
        assert_treasury_v3(arg0);
        let v0 = 0x2::coin::burn<SS>(&mut arg0.treasury_cap, arg1);
        arg0.post_genesis_burned_raw = arg0.post_genesis_burned_raw + (v0 as u128);
        v0
    }

    fun close_supply_day_record(arg0: &mut ProtocolTreasury, arg1: u64) : (u128, u128) {
        ensure_supply_day_record(arg0, arg1);
        let v0 = SupplyDayKey{day: arg1};
        let v1 = 0x2::dynamic_field::borrow_mut<SupplyDayKey, SupplyDayRecord>(&mut arg0.id, v0);
        assert!(!v1.closed, 3);
        v1.closed = true;
        (v1.minted_raw, v1.burned_raw)
    }

    fun close_supply_day_record_v3(arg0: &mut ProtocolTreasuryV3, arg1: u64) : (u128, u128) {
        assert_treasury_v3(arg0);
        ensure_supply_day_record_v3(arg0, arg1);
        let v0 = SupplyDayKey{day: arg1};
        let v1 = 0x2::dynamic_field::borrow_mut<SupplyDayKey, SupplyDayRecord>(&mut arg0.id, v0);
        assert!(!v1.closed, 3);
        v1.closed = true;
        (v1.minted_raw, v1.burned_raw)
    }

    public(friend) fun discard_treasury_migration_scan(arg0: &ProtocolAdminCap, arg1: TreasuryMigrationScan) {
        assert!(arg1.admin_cap_id == 0x2::object::id<ProtocolAdminCap>(arg0), 31003);
        let TreasuryMigrationScan {
            id                 : v0,
            legacy_treasury_id : _,
            settlement_book_id : _,
            admin_cap_id       : _,
            clock_day          : _,
            next_day           : _,
            minted_raw         : _,
            burned_raw         : _,
            rollover_day       : _,
            supply_raw         : _,
            ledger_days        : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    fun ensure_supply_day_record(arg0: &mut ProtocolTreasury, arg1: u64) {
        let v0 = SupplyDayKey{day: arg1};
        if (!0x2::dynamic_field::exists<SupplyDayKey>(&arg0.id, v0)) {
            let v1 = SupplyDayRecord{
                minted_raw : 0,
                burned_raw : 0,
                closed     : false,
            };
            0x2::dynamic_field::add<SupplyDayKey, SupplyDayRecord>(&mut arg0.id, v0, v1);
        };
    }

    fun ensure_supply_day_record_v3(arg0: &mut ProtocolTreasuryV3, arg1: u64) {
        assert_treasury_v3(arg0);
        let v0 = SupplyDayKey{day: arg1};
        if (!0x2::dynamic_field::exists<SupplyDayKey>(&arg0.id, v0)) {
            let v1 = SupplyDayRecord{
                minted_raw : 0,
                burned_raw : 0,
                closed     : false,
            };
            0x2::dynamic_field::add<SupplyDayKey, SupplyDayRecord>(&mut arg0.id, v0, v1);
        };
    }

    public(friend) fun finalize_current_supply_rollover_day(arg0: &mut ProtocolTreasury, arg1: 0x2::balance::Balance<SS>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (u64, u128, u128, u64) {
        assert!(arg0.supply_rollover_activated, 30100);
        let v0 = arg0.supply_rollover_current_day;
        assert!(v0 < 0x2::clock::timestamp_ms(arg2) / 86400000, 30103);
        assert!(!supply_day_closed(arg0, v0), 3);
        let v1 = 0x2::balance::value<SS>(&arg1);
        let v2 = if (v1 == 0) {
            0x2::balance::destroy_zero<SS>(arg1);
            0
        } else {
            let v3 = burn_protocol_coin(arg0, 0x2::coin::from_balance<SS>(arg1, arg3));
            assert!(v3 == v1, 30104);
            v3
        };
        record_supply_day_burn(arg0, v0, (v2 as u128));
        let (v4, v5) = close_supply_day_record(arg0, v0);
        arg0.supply_rollover_current_day = v0 + 1;
        (v0, v4, v5, v2)
    }

    public(friend) fun finalize_current_supply_rollover_day_v3(arg0: &mut ProtocolTreasuryV3, arg1: 0x2::balance::Balance<SS>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (u64, u128, u128, u64) {
        assert_treasury_v3(arg0);
        assert!(arg0.supply_rollover_activated, 30100);
        let v0 = arg0.supply_rollover_current_day;
        assert!(v0 < 0x2::clock::timestamp_ms(arg2) / 86400000, 30103);
        assert!(!supply_day_closed_v3(arg0, v0), 3);
        let v1 = 0x2::balance::value<SS>(&arg1);
        let v2 = if (v1 == 0) {
            0x2::balance::destroy_zero<SS>(arg1);
            0
        } else {
            let v3 = burn_protocol_coin_v3(arg0, 0x2::coin::from_balance<SS>(arg1, arg3));
            assert!(v3 == v1, 30104);
            v3
        };
        record_supply_day_burn_v3(arg0, v0, (v2 as u128));
        let (v4, v5) = close_supply_day_record_v3(arg0, v0);
        arg0.supply_rollover_current_day = v0 + 1;
        (v0, v4, v5, v2)
    }

    public fun genesis_reserve_balance(arg0: &GenesisReserve) : u64 {
        0x2::balance::value<SS>(&arg0.balance)
    }

    fun init(arg0: SS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SS>(arg0, 9, 0x1::string::utf8(b"SS"), 0x1::string::utf8(b"SuiSword"), 0x1::string::utf8(b"SuiSword protocol token. Strengthen your sword, expand mining power, and participate in the SuiSword economy."), 0x1::string::utf8(b""), arg1);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SS>>(0x2::coin_registry::finalize<SS>(v0, arg1), 0x2::tx_context::sender(arg1));
        let v3 = ProtocolAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<ProtocolAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = GenesisReserve{
            id      : 0x2::object::new(arg1),
            balance : 0x2::coin::into_balance<SS>(0x2::coin::mint<SS>(&mut v2, 1000000000000000, arg1)),
        };
        0x2::transfer::share_object<GenesisReserve>(v4);
        let v5 = ProtocolTreasury{
            id                          : 0x2::object::new(arg1),
            treasury_cap                : v2,
            post_genesis_minted_raw     : 0,
            post_genesis_burned_raw     : 0,
            supply_rollover_activated   : false,
            supply_rollover_current_day : 0,
        };
        0x2::transfer::share_object<ProtocolTreasury>(v5);
    }

    public(friend) fun migrate_protocol_treasury_v3(arg0: &ProtocolAdminCap, arg1: ProtocolTreasury, arg2: TreasuryMigrationScan, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : ProtocolTreasuryV3 {
        assert_migration_scan_unchanged(&arg2, &arg1, arg4);
        let v0 = if (arg2.admin_cap_id == 0x2::object::id<ProtocolAdminCap>(arg0)) {
            if (arg2.settlement_book_id == arg3) {
                arg2.next_day == arg2.clock_day + 1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 31003);
        let TreasuryMigrationScan {
            id                 : v1,
            legacy_treasury_id : _,
            settlement_book_id : _,
            admin_cap_id       : _,
            clock_day          : v5,
            next_day           : _,
            minted_raw         : _,
            burned_raw         : _,
            rollover_day       : _,
            supply_raw         : _,
            ledger_days        : v11,
        } = arg2;
        let v12 = v11;
        let ProtocolTreasury {
            id                          : v13,
            treasury_cap                : v14,
            post_genesis_minted_raw     : v15,
            post_genesis_burned_raw     : v16,
            supply_rollover_activated   : v17,
            supply_rollover_current_day : v18,
        } = arg1;
        let v19 = v13;
        let v20 = 0x2::object::uid_to_inner(&v19);
        let v21 = ProtocolTreasuryV3{
            id                          : 0x2::object::new(arg5),
            treasury_cap                : v14,
            post_genesis_minted_raw     : v15,
            post_genesis_burned_raw     : v16,
            supply_rollover_activated   : v17,
            supply_rollover_current_day : v18,
            version                     : 3,
            legacy_treasury_id          : v20,
            settlement_book_id          : arg3,
        };
        let v22 = 0;
        let v23 = 0x1::vector::length<u64>(&v12);
        let v24 = 0;
        let v25 = 0;
        while (v22 < v23) {
            let v26 = SupplyDayKey{day: *0x1::vector::borrow<u64>(&v12, v22)};
            let v27 = 0x2::dynamic_field::remove<SupplyDayKey, SupplyDayRecord>(&mut v19, v26);
            v24 = v24 + v27.minted_raw;
            v25 = v25 + v27.burned_raw;
            0x2::dynamic_field::add<SupplyDayKey, SupplyDayRecord>(&mut v21.id, v26, v27);
            v22 = v22 + 1;
        };
        assert!(v24 == v15 && v25 == v16, 31001);
        let v28 = 0x2::coin::total_supply<SS>(&v21.treasury_cap);
        assert!((v28 as u128) + v25 == (1000000000000000 as u128) + v24, 31001);
        0x2::object::delete(v19);
        0x2::object::delete(v1);
        let v29 = ProtocolTreasuryMigratedV3{
            old_treasury_id     : v20,
            new_treasury_id     : 0x2::object::id<ProtocolTreasuryV3>(&v21),
            settlement_book_id  : arg3,
            records_migrated    : v23,
            scanned_through_day : v5,
            minted_raw          : v24,
            burned_raw          : v25,
            total_supply_raw    : v28,
        };
        0x2::event::emit<ProtocolTreasuryMigratedV3>(v29);
        v21
    }

    fun mint_protocol_balance(arg0: &mut ProtocolTreasury, arg1: u64) : 0x2::balance::Balance<SS> {
        arg0.post_genesis_minted_raw = arg0.post_genesis_minted_raw + (arg1 as u128);
        0x2::coin::mint_balance<SS>(&mut arg0.treasury_cap, arg1)
    }

    public(friend) fun mint_protocol_balance_current_day(arg0: &mut ProtocolTreasury, arg1: u64, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<SS> {
        let v0 = mint_protocol_balance(arg0, arg1);
        record_supply_day_mint(arg0, 0x2::clock::timestamp_ms(arg2) / 86400000, (arg1 as u128));
        v0
    }

    public(friend) fun mint_protocol_balance_current_day_v3(arg0: &mut ProtocolTreasuryV3, arg1: u64, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<SS> {
        assert_treasury_v3(arg0);
        let v0 = mint_protocol_balance_v3(arg0, arg1);
        record_supply_day_mint_v3(arg0, 0x2::clock::timestamp_ms(arg2) / 86400000, (arg1 as u128));
        v0
    }

    fun mint_protocol_balance_v3(arg0: &mut ProtocolTreasuryV3, arg1: u64) : 0x2::balance::Balance<SS> {
        assert_treasury_v3(arg0);
        arg0.post_genesis_minted_raw = arg0.post_genesis_minted_raw + (arg1 as u128);
        0x2::coin::mint_balance<SS>(&mut arg0.treasury_cap, arg1)
    }

    public fun post_genesis_burned_raw(arg0: &ProtocolTreasury) : u128 {
        arg0.post_genesis_burned_raw
    }

    public fun post_genesis_burned_raw_v3(arg0: &ProtocolTreasuryV3) : u128 {
        assert_treasury_v3(arg0);
        arg0.post_genesis_burned_raw
    }

    public fun post_genesis_minted_raw(arg0: &ProtocolTreasury) : u128 {
        arg0.post_genesis_minted_raw
    }

    public fun post_genesis_minted_raw_v3(arg0: &ProtocolTreasuryV3) : u128 {
        assert_treasury_v3(arg0);
        arg0.post_genesis_minted_raw
    }

    fun record_supply_day_burn(arg0: &mut ProtocolTreasury, arg1: u64, arg2: u128) {
        ensure_supply_day_record(arg0, arg1);
        let v0 = SupplyDayKey{day: arg1};
        let v1 = 0x2::dynamic_field::borrow_mut<SupplyDayKey, SupplyDayRecord>(&mut arg0.id, v0);
        assert!(!v1.closed, 3);
        v1.burned_raw = v1.burned_raw + arg2;
    }

    fun record_supply_day_burn_v3(arg0: &mut ProtocolTreasuryV3, arg1: u64, arg2: u128) {
        assert_treasury_v3(arg0);
        ensure_supply_day_record_v3(arg0, arg1);
        let v0 = SupplyDayKey{day: arg1};
        let v1 = 0x2::dynamic_field::borrow_mut<SupplyDayKey, SupplyDayRecord>(&mut arg0.id, v0);
        assert!(!v1.closed, 3);
        v1.burned_raw = v1.burned_raw + arg2;
    }

    fun record_supply_day_mint(arg0: &mut ProtocolTreasury, arg1: u64, arg2: u128) {
        ensure_supply_day_record(arg0, arg1);
        let v0 = SupplyDayKey{day: arg1};
        let v1 = 0x2::dynamic_field::borrow_mut<SupplyDayKey, SupplyDayRecord>(&mut arg0.id, v0);
        assert!(!v1.closed, 3);
        v1.minted_raw = v1.minted_raw + arg2;
    }

    fun record_supply_day_mint_v3(arg0: &mut ProtocolTreasuryV3, arg1: u64, arg2: u128) {
        assert_treasury_v3(arg0);
        ensure_supply_day_record_v3(arg0, arg1);
        let v0 = SupplyDayKey{day: arg1};
        let v1 = 0x2::dynamic_field::borrow_mut<SupplyDayKey, SupplyDayRecord>(&mut arg0.id, v0);
        assert!(!v1.closed, 3);
        v1.minted_raw = v1.minted_raw + arg2;
    }

    public(friend) fun share_protocol_treasury_v3(arg0: ProtocolTreasuryV3) {
        assert_treasury_v3(&arg0);
        0x2::transfer::share_object<ProtocolTreasuryV3>(arg0);
    }

    public(friend) fun share_treasury_migration_scan(arg0: TreasuryMigrationScan) {
        0x2::transfer::share_object<TreasuryMigrationScan>(arg0);
    }

    public fun supply_day_burned_raw(arg0: &ProtocolTreasury, arg1: u64) : u128 {
        let v0 = SupplyDayKey{day: arg1};
        if (!0x2::dynamic_field::exists<SupplyDayKey>(&arg0.id, v0)) {
            0
        } else {
            0x2::dynamic_field::borrow<SupplyDayKey, SupplyDayRecord>(&arg0.id, v0).burned_raw
        }
    }

    public fun supply_day_burned_raw_v3(arg0: &ProtocolTreasuryV3, arg1: u64) : u128 {
        assert_treasury_v3(arg0);
        let v0 = SupplyDayKey{day: arg1};
        if (!0x2::dynamic_field::exists<SupplyDayKey>(&arg0.id, v0)) {
            0
        } else {
            0x2::dynamic_field::borrow<SupplyDayKey, SupplyDayRecord>(&arg0.id, v0).burned_raw
        }
    }

    public fun supply_day_closed(arg0: &ProtocolTreasury, arg1: u64) : bool {
        let v0 = SupplyDayKey{day: arg1};
        !0x2::dynamic_field::exists<SupplyDayKey>(&arg0.id, v0) && false || 0x2::dynamic_field::borrow<SupplyDayKey, SupplyDayRecord>(&arg0.id, v0).closed
    }

    public fun supply_day_closed_v3(arg0: &ProtocolTreasuryV3, arg1: u64) : bool {
        assert_treasury_v3(arg0);
        let v0 = SupplyDayKey{day: arg1};
        !0x2::dynamic_field::exists<SupplyDayKey>(&arg0.id, v0) && false || 0x2::dynamic_field::borrow<SupplyDayKey, SupplyDayRecord>(&arg0.id, v0).closed
    }

    public fun supply_day_exists(arg0: &ProtocolTreasury, arg1: u64) : bool {
        let v0 = SupplyDayKey{day: arg1};
        0x2::dynamic_field::exists<SupplyDayKey>(&arg0.id, v0)
    }

    public fun supply_day_exists_v3(arg0: &ProtocolTreasuryV3, arg1: u64) : bool {
        assert_treasury_v3(arg0);
        let v0 = SupplyDayKey{day: arg1};
        0x2::dynamic_field::exists<SupplyDayKey>(&arg0.id, v0)
    }

    public fun supply_day_minted_raw(arg0: &ProtocolTreasury, arg1: u64) : u128 {
        let v0 = SupplyDayKey{day: arg1};
        if (!0x2::dynamic_field::exists<SupplyDayKey>(&arg0.id, v0)) {
            0
        } else {
            0x2::dynamic_field::borrow<SupplyDayKey, SupplyDayRecord>(&arg0.id, v0).minted_raw
        }
    }

    public fun supply_day_minted_raw_v3(arg0: &ProtocolTreasuryV3, arg1: u64) : u128 {
        assert_treasury_v3(arg0);
        let v0 = SupplyDayKey{day: arg1};
        if (!0x2::dynamic_field::exists<SupplyDayKey>(&arg0.id, v0)) {
            0
        } else {
            0x2::dynamic_field::borrow<SupplyDayKey, SupplyDayRecord>(&arg0.id, v0).minted_raw
        }
    }

    public fun supply_rollover_activated(arg0: &ProtocolTreasury) : bool {
        arg0.supply_rollover_activated
    }

    public fun supply_rollover_activated_v3(arg0: &ProtocolTreasuryV3) : bool {
        assert_treasury_v3(arg0);
        arg0.supply_rollover_activated
    }

    public fun supply_rollover_current_day(arg0: &ProtocolTreasury) : u64 {
        arg0.supply_rollover_current_day
    }

    public fun supply_rollover_current_day_v3(arg0: &ProtocolTreasuryV3) : u64 {
        assert_treasury_v3(arg0);
        arg0.supply_rollover_current_day
    }

    public fun total_supply_v3(arg0: &ProtocolTreasuryV3) : u64 {
        assert_treasury_v3(arg0);
        0x2::coin::total_supply<SS>(&arg0.treasury_cap)
    }

    public fun treasury_migration_scan_complete(arg0: &TreasuryMigrationScan) : bool {
        arg0.next_day == arg0.clock_day + 1
    }

    public fun treasury_migration_scan_next_day(arg0: &TreasuryMigrationScan) : u64 {
        arg0.next_day
    }

    public(friend) fun treasury_uid_mut(arg0: &mut ProtocolTreasury) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun treasury_uid_mut_v3(arg0: &mut ProtocolTreasuryV3) : &mut 0x2::object::UID {
        assert_treasury_v3(arg0);
        &mut arg0.id
    }

    public fun treasury_v3_book_id(arg0: &ProtocolTreasuryV3) : 0x2::object::ID {
        assert_treasury_v3(arg0);
        arg0.settlement_book_id
    }

    public fun treasury_v3_legacy_id(arg0: &ProtocolTreasuryV3) : 0x2::object::ID {
        assert_treasury_v3(arg0);
        arg0.legacy_treasury_id
    }

    public fun withdraw_genesis_reserve(arg0: &ProtocolAdminCap, arg1: &mut GenesisReserve, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        assert!(arg2 <= 0x2::balance::value<SS>(&arg1.balance), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SS>>(0x2::coin::from_balance<SS>(0x2::balance::split<SS>(&mut arg1.balance, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v7
}

