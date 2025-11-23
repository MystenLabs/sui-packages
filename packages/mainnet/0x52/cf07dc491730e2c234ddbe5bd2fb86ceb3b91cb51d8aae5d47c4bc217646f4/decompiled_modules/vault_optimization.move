module 0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::vault_optimization {
    struct CollateralSwap has copy, drop, store {
        from_token: 0x1::string::String,
        to_token: 0x1::string::String,
        amount_in: u64,
        amount_out: u64,
        exchange_rate: u64,
        dex_used: address,
        timestamp: u64,
        swap_tx_hash: 0x1::string::String,
    }

    struct YieldRedirection has copy, drop, store {
        amount: u64,
        applied_to: 0x1::string::String,
        timestamp: u64,
        remaining_arrears_after: u64,
    }

    struct AppreciationCapture has copy, drop, store {
        starting_value_usd: u64,
        current_value_usd: u64,
        gain_amount_usd: u64,
        gain_percentage_bps: u64,
        applied_to_arrears: u64,
        timestamp: u64,
    }

    struct OptimizedVault has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        borrower: address,
        is_in_workout: bool,
        workout_start_date: u64,
        workout_end_date: u64,
        collateral_token_symbol: 0x1::string::String,
        collateral_amount: u64,
        starting_price_per_token: u64,
        latest_price_per_token: u64,
        last_price_update: u64,
        yield_redirection_active: bool,
        redirected_yield_total: u64,
        yield_redirection_history: vector<YieldRedirection>,
        total_appreciation_captured: u64,
        applied_gain_to_arrears: u64,
        appreciation_history: vector<AppreciationCapture>,
        collateral_swap_log: vector<CollateralSwap>,
        total_swaps_executed: u64,
        additional_collateral_deposited: u64,
        additional_deposits_count: u64,
        current_arrears_amount: u64,
        missed_payments_count: u64,
        created_at: u64,
        updated_at: u64,
    }

    struct DEXRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        whitelisted_dexes: 0x2::table::Table<address, DEXInfo>,
        dex_count: u64,
    }

    struct DEXInfo has copy, drop, store {
        name: 0x1::string::String,
        address: address,
        is_active: bool,
        added_at: u64,
        total_swaps: u64,
        total_volume: u64,
    }

    struct OptimizationConfig has key {
        id: 0x2::object::UID,
        admin: address,
        min_appreciation_threshold_bps: u64,
        max_slippage_bps: u64,
        yield_redirect_percentage_bps: u64,
        max_swaps_per_workout: u64,
        max_appreciation_capture_per_month: u64,
        dao_approval_required_above: u64,
        is_active: bool,
    }

    struct CollateralSwapped has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        from_token: 0x1::string::String,
        to_token: 0x1::string::String,
        amount_in: u64,
        amount_out: u64,
        dex_used: address,
        timestamp: u64,
    }

    struct CollateralAdded has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        token: 0x1::string::String,
        amount: u64,
        new_total: u64,
        timestamp: u64,
    }

    struct YieldRedirected has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        enabled: bool,
        timestamp: u64,
    }

    struct YieldAppliedToArrears has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        yield_amount: u64,
        applied_to_arrears: u64,
        remaining_arrears: u64,
        timestamp: u64,
    }

    struct CollateralGainApplied has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        appreciation_percentage_bps: u64,
        gain_amount_usd: u64,
        applied_to_arrears: u64,
        remaining_arrears: u64,
        timestamp: u64,
    }

    struct WorkoutStatusChanged has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        is_in_workout: bool,
        timestamp: u64,
    }

    struct DEXWhitelisted has copy, drop {
        dex_address: address,
        dex_name: 0x1::string::String,
        timestamp: u64,
    }

    public entry fun add_collateral(arg0: &mut OptimizedVault, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.borrower, 1);
        assert!(arg1 > 0, 3);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg0.collateral_amount = arg0.collateral_amount + arg1;
        arg0.additional_collateral_deposited = arg0.additional_collateral_deposited + arg1;
        arg0.additional_deposits_count = arg0.additional_deposits_count + 1;
        arg0.updated_at = v0;
        let v1 = CollateralAdded{
            vault_id  : arg0.vault_id,
            borrower  : arg0.borrower,
            token     : arg0.collateral_token_symbol,
            amount    : arg1,
            new_total : arg0.collateral_amount,
            timestamp : v0,
        };
        0x2::event::emit<CollateralAdded>(v1);
    }

    public entry fun apply_appreciation_to_arrears(arg0: &mut OptimizedVault, arg1: &OptimizationConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_in_workout, 2);
        assert!(arg0.current_arrears_amount > 0, 8);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg0.latest_price_per_token = arg2;
        arg0.last_price_update = v0;
        let v1 = if (arg2 > arg0.starting_price_per_token) {
            (arg2 - arg0.starting_price_per_token) * 10000 / arg0.starting_price_per_token
        } else {
            0
        };
        assert!(v1 >= arg1.min_appreciation_threshold_bps, 9);
        let v2 = arg0.collateral_amount * arg0.starting_price_per_token;
        let v3 = arg0.collateral_amount * arg2;
        let v4 = v3 - v2;
        let v5 = if (v4 > arg0.current_arrears_amount) {
            arg0.current_arrears_amount
        } else {
            v4
        };
        arg0.current_arrears_amount = arg0.current_arrears_amount - v5;
        arg0.applied_gain_to_arrears = arg0.applied_gain_to_arrears + v5;
        arg0.total_appreciation_captured = arg0.total_appreciation_captured + v4;
        let v6 = AppreciationCapture{
            starting_value_usd  : v2,
            current_value_usd   : v3,
            gain_amount_usd     : v4,
            gain_percentage_bps : v1,
            applied_to_arrears  : v5,
            timestamp           : v0,
        };
        0x1::vector::push_back<AppreciationCapture>(&mut arg0.appreciation_history, v6);
        arg0.starting_price_per_token = arg2;
        arg0.updated_at = v0;
        let v7 = CollateralGainApplied{
            vault_id                    : arg0.vault_id,
            borrower                    : arg0.borrower,
            appreciation_percentage_bps : v1,
            gain_amount_usd             : v4,
            applied_to_arrears          : v5,
            remaining_arrears           : arg0.current_arrears_amount,
            timestamp                   : v0,
        };
        0x2::event::emit<CollateralGainApplied>(v7);
    }

    public entry fun apply_yield_to_arrears(arg0: &mut OptimizedVault, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.yield_redirection_active, 1);
        assert!(arg1 > 0, 3);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = if (arg1 > arg0.current_arrears_amount) {
            arg0.current_arrears_amount
        } else {
            arg1
        };
        arg0.current_arrears_amount = arg0.current_arrears_amount - v1;
        arg0.redirected_yield_total = arg0.redirected_yield_total + v1;
        let v2 = YieldRedirection{
            amount                  : v1,
            applied_to              : 0x1::string::utf8(b"missed_payments"),
            timestamp               : v0,
            remaining_arrears_after : arg0.current_arrears_amount,
        };
        0x1::vector::push_back<YieldRedirection>(&mut arg0.yield_redirection_history, v2);
        arg0.updated_at = v0;
        let v3 = YieldAppliedToArrears{
            vault_id           : arg0.vault_id,
            borrower           : arg0.borrower,
            yield_amount       : arg1,
            applied_to_arrears : v1,
            remaining_arrears  : arg0.current_arrears_amount,
            timestamp          : v0,
        };
        0x2::event::emit<YieldAppliedToArrears>(v3);
    }

    public entry fun create_optimized_vault(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = OptimizedVault{
            id                              : 0x2::object::new(arg7),
            vault_id                        : arg0,
            borrower                        : 0x2::tx_context::sender(arg7),
            is_in_workout                   : true,
            workout_start_date              : v0,
            workout_end_date                : v0 + 15552000000,
            collateral_token_symbol         : 0x1::string::utf8(arg1),
            collateral_amount               : arg2,
            starting_price_per_token        : arg3,
            latest_price_per_token          : arg3,
            last_price_update               : v0,
            yield_redirection_active        : false,
            redirected_yield_total          : 0,
            yield_redirection_history       : 0x1::vector::empty<YieldRedirection>(),
            total_appreciation_captured     : 0,
            applied_gain_to_arrears         : 0,
            appreciation_history            : 0x1::vector::empty<AppreciationCapture>(),
            collateral_swap_log             : 0x1::vector::empty<CollateralSwap>(),
            total_swaps_executed            : 0,
            additional_collateral_deposited : 0,
            additional_deposits_count       : 0,
            current_arrears_amount          : arg4,
            missed_payments_count           : arg5,
            created_at                      : v0,
            updated_at                      : v0,
        };
        let v2 = WorkoutStatusChanged{
            vault_id      : arg0,
            borrower      : 0x2::tx_context::sender(arg7),
            is_in_workout : true,
            timestamp     : v0,
        };
        0x2::event::emit<WorkoutStatusChanged>(v2);
        0x2::transfer::share_object<OptimizedVault>(v1);
    }

    public fun get_appreciation_info(arg0: &OptimizedVault) : (u64, u64, u64, u64) {
        (arg0.starting_price_per_token, arg0.latest_price_per_token, arg0.total_appreciation_captured, arg0.applied_gain_to_arrears)
    }

    public fun get_vault_status(arg0: &OptimizedVault) : (bool, u64, u64, u64) {
        (arg0.is_in_workout, arg0.current_arrears_amount, arg0.collateral_amount, arg0.redirected_yield_total)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DEXRegistry{
            id                : 0x2::object::new(arg0),
            admin             : 0x2::tx_context::sender(arg0),
            whitelisted_dexes : 0x2::table::new<address, DEXInfo>(arg0),
            dex_count         : 0,
        };
        0x2::transfer::share_object<DEXRegistry>(v0);
        let v1 = OptimizationConfig{
            id                                 : 0x2::object::new(arg0),
            admin                              : 0x2::tx_context::sender(arg0),
            min_appreciation_threshold_bps     : 500,
            max_slippage_bps                   : 500,
            yield_redirect_percentage_bps      : 10000,
            max_swaps_per_workout              : 5,
            max_appreciation_capture_per_month : 3,
            dao_approval_required_above        : 10000000,
            is_active                          : true,
        };
        0x2::transfer::share_object<OptimizationConfig>(v1);
    }

    public fun is_dex_whitelisted(arg0: &DEXRegistry, arg1: address) : bool {
        0x2::table::contains<address, DEXInfo>(&arg0.whitelisted_dexes, arg1)
    }

    public entry fun redirect_yield(arg0: &mut OptimizedVault, arg1: bool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.borrower, 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg0.yield_redirection_active = arg1;
        arg0.updated_at = v0;
        let v1 = YieldRedirected{
            vault_id  : arg0.vault_id,
            borrower  : arg0.borrower,
            enabled   : arg1,
            timestamp : v0,
        };
        0x2::event::emit<YieldRedirected>(v1);
    }

    public entry fun set_workout_status(arg0: &mut OptimizedVault, arg1: bool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg0.is_in_workout = arg1;
        if (arg1 && arg0.workout_start_date == 0) {
            arg0.workout_start_date = v0;
            arg0.workout_end_date = v0 + 15552000000;
        };
        arg0.updated_at = v0;
        let v1 = WorkoutStatusChanged{
            vault_id      : arg0.vault_id,
            borrower      : arg0.borrower,
            is_in_workout : arg1,
            timestamp     : v0,
        };
        0x2::event::emit<WorkoutStatusChanged>(v1);
    }

    public entry fun swap_collateral(arg0: &mut OptimizedVault, arg1: &DEXRegistry, arg2: &OptimizationConfig, arg3: address, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == arg0.borrower, 1);
        assert!(arg0.is_in_workout, 2);
        assert!(0x2::table::contains<address, DEXInfo>(&arg1.whitelisted_dexes, arg3), 4);
        assert!(arg4 <= arg0.collateral_amount, 6);
        assert!(arg4 > 0, 3);
        assert!(arg0.total_swaps_executed < arg2.max_swaps_per_workout, 1);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = arg4 * arg0.latest_price_per_token / arg0.starting_price_per_token;
        let v2 = if (v1 > arg5) {
            (v1 - arg5) * 10000 / v1
        } else {
            0
        };
        assert!(v2 <= arg2.max_slippage_bps, 5);
        let v3 = CollateralSwap{
            from_token    : arg0.collateral_token_symbol,
            to_token      : 0x1::string::utf8(arg6),
            amount_in     : arg4,
            amount_out    : arg5,
            exchange_rate : arg5 * 10000 / arg4,
            dex_used      : arg3,
            timestamp     : v0,
            swap_tx_hash  : 0x1::string::utf8(b"pending"),
        };
        0x1::vector::push_back<CollateralSwap>(&mut arg0.collateral_swap_log, v3);
        arg0.collateral_amount = arg0.collateral_amount - arg4 + arg5;
        arg0.collateral_token_symbol = 0x1::string::utf8(arg6);
        arg0.total_swaps_executed = arg0.total_swaps_executed + 1;
        arg0.updated_at = v0;
        let v4 = CollateralSwapped{
            vault_id   : arg0.vault_id,
            borrower   : arg0.borrower,
            from_token : v3.from_token,
            to_token   : v3.to_token,
            amount_in  : arg4,
            amount_out : arg5,
            dex_used   : arg3,
            timestamp  : v0,
        };
        0x2::event::emit<CollateralSwapped>(v4);
    }

    public entry fun update_config(arg0: &mut OptimizationConfig, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 1);
        arg0.min_appreciation_threshold_bps = arg1;
        arg0.max_slippage_bps = arg2;
        arg0.yield_redirect_percentage_bps = arg3;
        arg0.max_swaps_per_workout = arg4;
        arg0.dao_approval_required_above = arg5;
    }

    public entry fun whitelist_dex(arg0: &mut DEXRegistry, arg1: address, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = DEXInfo{
            name         : 0x1::string::utf8(arg2),
            address      : arg1,
            is_active    : true,
            added_at     : v0,
            total_swaps  : 0,
            total_volume : 0,
        };
        0x2::table::add<address, DEXInfo>(&mut arg0.whitelisted_dexes, arg1, v1);
        arg0.dex_count = arg0.dex_count + 1;
        let v2 = DEXWhitelisted{
            dex_address : arg1,
            dex_name    : 0x1::string::utf8(arg2),
            timestamp   : v0,
        };
        0x2::event::emit<DEXWhitelisted>(v2);
    }

    // decompiled from Move bytecode v6
}

