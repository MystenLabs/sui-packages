module 0x901bba04235e18e3bb425ff9bfe908fffb6c14ab243ce97c81248bf70a956c68::arb_executor {
    struct ArbExecutor has store, key {
        id: 0x2::object::UID,
        owner: address,
        total_profit: u64,
        successful_arbs: u64,
        failed_arbs: u64,
        total_gas_spent: u64,
    }

    struct ArbExecuted has copy, drop {
        executor_id: 0x2::object::ID,
        timestamp_ms: u64,
        input_amount: u64,
        output_amount: u64,
        profit_bps: u64,
        route: vector<u8>,
        success: bool,
    }

    fun calculate_profit_bps(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        if (arg1 <= arg0) {
            return 0
        };
        (arg1 - arg0) * 10000 / arg0
    }

    public entry fun execute_direct_arb(arg0: &mut ArbExecutor, arg1: address, arg2: address, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        arg0.successful_arbs = arg0.successful_arbs + 1;
        let v0 = ArbExecuted{
            executor_id   : 0x2::object::uid_to_inner(&arg0.id),
            timestamp_ms  : 0,
            input_amount  : 0,
            output_amount : 0,
            profit_bps    : arg4,
            route         : b"DIRECT_ARB",
            success       : true,
        };
        0x2::event::emit<ArbExecuted>(v0);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
    }

    public entry fun execute_flash_loan_arb(arg0: &mut ArbExecutor, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = calculate_profit_bps(arg2, arg2);
        let v1 = v0 >= arg3;
        if (v1) {
            arg0.successful_arbs = arg0.successful_arbs + 1;
        } else {
            arg0.failed_arbs = arg0.failed_arbs + 1;
        };
        let v2 = ArbExecuted{
            executor_id   : 0x2::object::uid_to_inner(&arg0.id),
            timestamp_ms  : 0,
            input_amount  : arg2,
            output_amount : arg2,
            profit_bps    : v0,
            route         : b"FLASH_LOAN_ARB",
            success       : v1,
        };
        0x2::event::emit<ArbExecuted>(v2);
    }

    public fun failed_arbs(arg0: &ArbExecutor) : u64 {
        arg0.failed_arbs
    }

    public fun init_executor(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ArbExecutor{
            id              : 0x2::object::new(arg0),
            owner           : 0x2::tx_context::sender(arg0),
            total_profit    : 0,
            successful_arbs : 0,
            failed_arbs     : 0,
            total_gas_spent : 0,
        };
        0x2::transfer::public_share_object<ArbExecutor>(v0);
    }

    public fun owner(arg0: &ArbExecutor) : address {
        arg0.owner
    }

    public fun successful_arbs(arg0: &ArbExecutor) : u64 {
        arg0.successful_arbs
    }

    public fun total_gas_spent(arg0: &ArbExecutor) : u64 {
        arg0.total_gas_spent
    }

    public fun total_profit(arg0: &ArbExecutor) : u64 {
        arg0.total_profit
    }

    public entry fun withdraw_profit(arg0: &mut ArbExecutor, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        assert!(arg0.total_profit >= arg2, 2);
        arg0.total_profit = arg0.total_profit - arg2;
    }

    // decompiled from Move bytecode v6
}

