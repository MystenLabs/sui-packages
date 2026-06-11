module 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::circuit_breaker {
    struct Rule has copy, drop, store {
        id: u64,
        primitive: u8,
        metric: u8,
        operator: u8,
        threshold: u64,
        action: u8,
        enabled: bool,
    }

    struct MetricValue has copy, drop, store {
        metric: u8,
        value: u64,
    }

    struct Violation has copy, drop, store {
        rule_id: u64,
        metric: u8,
        operator: u8,
        threshold: u64,
        actual: u64,
        action: u8,
    }

    struct EvaluationReport has copy, drop, store {
        primitive: u8,
        evaluated_rule_count: u64,
        violations: vector<Violation>,
    }

    struct CircuitBreaker has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
        owner: address,
        paused: bool,
        rules: vector<Rule>,
    }

    struct CircuitBreakerCap has store, key {
        id: 0x2::object::UID,
        circuit_breaker_id: 0x2::object::ID,
        owner: address,
    }

    struct CircuitBreakerCreated has copy, drop {
        circuit_breaker_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        owner: address,
    }

    struct CircuitBreakerUpdated has copy, drop {
        circuit_breaker_id: 0x2::object::ID,
        field: vector<u8>,
        rule_count: u64,
    }

    public fun id(arg0: &CircuitBreaker) : 0x2::object::ID {
        0x2::object::id<CircuitBreaker>(arg0)
    }

    public fun action_block() : u8 {
        1
    }

    public fun action_require_approval() : u8 {
        2
    }

    public fun add_borrow_template(arg0: &mut CircuitBreaker, arg1: &CircuitBreakerCap, arg2: u64, arg3: u64) {
        add_rule(arg0, arg1, new_rule(2001, 2, 4, 1, arg2, 1));
        add_rule(arg0, arg1, new_rule(2002, 2, 3, 3, arg3, 2));
    }

    public fun add_liquidation_template(arg0: &mut CircuitBreaker, arg1: &CircuitBreakerCap, arg2: u64, arg3: u64) {
        add_rule(arg0, arg1, new_rule(4001, 4, 5, 1, arg2, 1));
        add_rule(arg0, arg1, new_rule(4002, 4, 2, 1, arg3, 2));
    }

    public fun add_rule(arg0: &mut CircuitBreaker, arg1: &CircuitBreakerCap, arg2: Rule) {
        assert_cap(arg0, arg1);
        assert!(0x1::vector::length<Rule>(&arg0.rules) < 64, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_too_many_rules());
        assert!(!contains_rule_id(&arg0.rules, arg2.id), 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_duplicate_rule());
        0x1::vector::push_back<Rule>(&mut arg0.rules, arg2);
        emit_update(arg0, b"rules");
    }

    public fun add_stake_template(arg0: &mut CircuitBreaker, arg1: &CircuitBreakerCap, arg2: u64, arg3: u64) {
        add_rule(arg0, arg1, new_rule(3001, 3, 6, 1, arg2, 1));
        add_rule(arg0, arg1, new_rule(3002, 3, 2, 1, arg3, 2));
    }

    public fun add_swap_template(arg0: &mut CircuitBreaker, arg1: &CircuitBreakerCap, arg2: u64, arg3: u64, arg4: u64) {
        add_rule(arg0, arg1, new_rule(1001, 1, 1, 1, arg2, 1));
        add_rule(arg0, arg1, new_rule(1002, 1, 2, 1, arg3, 2));
        add_rule(arg0, arg1, new_rule(1003, 1, 3, 3, arg4, 1));
    }

    fun assert_cap(arg0: &CircuitBreaker, arg1: &CircuitBreakerCap) {
        assert!(arg1.circuit_breaker_id == 0x2::object::id<CircuitBreaker>(arg0), 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_circuit_breaker_policy_mismatch());
        assert!(arg1.owner == arg0.owner, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_not_authorized());
    }

    public fun assert_policy(arg0: &CircuitBreaker, arg1: &0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::Policy) {
        assert!(arg0.policy_id == 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::id(arg1), 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_circuit_breaker_policy_mismatch());
    }

    public fun assert_rules(arg0: &CircuitBreaker, arg1: u8, arg2: &vector<MetricValue>, arg3: bool) {
        let v0 = evaluate_rules(arg0, arg1, arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Violation>(&v0.violations)) {
            if (0x1::vector::borrow<Violation>(&v0.violations, v1).action == 1) {
                abort 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_circuit_breaker_rule_violated()
            };
            assert!(arg3, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_circuit_breaker_approval_required());
            v1 = v1 + 1;
        };
    }

    fun assert_unique_metrics(arg0: &vector<MetricValue>) {
        let v0 = 0;
        let v1 = 0x1::vector::length<MetricValue>(arg0);
        while (v0 < v1) {
            let v2 = 0x1::vector::borrow<MetricValue>(arg0, v0).metric;
            assert_valid_metric(v2);
            let v3 = v0 + 1;
            while (v3 < v1) {
                assert!(0x1::vector::borrow<MetricValue>(arg0, v3).metric != v2, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_duplicate_metric());
                v3 = v3 + 1;
            };
            v0 = v0 + 1;
        };
    }

    fun assert_valid_metric(arg0: u8) {
        let v0 = if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else if (arg0 == 5) {
            true
        } else {
            arg0 == 6
        };
        assert!(v0, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_invalid_circuit_breaker_rule());
    }

    fun assert_valid_primitive(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else {
            arg0 == 4
        };
        assert!(v0, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_invalid_circuit_breaker_rule());
    }

    fun assert_valid_rule_fields(arg0: u8, arg1: u8, arg2: u8, arg3: u8) {
        assert_valid_primitive(arg0);
        assert_valid_metric(arg1);
        let v0 = if (arg2 == 1) {
            true
        } else if (arg2 == 2) {
            true
        } else if (arg2 == 3) {
            true
        } else {
            arg2 == 4
        };
        assert!(v0, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_invalid_circuit_breaker_rule());
        assert!(arg3 == 1 || arg3 == 2, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_invalid_circuit_breaker_rule());
    }

    fun contains_rule_id(arg0: &vector<Rule>, arg1: u64) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Rule>(arg0)) {
            if (0x1::vector::borrow<Rule>(arg0, v0).id == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun create(arg0: &0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::Policy, arg1: &0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::PolicyCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::assert_cap(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        let (v1, v2) = new_circuit_breaker(0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::id(arg0), v0, arg2);
        let v3 = v1;
        let v4 = CircuitBreakerCreated{
            circuit_breaker_id : 0x2::object::id<CircuitBreaker>(&v3),
            policy_id          : 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::id(arg0),
            owner              : v0,
        };
        0x2::event::emit<CircuitBreakerCreated>(v4);
        0x2::transfer::public_transfer<CircuitBreaker>(v3, v0);
        0x2::transfer::public_transfer<CircuitBreakerCap>(v2, v0);
    }

    fun emit_update(arg0: &CircuitBreaker, arg1: vector<u8>) {
        let v0 = CircuitBreakerUpdated{
            circuit_breaker_id : 0x2::object::id<CircuitBreaker>(arg0),
            field              : arg1,
            rule_count         : 0x1::vector::length<Rule>(&arg0.rules),
        };
        0x2::event::emit<CircuitBreakerUpdated>(v0);
    }

    public fun evaluate_rules(arg0: &CircuitBreaker, arg1: u8, arg2: &vector<MetricValue>) : EvaluationReport {
        assert!(!arg0.paused, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_circuit_breaker_paused());
        assert_valid_primitive(arg1);
        assert_unique_metrics(arg2);
        let v0 = 0;
        let v1 = 0x1::vector::empty<Violation>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<Rule>(&arg0.rules)) {
            let v3 = 0x1::vector::borrow<Rule>(&arg0.rules, v2);
            if (v3.enabled && (v3.primitive == 0 || v3.primitive == arg1)) {
                let v4 = find_metric(arg2, v3.metric);
                v0 = v0 + 1;
                if (is_triggered(v4, v3.operator, v3.threshold)) {
                    let v5 = Violation{
                        rule_id   : v3.id,
                        metric    : v3.metric,
                        operator  : v3.operator,
                        threshold : v3.threshold,
                        actual    : v4,
                        action    : v3.action,
                    };
                    0x1::vector::push_back<Violation>(&mut v1, v5);
                };
            };
            v2 = v2 + 1;
        };
        EvaluationReport{
            primitive            : arg1,
            evaluated_rule_count : v0,
            violations           : v1,
        }
    }

    public fun evaluated_rule_count(arg0: &EvaluationReport) : u64 {
        arg0.evaluated_rule_count
    }

    fun find_metric(arg0: &vector<MetricValue>, arg1: u8) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<MetricValue>(arg0)) {
            let v1 = 0x1::vector::borrow<MetricValue>(arg0, v0);
            if (v1.metric == arg1) {
                return v1.value
            };
            v0 = v0 + 1;
        };
        abort 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_circuit_breaker_metric_missing()
    }

    public fun has_blocking_violation(arg0: &EvaluationReport) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Violation>(&arg0.violations)) {
            if (0x1::vector::borrow<Violation>(&arg0.violations, v0).action == 1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_paused(arg0: &CircuitBreaker) : bool {
        arg0.paused
    }

    fun is_triggered(arg0: u64, arg1: u8, arg2: u64) : bool {
        if (arg1 == 1) {
            return arg0 > arg2
        };
        if (arg1 == 2) {
            return arg0 >= arg2
        };
        if (arg1 == 3) {
            return arg0 < arg2
        };
        arg0 <= arg2
    }

    public fun metric_liquidation_amount_usd() : u8 {
        5
    }

    public fun metric_liquidity_usd() : u8 {
        3
    }

    public fun metric_ltv_bps() : u8 {
        4
    }

    public fun metric_price_deviation_bps() : u8 {
        2
    }

    public fun metric_slippage_bps() : u8 {
        1
    }

    public fun metric_validator_concentration_bps() : u8 {
        6
    }

    fun new_circuit_breaker(arg0: 0x2::object::ID, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (CircuitBreaker, CircuitBreakerCap) {
        let v0 = CircuitBreaker{
            id        : 0x2::object::new(arg2),
            policy_id : arg0,
            owner     : arg1,
            paused    : false,
            rules     : 0x1::vector::empty<Rule>(),
        };
        let v1 = CircuitBreakerCap{
            id                 : 0x2::object::new(arg2),
            circuit_breaker_id : 0x2::object::id<CircuitBreaker>(&v0),
            owner              : arg1,
        };
        (v0, v1)
    }

    public fun new_metric(arg0: u8, arg1: u64) : MetricValue {
        assert_valid_metric(arg0);
        MetricValue{
            metric : arg0,
            value  : arg1,
        }
    }

    public fun new_rule(arg0: u64, arg1: u8, arg2: u8, arg3: u8, arg4: u64, arg5: u8) : Rule {
        assert_valid_rule_fields(arg1, arg2, arg3, arg5);
        Rule{
            id        : arg0,
            primitive : arg1,
            metric    : arg2,
            operator  : arg3,
            threshold : arg4,
            action    : arg5,
            enabled   : true,
        }
    }

    public fun operator_gt() : u8 {
        1
    }

    public fun operator_gte() : u8 {
        2
    }

    public fun operator_lt() : u8 {
        3
    }

    public fun operator_lte() : u8 {
        4
    }

    public fun policy_id(arg0: &CircuitBreaker) : 0x2::object::ID {
        arg0.policy_id
    }

    public fun primitive_any() : u8 {
        0
    }

    public fun primitive_borrow() : u8 {
        2
    }

    public fun primitive_liquidation() : u8 {
        4
    }

    public fun primitive_stake() : u8 {
        3
    }

    public fun primitive_swap() : u8 {
        1
    }

    public fun remove_rule(arg0: &mut CircuitBreaker, arg1: &CircuitBreakerCap, arg2: u64) {
        assert_cap(arg0, arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<Rule>(&arg0.rules)) {
            if (0x1::vector::borrow<Rule>(&arg0.rules, v0).id == arg2) {
                0x1::vector::remove<Rule>(&mut arg0.rules, v0);
                emit_update(arg0, b"rules");
                return
            };
            v0 = v0 + 1;
        };
        abort 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_rule_not_found()
    }

    public fun replace_rule(arg0: &mut CircuitBreaker, arg1: &CircuitBreakerCap, arg2: Rule) {
        assert_cap(arg0, arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<Rule>(&arg0.rules)) {
            if (0x1::vector::borrow<Rule>(&arg0.rules, v0).id == arg2.id) {
                *0x1::vector::borrow_mut<Rule>(&mut arg0.rules, v0) = arg2;
                emit_update(arg0, b"rules");
                return
            };
            v0 = v0 + 1;
        };
        abort 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_rule_not_found()
    }

    public fun requires_approval(arg0: &EvaluationReport) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Violation>(&arg0.violations)) {
            if (0x1::vector::borrow<Violation>(&arg0.violations, v0).action == 2) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun rule_count(arg0: &CircuitBreaker) : u64 {
        0x1::vector::length<Rule>(&arg0.rules)
    }

    public fun set_paused(arg0: &mut CircuitBreaker, arg1: &CircuitBreakerCap, arg2: bool) {
        assert_cap(arg0, arg1);
        arg0.paused = arg2;
        emit_update(arg0, b"paused");
    }

    public fun set_rule_enabled(arg0: &mut CircuitBreaker, arg1: &CircuitBreakerCap, arg2: u64, arg3: bool) {
        assert_cap(arg0, arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<Rule>(&arg0.rules)) {
            let v1 = 0x1::vector::borrow_mut<Rule>(&mut arg0.rules, v0);
            if (v1.id == arg2) {
                v1.enabled = arg3;
                emit_update(arg0, b"rules");
                return
            };
            v0 = v0 + 1;
        };
        abort 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_rule_not_found()
    }

    public fun violation_action(arg0: &Violation) : u8 {
        arg0.action
    }

    public fun violation_actual(arg0: &Violation) : u64 {
        arg0.actual
    }

    public fun violation_at(arg0: &EvaluationReport, arg1: u64) : Violation {
        *0x1::vector::borrow<Violation>(&arg0.violations, arg1)
    }

    public fun violation_count(arg0: &EvaluationReport) : u64 {
        0x1::vector::length<Violation>(&arg0.violations)
    }

    public fun violation_metric(arg0: &Violation) : u8 {
        arg0.metric
    }

    public fun violation_operator(arg0: &Violation) : u8 {
        arg0.operator
    }

    public fun violation_rule_id(arg0: &Violation) : u64 {
        arg0.rule_id
    }

    public fun violation_threshold(arg0: &Violation) : u64 {
        arg0.threshold
    }

    // decompiled from Move bytecode v7
}

