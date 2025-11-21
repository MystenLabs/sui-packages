module 0xaf2f8ad6382c0706e0ed17ce4d68bec8ccd858ec3741bcfd2b5d38234409df07::refinance_analyzer {
    struct MarketConditions has key {
        id: 0x2::object::UID,
        current_base_rate_bps: u64,
        sui_price_usd: u64,
        sui_30d_volatility: u64,
        default_rate_bps: u64,
        last_updated: u64,
        update_count: u64,
    }

    struct RefinanceAnalysis has copy, drop, store {
        vault_id: 0x2::object::ID,
        should_refinance: bool,
        viability_score: u64,
        recommended_new_rate: u64,
        estimated_monthly_savings: u64,
        breakeven_months: u64,
        rate_differential_score: u64,
        cltv_improvement_score: u64,
        payment_history_score: u64,
        collateral_trend_score: u64,
        time_elapsed_score: u64,
        timestamp: u64,
    }

    struct RefinanceTracker has key {
        id: 0x2::object::UID,
        vault_analyses: 0x2::table::Table<0x2::object::ID, RefinanceAnalysis>,
        last_analysis_time: 0x2::table::Table<0x2::object::ID, u64>,
        total_analyses_performed: u64,
    }

    struct PaymentPerformance has copy, drop, store {
        vault_id: 0x2::object::ID,
        total_payments_made: u64,
        on_time_payments: u64,
        late_payments: u64,
        missed_payments: u64,
        average_days_late: u64,
        last_payment_timestamp: u64,
        performance_score: u64,
    }

    struct CollateralTrend has copy, drop, store {
        vault_id: 0x2::object::ID,
        initial_collateral_value: u64,
        current_collateral_value: u64,
        appreciation_rate_bps: u64,
        trend_direction: u8,
    }

    struct RefinanceAnalyzed has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        should_refinance: bool,
        viability_score: u64,
        current_rate: u64,
        recommended_rate: u64,
        estimated_savings: u64,
        timestamp: u64,
    }

    struct AutoRefinanceTriggered has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        old_rate: u64,
        new_rate: u64,
        viability_score: u64,
        timestamp: u64,
    }

    struct MarketConditionsUpdated has copy, drop {
        base_rate: u64,
        sui_price: u64,
        volatility: u64,
        timestamp: u64,
    }

    public fun analyze_refinance_viability(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: PaymentPerformance, arg6: CollateralTrend, arg7: &MarketConditions, arg8: &0x2::clock::Clock) : RefinanceAnalysis {
        let v0 = 0x2::clock::timestamp_ms(arg8) / 1000;
        let v1 = (v0 - arg4) / 2592000;
        let v2 = calculate_rate_differential_score(arg1, arg7.current_base_rate_bps);
        let v3 = calculate_cltv_improvement_score(arg2, arg6.current_collateral_value);
        let v4 = arg5.performance_score;
        let v5 = calculate_collateral_trend_score(&arg6);
        let v6 = calculate_time_elapsed_score(v1);
        let v7 = (v2 * 3500 + v3 * 2500 + v4 * 2000 + v5 * 1500 + v6 * 500) / 10000;
        let v8 = if (v7 >= 6500) {
            if (v1 >= 12) {
                v4 >= 7000
            } else {
                false
            }
        } else {
            false
        };
        let v9 = if (v8) {
            arg7.current_base_rate_bps + calculate_risk_premium(v4)
        } else {
            arg1
        };
        let v10 = calculate_monthly_payment(arg2, arg1);
        let v11 = calculate_monthly_payment(arg2, v9);
        let v12 = if (v11 < v10) {
            v10 - v11
        } else {
            0
        };
        let v13 = if (v12 > 0) {
            arg2 * 200 / 10000 / v12
        } else {
            999
        };
        RefinanceAnalysis{
            vault_id                  : arg0,
            should_refinance          : v8,
            viability_score           : v7,
            recommended_new_rate      : v9,
            estimated_monthly_savings : v12,
            breakeven_months          : v13,
            rate_differential_score   : v2,
            cltv_improvement_score    : v3,
            payment_history_score     : v4,
            collateral_trend_score    : v5,
            time_elapsed_score        : v6,
            timestamp                 : v0,
        }
    }

    public fun analyze_vault_for_refinance(arg0: &mut RefinanceTracker, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: PaymentPerformance, arg8: CollateralTrend, arg9: &MarketConditions, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = analyze_refinance_viability(arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        if (0x2::table::contains<0x2::object::ID, RefinanceAnalysis>(&arg0.vault_analyses, arg1)) {
            *0x2::table::borrow_mut<0x2::object::ID, RefinanceAnalysis>(&mut arg0.vault_analyses, arg1) = v0;
        } else {
            0x2::table::add<0x2::object::ID, RefinanceAnalysis>(&mut arg0.vault_analyses, arg1, v0);
        };
        let v1 = 0x2::clock::timestamp_ms(arg10) / 1000;
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.last_analysis_time, arg1)) {
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.last_analysis_time, arg1) = v1;
        } else {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.last_analysis_time, arg1, v1);
        };
        arg0.total_analyses_performed = arg0.total_analyses_performed + 1;
        let v2 = RefinanceAnalyzed{
            vault_id          : arg1,
            borrower          : arg2,
            should_refinance  : v0.should_refinance,
            viability_score   : v0.viability_score,
            current_rate      : arg3,
            recommended_rate  : v0.recommended_new_rate,
            estimated_savings : v0.estimated_monthly_savings,
            timestamp         : v1,
        };
        0x2::event::emit<RefinanceAnalyzed>(v2);
    }

    fun calculate_cltv_improvement_score(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = arg0 * 10000 / arg1;
        if (v0 < 5000) {
            10000
        } else if (v0 < 6000) {
            8000
        } else if (v0 < 7000) {
            6000
        } else if (v0 < 8000) {
            4000
        } else {
            2000
        }
    }

    fun calculate_collateral_trend_score(arg0: &CollateralTrend) : u64 {
        if (arg0.appreciation_rate_bps >= 1000) {
            10000
        } else if (arg0.appreciation_rate_bps >= 500) {
            8000
        } else if (arg0.appreciation_rate_bps > 0) {
            6000
        } else if (arg0.appreciation_rate_bps >= 0) {
            4000
        } else {
            2000
        }
    }

    fun calculate_monthly_payment(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 12 * 10000
    }

    fun calculate_rate_differential_score(arg0: u64, arg1: u64) : u64 {
        if (arg0 <= arg1) {
            return 0
        };
        let v0 = arg0 - arg1;
        if (v0 >= 200) {
            10000
        } else if (v0 >= 100) {
            8000
        } else if (v0 >= 50) {
            5000
        } else {
            2000
        }
    }

    fun calculate_risk_premium(arg0: u64) : u64 {
        if (arg0 >= 9000) {
            50
        } else if (arg0 >= 8000) {
            100
        } else if (arg0 >= 7000) {
            150
        } else {
            200
        }
    }

    fun calculate_time_elapsed_score(arg0: u64) : u64 {
        if (arg0 < 12) {
            0
        } else if (arg0 < 24) {
            5000
        } else if (arg0 < 36) {
            7000
        } else {
            10000
        }
    }

    public fun create_collateral_trend(arg0: 0x2::object::ID, arg1: u64, arg2: u64) : CollateralTrend {
        let v0 = if (arg1 > 0) {
            let v1 = if (arg2 > arg1) {
                arg2 - arg1
            } else {
                0
            };
            v1 * 10000 / arg1
        } else {
            0
        };
        let v2 = if (arg2 > arg1) {
            1
        } else if (arg2 == arg1) {
            2
        } else {
            3
        };
        CollateralTrend{
            vault_id                 : arg0,
            initial_collateral_value : arg1,
            current_collateral_value : arg2,
            appreciation_rate_bps    : v0,
            trend_direction          : v2,
        }
    }

    public fun create_payment_performance(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : PaymentPerformance {
        let v0 = if (arg1 > 0) {
            let v1 = arg2 * 10000 / arg1;
            let v2 = arg3 * 2000 / arg1;
            let v3 = arg4 * 5000 / arg1;
            if (v1 > v2 + v3) {
                v1 - v2 - v3
            } else {
                0
            }
        } else {
            10000
        };
        PaymentPerformance{
            vault_id               : arg0,
            total_payments_made    : arg1,
            on_time_payments       : arg2,
            late_payments          : arg3,
            missed_payments        : arg4,
            average_days_late      : arg5,
            last_payment_timestamp : arg6,
            performance_score      : v0,
        }
    }

    public fun get_latest_analysis(arg0: &RefinanceTracker, arg1: 0x2::object::ID) : 0x1::option::Option<RefinanceAnalysis> {
        if (0x2::table::contains<0x2::object::ID, RefinanceAnalysis>(&arg0.vault_analyses, arg1)) {
            0x1::option::some<RefinanceAnalysis>(*0x2::table::borrow<0x2::object::ID, RefinanceAnalysis>(&arg0.vault_analyses, arg1))
        } else {
            0x1::option::none<RefinanceAnalysis>()
        }
    }

    public fun get_market_rate(arg0: &MarketConditions) : u64 {
        arg0.current_base_rate_bps
    }

    public fun get_sui_price(arg0: &MarketConditions) : u64 {
        arg0.sui_price_usd
    }

    public fun get_total_analyses(arg0: &RefinanceTracker) : u64 {
        arg0.total_analyses_performed
    }

    public entry fun initialize_analyzer(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketConditions{
            id                    : 0x2::object::new(arg3),
            current_base_rate_bps : arg0,
            sui_price_usd         : arg1,
            sui_30d_volatility    : 2000,
            default_rate_bps      : 200,
            last_updated          : 0x2::clock::timestamp_ms(arg2) / 1000,
            update_count          : 0,
        };
        let v1 = RefinanceTracker{
            id                       : 0x2::object::new(arg3),
            vault_analyses           : 0x2::table::new<0x2::object::ID, RefinanceAnalysis>(arg3),
            last_analysis_time       : 0x2::table::new<0x2::object::ID, u64>(arg3),
            total_analyses_performed : 0,
        };
        0x2::transfer::share_object<MarketConditions>(v0);
        0x2::transfer::share_object<RefinanceTracker>(v1);
    }

    public entry fun update_market_conditions(arg0: &mut MarketConditions, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        arg0.current_base_rate_bps = arg1;
        arg0.sui_price_usd = arg2;
        arg0.sui_30d_volatility = arg3;
        arg0.last_updated = 0x2::clock::timestamp_ms(arg4) / 1000;
        arg0.update_count = arg0.update_count + 1;
        let v0 = MarketConditionsUpdated{
            base_rate  : arg1,
            sui_price  : arg2,
            volatility : arg3,
            timestamp  : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<MarketConditionsUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

