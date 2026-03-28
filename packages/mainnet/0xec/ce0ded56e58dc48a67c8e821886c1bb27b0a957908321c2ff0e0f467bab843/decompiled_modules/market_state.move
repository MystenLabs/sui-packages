module 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::market_state {
    struct MarketStatus has copy, drop, store {
        trading_started: bool,
        trading_ended: bool,
        in_execution_window: bool,
        finalized: bool,
    }

    struct MarketState has store, key {
        id: 0x2::object::UID,
        proposal_id: 0x2::object::ID,
        dao_id: 0x2::object::ID,
        outcome_count: u64,
        outcome_messages: vector<0x1::string::String>,
        amm_pools: 0x1::option::Option<vector<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::LiquidityPool>>,
        status: MarketStatus,
        winning_outcome: 0x1::option::Option<u64>,
        creation_time: u64,
        trading_start: u64,
        trading_end: 0x1::option::Option<u64>,
        finalization_time: 0x1::option::Option<u64>,
        execution_deadline: 0x1::option::Option<u64>,
        frozen_twaps: 0x1::option::Option<vector<u128>>,
        market_winner: 0x1::option::Option<u64>,
    }

    struct TradingStartedEvent has copy, drop {
        proposal_id: 0x2::object::ID,
        start_time: u64,
    }

    struct TradingEndedEvent has copy, drop {
        proposal_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct MarketStateFinalizedEvent has copy, drop {
        proposal_id: 0x2::object::ID,
        winning_outcome: u64,
        timestamp_ms: u64,
    }

    struct ExecutionWindowStartedEvent has copy, drop {
        proposal_id: 0x2::object::ID,
        market_winner: u64,
        execution_deadline: u64,
        timestamp_ms: u64,
    }

    struct ExecutionTimeoutEvent has copy, drop {
        proposal_id: 0x2::object::ID,
        market_winner: u64,
        actual_winner: u64,
        timestamp_ms: u64,
    }

    public fun new(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: vector<0x1::string::String>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : MarketState {
        assert!(arg2 >= 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::min_outcomes(), 16);
        assert!(arg2 <= 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::protocol_max_outcomes(), 16);
        assert!(0x1::vector::length<0x1::string::String>(&arg3) == arg2, 17);
        let v0 = MarketStatus{
            trading_started     : false,
            trading_ended       : false,
            in_execution_window : false,
            finalized           : false,
        };
        MarketState{
            id                 : 0x2::object::new(arg5),
            proposal_id        : arg0,
            dao_id             : arg1,
            outcome_count      : arg2,
            outcome_messages   : arg3,
            amm_pools          : 0x1::option::none<vector<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::LiquidityPool>>(),
            status             : v0,
            winning_outcome    : 0x1::option::none<u64>(),
            creation_time      : 0x2::clock::timestamp_ms(arg4),
            trading_start      : 0,
            trading_end        : 0x1::option::none<u64>(),
            finalization_time  : 0x1::option::none<u64>(),
            execution_deadline : 0x1::option::none<u64>(),
            frozen_twaps       : 0x1::option::none<vector<u128>>(),
            market_winner      : 0x1::option::none<u64>(),
        }
    }

    public fun are_swaps_allowed(arg0: &MarketState, arg1: &0x2::clock::Clock) : bool {
        if (!arg0.status.trading_started) {
            return false
        };
        if (arg0.status.finalized) {
            return false
        };
        let v0 = !arg0.status.trading_ended;
        let v1 = arg0.status.in_execution_window;
        let v2 = v0 || v1;
        if (!v2) {
            return false
        };
        if (v0 && 0x1::option::is_some<u64>(&arg0.trading_end)) {
            if (!(0x2::clock::timestamp_ms(arg1) < *0x1::option::borrow<u64>(&arg0.trading_end))) {
                return false
            };
        };
        if (v1) {
            if (!0x1::option::is_some<u64>(&arg0.execution_deadline)) {
                return false
            };
            if (!(0x2::clock::timestamp_ms(arg1) < *0x1::option::borrow<u64>(&arg0.execution_deadline))) {
                return false
            };
        };
        true
    }

    public fun assert_can_execute(arg0: &MarketState, arg1: &0x2::clock::Clock) {
        assert!(arg0.status.in_execution_window, 12);
        assert!(!arg0.status.finalized, 2);
        assert!(0x1::option::is_some<u64>(&arg0.execution_deadline), 12);
        assert!(0x2::clock::timestamp_ms(arg1) < *0x1::option::borrow<u64>(&arg0.execution_deadline), 10);
    }

    public fun assert_in_trading_or_pre_trading(arg0: &MarketState) {
        assert!(!arg0.status.trading_ended, 3);
        assert!(!arg0.status.finalized, 2);
    }

    public fun assert_market_finalized(arg0: &MarketState) {
        assert!(arg0.status.finalized, 5);
    }

    public fun assert_not_finalized(arg0: &MarketState) {
        assert!(!arg0.status.finalized, 2);
    }

    public fun assert_swaps_allowed(arg0: &MarketState, arg1: &0x2::clock::Clock) {
        assert!(arg0.status.trading_started, 6);
        assert!(!arg0.status.finalized, 2);
        let v0 = !arg0.status.trading_ended;
        let v1 = arg0.status.in_execution_window;
        assert!(v0 || v1, 3);
        if (v0 && 0x1::option::is_some<u64>(&arg0.trading_end)) {
            assert!(0x2::clock::timestamp_ms(arg1) < *0x1::option::borrow<u64>(&arg0.trading_end), 23);
        };
        if (v1) {
            assert!(0x1::option::is_some<u64>(&arg0.execution_deadline), 12);
            assert!(0x2::clock::timestamp_ms(arg1) < *0x1::option::borrow<u64>(&arg0.execution_deadline), 10);
        };
    }

    public fun assert_trading_active(arg0: &MarketState) {
        assert!(arg0.status.trading_started, 6);
        assert!(!arg0.status.trading_ended, 3);
    }

    public fun borrow_amm_pools(arg0: &MarketState) : &vector<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::LiquidityPool> {
        assert!(0x1::option::is_some<vector<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::LiquidityPool>>(&arg0.amm_pools), 19);
        0x1::option::borrow<vector<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::LiquidityPool>>(&arg0.amm_pools)
    }

    public fun can_execute(arg0: &MarketState, arg1: &0x2::clock::Clock) : bool {
        if (!arg0.status.in_execution_window || arg0.status.finalized) {
            return false
        };
        if (0x1::option::is_none<u64>(&arg0.execution_deadline)) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) < *0x1::option::borrow<u64>(&arg0.execution_deadline)
    }

    public fun dao_id(arg0: &MarketState) : 0x2::object::ID {
        arg0.dao_id
    }

    public fun finalize_from_execution_success(arg0: &mut MarketState, arg1: &0x2::clock::Clock, arg2: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::MarketStateMutationAuth) {
        assert!(arg0.status.in_execution_window, 12);
        assert!(!arg0.status.finalized, 2);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(0x1::option::is_some<u64>(&arg0.execution_deadline), 12);
        assert!(v0 < *0x1::option::borrow<u64>(&arg0.execution_deadline), 10);
        assert!(0x1::option::is_some<u64>(&arg0.market_winner), 12);
        let v1 = *0x1::option::borrow<u64>(&arg0.market_winner);
        arg0.status.finalized = true;
        arg0.status.in_execution_window = false;
        arg0.winning_outcome = 0x1::option::some<u64>(v1);
        arg0.finalization_time = 0x1::option::some<u64>(v0);
        let v2 = MarketStateFinalizedEvent{
            proposal_id     : arg0.proposal_id,
            winning_outcome : v1,
            timestamp_ms    : v0,
        };
        0x2::event::emit<MarketStateFinalizedEvent>(v2);
    }

    public fun finalize_from_timeout(arg0: &mut MarketState, arg1: &0x2::clock::Clock, arg2: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::MarketStateMutationAuth) {
        assert!(arg0.status.in_execution_window, 12);
        assert!(!arg0.status.finalized, 2);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(0x1::option::is_some<u64>(&arg0.execution_deadline), 12);
        assert!(v0 >= *0x1::option::borrow<u64>(&arg0.execution_deadline), 11);
        assert!(0x1::option::is_some<u64>(&arg0.market_winner), 12);
        let v1 = 0;
        arg0.status.finalized = true;
        arg0.status.in_execution_window = false;
        arg0.winning_outcome = 0x1::option::some<u64>(v1);
        arg0.finalization_time = 0x1::option::some<u64>(v0);
        let v2 = MarketStateFinalizedEvent{
            proposal_id     : arg0.proposal_id,
            winning_outcome : v1,
            timestamp_ms    : v0,
        };
        0x2::event::emit<MarketStateFinalizedEvent>(v2);
        let v3 = ExecutionTimeoutEvent{
            proposal_id   : arg0.proposal_id,
            market_winner : *0x1::option::borrow<u64>(&arg0.market_winner),
            actual_winner : v1,
            timestamp_ms  : v0,
        };
        0x2::event::emit<ExecutionTimeoutEvent>(v3);
    }

    public fun finalize_immediately_with_reject(arg0: &mut MarketState, arg1: vector<u128>, arg2: &0x2::clock::Clock, arg3: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::MarketStateMutationAuth) {
        assert!(arg0.status.trading_started, 6);
        assert!(!arg0.status.trading_ended, 3);
        assert!(!arg0.status.finalized, 2);
        assert!(!arg0.status.in_execution_window, 9);
        assert!(0x1::vector::length<u128>(&arg1) == arg0.outcome_count, 14);
        if (0x1::option::is_some<u64>(&arg0.trading_end)) {
            assert!(0x2::clock::timestamp_ms(arg2) >= *0x1::option::borrow<u64>(&arg0.trading_end), 20);
        };
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg0.status.trading_ended = true;
        arg0.status.finalized = true;
        arg0.winning_outcome = 0x1::option::some<u64>(0);
        arg0.finalization_time = 0x1::option::some<u64>(v0);
        arg0.frozen_twaps = 0x1::option::some<vector<u128>>(arg1);
        arg0.market_winner = 0x1::option::some<u64>(0);
        let v1 = TradingEndedEvent{
            proposal_id  : arg0.proposal_id,
            timestamp_ms : v0,
        };
        0x2::event::emit<TradingEndedEvent>(v1);
        let v2 = MarketStateFinalizedEvent{
            proposal_id     : arg0.proposal_id,
            winning_outcome : 0,
            timestamp_ms    : v0,
        };
        0x2::event::emit<MarketStateFinalizedEvent>(v2);
    }

    public fun get_creation_time(arg0: &MarketState) : u64 {
        arg0.creation_time
    }

    public fun get_execution_deadline(arg0: &MarketState) : 0x1::option::Option<u64> {
        arg0.execution_deadline
    }

    public fun get_finalization_time(arg0: &MarketState) : 0x1::option::Option<u64> {
        arg0.finalization_time
    }

    public fun get_frozen_twaps(arg0: &MarketState) : &0x1::option::Option<vector<u128>> {
        &arg0.frozen_twaps
    }

    public fun get_market_winner(arg0: &MarketState) : 0x1::option::Option<u64> {
        arg0.market_winner
    }

    public fun get_outcome_message(arg0: &MarketState, arg1: u64) : 0x1::string::String {
        assert!(arg1 < arg0.outcome_count, 1);
        *0x1::vector::borrow<0x1::string::String>(&arg0.outcome_messages, arg1)
    }

    public fun get_pool_by_outcome(arg0: &MarketState, arg1: u64) : &0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::LiquidityPool {
        assert!(arg1 < arg0.outcome_count, 1);
        assert!(0x1::option::is_some<vector<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::LiquidityPool>>(&arg0.amm_pools), 19);
        0x1::vector::borrow<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::LiquidityPool>(0x1::option::borrow<vector<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::LiquidityPool>>(&arg0.amm_pools), arg1)
    }

    public fun get_pool_mut_by_outcome(arg0: &mut MarketState, arg1: u64, arg2: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::escrow_mutation_auth::EscrowMutationAuth) : &mut 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::LiquidityPool {
        assert!(arg1 < arg0.outcome_count, 1);
        assert!(0x1::option::is_some<vector<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::LiquidityPool>>(&arg0.amm_pools), 19);
        0x1::vector::borrow_mut<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::LiquidityPool>(0x1::option::borrow_mut<vector<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::LiquidityPool>>(&mut arg0.amm_pools), arg1)
    }

    public fun get_trading_end_time(arg0: &MarketState) : 0x1::option::Option<u64> {
        arg0.trading_end
    }

    public fun get_trading_start(arg0: &MarketState) : u64 {
        arg0.trading_start
    }

    public fun get_winning_outcome(arg0: &MarketState) : u64 {
        assert!(arg0.status.finalized, 5);
        let v0 = &arg0.winning_outcome;
        assert!(0x1::option::is_some<u64>(v0), 5);
        *0x1::option::borrow<u64>(v0)
    }

    public fun has_amm_pools(arg0: &MarketState) : bool {
        0x1::option::is_some<vector<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::LiquidityPool>>(&arg0.amm_pools)
    }

    public fun is_execution_timed_out(arg0: &MarketState, arg1: &0x2::clock::Clock) : bool {
        if (!arg0.status.in_execution_window || arg0.status.finalized) {
            return false
        };
        if (0x1::option::is_none<u64>(&arg0.execution_deadline)) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) >= *0x1::option::borrow<u64>(&arg0.execution_deadline)
    }

    public fun is_finalized(arg0: &MarketState) : bool {
        arg0.status.finalized
    }

    public fun is_in_execution_window(arg0: &MarketState) : bool {
        arg0.status.in_execution_window
    }

    public fun is_trading_active(arg0: &MarketState) : bool {
        arg0.status.trading_started && !arg0.status.trading_ended
    }

    public fun is_trading_started(arg0: &MarketState) : bool {
        arg0.status.trading_started
    }

    public fun market_id(arg0: &MarketState) : 0x2::object::ID {
        0x2::object::id<MarketState>(arg0)
    }

    public fun outcome_count(arg0: &MarketState) : u64 {
        arg0.outcome_count
    }

    public fun proposal_id(arg0: &MarketState) : 0x2::object::ID {
        arg0.proposal_id
    }

    public fun set_amm_pools(arg0: &mut MarketState, arg1: vector<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::LiquidityPool>, arg2: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::MarketStateMutationAuth) {
        assert!(0x1::option::is_none<vector<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::LiquidityPool>>(&arg0.amm_pools), 15);
        assert!(0x1::vector::length<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::LiquidityPool>(&arg1) == arg0.outcome_count, 18);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::LiquidityPool>(&arg1)) {
            assert!(0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::get_ms_id(0x1::vector::borrow<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::LiquidityPool>(&arg1, v0)) == 0x2::object::id<MarketState>(arg0), 22);
            assert!((0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::get_outcome_idx(0x1::vector::borrow<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::LiquidityPool>(&arg1, v0)) as u64) == v0, 24);
            v0 = v0 + 1;
        };
        0x1::option::fill<vector<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::LiquidityPool>>(&mut arg0.amm_pools, arg1);
    }

    public fun start_execution_window(arg0: &mut MarketState, arg1: u64, arg2: vector<u128>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::MarketStateMutationAuth) {
        assert!(arg0.status.trading_started, 6);
        assert!(!arg0.status.trading_ended, 3);
        assert!(!arg0.status.in_execution_window, 9);
        assert!(!arg0.status.finalized, 2);
        assert!(arg3 < arg0.outcome_count, 1);
        if (0x1::option::is_some<u64>(&arg0.trading_end)) {
            assert!(0x2::clock::timestamp_ms(arg4) >= *0x1::option::borrow<u64>(&arg0.trading_end), 20);
        };
        assert!(arg1 >= 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::min_execution_window_ms() && arg1 <= 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::max_execution_window_ms(), 13);
        assert!(0x1::vector::length<u128>(&arg2) == arg0.outcome_count, 14);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = v0 + arg1;
        arg0.status.trading_ended = true;
        arg0.status.in_execution_window = true;
        arg0.execution_deadline = 0x1::option::some<u64>(v1);
        arg0.frozen_twaps = 0x1::option::some<vector<u128>>(arg2);
        arg0.market_winner = 0x1::option::some<u64>(arg3);
        let v2 = TradingEndedEvent{
            proposal_id  : arg0.proposal_id,
            timestamp_ms : v0,
        };
        0x2::event::emit<TradingEndedEvent>(v2);
        let v3 = ExecutionWindowStartedEvent{
            proposal_id        : arg0.proposal_id,
            market_winner      : arg3,
            execution_deadline : v1,
            timestamp_ms       : v0,
        };
        0x2::event::emit<ExecutionWindowStartedEvent>(v3);
    }

    public fun start_trading(arg0: &mut MarketState, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::MarketStateMutationAuth) {
        assert!(!arg0.status.trading_started, 0);
        assert!(arg1 > 0 && arg1 <= 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::max_trading_duration_ms(), 7);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg2, 25);
        arg0.status.trading_started = true;
        arg0.trading_start = arg2;
        arg0.trading_end = 0x1::option::some<u64>(arg2 + arg1);
        let v0 = TradingStartedEvent{
            proposal_id : arg0.proposal_id,
            start_time  : arg2,
        };
        0x2::event::emit<TradingStartedEvent>(v0);
    }

    public fun validate_outcome(arg0: &MarketState, arg1: u64) {
        assert!(arg1 < arg0.outcome_count, 1);
    }

    // decompiled from Move bytecode v6
}

