module 0x900bca6461ad24c86b83c974788b457cb76c3f6f4fd7b061c5b58cb40d974bab::community_pool_usdc {
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
        deposited_usdc: u64,
        withdrawn_usdc: u64,
        joined_at: u64,
        last_deposit_at: u64,
        high_water_mark: u64,
    }

    struct AssetAllocation has copy, drop, store {
        btc_bps: u64,
        eth_bps: u64,
        sui_bps: u64,
        cro_bps: u64,
    }

    struct AIDecision has copy, drop, store {
        decision_id: vector<u8>,
        timestamp: u64,
        target_allocation: AssetAllocation,
        confidence: u8,
        urgency: u8,
        expected_return_bps: u64,
        risk_score: u64,
        reason_hash: vector<u8>,
        data_feed_hash: vector<u8>,
        executed: bool,
    }

    struct HedgePosition has copy, drop, store {
        hedge_id: vector<u8>,
        pair_index: u8,
        collateral_usdc: u64,
        leverage: u64,
        is_long: bool,
        open_time: u64,
        reason_hash: vector<u8>,
    }

    struct AutoHedgeConfig has copy, drop, store {
        enabled: bool,
        risk_threshold_bps: u64,
        max_hedge_ratio_bps: u64,
        default_leverage: u64,
        cooldown_ms: u64,
        last_hedge_time: u64,
    }

    struct UsdcAIState has store {
        current_allocation: AssetAllocation,
        target_allocation: AssetAllocation,
        current_ai_decision: AIDecision,
        ai_decision_count: u64,
        min_ai_confidence: u8,
        last_rebalance_time: u64,
        rebalance_cooldown: u64,
        rebalance_count: u64,
    }

    struct UsdcHedgeState has store {
        auto_hedge_config: AutoHedgeConfig,
        active_hedges: vector<HedgePosition>,
        total_hedged_value: u64,
        daily_hedge_total: u64,
        current_hedge_day: u64,
    }

    struct UsdcPoolState<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
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
        created_at: u64,
        ai_state: UsdcAIState,
        hedge_state: UsdcHedgeState,
    }

    struct UsdcPoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        treasury: address,
        creator: address,
        initial_allocation: AssetAllocation,
        timestamp: u64,
    }

    struct UsdcDeposited has copy, drop {
        member: address,
        amount_usdc: u64,
        shares_received: u64,
        share_price: u64,
        timestamp: u64,
    }

    struct UsdcWithdrawn has copy, drop {
        member: address,
        shares_burned: u64,
        amount_usdc: u64,
        share_price: u64,
        timestamp: u64,
    }

    struct AllocationUpdated has copy, drop {
        old_allocation: AssetAllocation,
        new_allocation: AssetAllocation,
        decision_id: vector<u8>,
        confidence: u8,
        timestamp: u64,
    }

    struct UsdcFeesCollected has copy, drop {
        management_fee: u64,
        performance_fee: u64,
        collector: address,
        timestamp: u64,
    }

    struct UsdcHedgeOpened has copy, drop {
        hedge_id: vector<u8>,
        pair_index: u8,
        collateral_usdc: u64,
        leverage: u64,
        is_long: bool,
        timestamp: u64,
    }

    struct UsdcHedgeClosed has copy, drop {
        hedge_id: vector<u8>,
        pnl_usdc: u64,
        is_profit: bool,
        timestamp: u64,
    }

    struct UsdcPoolPaused has copy, drop {
        pool_id: 0x2::object::ID,
        paused: bool,
        timestamp: u64,
    }

    public entry fun add_agent<T0>(arg0: &AdminCap, arg1: &mut UsdcPoolState<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = AgentCap{
            id            : 0x2::object::new(arg3),
            agent_address : arg2,
        };
        0x2::transfer::transfer<AgentCap>(v0, arg2);
    }

    public entry fun admin_reset_daily_hedge<T0>(arg0: &AdminCap, arg1: &mut UsdcPoolState<T0>, arg2: &0x2::clock::Clock) {
        arg1.hedge_state.daily_hedge_total = 0;
        arg1.hedge_state.current_hedge_day = 0x2::clock::timestamp_ms(arg2) / 86400000;
        let v0 = UsdcPoolPaused{
            pool_id   : 0x2::object::id<UsdcPoolState<T0>>(arg1),
            paused    : false,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<UsdcPoolPaused>(v0);
    }

    public entry fun admin_reset_hedge_state<T0>(arg0: &AdminCap, arg1: &mut UsdcPoolState<T0>, arg2: &0x2::clock::Clock) {
        arg1.hedge_state.active_hedges = 0x1::vector::empty<HedgePosition>();
        arg1.hedge_state.total_hedged_value = 0;
        arg1.hedge_state.daily_hedge_total = 0;
        arg1.hedge_state.current_hedge_day = 0x2::clock::timestamp_ms(arg2) / 86400000;
        let v0 = UsdcPoolPaused{
            pool_id   : 0x2::object::id<UsdcPoolState<T0>>(arg1),
            paused    : false,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<UsdcPoolPaused>(v0);
    }

    public fun calculate_assets_for_shares<T0>(arg0: &UsdcPoolState<T0>, arg1: u64) : u64 {
        if (arg0.total_shares == 0) {
            return 0
        };
        (((arg1 as u128) * ((0x2::balance::value<T0>(&arg0.balance) + 1000000) as u128) / ((arg0.total_shares + 1000000) as u128)) as u64)
    }

    public fun calculate_shares_for_deposit<T0>(arg0: &UsdcPoolState<T0>, arg1: u64) : u64 {
        (((arg1 as u128) * ((arg0.total_shares + 1000000) as u128) / ((0x2::balance::value<T0>(&arg0.balance) + 1000000) as u128)) as u64)
    }

    public entry fun close_hedge<T0>(arg0: &AgentCap, arg1: &mut UsdcPoolState<T0>, arg2: vector<u8>, arg3: u64, arg4: bool, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
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
        let v4 = if (arg1.hedge_state.total_hedged_value > v3.collateral_usdc) {
            arg1.hedge_state.total_hedged_value - v3.collateral_usdc
        } else {
            0
        };
        arg1.hedge_state.total_hedged_value = v4;
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg5));
        if (arg4) {
            let v5 = get_nav_per_share<T0>(arg1);
            if (v5 > arg1.all_time_high_nav_per_share) {
                arg1.all_time_high_nav_per_share = v5;
            };
        };
        let v6 = UsdcHedgeClosed{
            hedge_id  : arg2,
            pnl_usdc  : arg3,
            is_profit : arg4,
            timestamp : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<UsdcHedgeClosed>(v6);
    }

    public entry fun collect_fees<T0>(arg0: &FeeManagerCap, arg1: &mut UsdcPoolState<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        collect_management_fee_internal<T0>(arg1, v0);
        let v1 = arg1.accumulated_management_fees + arg1.accumulated_performance_fees;
        assert!(v1 > 0, 2);
        assert!(0x2::balance::value<T0>(&arg1.balance) >= v1, 4);
        arg1.accumulated_management_fees = 0;
        arg1.accumulated_performance_fees = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v1), arg3), arg1.treasury);
        let v2 = UsdcFeesCollected{
            management_fee  : arg1.accumulated_management_fees,
            performance_fee : arg1.accumulated_performance_fees,
            collector       : 0x2::tx_context::sender(arg3),
            timestamp       : v0,
        };
        0x2::event::emit<UsdcFeesCollected>(v2);
    }

    fun collect_management_fee_internal<T0>(arg0: &mut UsdcPoolState<T0>, arg1: u64) {
        if (arg0.total_shares == 0) {
            arg0.last_fee_collection = arg1;
            return
        };
        let v0 = arg1 - arg0.last_fee_collection;
        if (v0 == 0) {
            return
        };
        let v1 = get_total_nav<T0>(arg0) * arg0.management_fee_bps * v0 / 1000 / 10000 * 31536000;
        if (v1 > 0) {
            arg0.accumulated_management_fees = arg0.accumulated_management_fees + v1;
        };
        arg0.last_fee_collection = arg1;
    }

    fun collect_performance_fee_internal<T0>(arg0: &mut UsdcPoolState<T0>, arg1: address) {
        if (!0x2::table::contains<address, MemberData>(&arg0.members, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow<address, MemberData>(&arg0.members, arg1);
        let v1 = get_nav_per_share<T0>(arg0);
        if (v1 > v0.high_water_mark) {
            let v2 = (v1 - v0.high_water_mark) * v0.shares / 1000000 * arg0.performance_fee_bps / 10000;
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

    public entry fun create_pool<T0>(arg0: &AdminCap, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 + arg3 + arg4 + arg5 == 10000, 28);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = AssetAllocation{
            btc_bps : arg2,
            eth_bps : arg3,
            sui_bps : arg4,
            cro_bps : arg5,
        };
        let v2 = AIDecision{
            decision_id         : 0x1::vector::empty<u8>(),
            timestamp           : 0,
            target_allocation   : v1,
            confidence          : 0,
            urgency             : 0,
            expected_return_bps : 0,
            risk_score          : 0,
            reason_hash         : 0x1::vector::empty<u8>(),
            data_feed_hash      : 0x1::vector::empty<u8>(),
            executed            : true,
        };
        let v3 = UsdcAIState{
            current_allocation  : v1,
            target_allocation   : v1,
            current_ai_decision : v2,
            ai_decision_count   : 0,
            min_ai_confidence   : 50,
            last_rebalance_time : 0,
            rebalance_cooldown  : 3600000,
            rebalance_count     : 0,
        };
        let v4 = AutoHedgeConfig{
            enabled             : false,
            risk_threshold_bps  : 500,
            max_hedge_ratio_bps : 2500,
            default_leverage    : 3,
            cooldown_ms         : 3600000,
            last_hedge_time     : 0,
        };
        let v5 = UsdcHedgeState{
            auto_hedge_config  : v4,
            active_hedges      : 0x1::vector::empty<HedgePosition>(),
            total_hedged_value : 0,
            daily_hedge_total  : 0,
            current_hedge_day  : v0 / 86400000,
        };
        let v6 = UsdcPoolState<T0>{
            id                           : 0x2::object::new(arg7),
            balance                      : 0x2::balance::zero<T0>(),
            total_shares                 : 0,
            total_deposited              : 0,
            total_withdrawn              : 0,
            all_time_high_nav_per_share  : 1000000,
            management_fee_bps           : 50,
            performance_fee_bps          : 1000,
            accumulated_management_fees  : 0,
            accumulated_performance_fees : 0,
            last_fee_collection          : v0,
            treasury                     : arg1,
            paused                       : false,
            circuit_breaker_tripped      : false,
            max_single_deposit           : 1000000000000,
            max_single_withdrawal_bps    : 2500,
            daily_withdrawal_cap_bps     : 5000,
            daily_withdrawal_total       : 0,
            current_withdrawal_day       : v0 / 86400000,
            members                      : 0x2::table::new<address, MemberData>(arg7),
            member_count                 : 0,
            created_at                   : v0,
            ai_state                     : v3,
            hedge_state                  : v5,
        };
        let v7 = UsdcPoolCreated{
            pool_id            : 0x2::object::id<UsdcPoolState<T0>>(&v6),
            treasury           : arg1,
            creator            : 0x2::tx_context::sender(arg7),
            initial_allocation : v1,
            timestamp          : v0,
        };
        0x2::event::emit<UsdcPoolCreated>(v7);
        0x2::transfer::share_object<UsdcPoolState<T0>>(v6);
    }

    public entry fun create_rebalancer_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = RebalancerCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<RebalancerCap>(v0, arg1);
    }

    public entry fun deposit<T0>(arg0: &mut UsdcPoolState<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(!arg0.circuit_breaker_tripped, 9);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        assert!(v0 >= 10000000, 5);
        assert!(v0 <= arg0.max_single_deposit, 10);
        if (arg0.total_shares == 0) {
            assert!(v0 >= 50000000, 5);
        };
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        collect_management_fee_internal<T0>(arg0, v2);
        let v3 = calculate_shares_for_deposit<T0>(arg0, v0);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_shares = arg0.total_shares + v3;
        arg0.total_deposited = arg0.total_deposited + v0;
        if (0x2::table::contains<address, MemberData>(&arg0.members, v1)) {
            let v4 = 0x2::table::borrow_mut<address, MemberData>(&mut arg0.members, v1);
            v4.shares = v4.shares + v3;
            v4.deposited_usdc = v4.deposited_usdc + v0;
            v4.last_deposit_at = v2;
        } else {
            let v5 = MemberData{
                shares          : v3,
                deposited_usdc  : v0,
                withdrawn_usdc  : 0,
                joined_at       : v2,
                last_deposit_at : v2,
                high_water_mark : get_nav_per_share<T0>(arg0),
            };
            0x2::table::add<address, MemberData>(&mut arg0.members, v1, v5);
            arg0.member_count = arg0.member_count + 1;
        };
        let v6 = get_nav_per_share<T0>(arg0);
        if (v6 > arg0.all_time_high_nav_per_share) {
            arg0.all_time_high_nav_per_share = v6;
        };
        let v7 = UsdcDeposited{
            member          : v1,
            amount_usdc     : v0,
            shares_received : v3,
            share_price     : v6,
            timestamp       : v2,
        };
        0x2::event::emit<UsdcDeposited>(v7);
    }

    public entry fun emergency_withdraw<T0>(arg0: &mut UsdcPoolState<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.circuit_breaker_tripped || arg0.paused, 0);
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::clock::timestamp_ms(arg1);
        assert!(0x2::table::contains<address, MemberData>(&arg0.members, v0), 7);
        let v1 = 0x2::table::borrow<address, MemberData>(&arg0.members, v0);
        assert!(v1.shares > 0, 3);
        let v2 = v1.shares;
        let v3 = calculate_assets_for_shares<T0>(arg0, v2);
        let v4 = v3;
        let v5 = 0x2::balance::value<T0>(&arg0.balance);
        if (v3 > v5) {
            v4 = v5;
        };
        arg0.total_shares = arg0.total_shares - v2;
        arg0.total_withdrawn = arg0.total_withdrawn + v4;
        let v6 = 0x2::table::borrow_mut<address, MemberData>(&mut arg0.members, v0);
        v6.shares = 0;
        v6.withdrawn_usdc = v6.withdrawn_usdc + v4;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v4), arg2), v0);
    }

    public entry fun execute_ai_decision<T0>(arg0: &RebalancerCap, arg1: &mut UsdcPoolState<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 1);
        assert!(!arg1.circuit_breaker_tripped, 9);
        assert!(!arg1.ai_state.current_ai_decision.executed, 17);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1.ai_state.last_rebalance_time + arg1.ai_state.rebalance_cooldown, 15);
        arg1.ai_state.current_allocation = arg1.ai_state.target_allocation;
        arg1.ai_state.last_rebalance_time = v0;
        arg1.ai_state.rebalance_count = arg1.ai_state.rebalance_count + 1;
        arg1.ai_state.current_ai_decision.executed = true;
        let v1 = AllocationUpdated{
            old_allocation : arg1.ai_state.current_allocation,
            new_allocation : arg1.ai_state.current_allocation,
            decision_id    : arg1.ai_state.current_ai_decision.decision_id,
            confidence     : arg1.ai_state.current_ai_decision.confidence,
            timestamp      : v0,
        };
        0x2::event::emit<AllocationUpdated>(v1);
    }

    public fun get_allocation<T0>(arg0: &UsdcPoolState<T0>) : (u64, u64, u64, u64) {
        (arg0.ai_state.current_allocation.btc_bps, arg0.ai_state.current_allocation.eth_bps, arg0.ai_state.current_allocation.sui_bps, arg0.ai_state.current_allocation.cro_bps)
    }

    public fun get_member_info<T0>(arg0: &UsdcPoolState<T0>, arg1: address) : (u64, u64, u64, u64, u64) {
        if (!0x2::table::contains<address, MemberData>(&arg0.members, arg1)) {
            return (0, 0, 0, 0, 0)
        };
        let v0 = 0x2::table::borrow<address, MemberData>(&arg0.members, arg1);
        (v0.shares, v0.deposited_usdc, v0.withdrawn_usdc, v0.joined_at, v0.last_deposit_at)
    }

    public fun get_nav_per_share<T0>(arg0: &UsdcPoolState<T0>) : u64 {
        if (arg0.total_shares == 0) {
            return 1000000
        };
        ((((0x2::balance::value<T0>(&arg0.balance) + 1000000) as u128) * (1000000 as u128) / ((arg0.total_shares + 1000000) as u128)) as u64)
    }

    public fun get_pool_stats<T0>(arg0: &UsdcPoolState<T0>) : (u64, u64, u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance), arg0.total_shares, arg0.total_deposited, arg0.total_withdrawn, arg0.member_count)
    }

    public fun get_total_nav<T0>(arg0: &UsdcPoolState<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FeeManagerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<FeeManagerCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = RebalancerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<RebalancerCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public entry fun open_hedge<T0>(arg0: &AgentCap, arg1: &mut UsdcPoolState<T0>, arg2: u8, arg3: u64, arg4: u64, arg5: bool, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 1);
        assert!(!arg1.circuit_breaker_tripped, 9);
        assert!(arg3 > 0, 2);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        assert!(v0 >= arg1.hedge_state.auto_hedge_config.last_hedge_time + arg1.hedge_state.auto_hedge_config.cooldown_ms, 18);
        let v1 = 0x2::balance::value<T0>(&arg1.balance);
        assert!(v1 >= arg3, 4);
        let v2 = get_total_nav<T0>(arg1);
        assert!(v1 - arg3 >= v2 * 2000 / 10000, 19);
        assert!(arg1.hedge_state.total_hedged_value + arg3 <= v2 * arg1.hedge_state.auto_hedge_config.max_hedge_ratio_bps / 10000, 20);
        let v3 = v0 / 86400000;
        if (v3 > arg1.hedge_state.current_hedge_day) {
            arg1.hedge_state.daily_hedge_total = 0;
            arg1.hedge_state.current_hedge_day = v3;
        };
        assert!(arg1.hedge_state.daily_hedge_total + arg3 <= v2 * 5000 / 10000, 20);
        let v4 = 0x2::bcs::to_bytes<u64>(&v0);
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u8>(&arg2));
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u64>(&arg3));
        let v5 = 0x2::hash::keccak256(&v4);
        let v6 = HedgePosition{
            hedge_id        : v5,
            pair_index      : arg2,
            collateral_usdc : arg3,
            leverage        : arg4,
            is_long         : arg5,
            open_time       : v0,
            reason_hash     : 0x2::hash::keccak256(&arg6),
        };
        0x1::vector::push_back<HedgePosition>(&mut arg1.hedge_state.active_hedges, v6);
        arg1.hedge_state.total_hedged_value = arg1.hedge_state.total_hedged_value + arg3;
        arg1.hedge_state.daily_hedge_total = arg1.hedge_state.daily_hedge_total + arg3;
        arg1.hedge_state.auto_hedge_config.last_hedge_time = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg3), arg8), arg1.treasury);
        let v7 = UsdcHedgeOpened{
            hedge_id        : v5,
            pair_index      : arg2,
            collateral_usdc : arg3,
            leverage        : arg4,
            is_long         : arg5,
            timestamp       : v0,
        };
        0x2::event::emit<UsdcHedgeOpened>(v7);
    }

    public entry fun record_ai_decision<T0>(arg0: &AgentCap, arg1: &mut UsdcPoolState<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: u8, arg8: u64, arg9: u64, arg10: vector<u8>, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 >= arg1.ai_state.min_ai_confidence, 16);
        assert!(arg2 + arg3 + arg4 + arg5 == 10000, 28);
        let v0 = 0x2::clock::timestamp_ms(arg12);
        let v1 = 0x2::tx_context::sender(arg13);
        let v2 = 0x2::bcs::to_bytes<u64>(&v0);
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg2));
        let v3 = 0x2::hash::keccak256(&v2);
        let v4 = AssetAllocation{
            btc_bps : arg2,
            eth_bps : arg3,
            sui_bps : arg4,
            cro_bps : arg5,
        };
        let v5 = AIDecision{
            decision_id         : v3,
            timestamp           : v0,
            target_allocation   : v4,
            confidence          : arg6,
            urgency             : arg7,
            expected_return_bps : arg8,
            risk_score          : arg9,
            reason_hash         : 0x2::hash::keccak256(&arg10),
            data_feed_hash      : arg11,
            executed            : false,
        };
        arg1.ai_state.current_ai_decision = v5;
        arg1.ai_state.ai_decision_count = arg1.ai_state.ai_decision_count + 1;
        arg1.ai_state.target_allocation = v4;
        let v6 = AllocationUpdated{
            old_allocation : arg1.ai_state.current_allocation,
            new_allocation : arg1.ai_state.target_allocation,
            decision_id    : v3,
            confidence     : arg6,
            timestamp      : v0,
        };
        0x2::event::emit<AllocationUpdated>(v6);
    }

    public entry fun reset_circuit_breaker<T0>(arg0: &AdminCap, arg1: &mut UsdcPoolState<T0>) {
        arg1.circuit_breaker_tripped = false;
    }

    public entry fun set_allocation<T0>(arg0: &RebalancerCap, arg1: &mut UsdcPoolState<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 1);
        assert!(arg2 + arg3 + arg4 + arg5 == 10000, 28);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        assert!(v0 >= arg1.ai_state.last_rebalance_time + arg1.ai_state.rebalance_cooldown, 15);
        let v1 = AssetAllocation{
            btc_bps : arg2,
            eth_bps : arg3,
            sui_bps : arg4,
            cro_bps : arg5,
        };
        arg1.ai_state.current_allocation = v1;
        arg1.ai_state.target_allocation = v1;
        arg1.ai_state.last_rebalance_time = v0;
        arg1.ai_state.rebalance_count = arg1.ai_state.rebalance_count + 1;
        let v2 = AllocationUpdated{
            old_allocation : arg1.ai_state.current_allocation,
            new_allocation : v1,
            decision_id    : 0x2::hash::keccak256(&arg6),
            confidence     : 100,
            timestamp      : v0,
        };
        0x2::event::emit<AllocationUpdated>(v2);
    }

    public entry fun set_auto_hedge_config<T0>(arg0: &AgentCap, arg1: &mut UsdcPoolState<T0>, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) {
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
        0x2::clock::timestamp_ms(arg7);
    }

    public entry fun set_fees<T0>(arg0: &FeeManagerCap, arg1: &mut UsdcPoolState<T0>, arg2: u64, arg3: u64) {
        assert!(arg2 <= 500, 13);
        assert!(arg3 <= 3000, 13);
        arg1.management_fee_bps = arg2;
        arg1.performance_fee_bps = arg3;
    }

    public entry fun set_min_ai_confidence<T0>(arg0: &AdminCap, arg1: &mut UsdcPoolState<T0>, arg2: u8) {
        assert!(arg2 <= 100, 14);
        arg1.ai_state.min_ai_confidence = arg2;
    }

    public entry fun set_paused<T0>(arg0: &AdminCap, arg1: &mut UsdcPoolState<T0>, arg2: bool, arg3: &0x2::clock::Clock) {
        arg1.paused = arg2;
        let v0 = UsdcPoolPaused{
            pool_id   : 0x2::object::id<UsdcPoolState<T0>>(arg1),
            paused    : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<UsdcPoolPaused>(v0);
    }

    public entry fun set_rebalance_cooldown<T0>(arg0: &AdminCap, arg1: &mut UsdcPoolState<T0>, arg2: u64) {
        assert!(arg2 <= 604800000, 14);
        arg1.ai_state.rebalance_cooldown = arg2;
    }

    public entry fun set_treasury<T0>(arg0: &AdminCap, arg1: &mut UsdcPoolState<T0>, arg2: address) {
        arg1.treasury = arg2;
    }

    public entry fun set_withdrawal_limits<T0>(arg0: &AdminCap, arg1: &mut UsdcPoolState<T0>, arg2: u64, arg3: u64) {
        assert!(arg2 <= 10000, 14);
        assert!(arg2 > 0, 2);
        assert!(arg3 <= 10000, 14);
        assert!(arg3 > 0, 2);
        arg1.max_single_withdrawal_bps = arg2;
        arg1.daily_withdrawal_cap_bps = arg3;
    }

    public entry fun trip_circuit_breaker<T0>(arg0: &AdminCap, arg1: &mut UsdcPoolState<T0>) {
        arg1.circuit_breaker_tripped = true;
    }

    public entry fun withdraw<T0>(arg0: &mut UsdcPoolState<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(!arg0.circuit_breaker_tripped, 9);
        assert!(arg1 > 0, 2);
        assert!(arg1 >= 1000, 6);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(0x2::table::contains<address, MemberData>(&arg0.members, v0), 7);
        assert!(0x2::table::borrow<address, MemberData>(&arg0.members, v0).shares >= arg1, 3);
        let v2 = v1 / 86400000;
        if (v2 > arg0.current_withdrawal_day) {
            arg0.daily_withdrawal_total = 0;
            arg0.current_withdrawal_day = v2;
        };
        collect_management_fee_internal<T0>(arg0, v1);
        collect_performance_fee_internal<T0>(arg0, v0);
        let v3 = calculate_assets_for_shares<T0>(arg0, arg1);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= v3, 4);
        let v4 = get_total_nav<T0>(arg0);
        assert!(v3 <= v4 * arg0.max_single_withdrawal_bps / 10000, 11);
        assert!(arg0.daily_withdrawal_total + v3 <= v4 * arg0.daily_withdrawal_cap_bps / 10000, 12);
        arg0.total_shares = arg0.total_shares - arg1;
        arg0.total_withdrawn = arg0.total_withdrawn + v3;
        arg0.daily_withdrawal_total = arg0.daily_withdrawal_total + v3;
        let v5 = 0x2::table::borrow_mut<address, MemberData>(&mut arg0.members, v0);
        v5.shares = v5.shares - arg1;
        v5.withdrawn_usdc = v5.withdrawn_usdc + v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v3), arg3), v0);
        let v6 = UsdcWithdrawn{
            member        : v0,
            shares_burned : arg1,
            amount_usdc   : v3,
            share_price   : get_nav_per_share<T0>(arg0),
            timestamp     : v1,
        };
        0x2::event::emit<UsdcWithdrawn>(v6);
    }

    // decompiled from Move bytecode v7
}

