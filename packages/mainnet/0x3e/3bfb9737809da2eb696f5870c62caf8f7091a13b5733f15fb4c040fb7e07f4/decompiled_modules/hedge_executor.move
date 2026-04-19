module 0x900bca6461ad24c86b83c974788b457cb76c3f6f4fd7b061c5b58cb40d974bab::hedge_executor {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AgentCap has store, key {
        id: 0x2::object::UID,
        agent_address: address,
    }

    struct HedgePosition has store, key {
        id: 0x2::object::UID,
        hedge_id: vector<u8>,
        trader: address,
        pair_index: u64,
        collateral_amount: u64,
        leverage: u64,
        is_long: bool,
        open_price: u64,
        close_price: u64,
        commitment_hash: vector<u8>,
        nullifier: vector<u8>,
        open_timestamp: u64,
        close_timestamp: u64,
        pnl_positive: u64,
        pnl_negative: u64,
        status: u8,
    }

    struct HedgeExecutorState has key {
        id: 0x2::object::UID,
        total_hedges_opened: u64,
        total_hedges_closed: u64,
        total_collateral_locked: u64,
        total_pnl_positive: u64,
        total_pnl_negative: u64,
        accumulated_fees: u64,
        fee_rate_bps: u64,
        max_leverage: u64,
        min_collateral: u64,
        paused: bool,
        nullifier_used: 0x2::table::Table<vector<u8>, bool>,
        hedge_ids: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
        user_hedges: 0x2::table::Table<address, vector<vector<u8>>>,
        price_feeds: 0x2::table::Table<u64, u64>,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        collateral_pool: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct HedgeOpened has copy, drop {
        hedge_id: vector<u8>,
        trader: address,
        pair_index: u64,
        is_long: bool,
        collateral: u64,
        leverage: u64,
        open_price: u64,
        commitment_hash: vector<u8>,
        timestamp: u64,
    }

    struct HedgeClosed has copy, drop {
        hedge_id: vector<u8>,
        trader: address,
        pnl_positive: u64,
        pnl_negative: u64,
        close_price: u64,
        duration_ms: u64,
    }

    struct HedgeLiquidated has copy, drop {
        hedge_id: vector<u8>,
        trader: address,
        collateral_lost: u64,
    }

    struct MarginAdded has copy, drop {
        hedge_id: vector<u8>,
        trader: address,
        amount: u64,
    }

    public entry fun add_margin(arg0: &mut HedgeExecutorState, arg1: &mut HedgePosition, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 7);
        assert!(arg1.status == 1, 5);
        assert!(arg1.trader == 0x2::tx_context::sender(arg3), 6);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.collateral_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg1.collateral_amount = arg1.collateral_amount + v0;
        arg0.total_collateral_locked = arg0.total_collateral_locked + v0;
        let v1 = MarginAdded{
            hedge_id : arg1.hedge_id,
            trader   : arg1.trader,
            amount   : v0,
        };
        0x2::event::emit<MarginAdded>(v1);
    }

    public entry fun agent_open_hedge(arg0: &AgentCap, arg1: &mut HedgeExecutorState, arg2: &0x2::clock::Clock, arg3: address, arg4: u64, arg5: u64, arg6: bool, arg7: vector<u8>, arg8: vector<u8>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 7);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg9);
        assert!(v0 >= arg1.min_collateral, 1);
        assert!(arg5 >= 2 && arg5 <= arg1.max_leverage, 2);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg1.nullifier_used, arg8), 3);
        let v1 = v0 * arg1.fee_rate_bps / 10000;
        let v2 = v0 - v1;
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg9);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.fee_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.collateral_pool, v3);
        assert!(0x2::table::contains<u64, u64>(&arg1.price_feeds, arg4), 8);
        let v4 = *0x2::table::borrow<u64, u64>(&arg1.price_feeds, arg4);
        let v5 = 0x2::clock::timestamp_ms(arg2);
        let v6 = b"agent_hedge_";
        0x1::vector::append<u8>(&mut v6, 0x1::bcs::to_bytes<u64>(&arg1.total_hedges_opened));
        0x1::vector::append<u8>(&mut v6, 0x1::bcs::to_bytes<u64>(&v5));
        let v7 = 0x2::hash::blake2b256(&v6);
        let v8 = HedgePosition{
            id                : 0x2::object::new(arg10),
            hedge_id          : v7,
            trader            : arg3,
            pair_index        : arg4,
            collateral_amount : v2,
            leverage          : arg5,
            is_long           : arg6,
            open_price        : v4,
            close_price       : 0,
            commitment_hash   : arg7,
            nullifier         : arg8,
            open_timestamp    : v5,
            close_timestamp   : 0,
            pnl_positive      : 0,
            pnl_negative      : 0,
            status            : 1,
        };
        0x2::table::add<vector<u8>, bool>(&mut arg1.nullifier_used, arg8, true);
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg1.hedge_ids, v7, 0x2::object::id<HedgePosition>(&v8));
        if (!0x2::table::contains<address, vector<vector<u8>>>(&arg1.user_hedges, arg3)) {
            0x2::table::add<address, vector<vector<u8>>>(&mut arg1.user_hedges, arg3, 0x1::vector::empty<vector<u8>>());
        };
        0x1::vector::push_back<vector<u8>>(0x2::table::borrow_mut<address, vector<vector<u8>>>(&mut arg1.user_hedges, arg3), v7);
        arg1.total_hedges_opened = arg1.total_hedges_opened + 1;
        arg1.total_collateral_locked = arg1.total_collateral_locked + v2;
        arg1.accumulated_fees = arg1.accumulated_fees + v1;
        let v9 = HedgeOpened{
            hedge_id        : v7,
            trader          : arg3,
            pair_index      : arg4,
            is_long         : arg6,
            collateral      : v2,
            leverage        : arg5,
            open_price      : v4,
            commitment_hash : arg7,
            timestamp       : v5,
        };
        0x2::event::emit<HedgeOpened>(v9);
        0x2::transfer::transfer<HedgePosition>(v8, arg3);
    }

    fun calculate_pnl(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : (u64, u64) {
        if (arg3) {
            if (arg1 > arg0) {
                ((arg1 - arg0) * arg2 / arg0, 0)
            } else {
                (0, (arg0 - arg1) * arg2 / arg0)
            }
        } else if (arg1 < arg0) {
            ((arg0 - arg1) * arg2 / arg0, 0)
        } else {
            (0, (arg1 - arg0) * arg2 / arg0)
        }
    }

    public entry fun close_hedge(arg0: &mut HedgeExecutorState, arg1: &0x2::clock::Clock, arg2: HedgePosition, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 7);
        assert!(arg2.status == 1, 5);
        assert!(arg2.trader == 0x2::tx_context::sender(arg3), 6);
        assert!(0x2::table::contains<u64, u64>(&arg0.price_feeds, arg2.pair_index), 8);
        let v0 = *0x2::table::borrow<u64, u64>(&arg0.price_feeds, arg2.pair_index);
        let (v1, v2) = calculate_pnl(arg2.open_price, v0, arg2.collateral_amount * arg2.leverage, arg2.is_long);
        let v3 = if (v1 > 0) {
            let v4 = arg2.collateral_amount + v1;
            let v5 = 0x2::balance::value<0x2::sui::SUI>(&arg0.collateral_pool);
            if (v4 > v5) {
                v5
            } else {
                v4
            }
        } else if (v2 < arg2.collateral_amount) {
            arg2.collateral_amount - v2
        } else {
            0
        };
        arg0.total_hedges_closed = arg0.total_hedges_closed + 1;
        arg0.total_collateral_locked = arg0.total_collateral_locked - arg2.collateral_amount;
        arg0.total_pnl_positive = arg0.total_pnl_positive + v1;
        arg0.total_pnl_negative = arg0.total_pnl_negative + v2;
        if (v3 > 0 && 0x2::balance::value<0x2::sui::SUI>(&arg0.collateral_pool) >= v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.collateral_pool, v3), arg3), arg2.trader);
        };
        let v6 = HedgeClosed{
            hedge_id     : arg2.hedge_id,
            trader       : arg2.trader,
            pnl_positive : v1,
            pnl_negative : v2,
            close_price  : v0,
            duration_ms  : 0x2::clock::timestamp_ms(arg1) - arg2.open_timestamp,
        };
        0x2::event::emit<HedgeClosed>(v6);
        let HedgePosition {
            id                : v7,
            hedge_id          : _,
            trader            : _,
            pair_index        : _,
            collateral_amount : _,
            leverage          : _,
            is_long           : _,
            open_price        : _,
            close_price       : _,
            commitment_hash   : _,
            nullifier         : _,
            open_timestamp    : _,
            close_timestamp   : _,
            pnl_positive      : _,
            pnl_negative      : _,
            status            : _,
        } = arg2;
        0x2::object::delete(v7);
    }

    public entry fun create_agent_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AgentCap{
            id            : 0x2::object::new(arg2),
            agent_address : arg1,
        };
        0x2::transfer::transfer<AgentCap>(v0, arg1);
    }

    public fun get_position_info(arg0: &HedgePosition) : (vector<u8>, address, u64, u64, u64, bool, u64, u8) {
        (arg0.hedge_id, arg0.trader, arg0.pair_index, arg0.collateral_amount, arg0.leverage, arg0.is_long, arg0.open_price, arg0.status)
    }

    public fun get_stats(arg0: &HedgeExecutorState) : (u64, u64, u64, u64, u64, u64) {
        (arg0.total_hedges_opened, arg0.total_hedges_closed, arg0.total_collateral_locked, arg0.total_pnl_positive, arg0.total_pnl_negative, arg0.accumulated_fees)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = HedgeExecutorState{
            id                      : 0x2::object::new(arg0),
            total_hedges_opened     : 0,
            total_hedges_closed     : 0,
            total_collateral_locked : 0,
            total_pnl_positive      : 0,
            total_pnl_negative      : 0,
            accumulated_fees        : 0,
            fee_rate_bps            : 10,
            max_leverage            : 100,
            min_collateral          : 1000000,
            paused                  : false,
            nullifier_used          : 0x2::table::new<vector<u8>, bool>(arg0),
            hedge_ids               : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg0),
            user_hedges             : 0x2::table::new<address, vector<vector<u8>>>(arg0),
            price_feeds             : 0x2::table::new<u64, u64>(arg0),
            fee_balance             : 0x2::balance::zero<0x2::sui::SUI>(),
            collateral_pool         : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<HedgeExecutorState>(v1);
    }

    public entry fun open_hedge(arg0: &mut HedgeExecutorState, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: bool, arg5: vector<u8>, arg6: vector<u8>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 7);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg7);
        assert!(v0 >= arg0.min_collateral, 1);
        assert!(arg3 >= 2 && arg3 <= arg0.max_leverage, 2);
        assert!(arg2 <= 12, 8);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.nullifier_used, arg6), 3);
        let v1 = v0 * arg0.fee_rate_bps / 10000;
        let v2 = v0 - v1;
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg7);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.collateral_pool, v3);
        assert!(0x2::table::contains<u64, u64>(&arg0.price_feeds, arg2), 8);
        let v4 = *0x2::table::borrow<u64, u64>(&arg0.price_feeds, arg2);
        let v5 = 0x2::clock::timestamp_ms(arg1);
        let v6 = 0x2::tx_context::sender(arg8);
        let v7 = b"hedge_";
        0x1::vector::append<u8>(&mut v7, 0x1::bcs::to_bytes<u64>(&arg0.total_hedges_opened));
        0x1::vector::append<u8>(&mut v7, 0x1::bcs::to_bytes<u64>(&v5));
        let v8 = 0x2::hash::blake2b256(&v7);
        let v9 = HedgePosition{
            id                : 0x2::object::new(arg8),
            hedge_id          : v8,
            trader            : v6,
            pair_index        : arg2,
            collateral_amount : v2,
            leverage          : arg3,
            is_long           : arg4,
            open_price        : v4,
            close_price       : 0,
            commitment_hash   : arg5,
            nullifier         : arg6,
            open_timestamp    : v5,
            close_timestamp   : 0,
            pnl_positive      : 0,
            pnl_negative      : 0,
            status            : 1,
        };
        0x2::table::add<vector<u8>, bool>(&mut arg0.nullifier_used, arg6, true);
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg0.hedge_ids, v8, 0x2::object::id<HedgePosition>(&v9));
        if (!0x2::table::contains<address, vector<vector<u8>>>(&arg0.user_hedges, v6)) {
            0x2::table::add<address, vector<vector<u8>>>(&mut arg0.user_hedges, v6, 0x1::vector::empty<vector<u8>>());
        };
        0x1::vector::push_back<vector<u8>>(0x2::table::borrow_mut<address, vector<vector<u8>>>(&mut arg0.user_hedges, v6), v8);
        arg0.total_hedges_opened = arg0.total_hedges_opened + 1;
        arg0.total_collateral_locked = arg0.total_collateral_locked + v2;
        arg0.accumulated_fees = arg0.accumulated_fees + v1;
        let v10 = HedgeOpened{
            hedge_id        : v8,
            trader          : v6,
            pair_index      : arg2,
            is_long         : arg4,
            collateral      : v2,
            leverage        : arg3,
            open_price      : v4,
            commitment_hash : arg5,
            timestamp       : v5,
        };
        0x2::event::emit<HedgeOpened>(v10);
        0x2::transfer::transfer<HedgePosition>(v9, v6);
    }

    public entry fun set_fee_rate(arg0: &AdminCap, arg1: &mut HedgeExecutorState, arg2: u64) {
        assert!(arg2 <= 100, 10);
        arg1.fee_rate_bps = arg2;
    }

    public entry fun set_max_leverage(arg0: &AdminCap, arg1: &mut HedgeExecutorState, arg2: u64) {
        arg1.max_leverage = arg2;
    }

    public entry fun set_paused(arg0: &AdminCap, arg1: &mut HedgeExecutorState, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun update_price_feed(arg0: &AdminCap, arg1: &mut HedgeExecutorState, arg2: u64, arg3: u64) {
        assert!(arg2 <= 12, 8);
        assert!(arg3 > 0, 1);
        if (0x2::table::contains<u64, u64>(&arg1.price_feeds, arg2)) {
            *0x2::table::borrow_mut<u64, u64>(&mut arg1.price_feeds, arg2) = arg3;
        } else {
            0x2::table::add<u64, u64>(&mut arg1.price_feeds, arg2, arg3);
        };
    }

    public entry fun withdraw_fees(arg0: &AdminCap, arg1: &mut HedgeExecutorState, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.fee_balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.fee_balance, v0), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    // decompiled from Move bytecode v7
}

