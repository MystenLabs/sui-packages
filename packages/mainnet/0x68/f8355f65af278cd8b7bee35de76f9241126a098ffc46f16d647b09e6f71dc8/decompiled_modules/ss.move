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

    fun close_supply_day_record(arg0: &mut ProtocolTreasury, arg1: u64) : (u128, u128) {
        ensure_supply_day_record(arg0, arg1);
        let v0 = SupplyDayKey{day: arg1};
        let v1 = 0x2::dynamic_field::borrow_mut<SupplyDayKey, SupplyDayRecord>(&mut arg0.id, v0);
        assert!(!v1.closed, 3);
        v1.closed = true;
        (v1.minted_raw, v1.burned_raw)
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

    fun mint_protocol_balance(arg0: &mut ProtocolTreasury, arg1: u64) : 0x2::balance::Balance<SS> {
        arg0.post_genesis_minted_raw = arg0.post_genesis_minted_raw + (arg1 as u128);
        0x2::coin::mint_balance<SS>(&mut arg0.treasury_cap, arg1)
    }

    public(friend) fun mint_protocol_balance_current_day(arg0: &mut ProtocolTreasury, arg1: u64, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<SS> {
        let v0 = mint_protocol_balance(arg0, arg1);
        record_supply_day_mint(arg0, 0x2::clock::timestamp_ms(arg2) / 86400000, (arg1 as u128));
        v0
    }

    public fun post_genesis_burned_raw(arg0: &ProtocolTreasury) : u128 {
        arg0.post_genesis_burned_raw
    }

    public fun post_genesis_minted_raw(arg0: &ProtocolTreasury) : u128 {
        arg0.post_genesis_minted_raw
    }

    fun record_supply_day_burn(arg0: &mut ProtocolTreasury, arg1: u64, arg2: u128) {
        ensure_supply_day_record(arg0, arg1);
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

    public fun supply_day_burned_raw(arg0: &ProtocolTreasury, arg1: u64) : u128 {
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

    public fun supply_day_exists(arg0: &ProtocolTreasury, arg1: u64) : bool {
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

    public fun supply_rollover_activated(arg0: &ProtocolTreasury) : bool {
        arg0.supply_rollover_activated
    }

    public fun supply_rollover_current_day(arg0: &ProtocolTreasury) : u64 {
        arg0.supply_rollover_current_day
    }

    public(friend) fun treasury_uid_mut(arg0: &mut ProtocolTreasury) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun withdraw_genesis_reserve(arg0: &ProtocolAdminCap, arg1: &mut GenesisReserve, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        assert!(arg2 <= 0x2::balance::value<SS>(&arg1.balance), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SS>>(0x2::coin::from_balance<SS>(0x2::balance::split<SS>(&mut arg1.balance, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v7
}

