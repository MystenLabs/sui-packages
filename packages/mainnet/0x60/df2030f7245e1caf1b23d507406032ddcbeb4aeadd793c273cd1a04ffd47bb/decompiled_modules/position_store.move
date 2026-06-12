module 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position_store {
    struct StoredPosition has copy, drop, store {
        owner: address,
        market_id: 0x2::object::ID,
        direction: u8,
        size: u64,
        entry_price: u64,
        collateral: u64,
        initial_margin_ratio_bps_at_open: u64,
        maintenance_margin_ratio_bps_at_open: u64,
        global_funding_index_snapshot: u128,
        global_funding_index_snapshot_is_negative: bool,
        short_borrow_index_snapshot: u128,
        locked_for_liquidation: bool,
        last_modified_ms: u64,
    }

    struct PositionStore has key {
        id: 0x2::object::UID,
        positions: 0x2::table::Table<vector<u8>, StoredPosition>,
        market_positions: 0x2::linked_table::LinkedTable<0x2::object::ID, vector<address>>,
        count: u64,
    }

    struct LiquidationLock {
        trader: address,
        market_id: 0x2::object::ID,
    }

    struct StorePositionOpened has copy, drop {
        owner: address,
        market_id: 0x2::object::ID,
        direction: u8,
        size: u64,
        entry_price: u64,
        collateral: u64,
    }

    struct StorePositionUpdated has copy, drop {
        owner: address,
        market_id: 0x2::object::ID,
        old_size: u64,
        new_size: u64,
        new_entry_price: u64,
        new_collateral: u64,
    }

    struct StorePositionClosed has copy, drop {
        owner: address,
        market_id: 0x2::object::ID,
        direction: u8,
        closed_size: u64,
    }

    struct FundingApplied has copy, drop {
        owner: address,
        market_id: 0x2::object::ID,
        direction: u8,
        funding_amount: u64,
        funding_is_cost: bool,
        borrow_amount: u64,
        old_collateral: u64,
        new_collateral: u64,
        global_funding_index_snapshot: u128,
        global_funding_index_snapshot_is_negative: bool,
        short_borrow_index_snapshot: u128,
    }

    fun add_signed_u128(arg0: u128, arg1: bool, arg2: u128, arg3: bool) : (u128, bool) {
        if (arg1 == arg3) {
            (arg0 + arg2, arg1)
        } else if (arg0 > arg2) {
            (arg0 - arg2, arg1)
        } else if (arg2 > arg0) {
            (arg2 - arg0, arg3)
        } else {
            (0, false)
        }
    }

    public(friend) fun apply_funding_to_position(arg0: &mut PositionStore, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: u128, arg5: bool, arg6: u128, arg7: u64) : bool {
        let v0 = make_key(arg1, arg2);
        assert!(0x2::table::contains<vector<u8>, StoredPosition>(&arg0.positions, v0), 0);
        let v1 = 0x2::table::borrow_mut<vector<u8>, StoredPosition>(&mut arg0.positions, v0);
        let v2 = if (v1.global_funding_index_snapshot == arg4) {
            if (v1.global_funding_index_snapshot_is_negative == arg5) {
                v1.short_borrow_index_snapshot == arg6
            } else {
                false
            }
        } else {
            false
        };
        if (v2) {
            return false
        };
        let v3 = (((v1.size as u128) * (arg3 as u128) / 1000000000) as u64);
        let (v4, v5) = compute_owed_funding(v1.direction, v3, arg4, arg5, v1.global_funding_index_snapshot, v1.global_funding_index_snapshot_is_negative);
        let v6 = if (v1.direction == 1) {
            compute_owed_borrow(v3, arg6, v1.short_borrow_index_snapshot)
        } else {
            0
        };
        v1.collateral = apply_settlement_to_collateral(v1.collateral, v4, v5, v6);
        v1.global_funding_index_snapshot = arg4;
        v1.global_funding_index_snapshot_is_negative = arg5;
        v1.short_borrow_index_snapshot = arg6;
        v1.last_modified_ms = arg7;
        if (v4 > 0 || v6 > 0) {
            let v7 = FundingApplied{
                owner                                     : arg1,
                market_id                                 : arg2,
                direction                                 : v1.direction,
                funding_amount                            : v4,
                funding_is_cost                           : v5,
                borrow_amount                             : v6,
                old_collateral                            : v1.collateral,
                new_collateral                            : v1.collateral,
                global_funding_index_snapshot             : arg4,
                global_funding_index_snapshot_is_negative : arg5,
                short_borrow_index_snapshot               : arg6,
            };
            0x2::event::emit<FundingApplied>(v7);
        };
        true
    }

    fun apply_settlement_to_collateral(arg0: u64, arg1: u64, arg2: bool, arg3: u64) : u64 {
        let v0 = (arg0 as u128);
        let v1 = if (arg2) {
            if ((arg1 as u128) >= v0) {
                0
            } else {
                v0 - (arg1 as u128)
            }
        } else {
            v0 + (arg1 as u128)
        };
        if ((arg3 as u128) >= v1) {
            0
        } else {
            ((v1 - (arg3 as u128)) as u64)
        }
    }

    public(friend) fun close_position<T0>(arg0: &mut PositionStore, arg1: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_bank::MarginBank<T0>, arg2: address, arg3: 0x2::object::ID, arg4: u64) : StoredPosition {
        let v0 = make_key(arg2, arg3);
        assert!(0x2::table::contains<vector<u8>, StoredPosition>(&arg0.positions, v0), 0);
        let v1 = 0x2::table::remove<vector<u8>, StoredPosition>(&mut arg0.positions, v0);
        remove_market_owner(arg0, arg3, arg2);
        arg0.count = arg0.count - 1;
        let v2 = v1.collateral;
        assert!(arg4 <= v2, 4);
        if (arg4 > 0) {
            0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_bank::unlock_collateral<T0>(arg1, arg2, arg4);
        };
        let v3 = v2 - arg4;
        if (v3 > 0) {
            0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_bank::slash_locked<T0>(arg1, arg2, v3);
        };
        let v4 = StorePositionClosed{
            owner       : arg2,
            market_id   : arg3,
            direction   : v1.direction,
            closed_size : v1.size,
        };
        0x2::event::emit<StorePositionClosed>(v4);
        v1
    }

    public(friend) fun close_position_for_liquidation<T0>(arg0: &mut PositionStore, arg1: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_bank::MarginBank<T0>, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: LiquidationLock) : StoredPosition {
        let LiquidationLock {
            trader    : v0,
            market_id : v1,
        } = arg5;
        assert!(v0 == arg2 && v1 == arg3, 6);
        close_position<T0>(arg0, arg1, arg2, arg3, arg4)
    }

    fun compute_index_delta(arg0: u128, arg1: bool, arg2: u128, arg3: bool) : (u128, bool) {
        let (v0, v1) = if (arg2 == 0) {
            (0, false)
        } else {
            (arg2, !arg3)
        };
        add_signed_u128(arg0, arg1, v0, v1)
    }

    fun compute_owed_borrow(arg0: u64, arg1: u128, arg2: u128) : u64 {
        if (arg1 <= arg2 || arg0 == 0) {
            return 0
        };
        (((arg0 as u128) * (arg1 - arg2) / 1000000000000000000) as u64)
    }

    fun compute_owed_funding(arg0: u8, arg1: u64, arg2: u128, arg3: bool, arg4: u128, arg5: bool) : (u64, bool) {
        let (v0, v1) = compute_index_delta(arg2, arg3, arg4, arg5);
        if (v0 == 0 || arg1 == 0) {
            return (0, false)
        };
        let v2 = arg0 == 0 && !v1 || v1;
        ((((arg1 as u128) * v0 / 1000000000000000000) as u64), v2)
    }

    public fun create_position_store(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PositionStore{
            id               : 0x2::object::new(arg1),
            positions        : 0x2::table::new<vector<u8>, StoredPosition>(arg1),
            market_positions : 0x2::linked_table::new<0x2::object::ID, vector<address>>(arg1),
            count            : 0,
        };
        0x2::transfer::share_object<PositionStore>(v0);
    }

    public fun get_position(arg0: &PositionStore, arg1: address, arg2: 0x2::object::ID) : &StoredPosition {
        let v0 = make_key(arg1, arg2);
        assert!(0x2::table::contains<vector<u8>, StoredPosition>(&arg0.positions, v0), 0);
        0x2::table::borrow<vector<u8>, StoredPosition>(&arg0.positions, v0)
    }

    public fun has_position(arg0: &PositionStore, arg1: address, arg2: 0x2::object::ID) : bool {
        0x2::table::contains<vector<u8>, StoredPosition>(&arg0.positions, make_key(arg1, arg2))
    }

    public(friend) fun lock_for_liquidation(arg0: &mut PositionStore, arg1: address, arg2: 0x2::object::ID) : LiquidationLock {
        let v0 = make_key(arg1, arg2);
        assert!(0x2::table::contains<vector<u8>, StoredPosition>(&arg0.positions, v0), 0);
        let v1 = 0x2::table::borrow_mut<vector<u8>, StoredPosition>(&mut arg0.positions, v0);
        assert!(!v1.locked_for_liquidation, 5);
        v1.locked_for_liquidation = true;
        LiquidationLock{
            trader    : arg1,
            market_id : arg2,
        }
    }

    public fun make_key(arg0: address, arg1: 0x2::object::ID) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<address>(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg1));
        v0
    }

    fun market_owners_snapshot(arg0: &PositionStore, arg1: 0x2::object::ID) : vector<address> {
        let v0 = 0x2::linked_table::borrow<0x2::object::ID, vector<address>>(&arg0.market_positions, arg1);
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(v0)) {
            0x1::vector::push_back<address>(&mut v1, *0x1::vector::borrow<address>(v0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun open_position(arg0: &mut PositionStore, arg1: address, arg2: 0x2::object::ID, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: bool, arg9: u128, arg10: u64, arg11: u64, arg12: u64) {
        assert!(arg3 == 0 || arg3 == 1, 3);
        assert!(arg4 > 0, 2);
        assert!(arg5 > 0, 4);
        let v0 = make_key(arg1, arg2);
        assert!(!0x2::table::contains<vector<u8>, StoredPosition>(&arg0.positions, v0), 1);
        if (!0x2::linked_table::contains<0x2::object::ID, vector<address>>(&arg0.market_positions, arg2)) {
            0x2::linked_table::push_back<0x2::object::ID, vector<address>>(&mut arg0.market_positions, arg2, 0x1::vector::empty<address>());
        };
        0x1::vector::push_back<address>(0x2::linked_table::borrow_mut<0x2::object::ID, vector<address>>(&mut arg0.market_positions, arg2), arg1);
        let v1 = StoredPosition{
            owner                                     : arg1,
            market_id                                 : arg2,
            direction                                 : arg3,
            size                                      : arg4,
            entry_price                               : arg5,
            collateral                                : arg6,
            initial_margin_ratio_bps_at_open          : arg10,
            maintenance_margin_ratio_bps_at_open      : arg11,
            global_funding_index_snapshot             : arg7,
            global_funding_index_snapshot_is_negative : arg8,
            short_borrow_index_snapshot               : arg9,
            locked_for_liquidation                    : false,
            last_modified_ms                          : arg12,
        };
        0x2::table::add<vector<u8>, StoredPosition>(&mut arg0.positions, v0, v1);
        arg0.count = arg0.count + 1;
        let v2 = StorePositionOpened{
            owner       : arg1,
            market_id   : arg2,
            direction   : arg3,
            size        : arg4,
            entry_price : arg5,
            collateral  : arg6,
        };
        0x2::event::emit<StorePositionOpened>(v2);
    }

    public fun pos_collateral(arg0: &StoredPosition) : u64 {
        arg0.collateral
    }

    public fun pos_direction(arg0: &StoredPosition) : u8 {
        arg0.direction
    }

    public fun pos_entry_price(arg0: &StoredPosition) : u64 {
        arg0.entry_price
    }

    public fun pos_global_funding_index_snapshot(arg0: &StoredPosition) : u128 {
        arg0.global_funding_index_snapshot
    }

    public fun pos_global_funding_index_snapshot_is_negative(arg0: &StoredPosition) : bool {
        arg0.global_funding_index_snapshot_is_negative
    }

    public fun pos_initial_margin_ratio_bps_at_open(arg0: &StoredPosition) : u64 {
        arg0.initial_margin_ratio_bps_at_open
    }

    public fun pos_last_modified_ms(arg0: &StoredPosition) : u64 {
        arg0.last_modified_ms
    }

    public fun pos_locked_for_liquidation(arg0: &StoredPosition) : bool {
        arg0.locked_for_liquidation
    }

    public fun pos_maintenance_margin_ratio_bps_at_open(arg0: &StoredPosition) : u64 {
        arg0.maintenance_margin_ratio_bps_at_open
    }

    public fun pos_market_id(arg0: &StoredPosition) : 0x2::object::ID {
        arg0.market_id
    }

    public fun pos_owner(arg0: &StoredPosition) : address {
        arg0.owner
    }

    public fun pos_short_borrow_index_snapshot(arg0: &StoredPosition) : u128 {
        arg0.short_borrow_index_snapshot
    }

    public fun pos_size(arg0: &StoredPosition) : u64 {
        arg0.size
    }

    public fun position_count(arg0: &PositionStore) : u64 {
        arg0.count
    }

    public(friend) fun reduce_position<T0>(arg0: &mut PositionStore, arg1: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_bank::MarginBank<T0>, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: bool, arg9: u128, arg10: u64) {
        let v0 = make_key(arg2, arg3);
        assert!(0x2::table::contains<vector<u8>, StoredPosition>(&arg0.positions, v0), 0);
        assert!(arg4 > 0, 2);
        let v1 = 0x2::table::borrow<vector<u8>, StoredPosition>(&arg0.positions, v0);
        let v2 = v1.size;
        let v3 = v1.collateral;
        assert!(arg4 <= v2, 2);
        let v4 = arg5 + arg6;
        assert!(v4 <= v3, 4);
        if (arg4 == v2) {
            close_position<T0>(arg0, arg1, arg2, arg3, arg5);
            return
        };
        update_position(arg0, arg2, arg3, v2 - arg4, v1.entry_price, v3 - v4, arg7, arg8, arg9, arg10);
        if (arg5 > 0) {
            0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_bank::unlock_collateral<T0>(arg1, arg2, arg5);
        };
        if (arg6 > 0) {
            0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_bank::slash_locked<T0>(arg1, arg2, arg6);
        };
    }

    public(friend) fun release_liquidation_lock(arg0: &mut PositionStore, arg1: LiquidationLock) {
        let LiquidationLock {
            trader    : v0,
            market_id : v1,
        } = arg1;
        let v2 = make_key(v0, v1);
        assert!(0x2::table::contains<vector<u8>, StoredPosition>(&arg0.positions, v2), 0);
        let v3 = 0x2::table::borrow_mut<vector<u8>, StoredPosition>(&mut arg0.positions, v2);
        assert!(v0 == v3.owner && v1 == v3.market_id, 6);
        v3.locked_for_liquidation = false;
    }

    fun remove_market_owner(arg0: &mut PositionStore, arg1: 0x2::object::ID, arg2: address) {
        let v0 = 0x2::linked_table::borrow_mut<0x2::object::ID, vector<address>>(&mut arg0.market_positions, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(v0)) {
            if (*0x1::vector::borrow<address>(v0, v1) == arg2) {
                0x1::vector::remove<address>(v0, v1);
                break
            };
            v1 = v1 + 1;
        };
        if (0x1::vector::length<address>(v0) == 0) {
            0x2::linked_table::remove<0x2::object::ID, vector<address>>(&mut arg0.market_positions, arg1);
        };
    }

    public(friend) fun settle_market_funding_round(arg0: &mut PositionStore, arg1: 0x2::object::ID, arg2: u64, arg3: u128, arg4: bool, arg5: u128, arg6: &0x2::clock::Clock) : u64 {
        if (!0x2::linked_table::contains<0x2::object::ID, vector<address>>(&arg0.market_positions, arg1)) {
            return 0
        };
        let v0 = market_owners_snapshot(arg0, arg1);
        let v1 = 0;
        let v2 = 0;
        while (v1 < 0x1::vector::length<address>(&v0)) {
            if (apply_funding_to_position(arg0, *0x1::vector::borrow<address>(&v0, v1), arg1, arg2, arg3, arg4, arg5, 0x2::clock::timestamp_ms(arg6))) {
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
        v2
    }

    public(friend) fun unlock_for_liquidation(arg0: &mut PositionStore, arg1: address, arg2: 0x2::object::ID) {
        let v0 = make_key(arg1, arg2);
        assert!(0x2::table::contains<vector<u8>, StoredPosition>(&arg0.positions, v0), 0);
        0x2::table::borrow_mut<vector<u8>, StoredPosition>(&mut arg0.positions, v0).locked_for_liquidation = false;
    }

    public(friend) fun update_position(arg0: &mut PositionStore, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: bool, arg8: u128, arg9: u64) {
        let v0 = make_key(arg1, arg2);
        assert!(0x2::table::contains<vector<u8>, StoredPosition>(&arg0.positions, v0), 0);
        assert!(arg3 > 0, 2);
        let v1 = 0x2::table::borrow_mut<vector<u8>, StoredPosition>(&mut arg0.positions, v0);
        v1.size = arg3;
        v1.entry_price = arg4;
        v1.collateral = arg5;
        v1.global_funding_index_snapshot = arg6;
        v1.global_funding_index_snapshot_is_negative = arg7;
        v1.short_borrow_index_snapshot = arg8;
        v1.last_modified_ms = arg9;
        let v2 = StorePositionUpdated{
            owner           : arg1,
            market_id       : arg2,
            old_size        : v1.size,
            new_size        : arg3,
            new_entry_price : arg4,
            new_collateral  : arg5,
        };
        0x2::event::emit<StorePositionUpdated>(v2);
    }

    // decompiled from Move bytecode v7
}

