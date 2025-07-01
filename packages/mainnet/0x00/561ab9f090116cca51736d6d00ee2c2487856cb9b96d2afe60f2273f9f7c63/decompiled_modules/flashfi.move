module 0x561ab9f090116cca51736d6d00ee2c2487856cb9b96d2afe60f2273f9f7c63::flashfi {
    struct FLASHFI has drop {
        dummy_field: bool,
    }

    struct FlashLoanPool<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        fee_bps: u64,
        min_loan_amount: u64,
        max_loan_amount: u64,
        is_paused: bool,
        total_borrowed: u64,
        total_repaid: u64,
        total_fees_collected: u64,
        registered_strategies: 0x2::table::Table<vector<u8>, StrategyInfo>,
        admin: address,
    }

    struct StrategyInfo has copy, drop, store {
        creator: address,
        total_executions: u64,
        total_profit: u64,
        total_gas_used: u64,
        success_count: u64,
        enabled: bool,
    }

    struct FlashLoan<phantom T0> {
        pool_id: 0x2::object::ID,
        amount: u64,
        fee: u64,
        borrower: address,
    }

    struct PoolAdminCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct FlashLoanReceipt has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        strategy_name: vector<u8>,
        amount_borrowed: u64,
        profit_made: u64,
        fee_paid: u64,
        gas_used: u64,
        timestamp: u64,
        borrower: address,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        admin: address,
        coin_type: vector<u8>,
    }

    struct FlashLoanExecuted has copy, drop {
        pool_id: 0x2::object::ID,
        borrower: address,
        strategy: vector<u8>,
        amount_borrowed: u64,
        profit_made: u64,
        fee_paid: u64,
        timestamp: u64,
    }

    struct StrategyRegistered has copy, drop {
        pool_id: 0x2::object::ID,
        strategy_name: vector<u8>,
        creator: address,
    }

    struct LiquidityAdded has copy, drop {
        pool_id: 0x2::object::ID,
        provider: address,
        amount: u64,
    }

    struct PoolConfigUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        old_fee_bps: u64,
        new_fee_bps: u64,
    }

    public fun borrow<T0>(arg0: &mut FlashLoanPool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoan<T0>) {
        assert!(!arg0.is_paused, 7);
        assert!(arg1 >= arg0.min_loan_amount, 6);
        assert!(arg1 <= arg0.max_loan_amount, 6);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 1);
        arg0.total_borrowed = arg0.total_borrowed + arg1;
        let v0 = FlashLoan<T0>{
            pool_id  : 0x2::object::id<FlashLoanPool<T0>>(arg0),
            amount   : arg1,
            fee      : arg1 * arg0.fee_bps / 10000,
            borrower : 0x2::tx_context::sender(arg2),
        };
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2), v0)
    }

    public fun add_liquidity<T0>(arg0: &mut FlashLoanPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 6);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v1 = LiquidityAdded{
            pool_id  : 0x2::object::id<FlashLoanPool<T0>>(arg0),
            provider : 0x2::tx_context::sender(arg2),
            amount   : v0,
        };
        0x2::event::emit<LiquidityAdded>(v1);
    }

    public fun create_pool<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : PoolAdminCap {
        assert!(arg0 <= 1000, 6);
        assert!(arg1 > 0, 6);
        assert!(arg2 >= arg1, 6);
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = FlashLoanPool<T0>{
            id                    : v0,
            balance               : 0x2::balance::zero<T0>(),
            fee_bps               : arg0,
            min_loan_amount       : arg1,
            max_loan_amount       : arg2,
            is_paused             : false,
            total_borrowed        : 0,
            total_repaid          : 0,
            total_fees_collected  : 0,
            registered_strategies : 0x2::table::new<vector<u8>, StrategyInfo>(arg3),
            admin                 : 0x2::tx_context::sender(arg3),
        };
        let v3 = PoolAdminCap{
            id      : 0x2::object::new(arg3),
            pool_id : v1,
        };
        let v4 = PoolCreated{
            pool_id   : v1,
            admin     : 0x2::tx_context::sender(arg3),
            coin_type : b"Generic",
        };
        0x2::event::emit<PoolCreated>(v4);
        0x2::transfer::share_object<FlashLoanPool<T0>>(v2);
        v3
    }

    public fun emergency_withdraw<T0>(arg0: &mut FlashLoanPool<T0>, arg1: &PoolAdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::id<FlashLoanPool<T0>>(arg0) == arg1.pool_id, 4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, 0x2::balance::value<T0>(&arg0.balance)), arg2)
    }

    public entry fun entry_create_pool<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = create_pool<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::transfer<PoolAdminCap>(v0, 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: FLASHFI, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun is_paused<T0>(arg0: &FlashLoanPool<T0>) : bool {
        arg0.is_paused
    }

    public fun keep_receipt(arg0: FlashLoanReceipt, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::transfer<FlashLoanReceipt>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun pool_balance<T0>(arg0: &FlashLoanPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun pool_config<T0>(arg0: &FlashLoanPool<T0>) : (u64, u64, u64) {
        (arg0.fee_bps, arg0.min_loan_amount, arg0.max_loan_amount)
    }

    public fun pool_stats<T0>(arg0: &FlashLoanPool<T0>) : (u64, u64, u64, u64) {
        (arg0.total_borrowed, arg0.total_repaid, arg0.total_fees_collected, 0x2::balance::value<T0>(&arg0.balance))
    }

    public fun register_strategy<T0>(arg0: &mut FlashLoanPool<T0>, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 7);
        assert!(!0x2::table::contains<vector<u8>, StrategyInfo>(&arg0.registered_strategies, arg1), 5);
        let v0 = StrategyInfo{
            creator          : 0x2::tx_context::sender(arg2),
            total_executions : 0,
            total_profit     : 0,
            total_gas_used   : 0,
            success_count    : 0,
            enabled          : true,
        };
        0x2::table::add<vector<u8>, StrategyInfo>(&mut arg0.registered_strategies, arg1, v0);
        let v1 = StrategyRegistered{
            pool_id       : 0x2::object::id<FlashLoanPool<T0>>(arg0),
            strategy_name : arg1,
            creator       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<StrategyRegistered>(v1);
    }

    public fun repay<T0>(arg0: &mut FlashLoanPool<T0>, arg1: FlashLoan<T0>, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : FlashLoanReceipt {
        let FlashLoan {
            pool_id  : v0,
            amount   : v1,
            fee      : v2,
            borrower : v3,
        } = arg1;
        assert!(0x2::object::id<FlashLoanPool<T0>>(arg0) == v0, 3);
        let v4 = 0x2::coin::value<T0>(&arg2);
        let v5 = v1 + v2;
        assert!(v4 >= v5, 2);
        let v6 = if (v4 > v5) {
            v4 - v5
        } else {
            0
        };
        arg0.total_repaid = arg0.total_repaid + v1;
        arg0.total_fees_collected = arg0.total_fees_collected + v2;
        if (0x2::table::contains<vector<u8>, StrategyInfo>(&arg0.registered_strategies, arg3)) {
            let v7 = 0x2::table::borrow_mut<vector<u8>, StrategyInfo>(&mut arg0.registered_strategies, arg3);
            v7.total_executions = v7.total_executions + 1;
            v7.total_profit = v7.total_profit + v6;
            v7.success_count = v7.success_count + 1;
        };
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg2));
        let v8 = FlashLoanReceipt{
            id              : 0x2::object::new(arg5),
            pool_id         : v0,
            strategy_name   : arg3,
            amount_borrowed : v1,
            profit_made     : v6,
            fee_paid        : v2,
            gas_used        : 0,
            timestamp       : 0x2::clock::timestamp_ms(arg4),
            borrower        : v3,
        };
        let v9 = FlashLoanExecuted{
            pool_id         : v0,
            borrower        : v3,
            strategy        : arg3,
            amount_borrowed : v1,
            profit_made     : v6,
            fee_paid        : v2,
            timestamp       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<FlashLoanExecuted>(v9);
        v8
    }

    public fun set_pool_paused<T0>(arg0: &mut FlashLoanPool<T0>, arg1: &PoolAdminCap, arg2: bool) {
        arg0.is_paused = arg2;
    }

    public fun strategy_stats<T0>(arg0: &FlashLoanPool<T0>, arg1: vector<u8>) : (u64, u64, u64, bool) {
        if (0x2::table::contains<vector<u8>, StrategyInfo>(&arg0.registered_strategies, arg1)) {
            let v4 = 0x2::table::borrow<vector<u8>, StrategyInfo>(&arg0.registered_strategies, arg1);
            (v4.total_executions, v4.total_profit, v4.success_count, v4.enabled)
        } else {
            (0, 0, 0, false)
        }
    }

    public fun update_fee<T0>(arg0: &mut FlashLoanPool<T0>, arg1: &PoolAdminCap, arg2: u64) {
        assert!(arg2 <= 1000, 6);
        arg0.fee_bps = arg2;
        let v0 = PoolConfigUpdated{
            pool_id     : 0x2::object::id<FlashLoanPool<T0>>(arg0),
            old_fee_bps : arg0.fee_bps,
            new_fee_bps : arg2,
        };
        0x2::event::emit<PoolConfigUpdated>(v0);
    }

    public fun withdraw_fees<T0>(arg0: &mut FlashLoanPool<T0>, arg1: &PoolAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2 <= 0x2::balance::value<T0>(&arg0.balance), 1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

