module 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::position {
    struct Position has copy, drop, store {
        owner: address,
        market_id: 0x2::object::ID,
        direction: u8,
        size: u64,
        entry_price: u64,
        collateral: u64,
        global_funding_index_snapshot: u128,
        global_funding_index_snapshot_is_negative: bool,
        short_borrow_index_snapshot: u128,
    }

    struct PositionKey has copy, drop, store {
        owner: address,
        market_id: 0x2::object::ID,
    }

    struct PositionRegistry has key {
        id: 0x2::object::UID,
        positions: 0x2::table::Table<PositionKey, Position>,
        position_count: u64,
    }

    struct PositionOpened has copy, drop {
        owner: address,
        market_id: 0x2::object::ID,
        direction: u8,
        size: u64,
        entry_price: u64,
        collateral: u64,
        global_funding_index_snapshot: u128,
        global_funding_index_snapshot_is_negative: bool,
        short_borrow_index_snapshot: u128,
    }

    struct PositionUpdated has copy, drop {
        owner: address,
        market_id: 0x2::object::ID,
        old_size: u64,
        new_size: u64,
        old_collateral: u64,
        new_collateral: u64,
        new_entry_price: u64,
        global_funding_index_snapshot: u128,
        global_funding_index_snapshot_is_negative: bool,
        short_borrow_index_snapshot: u128,
    }

    struct PositionClosed has copy, drop {
        owner: address,
        market_id: 0x2::object::ID,
        direction: u8,
        closed_size: u64,
        entry_price: u64,
    }

    struct CollateralModified has copy, drop {
        owner: address,
        market_id: 0x2::object::ID,
        old_collateral: u64,
        new_collateral: u64,
    }

    struct FundingSettled has copy, drop {
        owner: address,
        market_id: 0x2::object::ID,
        direction: u8,
        funding_amount: u64,
        funding_is_cost: bool,
        borrow_amount: u64,
        old_collateral: u64,
        new_collateral: u64,
    }

    public fun borrow_position(arg0: &PositionRegistry, arg1: address, arg2: 0x2::object::ID) : &Position {
        let v0 = PositionKey{
            owner     : arg1,
            market_id : arg2,
        };
        assert!(0x2::table::contains<PositionKey, Position>(&arg0.positions, v0), 1);
        0x2::table::borrow<PositionKey, Position>(&arg0.positions, v0)
    }

    public fun direction_long() : u8 {
        0
    }

    public fun direction_short() : u8 {
        1
    }

    public(friend) fun increase_position(arg0: &mut PositionRegistry, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: bool, arg8: u128) {
        let v0 = PositionKey{
            owner     : arg1,
            market_id : arg2,
        };
        assert!(0x2::table::contains<PositionKey, Position>(&arg0.positions, v0), 1);
        assert!(arg3 > 0, 3);
        assert!(arg4 > 0, 4);
        let v1 = 0x2::table::borrow_mut<PositionKey, Position>(&mut arg0.positions, v0);
        let v2 = v1.size;
        let v3 = v1.collateral;
        let v4 = v2 + arg3;
        let v5 = ((((v2 as u128) * (v1.entry_price as u128) + (arg3 as u128) * (arg4 as u128)) / (v4 as u128)) as u64);
        v1.size = v4;
        v1.entry_price = v5;
        v1.collateral = v3 + arg5;
        v1.global_funding_index_snapshot = arg6;
        v1.global_funding_index_snapshot_is_negative = arg7;
        v1.short_borrow_index_snapshot = arg8;
        let v6 = PositionUpdated{
            owner                                     : arg1,
            market_id                                 : arg2,
            old_size                                  : v2,
            new_size                                  : v4,
            old_collateral                            : v3,
            new_collateral                            : v1.collateral,
            new_entry_price                           : v5,
            global_funding_index_snapshot             : arg6,
            global_funding_index_snapshot_is_negative : arg7,
            short_borrow_index_snapshot               : arg8,
        };
        0x2::event::emit<PositionUpdated>(v6);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PositionRegistry{
            id             : 0x2::object::new(arg0),
            positions      : 0x2::table::new<PositionKey, Position>(arg0),
            position_count : 0,
        };
        0x2::transfer::share_object<PositionRegistry>(v0);
    }

    public(friend) fun modify_collateral(arg0: &mut PositionRegistry, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: u128, arg5: bool, arg6: u128) {
        let v0 = PositionKey{
            owner     : arg1,
            market_id : arg2,
        };
        assert!(0x2::table::contains<PositionKey, Position>(&arg0.positions, v0), 1);
        assert!(arg3 > 0, 8);
        let v1 = 0x2::table::borrow_mut<PositionKey, Position>(&mut arg0.positions, v0);
        v1.collateral = arg3;
        v1.global_funding_index_snapshot = arg4;
        v1.global_funding_index_snapshot_is_negative = arg5;
        v1.short_borrow_index_snapshot = arg6;
        let v2 = CollateralModified{
            owner          : arg1,
            market_id      : arg2,
            old_collateral : v1.collateral,
            new_collateral : arg3,
        };
        0x2::event::emit<CollateralModified>(v2);
    }

    public(friend) fun open_position(arg0: &mut PositionRegistry, arg1: address, arg2: 0x2::object::ID, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: bool, arg9: u128) {
        assert!(arg3 == 0 || arg3 == 1, 2);
        assert!(arg4 > 0, 3);
        assert!(arg5 > 0, 4);
        assert!(arg6 > 0, 5);
        let v0 = PositionKey{
            owner     : arg1,
            market_id : arg2,
        };
        assert!(!0x2::table::contains<PositionKey, Position>(&arg0.positions, v0), 0);
        let v1 = Position{
            owner                                     : arg1,
            market_id                                 : arg2,
            direction                                 : arg3,
            size                                      : arg4,
            entry_price                               : arg5,
            collateral                                : arg6,
            global_funding_index_snapshot             : arg7,
            global_funding_index_snapshot_is_negative : arg8,
            short_borrow_index_snapshot               : arg9,
        };
        0x2::table::add<PositionKey, Position>(&mut arg0.positions, v0, v1);
        arg0.position_count = arg0.position_count + 1;
        let v2 = PositionOpened{
            owner                                     : arg1,
            market_id                                 : arg2,
            direction                                 : arg3,
            size                                      : arg4,
            entry_price                               : arg5,
            collateral                                : arg6,
            global_funding_index_snapshot             : arg7,
            global_funding_index_snapshot_is_negative : arg8,
            short_borrow_index_snapshot               : arg9,
        };
        0x2::event::emit<PositionOpened>(v2);
    }

    public fun position_collateral(arg0: &Position) : u64 {
        arg0.collateral
    }

    public fun position_count(arg0: &PositionRegistry) : u64 {
        arg0.position_count
    }

    public fun position_direction(arg0: &Position) : u8 {
        arg0.direction
    }

    public fun position_entry_price(arg0: &Position) : u64 {
        arg0.entry_price
    }

    public fun position_exists(arg0: &PositionRegistry, arg1: address, arg2: 0x2::object::ID) : bool {
        let v0 = PositionKey{
            owner     : arg1,
            market_id : arg2,
        };
        0x2::table::contains<PositionKey, Position>(&arg0.positions, v0)
    }

    public fun position_global_funding_index_snapshot(arg0: &Position) : u128 {
        arg0.global_funding_index_snapshot
    }

    public fun position_global_funding_index_snapshot_is_negative(arg0: &Position) : bool {
        arg0.global_funding_index_snapshot_is_negative
    }

    public fun position_market_id(arg0: &Position) : 0x2::object::ID {
        arg0.market_id
    }

    public fun position_owner(arg0: &Position) : address {
        arg0.owner
    }

    public fun position_short_borrow_index_snapshot(arg0: &Position) : u128 {
        arg0.short_borrow_index_snapshot
    }

    public fun position_size(arg0: &Position) : u64 {
        arg0.size
    }

    public(friend) fun reduce_position(arg0: &mut PositionRegistry, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: u128, arg5: bool, arg6: u128) {
        let v0 = PositionKey{
            owner     : arg1,
            market_id : arg2,
        };
        assert!(0x2::table::contains<PositionKey, Position>(&arg0.positions, v0), 1);
        assert!(arg3 > 0, 7);
        let v1 = 0x2::table::borrow<PositionKey, Position>(&arg0.positions, v0).size;
        assert!(arg3 <= v1, 6);
        if (arg3 == v1) {
            let v2 = 0x2::table::remove<PositionKey, Position>(&mut arg0.positions, v0);
            arg0.position_count = arg0.position_count - 1;
            let v3 = PositionClosed{
                owner       : arg1,
                market_id   : arg2,
                direction   : v2.direction,
                closed_size : v2.size,
                entry_price : v2.entry_price,
            };
            0x2::event::emit<PositionClosed>(v3);
        } else {
            let v4 = 0x2::table::borrow_mut<PositionKey, Position>(&mut arg0.positions, v0);
            let v5 = v4.collateral;
            let v6 = v1 - arg3;
            v4.size = v6;
            v4.collateral = (((v5 as u128) * (v6 as u128) / (v1 as u128)) as u64);
            v4.global_funding_index_snapshot = arg4;
            v4.global_funding_index_snapshot_is_negative = arg5;
            v4.short_borrow_index_snapshot = arg6;
            let v7 = PositionUpdated{
                owner                                     : arg1,
                market_id                                 : arg2,
                old_size                                  : v4.size,
                new_size                                  : v4.size,
                old_collateral                            : v5,
                new_collateral                            : v4.collateral,
                new_entry_price                           : v4.entry_price,
                global_funding_index_snapshot             : arg4,
                global_funding_index_snapshot_is_negative : arg5,
                short_borrow_index_snapshot               : arg6,
            };
            0x2::event::emit<PositionUpdated>(v7);
        };
    }

    public(friend) fun settle_funding(arg0: &mut PositionRegistry, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: u128, arg8: bool, arg9: u128) {
        let v0 = PositionKey{
            owner     : arg1,
            market_id : arg2,
        };
        assert!(0x2::table::contains<PositionKey, Position>(&arg0.positions, v0), 1);
        let v1 = 0x2::table::borrow_mut<PositionKey, Position>(&mut arg0.positions, v0);
        v1.collateral = arg3;
        v1.global_funding_index_snapshot = arg7;
        v1.global_funding_index_snapshot_is_negative = arg8;
        v1.short_borrow_index_snapshot = arg9;
        if (arg4 > 0 || arg6 > 0) {
            let v2 = FundingSettled{
                owner           : arg1,
                market_id       : arg2,
                direction       : v1.direction,
                funding_amount  : arg4,
                funding_is_cost : arg5,
                borrow_amount   : arg6,
                old_collateral  : v1.collateral,
                new_collateral  : arg3,
            };
            0x2::event::emit<FundingSettled>(v2);
        };
    }

    // decompiled from Move bytecode v7
}

