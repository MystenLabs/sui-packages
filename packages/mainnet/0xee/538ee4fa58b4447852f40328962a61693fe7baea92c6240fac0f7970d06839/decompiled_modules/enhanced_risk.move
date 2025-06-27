module 0xee538ee4fa58b4447852f40328962a61693fe7baea92c6240fac0f7970d06839::enhanced_risk {
    struct EmergencySystem has key {
        id: 0x2::object::UID,
        emergency_mode: bool,
        system_paused: bool,
        circuit_breakers_active: bool,
        last_emergency_timestamp: u64,
        emergency_admin: address,
        emergency_council: vector<address>,
        minimum_council_approval: u64,
        insurance_fund: 0x2::balance::Balance<0x2::sui::SUI>,
        total_insurance_claims: u64,
    }

    struct CircuitBreaker has key {
        id: 0x2::object::UID,
        price_volatility_breaker: bool,
        volume_spike_breaker: bool,
        liquidation_cascade_breaker: bool,
        daily_loss_limit: u64,
        current_daily_loss: u64,
        last_reset_timestamp: u64,
        trigger_count: u64,
        cooldown_period: u64,
    }

    struct RiskMetrics has key {
        id: 0x2::object::UID,
        system_tvl: u64,
        total_exposure: u64,
        concentration_risk: u64,
        liquidity_risk: u64,
        counterparty_risk: u64,
        market_risk: u64,
        operational_risk: u64,
        stress_test_results: 0x2::table::Table<u64, StressTestResult>,
        var_95: u64,
        expected_shortfall: u64,
        last_risk_assessment: u64,
        insurance_fund: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct StressTestResult has store {
        test_scenario: u8,
        projected_loss: u64,
        system_survival: bool,
        recommended_actions: vector<u8>,
        test_timestamp: u64,
    }

    struct RiskPosition has store, key {
        id: 0x2::object::UID,
        owner: address,
        gas_credits_exposure: u64,
        collateral_amount: u64,
        leverage_ratio: u64,
        health_factor: u64,
        liquidation_threshold: u64,
        risk_score: u64,
        last_update: u64,
        margin_call_level: u64,
        auto_liquidation_enabled: bool,
    }

    struct EmergencyProtocol has key {
        id: 0x2::object::UID,
        protocol_type: u8,
        trigger_conditions: vector<u64>,
        auto_trigger_enabled: bool,
        manual_override: bool,
        activation_timestamp: u64,
        estimated_duration: u64,
        affected_users: vector<address>,
        compensation_pool: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct InsuranceClaim has store, key {
        id: 0x2::object::UID,
        claimant: address,
        claim_amount: u64,
        incident_type: u8,
        incident_timestamp: u64,
        claim_timestamp: u64,
        status: u8,
        evidence_hash: vector<u8>,
        assessor: address,
        payout_amount: u64,
    }

    struct EmergencyActivated has copy, drop {
        trigger_reason: vector<u8>,
        trigger_timestamp: u64,
        estimated_resolution_time: u64,
        affected_systems: vector<u8>,
    }

    struct CircuitBreakerTriggered has copy, drop {
        breaker_type: u8,
        trigger_value: u64,
        threshold: u64,
        trigger_timestamp: u64,
        estimated_cooldown: u64,
    }

    struct RiskAssessmentUpdated has copy, drop {
        system_risk_level: u8,
        total_exposure: u64,
        var_95: u64,
        recommendations: vector<u8>,
        assessment_timestamp: u64,
    }

    struct LiquidationTriggered has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        liquidated_amount: u64,
        remaining_collateral: u64,
        liquidation_penalty: u64,
        liquidator: address,
    }

    struct InsuranceClaimFiled has copy, drop {
        claim_id: 0x2::object::ID,
        claimant: address,
        claim_amount: u64,
        incident_type: u8,
        filed_timestamp: u64,
    }

    public entry fun activate_emergency_mode(arg0: &mut EmergencySystem, arg1: &mut CircuitBreaker, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.emergency_admin == 0x2::tx_context::sender(arg5), 4);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg0.emergency_mode = true;
        arg0.last_emergency_timestamp = v0;
        arg1.price_volatility_breaker = true;
        arg1.volume_spike_breaker = true;
        arg1.liquidation_cascade_breaker = true;
        let v1 = EmergencyActivated{
            trigger_reason            : arg2,
            trigger_timestamp         : v0,
            estimated_resolution_time : v0 + arg3,
            affected_systems          : b"all_systems",
        };
        0x2::event::emit<EmergencyActivated>(v1);
    }

    fun calculate_expected_shortfall(arg0: u64) : u64 {
        arg0 * 130 / 100
    }

    fun calculate_health_factor(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 == 0) {
            return 10000
        };
        let v0 = arg0 * arg2 / 10000;
        if (arg1 >= v0) {
            arg1 * 10000 / v0
        } else {
            arg1 * 10000 / v0
        }
    }

    fun calculate_risk_score(arg0: u64, arg1: u64) : u64 {
        let v0 = if (arg0 > 500) {
            5000
        } else if (arg0 > 300) {
            3000
        } else if (arg0 > 200) {
            2000
        } else {
            1000
        };
        let v1 = if (arg1 < 8000) {
            5000
        } else if (arg1 < 9000) {
            3000
        } else if (arg1 < 9500) {
            2000
        } else {
            1000
        };
        v0 + v1
    }

    fun calculate_system_risk_level(arg0: &RiskMetrics) : u8 {
        let v0 = 0;
        let v1 = v0;
        if (arg0.market_risk > 1500) {
            v1 = v0 + 1;
        };
        if (arg0.liquidity_risk >= (3 as u64)) {
            v1 = v1 + 1;
        };
        if (arg0.concentration_risk > 5000) {
            v1 = v1 + 1;
        };
        if (arg0.counterparty_risk > 3000) {
            v1 = v1 + 1;
        };
        if (v1 >= 3) {
            4
        } else if (v1 >= 2) {
            3
        } else if (v1 >= 1) {
            2
        } else {
            1
        }
    }

    fun calculate_var_95(arg0: u64, arg1: u64) : u64 {
        if (arg1 > 1000) {
            arg0 * 1000 / 100 * 150 / 100
        } else {
            arg0 * 1000 / 100
        }
    }

    public entry fun check_circuit_breakers(arg0: &mut EmergencySystem, arg1: &mut CircuitBreaker, arg2: &mut RiskMetrics, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        if (arg1.price_volatility_breaker && arg3 > 2000) {
            trigger_circuit_breaker(arg0, arg1, 1, arg3, v0);
        };
        if (arg1.volume_spike_breaker && arg4 > 5000) {
            trigger_circuit_breaker(arg0, arg1, 2, arg4, v0);
        };
        if (arg1.liquidation_cascade_breaker && arg5 > 1000) {
            trigger_circuit_breaker(arg0, arg1, 3, arg5, v0);
        };
        update_risk_metrics(arg2, arg3, arg4, arg5, v0);
    }

    public entry fun create_risk_position(arg0: u64, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = calculate_health_factor(arg0, v0, arg2);
        let v2 = RiskPosition{
            id                       : 0x2::object::new(arg5),
            owner                    : 0x2::tx_context::sender(arg5),
            gas_credits_exposure     : arg0,
            collateral_amount        : v0,
            leverage_ratio           : arg2,
            health_factor            : v1,
            liquidation_threshold    : 8000,
            risk_score               : calculate_risk_score(arg2, v1),
            last_update              : 0x2::clock::timestamp_ms(arg4),
            margin_call_level        : 9000,
            auto_liquidation_enabled : arg3,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0x0);
        0x2::transfer::transfer<RiskPosition>(v2, 0x2::tx_context::sender(arg5));
    }

    public entry fun file_insurance_claim(arg0: &mut EmergencySystem, arg1: u64, arg2: u8, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = InsuranceClaim{
            id                 : 0x2::object::new(arg5),
            claimant           : 0x2::tx_context::sender(arg5),
            claim_amount       : arg1,
            incident_type      : arg2,
            incident_timestamp : v0 - 86400000,
            claim_timestamp    : v0,
            status             : 1,
            evidence_hash      : arg3,
            assessor           : arg0.emergency_admin,
            payout_amount      : 0,
        };
        arg0.total_insurance_claims = arg0.total_insurance_claims + 1;
        let v2 = InsuranceClaimFiled{
            claim_id        : 0x2::object::uid_to_inner(&v1.id),
            claimant        : 0x2::tx_context::sender(arg5),
            claim_amount    : arg1,
            incident_type   : arg2,
            filed_timestamp : v0,
        };
        0x2::event::emit<InsuranceClaimFiled>(v2);
        0x2::transfer::transfer<InsuranceClaim>(v1, 0x2::tx_context::sender(arg5));
    }

    public fun get_circuit_breaker_status(arg0: &CircuitBreaker) : (bool, bool, bool, u64) {
        (arg0.price_volatility_breaker, arg0.volume_spike_breaker, arg0.liquidation_cascade_breaker, arg0.trigger_count)
    }

    public fun get_emergency_status(arg0: &EmergencySystem) : (bool, bool, bool, u64) {
        (arg0.emergency_mode, arg0.system_paused, arg0.circuit_breakers_active, arg0.last_emergency_timestamp)
    }

    public fun get_position_health(arg0: &RiskPosition) : (u64, u64, u64, bool) {
        (arg0.health_factor, arg0.risk_score, arg0.liquidation_threshold, arg0.auto_liquidation_enabled)
    }

    public fun get_risk_metrics(arg0: &RiskMetrics) : (u64, u64, u64, u64, u64) {
        (arg0.total_exposure, arg0.var_95, arg0.expected_shortfall, arg0.market_risk, arg0.last_risk_assessment)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = EmergencySystem{
            id                       : 0x2::object::new(arg0),
            emergency_mode           : false,
            system_paused            : false,
            circuit_breakers_active  : true,
            last_emergency_timestamp : 0,
            emergency_admin          : 0x2::tx_context::sender(arg0),
            emergency_council        : 0x1::vector::empty<address>(),
            minimum_council_approval : 3,
            insurance_fund           : 0x2::balance::zero<0x2::sui::SUI>(),
            total_insurance_claims   : 0,
        };
        let v1 = CircuitBreaker{
            id                          : 0x2::object::new(arg0),
            price_volatility_breaker    : true,
            volume_spike_breaker        : true,
            liquidation_cascade_breaker : true,
            daily_loss_limit            : 1000000000,
            current_daily_loss          : 0,
            last_reset_timestamp        : 0,
            trigger_count               : 0,
            cooldown_period             : 3600000,
        };
        let v2 = RiskMetrics{
            id                   : 0x2::object::new(arg0),
            system_tvl           : 0,
            total_exposure       : 0,
            concentration_risk   : 0,
            liquidity_risk       : 0,
            counterparty_risk    : 0,
            market_risk          : 0,
            operational_risk     : 0,
            stress_test_results  : 0x2::table::new<u64, StressTestResult>(arg0),
            var_95               : 0,
            expected_shortfall   : 0,
            last_risk_assessment : 0,
            insurance_fund       : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<EmergencySystem>(v0);
        0x2::transfer::share_object<CircuitBreaker>(v1);
        0x2::transfer::share_object<RiskMetrics>(v2);
    }

    public entry fun run_stress_test(arg0: &mut RiskMetrics, arg1: u8, arg2: vector<u64>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = if (arg1 == 1) {
            arg0.total_exposure * 2000 / 10000
        } else if (arg1 == 2) {
            arg0.total_exposure * 1500 / 10000
        } else {
            arg0.total_exposure * 3000 / 10000
        };
        let v2 = v1 < 0x2::balance::value<0x2::sui::SUI>(&arg0.insurance_fund);
        let v3 = if (v2) {
            b"continue_operations"
        } else {
            b"emergency_protocols"
        };
        let v4 = StressTestResult{
            test_scenario       : arg1,
            projected_loss      : v1,
            system_survival     : v2,
            recommended_actions : v3,
            test_timestamp      : v0,
        };
        0x2::table::add<u64, StressTestResult>(&mut arg0.stress_test_results, v0, v4);
    }

    fun trigger_circuit_breaker(arg0: &mut EmergencySystem, arg1: &mut CircuitBreaker, arg2: u8, arg3: u64, arg4: u64) {
        arg1.trigger_count = arg1.trigger_count + 1;
        arg0.circuit_breakers_active = true;
        let v0 = if (arg2 == 1) {
            2000
        } else if (arg2 == 2) {
            5000
        } else {
            1000
        };
        let v1 = CircuitBreakerTriggered{
            breaker_type       : arg2,
            trigger_value      : arg3,
            threshold          : v0,
            trigger_timestamp  : arg4,
            estimated_cooldown : arg1.cooldown_period,
        };
        0x2::event::emit<CircuitBreakerTriggered>(v1);
    }

    public entry fun trigger_liquidation(arg0: &mut EmergencySystem, arg1: &mut RiskPosition, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_mode, 1);
        assert!(arg1.health_factor < arg1.liquidation_threshold, 6);
        let v0 = arg2 * 500 / 10000;
        arg1.gas_credits_exposure = arg1.gas_credits_exposure - arg2;
        arg1.collateral_amount = arg1.collateral_amount - v0;
        arg1.last_update = 0x2::clock::timestamp_ms(arg3);
        arg1.health_factor = calculate_health_factor(arg1.gas_credits_exposure, arg1.collateral_amount, arg1.leverage_ratio);
        let v1 = LiquidationTriggered{
            position_id          : 0x2::object::uid_to_inner(&arg1.id),
            owner                : arg1.owner,
            liquidated_amount    : arg2,
            remaining_collateral : arg1.collateral_amount,
            liquidation_penalty  : v0,
            liquidator           : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<LiquidationTriggered>(v1);
    }

    fun update_risk_metrics(arg0: &mut RiskMetrics, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        arg0.var_95 = calculate_var_95(arg1, arg2);
        arg0.expected_shortfall = calculate_expected_shortfall(arg0.var_95);
        arg0.market_risk = arg1;
        let v0 = if (arg2 > 1000) {
            (3 as u64)
        } else if (arg2 > 500) {
            (2 as u64)
        } else {
            (1 as u64)
        };
        arg0.liquidity_risk = v0;
        arg0.last_risk_assessment = arg4;
        let v1 = RiskAssessmentUpdated{
            system_risk_level    : calculate_system_risk_level(arg0),
            total_exposure       : arg0.total_exposure,
            var_95               : arg0.var_95,
            recommendations      : b"monitor_closely",
            assessment_timestamp : arg4,
        };
        0x2::event::emit<RiskAssessmentUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

