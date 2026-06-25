module 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::risk_engine {
    struct EscalationTier has copy, drop, store {
        threshold_bps: u64,
        margin_multiplier_bps: u64,
    }

    struct MarketRiskParams has copy, drop, store {
        symbol: vector<u8>,
        max_leverage: u64,
        initial_margin_ratio_bps: u64,
        maintenance_margin_ratio_bps: u64,
        escalation_tiers: vector<EscalationTier>,
    }

    struct RiskRegistry has key {
        id: 0x2::object::UID,
        params: 0x2::table::Table<vector<u8>, MarketRiskParams>,
        market_count: u64,
    }

    struct MarginCheckResult has copy, drop, store {
        base_initial_margin: u64,
        escalated_initial_margin: u64,
        base_maintenance_margin: u64,
        escalated_maintenance_margin: u64,
        oi_utilization_bps: u64,
        applied_multiplier_bps: u64,
        meets_initial_margin: bool,
        meets_maintenance_margin: bool,
    }

    struct MarketRiskRegistered has copy, drop {
        symbol: vector<u8>,
        max_leverage: u64,
        initial_margin_ratio_bps: u64,
        maintenance_margin_ratio_bps: u64,
        tier_count: u64,
    }

    struct MarketRiskUpdated has copy, drop {
        symbol: vector<u8>,
        max_leverage: u64,
        initial_margin_ratio_bps: u64,
        maintenance_margin_ratio_bps: u64,
    }

    struct EscalationTiersUpdated has copy, drop {
        symbol: vector<u8>,
        tier_count: u64,
    }

    struct LeverageRejected has copy, drop {
        symbol: vector<u8>,
        requested_leverage_x10000: u64,
        max_leverage: u64,
    }

    struct MarginEscalated has copy, drop {
        symbol: vector<u8>,
        oi_utilization_bps: u64,
        applied_multiplier_bps: u64,
        escalated_initial_margin: u64,
    }

    fun apply_multiplier(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun borrow_params(arg0: &RiskRegistry, arg1: vector<u8>) : &MarketRiskParams {
        assert!(0x2::table::contains<vector<u8>, MarketRiskParams>(&arg0.params, arg1), 1);
        0x2::table::borrow<vector<u8>, MarketRiskParams>(&arg0.params, arg1)
    }

    fun build_escalation_tiers(arg0: vector<u64>, arg1: vector<u64>) : vector<EscalationTier> {
        let v0 = 0x1::vector::length<u64>(&arg0);
        assert!(v0 == 0x1::vector::length<u64>(&arg1), 7);
        let v1 = 0x1::vector::empty<EscalationTier>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg0, v2);
            let v4 = *0x1::vector::borrow<u64>(&arg1, v2);
            assert!(v3 > 0 && v3 <= 10000, 8);
            if (v2 > 0) {
                assert!(v3 > 0, 7);
            };
            assert!(v4 >= 10000, 9);
            if (v2 > 0) {
                assert!(v4 > 0, 13);
            };
            let v5 = EscalationTier{
                threshold_bps         : v3,
                margin_multiplier_bps : v4,
            };
            0x1::vector::push_back<EscalationTier>(&mut v1, v5);
            v2 = v2 + 1;
        };
        v1
    }

    public fun check_applied_multiplier_bps(arg0: &MarginCheckResult) : u64 {
        arg0.applied_multiplier_bps
    }

    public fun check_base_initial_margin(arg0: &MarginCheckResult) : u64 {
        arg0.base_initial_margin
    }

    public fun check_base_maintenance_margin(arg0: &MarginCheckResult) : u64 {
        arg0.base_maintenance_margin
    }

    public fun check_escalated_initial_margin(arg0: &MarginCheckResult) : u64 {
        arg0.escalated_initial_margin
    }

    public fun check_escalated_maintenance_margin(arg0: &MarginCheckResult) : u64 {
        arg0.escalated_maintenance_margin
    }

    public fun check_meets_initial_margin(arg0: &MarginCheckResult) : bool {
        arg0.meets_initial_margin
    }

    public fun check_meets_maintenance_margin(arg0: &MarginCheckResult) : bool {
        arg0.meets_maintenance_margin
    }

    public fun check_oi_utilization_bps(arg0: &MarginCheckResult) : u64 {
        arg0.oi_utilization_bps
    }

    public fun compute_effective_initial_margin_bps(arg0: &RiskRegistry, arg1: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::MarketRegistry, arg2: vector<u8>) : u64 {
        assert!(0x2::table::contains<vector<u8>, MarketRiskParams>(&arg0.params, arg2), 1);
        let v0 = 0x2::table::borrow<vector<u8>, MarketRiskParams>(&arg0.params, arg2);
        apply_multiplier(v0.initial_margin_ratio_bps, get_oi_multiplier(v0, arg1, arg2))
    }

    public fun compute_effective_maintenance_margin_bps(arg0: &RiskRegistry, arg1: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::MarketRegistry, arg2: vector<u8>) : u64 {
        assert!(0x2::table::contains<vector<u8>, MarketRiskParams>(&arg0.params, arg2), 1);
        let v0 = 0x2::table::borrow<vector<u8>, MarketRiskParams>(&arg0.params, arg2);
        apply_multiplier(v0.maintenance_margin_ratio_bps, get_oi_multiplier(v0, arg1, arg2))
    }

    public fun compute_margin_check(arg0: &RiskRegistry, arg1: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::MarketRegistry, arg2: vector<u8>, arg3: u64, arg4: u64) : MarginCheckResult {
        assert!(0x2::table::contains<vector<u8>, MarketRiskParams>(&arg0.params, arg2), 1);
        let v0 = 0x2::table::borrow<vector<u8>, MarketRiskParams>(&arg0.params, arg2);
        let v1 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_calculator::compute_initial_margin(arg3, v0.initial_margin_ratio_bps);
        let v2 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_calculator::compute_maintenance_margin(arg3, v0.maintenance_margin_ratio_bps);
        let v3 = compute_oi_utilization_bps(arg1, arg2);
        let v4 = find_applicable_multiplier(&v0.escalation_tiers, v3);
        let v5 = apply_multiplier(v1, v4);
        let v6 = apply_multiplier(v2, v4);
        MarginCheckResult{
            base_initial_margin          : v1,
            escalated_initial_margin     : v5,
            base_maintenance_margin      : v2,
            escalated_maintenance_margin : v6,
            oi_utilization_bps           : v3,
            applied_multiplier_bps       : v4,
            meets_initial_margin         : arg4 >= v5,
            meets_maintenance_margin     : arg4 >= v6,
        }
    }

    public fun compute_oi_utilization_bps(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::MarketRegistry, arg1: vector<u8>) : u64 {
        let v0 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::borrow_market(arg0, arg1);
        let v1 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::market_total_oi_cap(v0);
        if (v1 == 0) {
            return 0
        };
        (((0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::market_total_oi(v0) as u128) * (10000 as u128) / (v1 as u128)) as u64)
    }

    fun find_applicable_multiplier(arg0: &vector<EscalationTier>, arg1: u64) : u64 {
        let v0 = 0x1::vector::length<EscalationTier>(arg0);
        if (v0 == 0) {
            return 10000
        };
        while (v0 > 0) {
            let v1 = v0 - 1;
            v0 = v1;
            if (arg1 >= 0x1::vector::borrow<EscalationTier>(arg0, v1).threshold_bps) {
                return 0x1::vector::borrow<EscalationTier>(arg0, v1).margin_multiplier_bps
            };
        };
        10000
    }

    fun get_oi_multiplier(arg0: &MarketRiskParams, arg1: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::MarketRegistry, arg2: vector<u8>) : u64 {
        find_applicable_multiplier(&arg0.escalation_tiers, compute_oi_utilization_bps(arg1, arg2))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RiskRegistry{
            id           : 0x2::object::new(arg0),
            params       : 0x2::table::new<vector<u8>, MarketRiskParams>(arg0),
            market_count : 0,
        };
        0x2::transfer::share_object<RiskRegistry>(v0);
    }

    public fun is_registered(arg0: &RiskRegistry, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, MarketRiskParams>(&arg0.params, arg1)
    }

    public fun market_count(arg0: &RiskRegistry) : u64 {
        arg0.market_count
    }

    public fun params_initial_margin_ratio_bps(arg0: &MarketRiskParams) : u64 {
        arg0.initial_margin_ratio_bps
    }

    public fun params_maintenance_margin_ratio_bps(arg0: &MarketRiskParams) : u64 {
        arg0.maintenance_margin_ratio_bps
    }

    public fun params_max_leverage(arg0: &MarketRiskParams) : u64 {
        arg0.max_leverage
    }

    public fun params_symbol(arg0: &MarketRiskParams) : vector<u8> {
        arg0.symbol
    }

    public fun params_tier_count(arg0: &MarketRiskParams) : u64 {
        0x1::vector::length<EscalationTier>(&arg0.escalation_tiers)
    }

    public fun params_tier_multiplier(arg0: &MarketRiskParams, arg1: u64) : u64 {
        0x1::vector::borrow<EscalationTier>(&arg0.escalation_tiers, arg1).margin_multiplier_bps
    }

    public fun params_tier_threshold(arg0: &MarketRiskParams, arg1: u64) : u64 {
        0x1::vector::borrow<EscalationTier>(&arg0.escalation_tiers, arg1).threshold_bps
    }

    public fun register_market_risk(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &mut RiskRegistry, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u64>, arg7: vector<u64>) {
        assert!(!0x2::table::contains<vector<u8>, MarketRiskParams>(&arg1.params, arg2), 0);
        assert!(arg3 >= 1, 2);
        assert!(arg3 <= 20, 3);
        assert!(arg4 > 0, 4);
        assert!(arg5 > 0, 5);
        assert!(arg4 >= arg5, 6);
        let v0 = build_escalation_tiers(arg6, arg7);
        let v1 = MarketRiskParams{
            symbol                       : arg2,
            max_leverage                 : arg3,
            initial_margin_ratio_bps     : arg4,
            maintenance_margin_ratio_bps : arg5,
            escalation_tiers             : v0,
        };
        0x2::table::add<vector<u8>, MarketRiskParams>(&mut arg1.params, arg2, v1);
        arg1.market_count = arg1.market_count + 1;
        let v2 = MarketRiskRegistered{
            symbol                       : arg2,
            max_leverage                 : arg3,
            initial_margin_ratio_bps     : arg4,
            maintenance_margin_ratio_bps : arg5,
            tier_count                   : 0x1::vector::length<EscalationTier>(&v0),
        };
        0x2::event::emit<MarketRiskRegistered>(v2);
    }

    public fun set_escalation_tiers(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &mut RiskRegistry, arg2: vector<u8>, arg3: vector<u64>, arg4: vector<u64>) {
        assert!(0x2::table::contains<vector<u8>, MarketRiskParams>(&arg1.params, arg2), 1);
        let v0 = build_escalation_tiers(arg3, arg4);
        0x2::table::borrow_mut<vector<u8>, MarketRiskParams>(&mut arg1.params, arg2).escalation_tiers = v0;
        let v1 = EscalationTiersUpdated{
            symbol     : arg2,
            tier_count : 0x1::vector::length<EscalationTier>(&v0),
        };
        0x2::event::emit<EscalationTiersUpdated>(v1);
    }

    public fun update_market_risk(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &mut RiskRegistry, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64) {
        assert!(0x2::table::contains<vector<u8>, MarketRiskParams>(&arg1.params, arg2), 1);
        assert!(arg3 >= 1, 2);
        assert!(arg3 <= 20, 3);
        assert!(arg4 > 0, 4);
        assert!(arg5 > 0, 5);
        assert!(arg4 >= arg5, 6);
        let v0 = 0x2::table::borrow_mut<vector<u8>, MarketRiskParams>(&mut arg1.params, arg2);
        v0.max_leverage = arg3;
        v0.initial_margin_ratio_bps = arg4;
        v0.maintenance_margin_ratio_bps = arg5;
        let v1 = MarketRiskUpdated{
            symbol                       : arg2,
            max_leverage                 : arg3,
            initial_margin_ratio_bps     : arg4,
            maintenance_margin_ratio_bps : arg5,
        };
        0x2::event::emit<MarketRiskUpdated>(v1);
    }

    public fun validate_initial_margin(arg0: &RiskRegistry, arg1: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::MarketRegistry, arg2: vector<u8>, arg3: u64, arg4: u64) {
        let v0 = compute_margin_check(arg0, arg1, arg2, arg3, arg4);
        if (!v0.meets_initial_margin) {
            let v1 = MarginEscalated{
                symbol                   : arg2,
                oi_utilization_bps       : v0.oi_utilization_bps,
                applied_multiplier_bps   : v0.applied_multiplier_bps,
                escalated_initial_margin : v0.escalated_initial_margin,
            };
            0x2::event::emit<MarginEscalated>(v1);
            abort 11
        };
    }

    public fun validate_leverage(arg0: &RiskRegistry, arg1: vector<u8>, arg2: u64, arg3: u64) {
        assert!(0x2::table::contains<vector<u8>, MarketRiskParams>(&arg0.params, arg1), 1);
        let v0 = 0x2::table::borrow<vector<u8>, MarketRiskParams>(&arg0.params, arg1);
        if ((arg2 as u128) > (arg3 as u128) * (v0.max_leverage as u128)) {
            let v1 = if (arg3 > 0) {
                (((arg2 as u128) * 10000 / (arg3 as u128)) as u64)
            } else {
                0
            };
            let v2 = LeverageRejected{
                symbol                    : arg1,
                requested_leverage_x10000 : v1,
                max_leverage              : v0.max_leverage,
            };
            0x2::event::emit<LeverageRejected>(v2);
            abort 10
        };
    }

    public fun validate_maintenance_margin(arg0: &RiskRegistry, arg1: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::MarketRegistry, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u64) {
        assert!(0x2::table::contains<vector<u8>, MarketRiskParams>(&arg0.params, arg2), 1);
        let v0 = 0x2::table::borrow<vector<u8>, MarketRiskParams>(&arg0.params, arg2);
        let v1 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_calculator::compute_account_equity(arg7, 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_calculator::compute_unrealized_pnl(arg3, arg4, arg5, arg6), arg8);
        assert!(0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_calculator::signed_is_negative(&v1) && false || 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_calculator::signed_value(&v1) >= apply_multiplier(0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_calculator::compute_maintenance_margin(0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::margin_calculator::compute_notional_value(arg3, arg5), v0.maintenance_margin_ratio_bps), get_oi_multiplier(v0, arg1, arg2)), 12);
    }

    public fun validate_position_change(arg0: &RiskRegistry, arg1: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::MarketRegistry, arg2: vector<u8>, arg3: u64, arg4: u64) {
        validate_leverage(arg0, arg2, arg3, arg4);
        validate_initial_margin(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

