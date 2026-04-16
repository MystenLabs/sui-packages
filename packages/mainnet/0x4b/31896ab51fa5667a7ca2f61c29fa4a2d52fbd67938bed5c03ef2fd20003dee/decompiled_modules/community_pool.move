module 0x900bca6461ad24c86b83c974788b457cb76c3f6f4fd7b061c5b58cb40d974bab::community_pool {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AgentCap has store, key {
        id: 0x2::object::UID,
        agent_address: address,
    }

    struct FeeManagerCap has store, key {
        id: 0x2::object::UID,
    }

    struct RebalancerCap has store, key {
        id: 0x2::object::UID,
    }

    struct MemberData has copy, drop, store {
        shares: u64,
        deposited_sui: u64,
        withdrawn_sui: u64,
        joined_at: u64,
        last_deposit_at: u64,
        high_water_mark: u64,
    }

    struct AIDecision has copy, drop, store {
        decision_id: vector<u8>,
        timestamp: u64,
        target_alloc_bps: u64,
        confidence: u8,
        urgency: u8,
        expected_return_bps: u64,
        risk_score: u64,
        reason_hash: vector<u8>,
        data_feed_hash: vector<u8>,
        executed: bool,
    }

    struct RebalanceRecord has copy, drop, store {
        timestamp: u64,
        previous_alloc_bps: u64,
        new_alloc_bps: u64,
        reason_hash: vector<u8>,
        executor: address,
    }

    struct CrossChainSignal has copy, drop, store {
        signal_id: vector<u8>,
        timestamp: u64,
        source_chain_id: u64,
        target_alloc_bps: u64,
        price_data_hash: vector<u8>,
        action: u8,
        acknowledged: bool,
    }

    struct AIAgentMetrics has copy, drop, store {
        total_decisions: u64,
        successful_decisions: u64,
        cumulative_return_bps: u64,
        avg_confidence: u64,
        last_decision_time: u64,
        last_decision_id: vector<u8>,
    }

    struct AutoHedgeConfig has copy, drop, store {
        enabled: bool,
        risk_threshold_bps: u64,
        max_hedge_ratio_bps: u64,
        default_leverage: u64,
        cooldown_ms: u64,
        last_hedge_time: u64,
    }

    struct HedgePosition has copy, drop, store {
        hedge_id: vector<u8>,
        pair_index: u8,
        collateral_amount: u64,
        leverage: u64,
        is_long: bool,
        open_time: u64,
        reason_hash: vector<u8>,
    }

    struct TimelockOperation has copy, drop, store {
        operation_id: vector<u8>,
        operation_type: u8,
        target_value: u64,
        target_address: address,
        scheduled_time: u64,
        expiry_time: u64,
        executed: bool,
    }

    struct AIManagementState has store {
        current_ai_decision: AIDecision,
        ai_decision_count: u64,
        latest_signal: CrossChainSignal,
        agent_metrics: vector<AIAgentMetrics>,
        min_ai_confidence: u8,
        require_signal_verification: bool,
    }

    struct RebalanceState has store {
        target_allocation_bps: u64,
        last_rebalance_time: u64,
        rebalance_cooldown: u64,
        rebalance_count: u64,
    }

    struct HedgeState has store {
        auto_hedge_config: AutoHedgeConfig,
        active_hedges: vector<HedgePosition>,
        total_hedged_value: u64,
        daily_hedge_total: u64,
        current_hedge_day: u64,
    }

    struct TimelockState has store {
        pending_operations: vector<TimelockOperation>,
        timelock_delay: u64,
        emergency_withdraw_enabled: bool,
    }

    struct CommunityPoolState has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_shares: u64,
        total_deposited: u64,
        total_withdrawn: u64,
        all_time_high_nav_per_share: u64,
        management_fee_bps: u64,
        performance_fee_bps: u64,
        accumulated_management_fees: u64,
        accumulated_performance_fees: u64,
        last_fee_collection: u64,
        treasury: address,
        paused: bool,
        circuit_breaker_tripped: bool,
        max_single_deposit: u64,
        max_single_withdrawal_bps: u64,
        daily_withdrawal_cap_bps: u64,
        daily_withdrawal_total: u64,
        current_withdrawal_day: u64,
        members: 0x2::table::Table<address, MemberData>,
        member_count: u64,
        agent_addresses: vector<address>,
        created_at: u64,
        ai_state: AIManagementState,
        rebalance_state: RebalanceState,
        hedge_state: HedgeState,
        timelock_state: TimelockState,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        treasury: address,
        creator: address,
        timestamp: u64,
    }

    struct Deposited has copy, drop {
        member: address,
        amount_sui: u64,
        shares_received: u64,
        share_price: u64,
        timestamp: u64,
    }

    struct Withdrawn has copy, drop {
        member: address,
        shares_burned: u64,
        amount_sui: u64,
        share_price: u64,
        timestamp: u64,
    }

    struct FeesCollected has copy, drop {
        management_fee: u64,
        performance_fee: u64,
        collector: address,
        timestamp: u64,
    }

    struct PoolPaused has copy, drop {
        pool_id: 0x2::object::ID,
        paused: bool,
        timestamp: u64,
    }

    struct CircuitBreakerTripped has copy, drop {
        pool_id: 0x2::object::ID,
        reason: vector<u8>,
        timestamp: u64,
    }

    struct TreasuryUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        old_treasury: address,
        new_treasury: address,
        timestamp: u64,
    }

    struct AgentAdded has copy, drop {
        pool_id: 0x2::object::ID,
        agent: address,
        timestamp: u64,
    }

    struct EmergencyWithdrawal has copy, drop {
        member: address,
        amount: u64,
        timestamp: u64,
    }

    struct AIDecisionRecorded has copy, drop {
        decision_id: vector<u8>,
        agent: address,
        target_alloc_bps: u64,
        confidence: u8,
        expected_return_bps: u64,
        timestamp: u64,
    }

    struct AIDecisionExecuted has copy, drop {
        decision_id: vector<u8>,
        executor: address,
        successful: bool,
        timestamp: u64,
    }

    struct CrossChainSignalReceived has copy, drop {
        signal_id: vector<u8>,
        source_chain_id: u64,
        action: u8,
        timestamp: u64,
    }

    struct AIAgentMetricsUpdated has copy, drop {
        agent: address,
        total_decisions: u64,
        cumulative_return_bps: u64,
        timestamp: u64,
    }

    struct Rebalanced has copy, drop {
        executor: address,
        previous_bps: u64,
        new_bps: u64,
        reason_hash: vector<u8>,
        timestamp: u64,
    }

    struct AllocationUpdated has copy, drop {
        old_bps: u64,
        new_bps: u64,
        timestamp: u64,
    }

    struct PoolHedgeOpened has copy, drop {
        hedge_id: vector<u8>,
        pair_index: u8,
        collateral_amount: u64,
        leverage: u64,
        is_long: bool,
        timestamp: u64,
    }

    struct PoolHedgeClosed has copy, drop {
        hedge_id: vector<u8>,
        pnl_amount: u64,
        is_profit: bool,
        timestamp: u64,
    }

    struct AutoHedgeConfigUpdated has copy, drop {
        enabled: bool,
        risk_threshold_bps: u64,
        max_hedge_ratio_bps: u64,
        default_leverage: u64,
        timestamp: u64,
    }

    struct TimelockOperationScheduled has copy, drop {
        operation_id: vector<u8>,
        operation_type: u8,
        scheduled_time: u64,
        timestamp: u64,
    }

    struct TimelockOperationExecuted has copy, drop {
        operation_id: vector<u8>,
        operation_type: u8,
        timestamp: u64,
    }

    struct TimelockOperationCancelled has copy, drop {
        operation_id: vector<u8>,
        timestamp: u64,
    }

    struct TokensRescued has copy, drop {
        amount: u64,
        recipient: address,
        timestamp: u64,
    }

    struct CircuitBreakerReset has copy, drop {
        pool_id: 0x2::object::ID,
        timestamp: u64,
    }

    public entry fun acknowledge_signal(arg0: &AgentCap, arg1: &mut CommunityPoolState) {
        arg1.ai_state.latest_signal.acknowledged = true;
    }

    public entry fun add_agent(arg0: &AdminCap, arg1: &mut CommunityPoolState, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<address>(&mut arg1.agent_addresses, arg2);
        let v0 = AgentCap{
            id            : 0x2::object::new(arg4),
            agent_address : arg2,
        };
        0x2::transfer::transfer<AgentCap>(v0, arg2);
        let v1 = AgentAdded{
            pool_id   : 0x2::object::id<CommunityPoolState>(arg1),
            agent     : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AgentAdded>(v1);
    }

    public entry fun admin_migrate_funds(arg0: &AdminCap, arg1: &mut CommunityPoolState, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.timelock_state.emergency_withdraw_enabled, 25);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        assert!(v0 > 0, 26);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v0), arg4), arg2);
        arg1.total_shares = 0;
        let v1 = TokensRescued{
            amount    : v0,
            recipient : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TokensRescued>(v1);
    }

    public entry fun agent_add_profits(arg0: &AgentCap, arg1: &mut CommunityPoolState, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock) {
        assert!(!arg1.paused, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) > 0, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v0 = get_nav_per_share(arg1);
        if (v0 > arg1.all_time_high_nav_per_share) {
            arg1.all_time_high_nav_per_share = v0;
        };
    }

    public entry fun agent_deposit_to_treasury(arg0: &AgentCap, arg1: &mut CommunityPoolState, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 1);
        assert!(arg2 > 0, 2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.balance) >= arg2, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg2), arg3), arg1.treasury);
    }

    public entry fun agent_record_loss(arg0: &AgentCap, arg1: &mut CommunityPoolState, arg2: u64) {
        assert!(!arg1.paused, 1);
    }

    public fun calculate_assets_for_shares(arg0: &CommunityPoolState, arg1: u64) : u64 {
        if (arg0.total_shares == 0) {
            return 0
        };
        (((arg1 as u128) * ((0x2::balance::value<0x2::sui::SUI>(&arg0.balance) + 1000000000) as u128) / ((arg0.total_shares + 1000000000) as u128)) as u64)
    }

    public fun calculate_shares_for_deposit(arg0: &CommunityPoolState, arg1: u64) : u64 {
        (((arg1 as u128) * ((arg0.total_shares + 1000000000) as u128) / ((0x2::balance::value<0x2::sui::SUI>(&arg0.balance) + 1000000000) as u128)) as u64)
    }

    public entry fun cancel_timelock_operation(arg0: &AdminCap, arg1: &mut CommunityPoolState, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        let v0 = 0;
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<TimelockOperation>(&arg1.timelock_state.pending_operations)) {
            let v3 = 0x1::vector::borrow<TimelockOperation>(&arg1.timelock_state.pending_operations, v2);
            if (v3.operation_id == arg2 && !v3.executed) {
                v0 = v2;
                v1 = true;
                break
            };
            v2 = v2 + 1;
        };
        assert!(v1, 24);
        0x1::vector::remove<TimelockOperation>(&mut arg1.timelock_state.pending_operations, v0);
        let v4 = TimelockOperationCancelled{
            operation_id : arg2,
            timestamp    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TimelockOperationCancelled>(v4);
    }

    public entry fun close_pool_hedge(arg0: &AgentCap, arg1: &mut CommunityPoolState, arg2: vector<u8>, arg3: u64, arg4: bool, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 1);
        let v0 = 0;
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<HedgePosition>(&arg1.hedge_state.active_hedges)) {
            if (0x1::vector::borrow<HedgePosition>(&arg1.hedge_state.active_hedges, v2).hedge_id == arg2) {
                v0 = v2;
                v1 = true;
                break
            };
            v2 = v2 + 1;
        };
        assert!(v1, 21);
        let v3 = 0x1::vector::remove<HedgePosition>(&mut arg1.hedge_state.active_hedges, v0);
        let v4 = if (arg1.hedge_state.total_hedged_value > v3.collateral_amount) {
            arg1.hedge_state.total_hedged_value - v3.collateral_amount
        } else {
            0
        };
        arg1.hedge_state.total_hedged_value = v4;
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
        if (arg4) {
            let v5 = get_nav_per_share(arg1);
            if (v5 > arg1.all_time_high_nav_per_share) {
                arg1.all_time_high_nav_per_share = v5;
            };
        };
        let v6 = PoolHedgeClosed{
            hedge_id   : arg2,
            pnl_amount : arg3,
            is_profit  : arg4,
            timestamp  : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<PoolHedgeClosed>(v6);
    }

    public entry fun collect_fees(arg0: &FeeManagerCap, arg1: &mut CommunityPoolState, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        collect_management_fee_internal(arg1, v0);
        let v1 = arg1.accumulated_management_fees + arg1.accumulated_performance_fees;
        assert!(v1 > 0, 2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.balance) >= v1, 4);
        arg1.accumulated_management_fees = 0;
        arg1.accumulated_performance_fees = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v1), arg3), arg1.treasury);
        let v2 = FeesCollected{
            management_fee  : arg1.accumulated_management_fees,
            performance_fee : arg1.accumulated_performance_fees,
            collector       : 0x2::tx_context::sender(arg3),
            timestamp       : v0,
        };
        0x2::event::emit<FeesCollected>(v2);
    }

    fun collect_management_fee_internal(arg0: &mut CommunityPoolState, arg1: u64) {
        if (arg0.total_shares == 0) {
            arg0.last_fee_collection = arg1;
            return
        };
        let v0 = arg1 - arg0.last_fee_collection;
        if (v0 == 0) {
            return
        };
        let v1 = (((get_total_nav(arg0) as u128) * (arg0.management_fee_bps as u128) * ((v0 / 1000) as u128) / (10000 as u128) * (31536000 as u128)) as u64);
        if (v1 > 0) {
            arg0.accumulated_management_fees = arg0.accumulated_management_fees + v1;
        };
        arg0.last_fee_collection = arg1;
    }

    fun collect_performance_fee_internal(arg0: &mut CommunityPoolState, arg1: address) {
        if (!0x2::table::contains<address, MemberData>(&arg0.members, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow<address, MemberData>(&arg0.members, arg1);
        let v1 = get_nav_per_share(arg0);
        if (v1 > v0.high_water_mark) {
            let v2 = (((((((v1 - v0.high_water_mark) as u128) * (v0.shares as u128) / (1000000000 as u128)) as u64) as u128) * (arg0.performance_fee_bps as u128) / (10000 as u128)) as u64);
            if (v2 > 0) {
                arg0.accumulated_performance_fees = arg0.accumulated_performance_fees + v2;
            };
        };
        0x2::table::borrow_mut<address, MemberData>(&mut arg0.members, arg1).high_water_mark = v1;
    }

    public entry fun create_admin_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    public entry fun create_fee_manager_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeManagerCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<FeeManagerCap>(v0, arg1);
    }

    public entry fun create_pool(arg0: &AdminCap, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = AIDecision{
            decision_id         : 0x1::vector::empty<u8>(),
            timestamp           : 0,
            target_alloc_bps    : 10000,
            confidence          : 0,
            urgency             : 0,
            expected_return_bps : 0,
            risk_score          : 0,
            reason_hash         : 0x1::vector::empty<u8>(),
            data_feed_hash      : 0x1::vector::empty<u8>(),
            executed            : true,
        };
        let v2 = CrossChainSignal{
            signal_id        : 0x1::vector::empty<u8>(),
            timestamp        : 0,
            source_chain_id  : 0,
            target_alloc_bps : 10000,
            price_data_hash  : 0x1::vector::empty<u8>(),
            action           : 0,
            acknowledged     : true,
        };
        let v3 = AIManagementState{
            current_ai_decision         : v1,
            ai_decision_count           : 0,
            latest_signal               : v2,
            agent_metrics               : 0x1::vector::empty<AIAgentMetrics>(),
            min_ai_confidence           : 50,
            require_signal_verification : false,
        };
        let v4 = RebalanceState{
            target_allocation_bps : 10000,
            last_rebalance_time   : 0,
            rebalance_cooldown    : 3600000,
            rebalance_count       : 0,
        };
        let v5 = AutoHedgeConfig{
            enabled             : false,
            risk_threshold_bps  : 500,
            max_hedge_ratio_bps : 2500,
            default_leverage    : 3,
            cooldown_ms         : 3600000,
            last_hedge_time     : 0,
        };
        let v6 = HedgeState{
            auto_hedge_config  : v5,
            active_hedges      : 0x1::vector::empty<HedgePosition>(),
            total_hedged_value : 0,
            daily_hedge_total  : 0,
            current_hedge_day  : v0 / 86400000,
        };
        let v7 = TimelockState{
            pending_operations         : 0x1::vector::empty<TimelockOperation>(),
            timelock_delay             : 300000,
            emergency_withdraw_enabled : false,
        };
        let v8 = CommunityPoolState{
            id                           : 0x2::object::new(arg3),
            balance                      : 0x2::balance::zero<0x2::sui::SUI>(),
            total_shares                 : 0,
            total_deposited              : 0,
            total_withdrawn              : 0,
            all_time_high_nav_per_share  : 1000000000,
            management_fee_bps           : 50,
            performance_fee_bps          : 1000,
            accumulated_management_fees  : 0,
            accumulated_performance_fees : 0,
            last_fee_collection          : v0,
            treasury                     : arg1,
            paused                       : false,
            circuit_breaker_tripped      : false,
            max_single_deposit           : 100000000000000,
            max_single_withdrawal_bps    : 2500,
            daily_withdrawal_cap_bps     : 5000,
            daily_withdrawal_total       : 0,
            current_withdrawal_day       : v0 / 86400000,
            members                      : 0x2::table::new<address, MemberData>(arg3),
            member_count                 : 0,
            agent_addresses              : 0x1::vector::empty<address>(),
            created_at                   : v0,
            ai_state                     : v3,
            rebalance_state              : v4,
            hedge_state                  : v6,
            timelock_state               : v7,
        };
        let v9 = PoolCreated{
            pool_id   : 0x2::object::id<CommunityPoolState>(&v8),
            treasury  : arg1,
            creator   : 0x2::tx_context::sender(arg3),
            timestamp : v0,
        };
        0x2::event::emit<PoolCreated>(v9);
        0x2::transfer::share_object<CommunityPoolState>(v8);
    }

    public entry fun create_rebalancer_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = RebalancerCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<RebalancerCap>(v0, arg1);
    }

    public entry fun deposit(arg0: &mut CommunityPoolState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(!arg0.circuit_breaker_tripped, 9);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 2);
        assert!(v0 >= 100000000, 5);
        assert!(v0 <= arg0.max_single_deposit, 10);
        if (arg0.total_shares == 0) {
            assert!(v0 >= 500000000, 5);
        };
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        collect_management_fee_internal(arg0, v2);
        let v3 = calculate_shares_for_deposit(arg0, v0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_shares = arg0.total_shares + v3;
        arg0.total_deposited = arg0.total_deposited + v0;
        if (0x2::table::contains<address, MemberData>(&arg0.members, v1)) {
            let v4 = 0x2::table::borrow_mut<address, MemberData>(&mut arg0.members, v1);
            v4.shares = v4.shares + v3;
            v4.deposited_sui = v4.deposited_sui + v0;
            v4.last_deposit_at = v2;
        } else {
            let v5 = MemberData{
                shares          : v3,
                deposited_sui   : v0,
                withdrawn_sui   : 0,
                joined_at       : v2,
                last_deposit_at : v2,
                high_water_mark : get_nav_per_share(arg0),
            };
            0x2::table::add<address, MemberData>(&mut arg0.members, v1, v5);
            arg0.member_count = arg0.member_count + 1;
        };
        let v6 = get_nav_per_share(arg0);
        if (v6 > arg0.all_time_high_nav_per_share) {
            arg0.all_time_high_nav_per_share = v6;
        };
        let v7 = Deposited{
            member          : v1,
            amount_sui      : v0,
            shares_received : v3,
            share_price     : v6,
            timestamp       : v2,
        };
        0x2::event::emit<Deposited>(v7);
    }

    public entry fun emergency_withdraw(arg0: &mut CommunityPoolState, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.circuit_breaker_tripped || arg0.paused, 0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, MemberData>(&arg0.members, v0), 7);
        let v1 = 0x2::table::borrow<address, MemberData>(&arg0.members, v0);
        assert!(v1.shares > 0, 3);
        let v2 = v1.shares;
        let v3 = calculate_assets_for_shares(arg0, v2);
        let v4 = v3;
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        if (v3 > v5) {
            v4 = v5;
        };
        arg0.total_shares = arg0.total_shares - v2;
        arg0.total_withdrawn = arg0.total_withdrawn + v4;
        let v6 = 0x2::table::borrow_mut<address, MemberData>(&mut arg0.members, v0);
        v6.shares = 0;
        v6.withdrawn_sui = v6.withdrawn_sui + v4;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v4), arg2), v0);
        let v7 = EmergencyWithdrawal{
            member    : v0,
            amount    : v4,
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<EmergencyWithdrawal>(v7);
    }

    public entry fun execute_ai_decision(arg0: &RebalancerCap, arg1: &mut CommunityPoolState, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 1);
        assert!(!arg1.circuit_breaker_tripped, 9);
        assert!(!arg1.ai_state.current_ai_decision.executed, 17);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1.rebalance_state.last_rebalance_time + arg1.rebalance_state.rebalance_cooldown, 15);
        let v1 = arg1.ai_state.current_ai_decision.target_alloc_bps;
        arg1.rebalance_state.target_allocation_bps = v1;
        arg1.rebalance_state.last_rebalance_time = v0;
        arg1.rebalance_state.rebalance_count = arg1.rebalance_state.rebalance_count + 1;
        arg1.ai_state.current_ai_decision.executed = true;
        let v2 = Rebalanced{
            executor     : 0x2::tx_context::sender(arg3),
            previous_bps : arg1.rebalance_state.target_allocation_bps,
            new_bps      : v1,
            reason_hash  : arg1.ai_state.current_ai_decision.reason_hash,
            timestamp    : v0,
        };
        0x2::event::emit<Rebalanced>(v2);
        let v3 = AIDecisionExecuted{
            decision_id : arg1.ai_state.current_ai_decision.decision_id,
            executor    : 0x2::tx_context::sender(arg3),
            successful  : true,
            timestamp   : v0,
        };
        0x2::event::emit<AIDecisionExecuted>(v3);
    }

    public entry fun execute_timelock_operation(arg0: &AdminCap, arg1: &mut CommunityPoolState, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0;
        let v2 = false;
        let v3 = 0;
        while (v3 < 0x1::vector::length<TimelockOperation>(&arg1.timelock_state.pending_operations)) {
            if (0x1::vector::borrow<TimelockOperation>(&arg1.timelock_state.pending_operations, v3).operation_id == arg2) {
                v1 = v3;
                v2 = true;
                break
            };
            v3 = v3 + 1;
        };
        assert!(v2, 24);
        let v4 = 0x1::vector::borrow<TimelockOperation>(&arg1.timelock_state.pending_operations, v1);
        assert!(!v4.executed, 17);
        assert!(v0 >= v4.scheduled_time, 22);
        assert!(v0 <= v4.expiry_time, 23);
        let v5 = v4.operation_type;
        let v6 = v4.target_value;
        if (v5 == 0) {
            arg1.treasury = v4.target_address;
        } else if (v5 == 1) {
            let v7 = v6 >> 32;
            let v8 = v6 & 4294967295;
            if (v7 <= 500 && v8 <= 3000) {
                arg1.management_fee_bps = v7;
                arg1.performance_fee_bps = v8;
            };
        } else if (v5 == 2) {
            arg1.max_single_deposit = v6;
        };
        0x1::vector::borrow_mut<TimelockOperation>(&mut arg1.timelock_state.pending_operations, v1).executed = true;
        let v9 = TimelockOperationExecuted{
            operation_id   : arg2,
            operation_type : v5,
            timestamp      : v0,
        };
        0x2::event::emit<TimelockOperationExecuted>(v9);
    }

    public fun get_ai_decision_info(arg0: &CommunityPoolState) : (vector<u8>, u64, u64, u8, bool) {
        (arg0.ai_state.current_ai_decision.decision_id, arg0.ai_state.current_ai_decision.timestamp, arg0.ai_state.current_ai_decision.target_alloc_bps, arg0.ai_state.current_ai_decision.confidence, arg0.ai_state.current_ai_decision.executed)
    }

    public fun get_auto_hedge_config(arg0: &CommunityPoolState) : (bool, u64, u64, u64, u64) {
        (arg0.hedge_state.auto_hedge_config.enabled, arg0.hedge_state.auto_hedge_config.risk_threshold_bps, arg0.hedge_state.auto_hedge_config.max_hedge_ratio_bps, arg0.hedge_state.auto_hedge_config.default_leverage, arg0.hedge_state.auto_hedge_config.cooldown_ms)
    }

    public fun get_hedge_status(arg0: &CommunityPoolState) : (u64, u64) {
        (0x1::vector::length<HedgePosition>(&arg0.hedge_state.active_hedges), arg0.hedge_state.total_hedged_value)
    }

    public fun get_member_info(arg0: &CommunityPoolState, arg1: address) : (u64, u64, u64, u64, u64) {
        if (!0x2::table::contains<address, MemberData>(&arg0.members, arg1)) {
            return (0, 0, 0, 0, 0)
        };
        let v0 = 0x2::table::borrow<address, MemberData>(&arg0.members, arg1);
        (v0.shares, v0.deposited_sui, v0.withdrawn_sui, v0.joined_at, v0.last_deposit_at)
    }

    public fun get_nav_per_share(arg0: &CommunityPoolState) : u64 {
        if (arg0.total_shares == 0) {
            return 1000000000
        };
        ((((0x2::balance::value<0x2::sui::SUI>(&arg0.balance) + 1000000000) as u128) * (1000000000 as u128) / ((arg0.total_shares + 1000000000) as u128)) as u64)
    }

    public fun get_pool_stats(arg0: &CommunityPoolState) : (u64, u64, u64, u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg0.total_shares, arg0.total_deposited, arg0.total_withdrawn, arg0.member_count)
    }

    public fun get_rebalance_info(arg0: &CommunityPoolState) : (u64, u64, u64) {
        (arg0.rebalance_state.target_allocation_bps, arg0.rebalance_state.last_rebalance_time, arg0.rebalance_state.rebalance_count)
    }

    public fun get_timelock_info(arg0: &CommunityPoolState) : (u64, u64, bool) {
        (arg0.timelock_state.timelock_delay, 0x1::vector::length<TimelockOperation>(&arg0.timelock_state.pending_operations), arg0.timelock_state.emergency_withdraw_enabled)
    }

    public fun get_total_nav(arg0: &CommunityPoolState) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FeeManagerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<FeeManagerCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = RebalancerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<RebalancerCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun is_member(arg0: &CommunityPoolState, arg1: address) : bool {
        0x2::table::contains<address, MemberData>(&arg0.members, arg1)
    }

    public entry fun open_pool_hedge(arg0: &AgentCap, arg1: &mut CommunityPoolState, arg2: u8, arg3: u64, arg4: u64, arg5: bool, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 1);
        assert!(!arg1.circuit_breaker_tripped, 9);
        assert!(arg3 > 0, 2);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        assert!(v0 >= arg1.hedge_state.auto_hedge_config.last_hedge_time + arg1.hedge_state.auto_hedge_config.cooldown_ms, 18);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        assert!(v1 >= arg3, 4);
        let v2 = get_total_nav(arg1);
        assert!(v1 - arg3 >= v2 * 2000 / 10000, 19);
        assert!(arg1.hedge_state.total_hedged_value + arg3 <= v2 * arg1.hedge_state.auto_hedge_config.max_hedge_ratio_bps / 10000, 20);
        let v3 = v0 / 86400000;
        if (v3 > arg1.hedge_state.current_hedge_day) {
            arg1.hedge_state.daily_hedge_total = 0;
            arg1.hedge_state.current_hedge_day = v3;
        };
        assert!(arg1.hedge_state.daily_hedge_total + arg3 <= v2 * 1500 / 10000, 20);
        let v4 = 0x2::bcs::to_bytes<u64>(&v0);
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u8>(&arg2));
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u64>(&arg3));
        let v5 = 0x2::hash::keccak256(&v4);
        let v6 = HedgePosition{
            hedge_id          : v5,
            pair_index        : arg2,
            collateral_amount : arg3,
            leverage          : arg4,
            is_long           : arg5,
            open_time         : v0,
            reason_hash       : 0x2::hash::keccak256(&arg6),
        };
        0x1::vector::push_back<HedgePosition>(&mut arg1.hedge_state.active_hedges, v6);
        arg1.hedge_state.total_hedged_value = arg1.hedge_state.total_hedged_value + arg3;
        arg1.hedge_state.daily_hedge_total = arg1.hedge_state.daily_hedge_total + arg3;
        arg1.hedge_state.auto_hedge_config.last_hedge_time = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg3), arg8), arg1.treasury);
        let v7 = PoolHedgeOpened{
            hedge_id          : v5,
            pair_index        : arg2,
            collateral_amount : arg3,
            leverage          : arg4,
            is_long           : arg5,
            timestamp         : v0,
        };
        0x2::event::emit<PoolHedgeOpened>(v7);
    }

    public entry fun receive_cross_chain_signal(arg0: &AgentCap, arg1: &mut CommunityPoolState, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: u8, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = CrossChainSignal{
            signal_id        : arg2,
            timestamp        : v0,
            source_chain_id  : arg3,
            target_alloc_bps : arg4,
            price_data_hash  : arg5,
            action           : arg6,
            acknowledged     : false,
        };
        arg1.ai_state.latest_signal = v1;
        let v2 = CrossChainSignalReceived{
            signal_id       : arg2,
            source_chain_id : arg3,
            action          : arg6,
            timestamp       : v0,
        };
        0x2::event::emit<CrossChainSignalReceived>(v2);
    }

    public entry fun record_ai_decision(arg0: &AgentCap, arg1: &mut CommunityPoolState, arg2: u64, arg3: u8, arg4: u8, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 >= arg1.ai_state.min_ai_confidence, 16);
        assert!(arg2 <= 10000, 14);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        let v1 = 0x2::tx_context::sender(arg10);
        let v2 = 0x2::bcs::to_bytes<u64>(&v0);
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg2));
        let v3 = 0x2::hash::keccak256(&v2);
        let v4 = AIDecision{
            decision_id         : v3,
            timestamp           : v0,
            target_alloc_bps    : arg2,
            confidence          : arg3,
            urgency             : arg4,
            expected_return_bps : arg5,
            risk_score          : arg6,
            reason_hash         : 0x2::hash::keccak256(&arg7),
            data_feed_hash      : arg8,
            executed            : false,
        };
        arg1.ai_state.current_ai_decision = v4;
        arg1.ai_state.ai_decision_count = arg1.ai_state.ai_decision_count + 1;
        update_agent_metrics(arg1, v1, arg3);
        let v5 = AIDecisionRecorded{
            decision_id         : v3,
            agent               : v1,
            target_alloc_bps    : arg2,
            confidence          : arg3,
            expected_return_bps : arg5,
            timestamp           : v0,
        };
        0x2::event::emit<AIDecisionRecorded>(v5);
    }

    public entry fun rescue_sui(arg0: &AdminCap, arg1: &mut CommunityPoolState, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.timelock_state.emergency_withdraw_enabled || arg1.circuit_breaker_tripped, 25);
        assert!(arg2 > 0, 26);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        let v1 = if (arg2 > v0) {
            v0
        } else {
            arg2
        };
        assert!(v1 > 0, 26);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v1), arg4), arg1.treasury);
        let v2 = TokensRescued{
            amount    : v1,
            recipient : arg1.treasury,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TokensRescued>(v2);
    }

    public entry fun reset_circuit_breaker(arg0: &AdminCap, arg1: &mut CommunityPoolState) {
        arg1.circuit_breaker_tripped = false;
    }

    public entry fun schedule_timelock_operation(arg0: &AdminCap, arg1: &mut CommunityPoolState, arg2: u8, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = v0 + arg1.timelock_state.timelock_delay;
        let v2 = 0x2::bcs::to_bytes<u64>(&v0);
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u8>(&arg2));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg3));
        let v3 = 0x2::hash::keccak256(&v2);
        let v4 = TimelockOperation{
            operation_id   : v3,
            operation_type : arg2,
            target_value   : arg3,
            target_address : arg4,
            scheduled_time : v1,
            expiry_time    : v1 + 604800000,
            executed       : false,
        };
        0x1::vector::push_back<TimelockOperation>(&mut arg1.timelock_state.pending_operations, v4);
        let v5 = TimelockOperationScheduled{
            operation_id   : v3,
            operation_type : arg2,
            scheduled_time : v1,
            timestamp      : v0,
        };
        0x2::event::emit<TimelockOperationScheduled>(v5);
    }

    public entry fun set_auto_hedge_config(arg0: &AgentCap, arg1: &mut CommunityPoolState, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) {
        assert!(arg5 >= 2 && arg5 <= 10, 14);
        assert!(arg4 <= 5000, 20);
        let v0 = AutoHedgeConfig{
            enabled             : arg2,
            risk_threshold_bps  : arg3,
            max_hedge_ratio_bps : arg4,
            default_leverage    : arg5,
            cooldown_ms         : arg6,
            last_hedge_time     : arg1.hedge_state.auto_hedge_config.last_hedge_time,
        };
        arg1.hedge_state.auto_hedge_config = v0;
        let v1 = AutoHedgeConfigUpdated{
            enabled             : arg2,
            risk_threshold_bps  : arg3,
            max_hedge_ratio_bps : arg4,
            default_leverage    : arg5,
            timestamp           : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<AutoHedgeConfigUpdated>(v1);
    }

    public entry fun set_circuit_breaker_limits(arg0: &AdminCap, arg1: &mut CommunityPoolState, arg2: u64, arg3: u64, arg4: u64) {
        arg1.max_single_deposit = arg2;
        arg1.max_single_withdrawal_bps = arg3;
        arg1.daily_withdrawal_cap_bps = arg4;
    }

    public entry fun set_emergency_withdraw(arg0: &AdminCap, arg1: &mut CommunityPoolState, arg2: bool) {
        arg1.timelock_state.emergency_withdraw_enabled = arg2;
    }

    public entry fun set_fees(arg0: &FeeManagerCap, arg1: &mut CommunityPoolState, arg2: u64, arg3: u64) {
        assert!(arg2 <= 500, 13);
        assert!(arg3 <= 3000, 13);
        arg1.management_fee_bps = arg2;
        arg1.performance_fee_bps = arg3;
    }

    public entry fun set_min_ai_confidence(arg0: &AdminCap, arg1: &mut CommunityPoolState, arg2: u8) {
        assert!(arg2 <= 100, 14);
        arg1.ai_state.min_ai_confidence = arg2;
    }

    public entry fun set_paused(arg0: &AdminCap, arg1: &mut CommunityPoolState, arg2: bool, arg3: &0x2::clock::Clock) {
        arg1.paused = arg2;
        let v0 = PoolPaused{
            pool_id   : 0x2::object::id<CommunityPoolState>(arg1),
            paused    : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PoolPaused>(v0);
    }

    public entry fun set_rebalance_cooldown(arg0: &AdminCap, arg1: &mut CommunityPoolState, arg2: u64) {
        assert!(arg2 <= 604800000, 14);
        arg1.rebalance_state.rebalance_cooldown = arg2;
    }

    public entry fun set_target_allocation(arg0: &RebalancerCap, arg1: &mut CommunityPoolState, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 1);
        assert!(arg2 <= 10000, 14);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg1.rebalance_state.last_rebalance_time + arg1.rebalance_state.rebalance_cooldown, 15);
        arg1.rebalance_state.target_allocation_bps = arg2;
        arg1.rebalance_state.last_rebalance_time = v0;
        arg1.rebalance_state.rebalance_count = arg1.rebalance_state.rebalance_count + 1;
        let v1 = Rebalanced{
            executor     : 0x2::tx_context::sender(arg5),
            previous_bps : arg1.rebalance_state.target_allocation_bps,
            new_bps      : arg2,
            reason_hash  : 0x2::hash::keccak256(&arg3),
            timestamp    : v0,
        };
        0x2::event::emit<Rebalanced>(v1);
    }

    public entry fun set_timelock_delay(arg0: &AdminCap, arg1: &mut CommunityPoolState, arg2: u64) {
        assert!(arg2 >= 300000 && arg2 <= 604800000, 14);
        arg1.timelock_state.timelock_delay = arg2;
    }

    public entry fun set_treasury(arg0: &AdminCap, arg1: &mut CommunityPoolState, arg2: address, arg3: &0x2::clock::Clock) {
        assert!(arg2 != @0x0, 27);
        arg1.treasury = arg2;
        let v0 = TreasuryUpdated{
            pool_id      : 0x2::object::id<CommunityPoolState>(arg1),
            old_treasury : arg1.treasury,
            new_treasury : arg2,
            timestamp    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TreasuryUpdated>(v0);
    }

    public entry fun trip_circuit_breaker(arg0: &AdminCap, arg1: &mut CommunityPoolState, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        arg1.circuit_breaker_tripped = true;
        let v0 = CircuitBreakerTripped{
            pool_id   : 0x2::object::id<CommunityPoolState>(arg1),
            reason    : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CircuitBreakerTripped>(v0);
    }

    fun update_agent_metrics(arg0: &mut CommunityPoolState, arg1: address, arg2: u8) {
        if (0x1::vector::length<AIAgentMetrics>(&arg0.ai_state.agent_metrics) == 0) {
            let v0 = AIAgentMetrics{
                total_decisions       : 1,
                successful_decisions  : 0,
                cumulative_return_bps : 0,
                avg_confidence        : (arg2 as u64) * 100,
                last_decision_time    : 0,
                last_decision_id      : 0x1::vector::empty<u8>(),
            };
            0x1::vector::push_back<AIAgentMetrics>(&mut arg0.ai_state.agent_metrics, v0);
        } else {
            let v1 = 0x1::vector::borrow_mut<AIAgentMetrics>(&mut arg0.ai_state.agent_metrics, 0);
            v1.total_decisions = v1.total_decisions + 1;
            v1.avg_confidence = (v1.avg_confidence * (v1.total_decisions - 1) + (arg2 as u64) * 100) / v1.total_decisions;
        };
    }

    public entry fun withdraw(arg0: &mut CommunityPoolState, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(!arg0.circuit_breaker_tripped, 9);
        assert!(arg1 > 0, 2);
        assert!(arg1 >= 1000000, 6);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(0x2::table::contains<address, MemberData>(&arg0.members, v0), 7);
        assert!(0x2::table::borrow<address, MemberData>(&arg0.members, v0).shares >= arg1, 3);
        let v2 = v1 / 86400000;
        if (v2 > arg0.current_withdrawal_day) {
            arg0.daily_withdrawal_total = 0;
            arg0.current_withdrawal_day = v2;
        };
        collect_management_fee_internal(arg0, v1);
        collect_performance_fee_internal(arg0, v0);
        let v3 = calculate_assets_for_shares(arg0, arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= v3, 4);
        let v4 = get_total_nav(arg0);
        assert!(v3 <= (((v4 as u128) * (arg0.max_single_withdrawal_bps as u128) / (10000 as u128)) as u64), 11);
        assert!(arg0.daily_withdrawal_total + v3 <= (((v4 as u128) * (arg0.daily_withdrawal_cap_bps as u128) / (10000 as u128)) as u64), 12);
        arg0.total_shares = arg0.total_shares - arg1;
        arg0.total_withdrawn = arg0.total_withdrawn + v3;
        arg0.daily_withdrawal_total = arg0.daily_withdrawal_total + v3;
        let v5 = 0x2::table::borrow_mut<address, MemberData>(&mut arg0.members, v0);
        v5.shares = v5.shares - arg1;
        v5.withdrawn_sui = v5.withdrawn_sui + v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v3), arg3), v0);
        let v6 = Withdrawn{
            member        : v0,
            shares_burned : arg1,
            amount_sui    : v3,
            share_price   : get_nav_per_share(arg0),
            timestamp     : v1,
        };
        0x2::event::emit<Withdrawn>(v6);
    }

    // decompiled from Move bytecode v7
}

