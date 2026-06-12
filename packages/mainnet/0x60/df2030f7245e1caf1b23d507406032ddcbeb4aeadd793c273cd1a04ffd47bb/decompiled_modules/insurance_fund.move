module 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::insurance_fund {
    struct InsuranceFundState has key {
        id: 0x2::object::UID,
        balance: u64,
        launch_balance: u64,
        total_inflows: u128,
        total_outflows: u128,
        total_fees_collected: u128,
        total_deficit_covered: u128,
        n_max_scale_bps: u64,
        n_max_halved_by_fund: bool,
        last_n_max_recalc_ms: u64,
        balance_at_last_recalc: u64,
        initialized: bool,
    }

    struct InsuranceFundInitialized has copy, drop {
        launch_balance: u64,
    }

    struct FeeAccumulated has copy, drop {
        amount: u64,
        new_balance: u64,
    }

    struct DeficitCovered has copy, drop {
        deficit_amount: u64,
        amount_covered: u64,
        new_balance: u64,
    }

    struct TreasuryDeposit has copy, drop {
        amount: u64,
        new_balance: u64,
    }

    struct TreasuryWithdraw has copy, drop {
        amount: u64,
        new_balance: u64,
    }

    struct NMaxHalvedByFund has copy, drop {
        balance: u64,
        launch_balance: u64,
        new_scale_bps: u64,
    }

    struct NMaxRestoredByFund has copy, drop {
        balance: u64,
        launch_balance: u64,
        new_scale_bps: u64,
    }

    struct NMaxScaleRecalculated has copy, drop {
        old_scale_bps: u64,
        new_scale_bps: u64,
        old_balance: u64,
        new_balance: u64,
    }

    public(friend) fun accumulate_fees(arg0: &mut InsuranceFundState, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg0.initialized, 1);
        assert!(arg1 > 0, 3);
        arg0.balance = arg0.balance + arg1;
        arg0.total_inflows = arg0.total_inflows + (arg1 as u128);
        arg0.total_fees_collected = arg0.total_fees_collected + (arg1 as u128);
        let v0 = FeeAccumulated{
            amount      : arg1,
            new_balance : arg0.balance,
        };
        0x2::event::emit<FeeAccumulated>(v0);
        update_n_max_scale(arg0, arg2);
    }

    public fun assert_initialized(arg0: &InsuranceFundState) {
        assert!(arg0.initialized, 1);
    }

    public fun balance(arg0: &InsuranceFundState) : u64 {
        arg0.balance
    }

    public fun balance_at_last_recalc(arg0: &InsuranceFundState) : u64 {
        arg0.balance_at_last_recalc
    }

    fun compute_change_bps(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            if (arg1 == 0) {
                return 0
            };
            return 10000
        };
        let v0 = if (arg1 > arg0) {
            arg1 - arg0
        } else {
            arg0 - arg1
        };
        (((v0 as u128) * (10000 as u128) / (arg0 as u128)) as u64)
    }

    public fun compute_effective_n_max(arg0: &InsuranceFundState, arg1: u64) : u64 {
        if (!arg0.initialized) {
            return arg1
        };
        (((arg1 as u128) * (arg0.n_max_scale_bps as u128) / (10000 as u128)) as u64)
    }

    public(friend) fun cover_deficit(arg0: &mut InsuranceFundState, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        assert!(arg0.initialized, 1);
        assert!(arg1 > 0, 3);
        let v0 = if (arg1 <= arg0.balance) {
            arg1
        } else {
            arg0.balance
        };
        arg0.balance = arg0.balance - v0;
        arg0.total_outflows = arg0.total_outflows + (v0 as u128);
        arg0.total_deficit_covered = arg0.total_deficit_covered + (v0 as u128);
        let v1 = DeficitCovered{
            deficit_amount : arg1,
            amount_covered : v0,
            new_balance    : arg0.balance,
        };
        0x2::event::emit<DeficitCovered>(v1);
        update_n_max_scale(arg0, arg2);
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InsuranceFundState{
            id                     : 0x2::object::new(arg0),
            balance                : 0,
            launch_balance         : 0,
            total_inflows          : 0,
            total_outflows         : 0,
            total_fees_collected   : 0,
            total_deficit_covered  : 0,
            n_max_scale_bps        : 10000,
            n_max_halved_by_fund   : false,
            last_n_max_recalc_ms   : 0,
            balance_at_last_recalc : 0,
            initialized            : false,
        };
        0x2::transfer::share_object<InsuranceFundState>(v0);
    }

    public fun initialize_fund(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::AdminCap, arg1: &mut InsuranceFundState, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(!arg1.initialized, 0);
        assert!(arg2 >= 100000000000000, 2);
        arg1.balance = arg2;
        arg1.launch_balance = arg2;
        arg1.total_inflows = (arg2 as u128);
        arg1.n_max_scale_bps = 10000;
        arg1.n_max_halved_by_fund = false;
        arg1.last_n_max_recalc_ms = 0x2::clock::timestamp_ms(arg3);
        arg1.balance_at_last_recalc = arg2;
        arg1.initialized = true;
        let v0 = InsuranceFundInitialized{launch_balance: arg2};
        0x2::event::emit<InsuranceFundInitialized>(v0);
    }

    public fun is_initialized(arg0: &InsuranceFundState) : bool {
        arg0.initialized
    }

    public fun is_n_max_halved_by_fund(arg0: &InsuranceFundState) : bool {
        arg0.n_max_halved_by_fund
    }

    public fun last_n_max_recalc_ms(arg0: &InsuranceFundState) : u64 {
        arg0.last_n_max_recalc_ms
    }

    public fun launch_balance(arg0: &InsuranceFundState) : u64 {
        arg0.launch_balance
    }

    public fun n_max_scale_bps(arg0: &InsuranceFundState) : u64 {
        arg0.n_max_scale_bps
    }

    public fun needs_n_max_recalc(arg0: &InsuranceFundState) : bool {
        if (!arg0.initialized || arg0.balance_at_last_recalc == 0) {
            return false
        };
        compute_change_bps(arg0.balance_at_last_recalc, arg0.balance) >= 1000
    }

    public fun total_deficit_covered(arg0: &InsuranceFundState) : u128 {
        arg0.total_deficit_covered
    }

    public fun total_fees_collected(arg0: &InsuranceFundState) : u128 {
        arg0.total_fees_collected
    }

    public fun total_inflows(arg0: &InsuranceFundState) : u128 {
        arg0.total_inflows
    }

    public fun total_outflows(arg0: &InsuranceFundState) : u128 {
        arg0.total_outflows
    }

    public fun treasury_deposit(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::AdminCap, arg1: &mut InsuranceFundState, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg1.initialized, 1);
        assert!(arg2 > 0, 3);
        arg1.balance = arg1.balance + arg2;
        arg1.total_inflows = arg1.total_inflows + (arg2 as u128);
        let v0 = TreasuryDeposit{
            amount      : arg2,
            new_balance : arg1.balance,
        };
        0x2::event::emit<TreasuryDeposit>(v0);
        update_n_max_scale(arg1, arg3);
    }

    public fun treasury_withdraw(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::AdminCap, arg1: &mut InsuranceFundState, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg1.initialized, 1);
        assert!(arg2 > 0, 3);
        assert!(arg1.balance >= arg2, 4);
        arg1.balance = arg1.balance - arg2;
        arg1.total_outflows = arg1.total_outflows + (arg2 as u128);
        let v0 = TreasuryWithdraw{
            amount      : arg2,
            new_balance : arg1.balance,
        };
        0x2::event::emit<TreasuryWithdraw>(v0);
        update_n_max_scale(arg1, arg3);
    }

    fun update_n_max_scale(arg0: &mut InsuranceFundState, arg1: &0x2::clock::Clock) {
        if (!arg0.initialized || arg0.launch_balance == 0) {
            return
        };
        let v0 = arg0.n_max_scale_bps;
        let v1 = (arg0.balance as u128);
        let v2 = (arg0.launch_balance as u128);
        let v3 = (10000 as u128);
        let v4 = ((v1 * v3 / v2) as u64);
        if (!arg0.n_max_halved_by_fund) {
            if (v1 < v2 * (5000 as u128) / v3) {
                arg0.n_max_halved_by_fund = true;
                arg0.n_max_scale_bps = 5000;
                let v5 = NMaxHalvedByFund{
                    balance        : arg0.balance,
                    launch_balance : arg0.launch_balance,
                    new_scale_bps  : 5000,
                };
                0x2::event::emit<NMaxHalvedByFund>(v5);
            } else {
                arg0.n_max_scale_bps = v4;
            };
        } else if (v1 > v2 * (5500 as u128) / v3) {
            arg0.n_max_halved_by_fund = false;
            arg0.n_max_scale_bps = v4;
            let v6 = NMaxRestoredByFund{
                balance        : arg0.balance,
                launch_balance : arg0.launch_balance,
                new_scale_bps  : v4,
            };
            0x2::event::emit<NMaxRestoredByFund>(v6);
        };
        let v7 = arg0.n_max_scale_bps;
        if (v7 != v0) {
            if (compute_change_bps(arg0.balance_at_last_recalc, arg0.balance) >= 1000) {
                let v8 = NMaxScaleRecalculated{
                    old_scale_bps : v0,
                    new_scale_bps : v7,
                    old_balance   : arg0.balance_at_last_recalc,
                    new_balance   : arg0.balance,
                };
                0x2::event::emit<NMaxScaleRecalculated>(v8);
                arg0.last_n_max_recalc_ms = 0x2::clock::timestamp_ms(arg1);
                arg0.balance_at_last_recalc = arg0.balance;
            };
        };
    }

    // decompiled from Move bytecode v7
}

