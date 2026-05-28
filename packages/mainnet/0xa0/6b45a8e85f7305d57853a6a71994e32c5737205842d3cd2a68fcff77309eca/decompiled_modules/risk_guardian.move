module 0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::risk_guardian {
    struct RiskGuardianCap has store, key {
        id: 0x2::object::UID,
    }

    struct RiskScore has key {
        id: 0x2::object::UID,
        score: u64,
        oracle_risk: u64,
        utilization_risk: u64,
        anomaly_score: u64,
        concentration_risk: u64,
        depeg_risk: u64,
        last_updated_ms: u64,
        update_count: u64,
    }

    struct RiskPolicy has key {
        id: 0x2::object::UID,
        emergency_threshold: u64,
        warning_threshold: u64,
        elevated_threshold: u64,
        adjustment_cooldown_ms: u64,
        last_action_ms: u64,
        market_paused: bool,
        dao_override_active: bool,
    }

    struct RiskScoreUpdated has copy, drop {
        score: u64,
        oracle_risk: u64,
        utilization_risk: u64,
        anomaly_score: u64,
        concentration_risk: u64,
        depeg_risk: u64,
        timestamp_ms: u64,
    }

    struct RiskActionTaken has copy, drop {
        action_type: vector<u8>,
        risk_score: u64,
        description: vector<u8>,
        timestamp_ms: u64,
    }

    struct MarketPauseToggled has copy, drop {
        paused: bool,
        risk_score: u64,
        timestamp_ms: u64,
    }

    struct DAOOverride has copy, drop {
        action: vector<u8>,
        timestamp_ms: u64,
    }

    public fun assert_fresh(arg0: &RiskScore, arg1: &0x2::clock::Clock, arg2: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = if (v0 > arg0.last_updated_ms) {
            v0 - arg0.last_updated_ms
        } else {
            0
        };
        assert!(v1 <= arg2, 208);
    }

    public fun assert_operational(arg0: &RiskScore, arg1: &RiskPolicy, arg2: u64) {
        assert!(!arg1.market_paused, 207);
        assert!(arg0.score <= arg2, 206);
    }

    public fun assert_safe(arg0: &RiskScore, arg1: u64) {
        assert!(arg0.score <= arg1, 206);
    }

    public fun dao_clear_override(arg0: &0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::agent_policy::AdminCap, arg1: &mut RiskPolicy, arg2: &0x2::clock::Clock) {
        arg1.dao_override_active = false;
        let v0 = DAOOverride{
            action       : b"clear_override",
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DAOOverride>(v0);
    }

    public fun dao_set_cooldown(arg0: &0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::agent_policy::AdminCap, arg1: &mut RiskPolicy, arg2: u64) {
        arg1.adjustment_cooldown_ms = arg2;
    }

    public fun dao_set_thresholds(arg0: &0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::agent_policy::AdminCap, arg1: &mut RiskPolicy, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg2 <= 100, 202);
        assert!(arg3 <= arg2, 202);
        assert!(arg4 <= arg3, 202);
        arg1.emergency_threshold = arg2;
        arg1.warning_threshold = arg3;
        arg1.elevated_threshold = arg4;
    }

    public fun dao_unpause(arg0: &0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::agent_policy::AdminCap, arg1: &mut RiskPolicy, arg2: &0x2::clock::Clock) {
        assert!(arg1.market_paused, 205);
        arg1.market_paused = false;
        arg1.dao_override_active = true;
        let v0 = DAOOverride{
            action       : b"unpause",
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DAOOverride>(v0);
        let v1 = MarketPauseToggled{
            paused       : false,
            risk_score   : 0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<MarketPauseToggled>(v1);
    }

    public fun execute_emergency_pause(arg0: &RiskGuardianCap, arg1: &RiskScore, arg2: &mut RiskPolicy, arg3: &0x2::clock::Clock) {
        assert!(!arg2.market_paused, 204);
        assert!(arg1.score >= arg2.emergency_threshold, 203);
        assert!(!arg2.dao_override_active, 200);
        arg2.market_paused = true;
        arg2.last_action_ms = 0x2::clock::timestamp_ms(arg3);
        let v0 = MarketPauseToggled{
            paused       : true,
            risk_score   : arg1.score,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MarketPauseToggled>(v0);
    }

    public fun get_anomaly_score(arg0: &RiskScore) : u64 {
        arg0.anomaly_score
    }

    public fun get_concentration_risk(arg0: &RiskScore) : u64 {
        arg0.concentration_risk
    }

    public fun get_depeg_risk(arg0: &RiskScore) : u64 {
        arg0.depeg_risk
    }

    public fun get_emergency_threshold(arg0: &RiskPolicy) : u64 {
        arg0.emergency_threshold
    }

    public fun get_last_updated(arg0: &RiskScore) : u64 {
        arg0.last_updated_ms
    }

    public fun get_oracle_risk(arg0: &RiskScore) : u64 {
        arg0.oracle_risk
    }

    public fun get_risk_view(arg0: &RiskScore) : (u64, u64, u64, u64, u64, u64, u64) {
        (arg0.score, arg0.oracle_risk, arg0.utilization_risk, arg0.anomaly_score, arg0.concentration_risk, arg0.depeg_risk, arg0.last_updated_ms)
    }

    public fun get_score(arg0: &RiskScore) : u64 {
        arg0.score
    }

    public fun get_update_count(arg0: &RiskScore) : u64 {
        arg0.update_count
    }

    public fun get_utilization_risk(arg0: &RiskScore) : u64 {
        arg0.utilization_risk
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RiskGuardianCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<RiskGuardianCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = RiskScore{
            id                 : 0x2::object::new(arg0),
            score              : 0,
            oracle_risk        : 0,
            utilization_risk   : 0,
            anomaly_score      : 0,
            concentration_risk : 0,
            depeg_risk         : 0,
            last_updated_ms    : 0,
            update_count       : 0,
        };
        0x2::transfer::share_object<RiskScore>(v1);
        let v2 = RiskPolicy{
            id                     : 0x2::object::new(arg0),
            emergency_threshold    : 80,
            warning_threshold      : 60,
            elevated_threshold     : 30,
            adjustment_cooldown_ms : 30000,
            last_action_ms         : 0,
            market_paused          : false,
            dao_override_active    : false,
        };
        0x2::transfer::share_object<RiskPolicy>(v2);
    }

    public fun is_dao_override(arg0: &RiskPolicy) : bool {
        arg0.dao_override_active
    }

    public fun is_market_paused(arg0: &RiskPolicy) : bool {
        arg0.market_paused
    }

    public fun is_operational(arg0: &RiskScore, arg1: &RiskPolicy, arg2: u64) : bool {
        !arg1.market_paused && arg0.score <= arg2
    }

    public fun log_risk_action(arg0: &RiskGuardianCap, arg1: &mut RiskPolicy, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg5) >= arg1.last_action_ms + arg1.adjustment_cooldown_ms, 201);
        arg1.last_action_ms = 0x2::clock::timestamp_ms(arg5);
        let v0 = RiskActionTaken{
            action_type  : arg2,
            risk_score   : arg3,
            description  : arg4,
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<RiskActionTaken>(v0);
    }

    public fun update_risk_score(arg0: &RiskGuardianCap, arg1: &mut RiskScore, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) {
        let v0 = arg2 + arg3 + arg4 + arg5 + arg6;
        let v1 = if (v0 > 100) {
            100
        } else {
            v0
        };
        arg1.score = v1;
        arg1.oracle_risk = arg2;
        arg1.utilization_risk = arg3;
        arg1.anomaly_score = arg4;
        arg1.concentration_risk = arg5;
        arg1.depeg_risk = arg6;
        arg1.last_updated_ms = 0x2::clock::timestamp_ms(arg7);
        arg1.update_count = arg1.update_count + 1;
        let v2 = RiskScoreUpdated{
            score              : v1,
            oracle_risk        : arg2,
            utilization_risk   : arg3,
            anomaly_score      : arg4,
            concentration_risk : arg5,
            depeg_risk         : arg6,
            timestamp_ms       : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<RiskScoreUpdated>(v2);
    }

    // decompiled from Move bytecode v7
}

