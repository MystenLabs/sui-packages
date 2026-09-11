module 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten {
    struct BTEN has drop {
        dummy_field: bool,
    }

    struct RouterCap has store, key {
        id: 0x2::object::UID,
    }

    struct RegistryAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PoolRegistry has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<address, u8>,
        finalized: bool,
    }

    struct PointKey has copy, drop, store {
        round: u64,
        trader: address,
    }

    struct TraderRound has copy, drop, store {
        total_points: u64,
        reward_total: u64,
        reward_paid: u64,
    }

    struct EmissionState has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<BTEN>,
        total_minted: u64,
        block_height: u64,
        last_slot_ts: u64,
        pending_blocks: u64,
        batch_trades: u64,
        batch_fee_points: u64,
        current_round: u64,
        trader_points: 0x2::table::Table<PointKey, u64>,
        trader_rounds: 0x2::table::Table<u64, TraderRound>,
        route_fee_vault: 0x2::balance::Balance<BTEN>,
        trader_vault: 0x2::balance::Balance<BTEN>,
        bten_lp_vault: 0x2::balance::Balance<BTEN>,
        staking_vault: 0x2::balance::Balance<BTEN>,
        cetus_vault: 0x2::balance::Balance<BTEN>,
        haedal_vault: 0x2::balance::Balance<BTEN>,
        blue_vault: 0x2::balance::Balance<BTEN>,
        magma_vault: 0x2::balance::Balance<BTEN>,
        sui_gas_vault: 0x2::balance::Balance<BTEN>,
    }

    struct RouteRecorded has copy, drop {
        trader: address,
        fee_points: u64,
        batch_trades: u64,
    }

    struct BlocksReleased has copy, drop {
        blocks: u64,
        emission: u64,
        remaining_pending: u64,
    }

    struct TraderPaid has copy, drop {
        round: u64,
        trader: address,
        amount: u64,
    }

    fun advance_slots(arg0: &mut EmissionState, arg1: u64) {
        if (arg0.last_slot_ts == 0) {
            arg0.last_slot_ts = arg1;
            return
        };
        if (arg1 <= arg0.last_slot_ts) {
            return
        };
        let v0 = (arg1 - arg0.last_slot_ts) / 600;
        if (v0 > 0) {
            arg0.pending_blocks = arg0.pending_blocks + v0;
            arg0.last_slot_ts = arg0.last_slot_ts + v0 * 600;
        };
    }

    fun allocate(arg0: &mut EmissionState, arg1: 0x2::balance::Balance<BTEN>, arg2: u64) {
        0x2::balance::join<BTEN>(&mut arg0.route_fee_vault, 0x2::balance::split<BTEN>(&mut arg1, arg2 * 5000 / 10000));
        0x2::balance::join<BTEN>(&mut arg0.trader_vault, 0x2::balance::split<BTEN>(&mut arg1, arg2 * 1000 / 10000));
        0x2::balance::join<BTEN>(&mut arg0.bten_lp_vault, 0x2::balance::split<BTEN>(&mut arg1, arg2 * 2500 / 10000));
        0x2::balance::join<BTEN>(&mut arg0.staking_vault, 0x2::balance::split<BTEN>(&mut arg1, arg2 * 1000 / 10000));
        0x2::balance::join<BTEN>(&mut arg0.cetus_vault, 0x2::balance::split<BTEN>(&mut arg1, arg2 * 100 / 10000));
        0x2::balance::join<BTEN>(&mut arg0.haedal_vault, 0x2::balance::split<BTEN>(&mut arg1, arg2 * 100 / 10000));
        0x2::balance::join<BTEN>(&mut arg0.blue_vault, 0x2::balance::split<BTEN>(&mut arg1, arg2 * 100 / 10000));
        0x2::balance::join<BTEN>(&mut arg0.magma_vault, 0x2::balance::split<BTEN>(&mut arg1, arg2 * 100 / 10000));
        0x2::balance::join<BTEN>(&mut arg0.sui_gas_vault, 0x2::balance::split<BTEN>(&mut arg1, arg2 * 100 / 10000));
        0x2::balance::join<BTEN>(&mut arg0.haedal_vault, arg1);
    }

    public fun auto_pay_trader(arg0: &mut EmissionState, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, TraderRound>(&arg0.trader_rounds, arg1), 6);
        let v0 = PointKey{
            round  : arg1,
            trader : arg2,
        };
        assert!(0x2::table::contains<PointKey, u64>(&arg0.trader_points, v0), 7);
        let v1 = 0x2::table::borrow_mut<u64, TraderRound>(&mut arg0.trader_rounds, arg1);
        let v2 = 0x2::table::remove<PointKey, u64>(&mut arg0.trader_points, v0) * v1.reward_total / v1.total_points;
        assert!(v2 > 0, 7);
        v1.reward_paid = v1.reward_paid + v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<BTEN>>(0x2::coin::from_balance<BTEN>(0x2::balance::split<BTEN>(&mut arg0.trader_vault, v2), arg3), arg2);
        let v3 = TraderPaid{
            round  : arg1,
            trader : arg2,
            amount : v2,
        };
        0x2::event::emit<TraderPaid>(v3);
    }

    public fun batch_trades(arg0: &EmissionState) : u64 {
        arg0.batch_trades
    }

    public fun block_height(arg0: &EmissionState) : u64 {
        arg0.block_height
    }

    public fun block_time_secs() : u64 {
        600
    }

    public fun blue_balance(arg0: &EmissionState) : u64 {
        0x2::balance::value<BTEN>(&arg0.blue_vault)
    }

    public fun bten_lp_balance(arg0: &EmissionState) : u64 {
        0x2::balance::value<BTEN>(&arg0.bten_lp_vault)
    }

    public fun cetus_balance(arg0: &EmissionState) : u64 {
        0x2::balance::value<BTEN>(&arg0.cetus_vault)
    }

    public fun current_round(arg0: &EmissionState) : u64 {
        arg0.current_round
    }

    public fun decimals() : u8 {
        8
    }

    fun emission_between(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0;
        let v1 = 0;
        while (v0 < arg1) {
            let v2 = (v0 / 210000 + 1) * 210000;
            let v3 = if (arg1 < v2) {
                arg1
            } else {
                v2
            };
            v1 = v1 + (v3 - arg0) * subsidy_at_height(arg0);
            v0 = v3;
        };
        v1
    }

    public fun finalize_pool_registry(arg0: &mut PoolRegistry, arg1: &RegistryAdminCap) {
        arg0.finalized = true;
    }

    public fun haedal_balance(arg0: &EmissionState) : u64 {
        0x2::balance::value<BTEN>(&arg0.haedal_vault)
    }

    fun init(arg0: BTEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BTEN>(arg0, 8, b"BTEN", b"BlockTen", b"Trade-gated, fixed-cap routing token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BTEN>>(v2, v0);
        let v3 = RouterCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<RouterCap>(v3, v0);
        let v4 = RegistryAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<RegistryAdminCap>(v4, v0);
        let v5 = PoolRegistry{
            id        : 0x2::object::new(arg1),
            pools     : 0x2::table::new<address, u8>(arg1),
            finalized : false,
        };
        0x2::transfer::share_object<PoolRegistry>(v5);
        let v6 = EmissionState{
            id               : 0x2::object::new(arg1),
            cap              : v1,
            total_minted     : 0,
            block_height     : 0,
            last_slot_ts     : 0,
            pending_blocks   : 0,
            batch_trades     : 0,
            batch_fee_points : 0,
            current_round    : 0,
            trader_points    : 0x2::table::new<PointKey, u64>(arg1),
            trader_rounds    : 0x2::table::new<u64, TraderRound>(arg1),
            route_fee_vault  : 0x2::balance::zero<BTEN>(),
            trader_vault     : 0x2::balance::zero<BTEN>(),
            bten_lp_vault    : 0x2::balance::zero<BTEN>(),
            staking_vault    : 0x2::balance::zero<BTEN>(),
            cetus_vault      : 0x2::balance::zero<BTEN>(),
            haedal_vault     : 0x2::balance::zero<BTEN>(),
            blue_vault       : 0x2::balance::zero<BTEN>(),
            magma_vault      : 0x2::balance::zero<BTEN>(),
            sui_gas_vault    : 0x2::balance::zero<BTEN>(),
        };
        0x2::transfer::share_object<EmissionState>(v6);
    }

    public fun initial_subsidy() : u64 {
        5000000000
    }

    public fun magma_balance(arg0: &EmissionState) : u64 {
        turbos_balance(arg0)
    }

    public fun max_supply() : u64 {
        2100000000000000
    }

    public fun min_trades_per_block() : u64 {
        10
    }

    public fun pending_blocks(arg0: &EmissionState) : u64 {
        arg0.pending_blocks
    }

    public fun pool_bucket(arg0: &PoolRegistry, arg1: address) : u8 {
        if (!0x2::table::contains<address, u8>(&arg0.pools, arg1)) {
            return 255
        };
        *0x2::table::borrow<address, u8>(&arg0.pools, arg1)
    }

    public fun record_qualified_route(arg0: &mut EmissionState, arg1: &RouterCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0);
        advance_slots(arg0, 0x2::clock::timestamp_ms(arg3) / 1000);
        arg0.batch_trades = arg0.batch_trades + 1;
        arg0.batch_fee_points = arg0.batch_fee_points + arg2;
        let v0 = PointKey{
            round  : arg0.current_round,
            trader : 0x2::tx_context::sender(arg4),
        };
        if (0x2::table::contains<PointKey, u64>(&arg0.trader_points, v0)) {
            *0x2::table::borrow_mut<PointKey, u64>(&mut arg0.trader_points, v0) = *0x2::table::borrow<PointKey, u64>(&arg0.trader_points, v0) + arg2;
        } else {
            0x2::table::add<PointKey, u64>(&mut arg0.trader_points, v0, arg2);
        };
        let v1 = RouteRecorded{
            trader       : 0x2::tx_context::sender(arg4),
            fee_points   : arg2,
            batch_trades : arg0.batch_trades,
        };
        0x2::event::emit<RouteRecorded>(v1);
    }

    public fun register_pool(arg0: &mut PoolRegistry, arg1: &RegistryAdminCap, arg2: address, arg3: u8) {
        assert!(!arg0.finalized, 5);
        assert!(arg3 <= 5, 3);
        assert!(!0x2::table::contains<address, u8>(&arg0.pools, arg2), 4);
        0x2::table::add<address, u8>(&mut arg0.pools, arg2, arg3);
    }

    public fun registry_is_finalized(arg0: &PoolRegistry) : bool {
        arg0.finalized
    }

    public fun release_genesis(arg0: &mut EmissionState, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.total_minted == 0 && arg0.block_height == 0, 10);
        let v0 = subsidy_at_height(0);
        arg0.total_minted = v0;
        let v1 = 0x2::coin::into_balance<BTEN>(0x2::coin::mint<BTEN>(&mut arg0.cap, v0, arg1));
        allocate(arg0, v1, v0);
        arg0.block_height = 1;
        let v2 = BlocksReleased{
            blocks            : 1,
            emission          : v0,
            remaining_pending : arg0.pending_blocks,
        };
        0x2::event::emit<BlocksReleased>(v2);
    }

    public fun route_fee_balance(arg0: &EmissionState) : u64 {
        0x2::balance::value<BTEN>(&arg0.route_fee_vault)
    }

    public fun settle(arg0: &mut EmissionState, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        advance_slots(arg0, 0x2::clock::timestamp_ms(arg1) / 1000);
        let v0 = arg0.batch_trades / 10;
        let v1 = if (arg0.pending_blocks < v0) {
            arg0.pending_blocks
        } else {
            v0
        };
        let v2 = v1;
        if (v1 > 100) {
            v2 = 100;
        };
        assert!(v2 > 0, 1);
        let v3 = emission_between(arg0.block_height, arg0.block_height + v2);
        if (v3 > 0) {
            assert!(arg0.total_minted + v3 <= 2100000000000000, 2);
            arg0.total_minted = arg0.total_minted + v3;
            let v4 = 0x2::coin::into_balance<BTEN>(0x2::coin::mint<BTEN>(&mut arg0.cap, v3, arg2));
            allocate(arg0, v4, v3);
            let v5 = TraderRound{
                total_points : arg0.batch_fee_points,
                reward_total : v3 * 1000 / 10000,
                reward_paid  : 0,
            };
            0x2::table::add<u64, TraderRound>(&mut arg0.trader_rounds, arg0.current_round, v5);
        };
        arg0.block_height = arg0.block_height + v2;
        arg0.pending_blocks = arg0.pending_blocks - v2;
        arg0.batch_trades = 0;
        arg0.batch_fee_points = 0;
        arg0.current_round = arg0.current_round + 1;
        let v6 = BlocksReleased{
            blocks            : v2,
            emission          : v3,
            remaining_pending : arg0.pending_blocks,
        };
        0x2::event::emit<BlocksReleased>(v6);
    }

    public fun staking_balance(arg0: &EmissionState) : u64 {
        0x2::balance::value<BTEN>(&arg0.staking_vault)
    }

    public fun subsidy_at_height(arg0: u64) : u64 {
        let v0 = arg0 / 210000;
        if (v0 >= 64) {
            return 0
        };
        let v1 = 1;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 * 2;
            v2 = v2 + 1;
        };
        5000000000 / v1
    }

    public fun sui_gas_balance(arg0: &EmissionState) : u64 {
        0x2::balance::value<BTEN>(&arg0.sui_gas_vault)
    }

    public fun total_minted(arg0: &EmissionState) : u64 {
        arg0.total_minted
    }

    public fun trader_balance(arg0: &EmissionState) : u64 {
        0x2::balance::value<BTEN>(&arg0.trader_vault)
    }

    public fun turbos_balance(arg0: &EmissionState) : u64 {
        0x2::balance::value<BTEN>(&arg0.magma_vault)
    }

    public fun unit() : u64 {
        100000000
    }

    public fun update_coin_metadata(arg0: &EmissionState, arg1: &RegistryAdminCap, arg2: &mut 0x2::coin::CoinMetadata<BTEN>, arg3: 0x1::ascii::String, arg4: 0x1::string::String) {
        0x2::coin::update_icon_url<BTEN>(&arg0.cap, arg2, arg3);
        0x2::coin::update_description<BTEN>(&arg0.cap, arg2, arg4);
    }

    public fun withdraw_bootstrap_bten_lp(arg0: &mut EmissionState, arg1: &RegistryAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BTEN> {
        assert!(arg2 > 0, 0);
        0x2::coin::from_balance<BTEN>(0x2::balance::split<BTEN>(&mut arg0.bten_lp_vault, arg2), arg3)
    }

    public fun withdraw_registered_pool_funding(arg0: &mut EmissionState, arg1: &PoolRegistry, arg2: &RegistryAdminCap, arg3: address, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BTEN> {
        assert!(arg5 > 0, 0);
        assert!(0x2::table::contains<address, u8>(&arg1.pools, arg3), 8);
        assert!(*0x2::table::borrow<address, u8>(&arg1.pools, arg3) == arg4, 3);
        let v0 = if (arg4 == 0) {
            true
        } else if (arg4 == 1) {
            true
        } else {
            arg4 == 3
        };
        assert!(v0, 9);
        let v1 = if (arg4 == 0) {
            &mut arg0.bten_lp_vault
        } else if (arg4 == 1) {
            &mut arg0.cetus_vault
        } else {
            &mut arg0.magma_vault
        };
        0x2::coin::from_balance<BTEN>(0x2::balance::split<BTEN>(v1, arg5), arg6)
    }

    // decompiled from Move bytecode v7
}

