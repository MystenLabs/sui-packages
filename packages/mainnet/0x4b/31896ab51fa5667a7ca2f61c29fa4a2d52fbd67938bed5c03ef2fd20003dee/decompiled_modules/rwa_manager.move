module 0x900bca6461ad24c86b83c974788b457cb76c3f6f4fd7b061c5b58cb40d974bab::rwa_manager {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AgentCap has store, key {
        id: 0x2::object::UID,
        agent_address: address,
    }

    struct StrategyExecutorCap has store, key {
        id: 0x2::object::UID,
        executor_address: address,
    }

    struct RWAManagerState has key {
        id: 0x2::object::UID,
        portfolio_count: u64,
        protocol_fee_bps: u64,
        fee_collector: address,
        zk_verifier: 0x1::option::Option<0x2::object::ID>,
        min_rebalance_interval: u64,
        paused: bool,
        fees: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Portfolio has store, key {
        id: 0x2::object::UID,
        owner: address,
        total_value: u64,
        target_yield: u64,
        risk_tolerance: u64,
        last_rebalance: u64,
        is_active: bool,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        allocations: 0x2::table::Table<0x1::string::String, u64>,
        created_at: u64,
    }

    struct StrategyExecution has copy, drop, store {
        portfolio_id: 0x2::object::ID,
        strategy: 0x1::string::String,
        timestamp: u64,
        executor: address,
        zk_proof_hash: vector<u8>,
        verified: bool,
        gas_used: u64,
    }

    struct PortfolioCreated has copy, drop {
        portfolio_id: 0x2::object::ID,
        owner: address,
        initial_value: u64,
        target_yield: u64,
        risk_tolerance: u64,
    }

    struct Deposited has copy, drop {
        portfolio_id: 0x2::object::ID,
        amount: u64,
        depositor: address,
        new_total: u64,
    }

    struct Withdrawn has copy, drop {
        portfolio_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
        remaining_total: u64,
    }

    struct StrategyExecuted has copy, drop {
        portfolio_id: 0x2::object::ID,
        strategy: 0x1::string::String,
        executor: address,
        zk_proof_hash: vector<u8>,
        success: bool,
    }

    struct PortfolioRebalanced has copy, drop {
        portfolio_id: 0x2::object::ID,
        old_value: u64,
        new_value: u64,
        timestamp: u64,
    }

    struct ZKProofVerified has copy, drop {
        portfolio_id: 0x2::object::ID,
        proof_hash: vector<u8>,
        verified: bool,
    }

    struct AllocationUpdated has copy, drop {
        portfolio_id: 0x2::object::ID,
        asset: 0x1::string::String,
        previous_allocation: u64,
        new_allocation: u64,
    }

    public entry fun create_portfolio(arg0: &mut RWAManagerState, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 0);
        assert!(arg2 <= 100, 5);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let v3 = Portfolio{
            id             : 0x2::object::new(arg5),
            owner          : v0,
            total_value    : v1,
            target_yield   : arg1,
            risk_tolerance : arg2,
            last_rebalance : v2,
            is_active      : true,
            balance        : 0x2::coin::into_balance<0x2::sui::SUI>(arg3),
            allocations    : 0x2::table::new<0x1::string::String, u64>(arg5),
            created_at     : v2,
        };
        arg0.portfolio_count = arg0.portfolio_count + 1;
        let v4 = PortfolioCreated{
            portfolio_id   : 0x2::object::id<Portfolio>(&v3),
            owner          : v0,
            initial_value  : v1,
            target_yield   : arg1,
            risk_tolerance : arg2,
        };
        0x2::event::emit<PortfolioCreated>(v4);
        0x2::transfer::share_object<Portfolio>(v3);
    }

    public entry fun deactivate_portfolio(arg0: &mut Portfolio, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        arg0.is_active = false;
    }

    public entry fun deposit(arg0: &mut RWAManagerState, arg1: &mut Portfolio, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 0);
        assert!(arg1.is_active, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 6);
        let v1 = v0 * arg0.protocol_fee_bps / 10000;
        let v2 = v0 - v1;
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, v3);
        arg1.total_value = arg1.total_value + v2;
        let v4 = Deposited{
            portfolio_id : 0x2::object::id<Portfolio>(arg1),
            amount       : v2,
            depositor    : 0x2::tx_context::sender(arg3),
            new_total    : arg1.total_value,
        };
        0x2::event::emit<Deposited>(v4);
    }

    public entry fun execute_strategy(arg0: &AgentCap, arg1: &RWAManagerState, arg2: &mut Portfolio, arg3: 0x1::string::String, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 0);
        assert!(arg2.is_active, 2);
        0x2::clock::timestamp_ms(arg5);
        let v0 = 0x1::vector::length<u8>(&arg4) > 0;
        let v1 = StrategyExecuted{
            portfolio_id  : 0x2::object::id<Portfolio>(arg2),
            strategy      : arg3,
            executor      : 0x2::tx_context::sender(arg6),
            zk_proof_hash : arg4,
            success       : v0,
        };
        0x2::event::emit<StrategyExecuted>(v1);
        if (v0) {
            let v2 = ZKProofVerified{
                portfolio_id : 0x2::object::id<Portfolio>(arg2),
                proof_hash   : arg4,
                verified     : true,
            };
            0x2::event::emit<ZKProofVerified>(v2);
        };
    }

    public fun get_portfolio_balance(arg0: &Portfolio) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_portfolio_owner(arg0: &Portfolio) : address {
        arg0.owner
    }

    public fun get_portfolio_value(arg0: &Portfolio) : u64 {
        arg0.total_value
    }

    public fun get_protocol_info(arg0: &RWAManagerState) : (u64, u64, bool) {
        (arg0.portfolio_count, arg0.protocol_fee_bps, arg0.paused)
    }

    public entry fun grant_agent_role(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AgentCap{
            id            : 0x2::object::new(arg2),
            agent_address : arg1,
        };
        0x2::transfer::transfer<AgentCap>(v0, arg1);
    }

    public entry fun grant_strategy_executor_role(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = StrategyExecutorCap{
            id               : 0x2::object::new(arg2),
            executor_address : arg1,
        };
        0x2::transfer::transfer<StrategyExecutorCap>(v0, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = RWAManagerState{
            id                     : 0x2::object::new(arg0),
            portfolio_count        : 0,
            protocol_fee_bps       : 50,
            fee_collector          : v0,
            zk_verifier            : 0x1::option::none<0x2::object::ID>(),
            min_rebalance_interval : 3600000,
            paused                 : false,
            fees                   : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<RWAManagerState>(v2);
    }

    public fun is_portfolio_active(arg0: &Portfolio) : bool {
        arg0.is_active
    }

    public entry fun rebalance(arg0: &AgentCap, arg1: &RWAManagerState, arg2: &mut Portfolio, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 0);
        assert!(arg2.is_active, 2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg2.last_rebalance + arg1.min_rebalance_interval, 4);
        arg2.last_rebalance = v0;
        let v1 = PortfolioRebalanced{
            portfolio_id : 0x2::object::id<Portfolio>(arg2),
            old_value    : arg2.total_value,
            new_value    : arg2.total_value,
            timestamp    : v0,
        };
        0x2::event::emit<PortfolioRebalanced>(v1);
    }

    public entry fun set_fee_collector(arg0: &AdminCap, arg1: &mut RWAManagerState, arg2: address) {
        arg1.fee_collector = arg2;
    }

    public entry fun set_paused(arg0: &AdminCap, arg1: &mut RWAManagerState, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun set_protocol_fee(arg0: &AdminCap, arg1: &mut RWAManagerState, arg2: u64) {
        assert!(arg2 <= 1000, 5);
        arg1.protocol_fee_bps = arg2;
    }

    public entry fun set_zk_verifier(arg0: &AdminCap, arg1: &mut RWAManagerState, arg2: 0x2::object::ID) {
        arg1.zk_verifier = 0x1::option::some<0x2::object::ID>(arg2);
    }

    public entry fun update_allocation(arg0: &AgentCap, arg1: &RWAManagerState, arg2: &mut Portfolio, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 0);
        assert!(arg2.is_active, 2);
        assert!(arg4 <= 10000, 5);
        let v0 = if (0x2::table::contains<0x1::string::String, u64>(&arg2.allocations, arg3)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg2.allocations, arg3)
        } else {
            0
        };
        if (0x2::table::contains<0x1::string::String, u64>(&arg2.allocations, arg3)) {
            *0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg2.allocations, arg3) = arg4;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg2.allocations, arg3, arg4);
        };
        let v1 = AllocationUpdated{
            portfolio_id        : 0x2::object::id<Portfolio>(arg2),
            asset               : arg3,
            previous_allocation : v0,
            new_allocation      : arg4,
        };
        0x2::event::emit<AllocationUpdated>(v1);
    }

    public entry fun withdraw(arg0: &RWAManagerState, arg1: &mut Portfolio, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.owner, 0);
        assert!(arg1.is_active, 2);
        assert!(arg2 > 0, 6);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.balance) >= arg2, 3);
        arg1.total_value = arg1.total_value - arg2;
        let v1 = Withdrawn{
            portfolio_id    : 0x2::object::id<Portfolio>(arg1),
            amount          : arg2,
            recipient       : v0,
            remaining_total : arg1.total_value,
        };
        0x2::event::emit<Withdrawn>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg2), arg3), v0);
    }

    public entry fun withdraw_fees(arg0: &AdminCap, arg1: &mut RWAManagerState, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<0x2::sui::SUI>(&arg1.fees) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.fees), arg2), arg1.fee_collector);
        };
    }

    // decompiled from Move bytecode v7
}

