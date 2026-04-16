module 0x900bca6461ad24c86b83c974788b457cb76c3f6f4fd7b061c5b58cb40d974bab::bluefin_bridge {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RelayerCap has store, key {
        id: 0x2::object::UID,
        relayer_address: address,
    }

    struct BluefinPosition has store, key {
        id: 0x2::object::UID,
        bluefin_position_id: vector<u8>,
        trader: address,
        pair_index: u64,
        is_long: bool,
        size: u64,
        leverage: u64,
        margin: u64,
        entry_price: u64,
        mark_price: u64,
        liquidation_price: u64,
        unrealized_pnl_positive: u64,
        unrealized_pnl_negative: u64,
        commitment_hash: vector<u8>,
        open_timestamp: u64,
        close_timestamp: u64,
        realized_pnl_positive: u64,
        realized_pnl_negative: u64,
        status: u8,
        portfolio_id: u64,
    }

    struct BluefinBridgeState has key {
        id: 0x2::object::UID,
        total_positions: u64,
        open_positions: u64,
        closed_positions: u64,
        total_margin_locked: u64,
        trader_positions: 0x2::table::Table<address, vector<0x2::object::ID>>,
        position_lookup: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
        paused: bool,
        relayer_whitelist: 0x2::table::Table<address, bool>,
    }

    struct PositionOpened has copy, drop {
        position_id: 0x2::object::ID,
        bluefin_id: vector<u8>,
        trader: address,
        pair_index: u64,
        is_long: bool,
        size: u64,
        leverage: u64,
        margin: u64,
        entry_price: u64,
        commitment_hash: vector<u8>,
        timestamp: u64,
    }

    struct PositionClosed has copy, drop {
        position_id: 0x2::object::ID,
        bluefin_id: vector<u8>,
        trader: address,
        pair_index: u64,
        close_price: u64,
        realized_pnl_positive: u64,
        realized_pnl_negative: u64,
        timestamp: u64,
    }

    struct PositionSynced has copy, drop {
        position_id: 0x2::object::ID,
        mark_price: u64,
        unrealized_pnl_positive: u64,
        unrealized_pnl_negative: u64,
        timestamp: u64,
    }

    public entry fun add_relayer(arg0: &AdminCap, arg1: &mut BluefinBridgeState, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::table::add<address, bool>(&mut arg1.relayer_whitelist, arg2, true);
        let v0 = RelayerCap{
            id              : 0x2::object::new(arg3),
            relayer_address : arg2,
        };
        0x2::transfer::transfer<RelayerCap>(v0, arg2);
    }

    public fun get_pair_name(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            b"BTC-PERP"
        } else if (arg0 == 1) {
            b"ETH-PERP"
        } else if (arg0 == 2) {
            b"SUI-PERP"
        } else if (arg0 == 3) {
            b"SOL-PERP"
        } else if (arg0 == 4) {
            b"APT-PERP"
        } else if (arg0 == 5) {
            b"ARB-PERP"
        } else if (arg0 == 6) {
            b"DOGE-PERP"
        } else if (arg0 == 7) {
            b"PEPE-PERP"
        } else {
            b"UNKNOWN"
        }
    }

    public fun get_position_info(arg0: &BluefinPosition) : (vector<u8>, address, u64, bool, u64, u64, u64, u64, u64, u8) {
        (arg0.bluefin_position_id, arg0.trader, arg0.pair_index, arg0.is_long, arg0.size, arg0.leverage, arg0.margin, arg0.entry_price, arg0.mark_price, arg0.status)
    }

    public fun get_stats(arg0: &BluefinBridgeState) : (u64, u64, u64, u64) {
        (arg0.total_positions, arg0.open_positions, arg0.closed_positions, arg0.total_margin_locked)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = BluefinBridgeState{
            id                  : 0x2::object::new(arg0),
            total_positions     : 0,
            open_positions      : 0,
            closed_positions    : 0,
            total_margin_locked : 0,
            trader_positions    : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            position_lookup     : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg0),
            paused              : false,
            relayer_whitelist   : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<BluefinBridgeState>(v1);
    }

    public fun is_valid_pair(arg0: u64) : bool {
        arg0 < 8
    }

    public entry fun record_position_close(arg0: &RelayerCap, arg1: &mut BluefinBridgeState, arg2: &mut BluefinPosition, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 5);
        assert!(arg2.status == 1, 3);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        arg2.mark_price = arg3;
        arg2.close_timestamp = v0;
        arg2.realized_pnl_positive = arg4;
        arg2.realized_pnl_negative = arg5;
        arg2.status = 2;
        arg1.open_positions = arg1.open_positions - 1;
        arg1.closed_positions = arg1.closed_positions + 1;
        if (arg1.total_margin_locked >= arg2.margin) {
            arg1.total_margin_locked = arg1.total_margin_locked - arg2.margin;
        } else {
            arg1.total_margin_locked = 0;
        };
        let v1 = PositionClosed{
            position_id           : 0x2::object::id<BluefinPosition>(arg2),
            bluefin_id            : arg2.bluefin_position_id,
            trader                : arg2.trader,
            pair_index            : arg2.pair_index,
            close_price           : arg3,
            realized_pnl_positive : arg4,
            realized_pnl_negative : arg5,
            timestamp             : v0,
        };
        0x2::event::emit<PositionClosed>(v1);
    }

    public entry fun record_position_open(arg0: &RelayerCap, arg1: &mut BluefinBridgeState, arg2: vector<u8>, arg3: address, arg4: u64, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 5);
        assert!(arg4 < 8, 1);
        assert!(arg7 <= 50, 4);
        let v0 = 0x2::clock::timestamp_ms(arg13);
        let v1 = BluefinPosition{
            id                      : 0x2::object::new(arg14),
            bluefin_position_id     : arg2,
            trader                  : arg3,
            pair_index              : arg4,
            is_long                 : arg5,
            size                    : arg6,
            leverage                : arg7,
            margin                  : arg8,
            entry_price             : arg9,
            mark_price              : arg9,
            liquidation_price       : arg10,
            unrealized_pnl_positive : 0,
            unrealized_pnl_negative : 0,
            commitment_hash         : arg11,
            open_timestamp          : v0,
            close_timestamp         : 0,
            realized_pnl_positive   : 0,
            realized_pnl_negative   : 0,
            status                  : 1,
            portfolio_id            : arg12,
        };
        let v2 = 0x2::object::id<BluefinPosition>(&v1);
        arg1.total_positions = arg1.total_positions + 1;
        arg1.open_positions = arg1.open_positions + 1;
        arg1.total_margin_locked = arg1.total_margin_locked + arg8;
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg1.trader_positions, arg3)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg1.trader_positions, arg3, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg1.trader_positions, arg3), v2);
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg1.position_lookup, v1.bluefin_position_id, v2);
        let v3 = PositionOpened{
            position_id     : v2,
            bluefin_id      : v1.bluefin_position_id,
            trader          : arg3,
            pair_index      : arg4,
            is_long         : arg5,
            size            : arg6,
            leverage        : arg7,
            margin          : arg8,
            entry_price     : arg9,
            commitment_hash : v1.commitment_hash,
            timestamp       : v0,
        };
        0x2::event::emit<PositionOpened>(v3);
        0x2::transfer::transfer<BluefinPosition>(v1, arg3);
    }

    public entry fun set_paused(arg0: &AdminCap, arg1: &mut BluefinBridgeState, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun sync_position(arg0: &RelayerCap, arg1: &BluefinBridgeState, arg2: &mut BluefinPosition, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 5);
        assert!(arg2.status == 1, 3);
        arg2.mark_price = arg3;
        arg2.unrealized_pnl_positive = arg4;
        arg2.unrealized_pnl_negative = arg5;
        let v0 = PositionSynced{
            position_id             : 0x2::object::id<BluefinPosition>(arg2),
            mark_price              : arg3,
            unrealized_pnl_positive : arg4,
            unrealized_pnl_negative : arg5,
            timestamp               : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<PositionSynced>(v0);
    }

    // decompiled from Move bytecode v7
}

