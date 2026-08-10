module 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store {
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

    struct FundingRoundDelta has copy, drop, store {
        owner: address,
        direction: u8,
        old_collateral: u64,
        funding_debit: u64,
        funding_shortfall: u64,
        funding_credit_raw: u64,
        funding_credit_paid: u64,
        borrow_amount: u64,
        borrow_debit: u64,
        borrow_shortfall: u64,
        new_collateral: u64,
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

    struct FundingDebitShortfall has copy, drop {
        owner: address,
        market_id: 0x2::object::ID,
        funding_shortfall: u64,
        borrow_shortfall: u64,
        timestamp_ms: u64,
    }

    struct FundingCreditForfeited has copy, drop {
        owner: address,
        market_id: 0x2::object::ID,
        amount: u64,
        timestamp_ms: u64,
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

    public(friend) fun close_position<T0>(arg0: &mut PositionStore, arg1: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg2: address, arg3: 0x2::object::ID, arg4: u64) : StoredPosition {
        let v0 = make_key(arg2, arg3);
        assert!(0x2::table::contains<vector<u8>, StoredPosition>(&arg0.positions, v0), 0);
        let v1 = 0x2::table::remove<vector<u8>, StoredPosition>(&mut arg0.positions, v0);
        remove_market_owner(arg0, arg3, arg2);
        arg0.count = arg0.count - 1;
        let v2 = v1.collateral;
        assert!(arg4 <= v2, 4);
        if (arg4 > 0) {
            0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::unlock_collateral<T0>(arg1, arg2, arg4);
        };
        let v3 = v2 - arg4;
        if (v3 > 0) {
            0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::slash_locked<T0>(arg1, arg2, v3);
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

    public(friend) fun close_position_for_liquidation<T0>(arg0: &mut PositionStore, arg1: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: LiquidationLock) : StoredPosition {
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

    fun compute_round_delta_v4<T0>(arg0: &PositionStore, arg1: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: u128, arg6: bool, arg7: u128) : FundingRoundDelta {
        let v0 = make_key(arg2, arg3);
        assert!(0x2::table::contains<vector<u8>, StoredPosition>(&arg0.positions, v0), 0);
        let v1 = 0x2::table::borrow<vector<u8>, StoredPosition>(&arg0.positions, v0);
        let v2 = if (v1.global_funding_index_snapshot == arg5) {
            if (v1.global_funding_index_snapshot_is_negative == arg6) {
                v1.short_borrow_index_snapshot == arg7
            } else {
                false
            }
        } else {
            false
        };
        if (v2) {
            return FundingRoundDelta{
                owner               : arg2,
                direction           : v1.direction,
                old_collateral      : v1.collateral,
                funding_debit       : 0,
                funding_shortfall   : 0,
                funding_credit_raw  : 0,
                funding_credit_paid : 0,
                borrow_amount       : 0,
                borrow_debit        : 0,
                borrow_shortfall    : 0,
                new_collateral      : v1.collateral,
            }
        };
        let v3 = (((v1.size as u128) * (arg4 as u128) / 100000000) as u64);
        let (v4, v5) = compute_owed_funding(v1.direction, v3, arg5, arg6, v1.global_funding_index_snapshot, v1.global_funding_index_snapshot_is_negative);
        let v6 = if (v5) {
            min_u64(v4, min_u64(v1.collateral, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::get_locked_balance<T0>(arg1, arg2)))
        } else {
            0
        };
        let v7 = if (v5 && v4 > v6) {
            v4 - v6
        } else {
            0
        };
        let v8 = if (v5) {
            0
        } else {
            v4
        };
        let v9 = if (v1.direction == 1) {
            compute_owed_borrow(v3, arg7, v1.short_borrow_index_snapshot)
        } else {
            0
        };
        FundingRoundDelta{
            owner               : arg2,
            direction           : v1.direction,
            old_collateral      : v1.collateral,
            funding_debit       : v6,
            funding_shortfall   : v7,
            funding_credit_raw  : v8,
            funding_credit_paid : 0,
            borrow_amount       : v9,
            borrow_debit        : 0,
            borrow_shortfall    : 0,
            new_collateral      : v1.collateral,
        }
    }

    public fun create_position_store(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
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

    fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
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

    public(friend) fun reduce_position<T0>(arg0: &mut PositionStore, arg1: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: bool, arg9: u128, arg10: u64) {
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
            0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::unlock_collateral<T0>(arg1, arg2, arg5);
        };
        if (arg6 > 0) {
            0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::slash_locked<T0>(arg1, arg2, arg6);
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

    public(friend) fun settle_market_funding_round_v4<T0>(arg0: &mut PositionStore, arg1: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: u128, arg5: bool, arg6: u128, arg7: &0x2::clock::Clock) : u64 {
        if (!0x2::linked_table::contains<0x2::object::ID, vector<address>>(&arg0.market_positions, arg2)) {
            return 0
        };
        let v0 = market_owners_snapshot(arg0, arg2);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        let v2 = 0x1::vector::empty<FundingRoundDelta>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<address>(&v0)) {
            let v7 = compute_round_delta_v4<T0>(arg0, arg1, *0x1::vector::borrow<address>(&v0, v6), arg2, arg3, arg4, arg5, arg6);
            v4 = v4 + (v7.funding_debit as u128);
            v5 = v5 + (v7.funding_credit_raw as u128);
            0x1::vector::push_back<u64>(&mut v3, v7.funding_debit);
            0x1::vector::push_back<FundingRoundDelta>(&mut v2, v7);
            v6 = v6 + 1;
        };
        let v8 = 0x1::vector::length<FundingRoundDelta>(&v2);
        let v9 = 0;
        v6 = 0;
        while (v6 < v8) {
            let v10 = 0x1::vector::borrow_mut<FundingRoundDelta>(&mut v2, v6);
            if (v10.funding_credit_raw > 0 && v4 > 0) {
                let v11 = if (v4 >= v5) {
                    v10.funding_credit_raw
                } else {
                    (((v10.funding_credit_raw as u128) * v4 / v5) as u64)
                };
                v10.funding_credit_paid = v11;
                v9 = v9 + (v10.funding_credit_paid as u128);
            };
            v6 = v6 + 1;
        };
        let v12 = 0;
        v6 = 0;
        while (v6 < v8) {
            let v13 = *0x1::vector::borrow<FundingRoundDelta>(&v2, v6);
            let v14 = v13.funding_credit_paid;
            while (v14 > 0) {
                while (v12 < v8 && *0x1::vector::borrow<u64>(&v3, v12) == 0) {
                    v12 = v12 + 1;
                };
                assert!(v12 < v8, 7);
                let v15 = *0x1::vector::borrow<FundingRoundDelta>(&v2, v12);
                let v16 = min_u64(v14, *0x1::vector::borrow<u64>(&v3, v12));
                0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::transfer_locked<T0>(arg1, v15.owner, v13.owner, v16);
                let v17 = 0x1::vector::borrow_mut<u64>(&mut v3, v12);
                *v17 = *v17 - v16;
                v14 = v14 - v16;
            };
            v6 = v6 + 1;
        };
        v6 = 0;
        while (v6 < v8) {
            let v18 = *0x1::vector::borrow<FundingRoundDelta>(&v2, v6);
            let v19 = *0x1::vector::borrow<u64>(&v3, v6);
            if (v19 > 0) {
                0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::slash_locked<T0>(arg1, v18.owner, v19);
            };
            v6 = v6 + 1;
        };
        let v20 = 0;
        v6 = 0;
        while (v6 < v8) {
            let v21 = 0x1::vector::borrow_mut<FundingRoundDelta>(&mut v2, v6);
            let v22 = v21.old_collateral - v21.funding_debit + v21.funding_credit_paid;
            v21.borrow_debit = min_u64(v21.borrow_amount, min_u64(v22, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::get_locked_balance<T0>(arg1, v21.owner)));
            v21.borrow_shortfall = v21.borrow_amount - v21.borrow_debit;
            v21.new_collateral = v22 - v21.borrow_debit;
            if (v21.borrow_debit > 0) {
                0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::slash_locked<T0>(arg1, v21.owner, v21.borrow_debit);
            };
            v6 = v6 + 1;
        };
        v6 = 0;
        while (v6 < v8) {
            let v23 = *0x1::vector::borrow<FundingRoundDelta>(&v2, v6);
            let v24 = 0x2::table::borrow_mut<vector<u8>, StoredPosition>(&mut arg0.positions, make_key(v23.owner, arg2));
            let v25 = if (v24.global_funding_index_snapshot != arg4) {
                true
            } else if (v24.global_funding_index_snapshot_is_negative != arg5) {
                true
            } else {
                v24.short_borrow_index_snapshot != arg6
            };
            if (v25) {
                v24.collateral = v23.new_collateral;
                v24.global_funding_index_snapshot = arg4;
                v24.global_funding_index_snapshot_is_negative = arg5;
                v24.short_borrow_index_snapshot = arg6;
                v24.last_modified_ms = v1;
                v20 = v20 + 1;
                let v26 = if (v23.funding_debit > 0) {
                    v23.funding_debit
                } else {
                    v23.funding_credit_paid
                };
                if (v26 > 0 || v23.borrow_debit > 0) {
                    let v27 = FundingApplied{
                        owner                                     : v23.owner,
                        market_id                                 : arg2,
                        direction                                 : v23.direction,
                        funding_amount                            : v26,
                        funding_is_cost                           : v23.funding_debit > 0,
                        borrow_amount                             : v23.borrow_debit,
                        old_collateral                            : v23.old_collateral,
                        new_collateral                            : v23.new_collateral,
                        global_funding_index_snapshot             : arg4,
                        global_funding_index_snapshot_is_negative : arg5,
                        short_borrow_index_snapshot               : arg6,
                    };
                    0x2::event::emit<FundingApplied>(v27);
                };
                if (v23.funding_shortfall > 0 || v23.borrow_shortfall > 0) {
                    let v28 = FundingDebitShortfall{
                        owner             : v23.owner,
                        market_id         : arg2,
                        funding_shortfall : v23.funding_shortfall,
                        borrow_shortfall  : v23.borrow_shortfall,
                        timestamp_ms      : v1,
                    };
                    0x2::event::emit<FundingDebitShortfall>(v28);
                };
            };
            v6 = v6 + 1;
        };
        v20
    }

    public(friend) fun settle_position_funding_v4<T0>(arg0: &mut PositionStore, arg1: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: u128, arg6: bool, arg7: u128, arg8: u64) : bool {
        let v0 = make_key(arg2, arg3);
        if (!0x2::table::contains<vector<u8>, StoredPosition>(&arg0.positions, v0)) {
            return false
        };
        let v1 = 0x2::table::borrow<vector<u8>, StoredPosition>(&arg0.positions, v0);
        let v2 = v1.direction;
        let v3 = v1.collateral;
        let v4 = v1.global_funding_index_snapshot;
        let v5 = v1.global_funding_index_snapshot_is_negative;
        let v6 = v1.short_borrow_index_snapshot;
        let v7 = if (v4 == arg5) {
            if (v5 == arg6) {
                v6 == arg7
            } else {
                false
            }
        } else {
            false
        };
        if (v7) {
            return false
        };
        let v8 = (((v1.size as u128) * (arg4 as u128) / 100000000) as u64);
        let (v9, v10) = compute_owed_funding(v2, v8, arg5, arg6, v4, v5);
        let v11 = if (v2 == 1) {
            compute_owed_borrow(v8, arg7, v6)
        } else {
            0
        };
        let (v12, v13, v14, v15) = if (v10) {
            let v16 = min_u64(v9, min_u64(v3, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::get_locked_balance<T0>(arg1, arg2)));
            if (v16 > 0) {
                0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::slash_locked<T0>(arg1, arg2, v16);
            };
            (v16, v9 - v16, 0, 0)
        } else {
            let v17 = 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::credit_locked_from_insurance<T0>(arg1, arg2, v9);
            (0, 0, v17, v9 - v17)
        };
        let v18 = v3 - v12 + v14;
        let v19 = min_u64(v11, min_u64(v18, 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::get_locked_balance<T0>(arg1, arg2)));
        let v20 = v11 - v19;
        if (v19 > 0) {
            0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::slash_locked<T0>(arg1, arg2, v19);
        };
        let v21 = v18 - v19;
        let v22 = 0x2::table::borrow_mut<vector<u8>, StoredPosition>(&mut arg0.positions, v0);
        v22.collateral = v21;
        v22.global_funding_index_snapshot = arg5;
        v22.global_funding_index_snapshot_is_negative = arg6;
        v22.short_borrow_index_snapshot = arg7;
        v22.last_modified_ms = arg8;
        let v23 = if (v10) {
            v12
        } else {
            v14
        };
        if (v23 > 0 || v19 > 0) {
            let v24 = FundingApplied{
                owner                                     : arg2,
                market_id                                 : arg3,
                direction                                 : v2,
                funding_amount                            : v23,
                funding_is_cost                           : v10,
                borrow_amount                             : v19,
                old_collateral                            : v3,
                new_collateral                            : v21,
                global_funding_index_snapshot             : arg5,
                global_funding_index_snapshot_is_negative : arg6,
                short_borrow_index_snapshot               : arg7,
            };
            0x2::event::emit<FundingApplied>(v24);
        };
        if (v15 > 0) {
            let v25 = FundingCreditForfeited{
                owner        : arg2,
                market_id    : arg3,
                amount       : v15,
                timestamp_ms : arg8,
            };
            0x2::event::emit<FundingCreditForfeited>(v25);
        };
        if (v13 > 0 || v20 > 0) {
            let v26 = FundingDebitShortfall{
                owner             : arg2,
                market_id         : arg3,
                funding_shortfall : v13,
                borrow_shortfall  : v20,
                timestamp_ms      : arg8,
            };
            0x2::event::emit<FundingDebitShortfall>(v26);
        };
        true
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

