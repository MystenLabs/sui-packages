module 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::aggregator {
    struct SourceRule has copy, drop, store {
        weight_bps: u16,
        required: bool,
        enabled: bool,
    }

    struct AggregatorCreatedEvent has copy, drop {
        aggregator_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        max_staleness_ms: u64,
        min_total_weight_bps: u64,
        min_source_count: u64,
        outlier_tolerance_bps: u64,
    }

    struct AggregatorPolicyUpdatedEvent has copy, drop {
        aggregator_id: 0x2::object::ID,
        enabled: bool,
        max_staleness_ms: u64,
        min_total_weight_bps: u64,
        min_source_count: u64,
        outlier_tolerance_bps: u64,
    }

    struct SourceRuleUpdatedEvent has copy, drop {
        aggregator_id: 0x2::object::ID,
        source_type: 0x1::type_name::TypeName,
        weight_bps: u16,
        required: bool,
        enabled: bool,
    }

    struct PriceAggregatedEvent has copy, drop {
        aggregator_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        source_count: u64,
        total_weight_bps: u64,
        sy_index: u128,
        updated_at: u64,
    }

    struct SourceRuleRemovedEvent has copy, drop {
        aggregator_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        source_type: 0x1::type_name::TypeName,
        weight_bps: u16,
        required: bool,
        enabled: bool,
    }

    struct PriceAggregator<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        enabled: bool,
        max_staleness_ms: u64,
        source_rules: 0x2::vec_map::VecMap<0x1::type_name::TypeName, SourceRule>,
        min_total_weight_bps: u64,
        min_source_count: u64,
        outlier_tolerance_bps: u64,
    }

    public fun add_source_rule_by_admin_cap<T0: drop, T1: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg2: &mut PriceAggregator<T0>, arg3: u16, arg4: bool, arg5: bool) {
        0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::package_version::assert_current(arg0);
        assert_valid_weight(arg3);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, SourceRule>(&arg2.source_rules, &v0), 963);
        let v1 = SourceRule{
            weight_bps : arg3,
            required   : arg4,
            enabled    : arg5,
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, SourceRule>(&mut arg2.source_rules, v0, v1);
        emit_source_rule_updated<T0>(arg2, v0);
    }

    public fun aggregate<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &PriceAggregator<T0>, arg2: &0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::collector::PriceCollector<T0>, arg3: &0x2::clock::Clock) : 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::PriceInfo<T0> {
        0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::package_version::assert_current(arg0);
        let v0 = arg1.market_id;
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg1.enabled, 959);
        assert!(0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::collector::market_id<T0>(arg2) == v0, 953);
        let v2 = 0x2::vec_map::keys<0x1::type_name::TypeName, SourceRule>(&arg1.source_rules);
        let v3 = 0x1::vector::length<0x1::type_name::TypeName>(&v2);
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        while (v6 < v3) {
            let v7 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v6);
            let v8 = *0x2::vec_map::get<0x1::type_name::TypeName, SourceRule>(&arg1.source_rules, &v7);
            if (v8.enabled) {
                if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::collector::SourceQuote>(0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::collector::contents<T0>(arg2), &v7)) {
                    assert!(!v8.required, 954);
                } else {
                    let v9 = 0x2::vec_map::get<0x1::type_name::TypeName, 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::collector::SourceQuote>(0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::collector::contents<T0>(arg2), &v7);
                    if (!quote_is_fresh(0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::collector::updated_at(v9), v1, arg1.max_staleness_ms)) {
                        assert!(!v8.required, 955);
                    } else {
                        v4 = v4 + (0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::collector::sy_index(v9) as u256) * (v8.weight_bps as u256);
                        v5 = v5 + (v8.weight_bps as u64);
                    };
                };
            };
            v6 = v6 + 1;
        };
        assert!(v5 >= arg1.min_total_weight_bps, 957);
        let v10 = 0;
        let v11 = 0;
        let v12 = 0;
        let v13 = v1;
        let v14 = false;
        let v15 = 0;
        while (v15 < v3) {
            let v16 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v15);
            let v17 = *0x2::vec_map::get<0x1::type_name::TypeName, SourceRule>(&arg1.source_rules, &v16);
            if (v17.enabled && 0x2::vec_map::contains<0x1::type_name::TypeName, 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::collector::SourceQuote>(0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::collector::contents<T0>(arg2), &v16)) {
                let v18 = 0x2::vec_map::get<0x1::type_name::TypeName, 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::collector::SourceQuote>(0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::collector::contents<T0>(arg2), &v16);
                let v19 = 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::collector::updated_at(v18);
                if (quote_is_fresh(v19, v1, arg1.max_staleness_ms)) {
                    let v20 = 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::collector::sy_index(v18);
                    if (exceeds_tolerance(v20, ((v4 / (v5 as u256)) as u128), arg1.outlier_tolerance_bps)) {
                        assert!(!v17.required, 956);
                    } else {
                        v10 = v10 + (v20 as u256) * (v17.weight_bps as u256);
                        v11 = v11 + (v17.weight_bps as u64);
                        v12 = v12 + 1;
                        if (!v14 || v19 < v1) {
                            v13 = v19;
                        };
                        v14 = true;
                    };
                };
            };
            v15 = v15 + 1;
        };
        assert!(v14, 958);
        assert!(v11 >= arg1.min_total_weight_bps, 957);
        assert!(v12 >= arg1.min_source_count, 962);
        let v21 = ((v10 / (v11 as u256)) as u128);
        let v22 = PriceAggregatedEvent{
            aggregator_id    : 0x2::object::id<PriceAggregator<T0>>(arg1),
            market_id        : v0,
            source_count     : v12,
            total_weight_bps : v11,
            sy_index         : v21,
            updated_at       : v13,
        };
        0x2::event::emit<PriceAggregatedEvent>(v22);
        0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info::create<T0>(0x2::object::id<PriceAggregator<T0>>(arg1), v0, v21, v13, arg1.max_staleness_ms, arg3)
    }

    fun assert_valid_max_staleness(arg0: u64) {
        assert!(arg0 > 0, 960);
    }

    fun assert_valid_min_source_count(arg0: u64) {
        assert!(arg0 > 0, 961);
    }

    fun assert_valid_threshold(arg0: u64) {
        assert!(arg0 > 0 && arg0 <= 10000, 951);
    }

    fun assert_valid_tolerance(arg0: u64) {
        assert!(arg0 <= 10000, 952);
    }

    fun assert_valid_weight(arg0: u16) {
        assert!(arg0 > 0 && (arg0 as u64) <= 10000, 950);
    }

    fun create_aggregator<T0: drop>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : PriceAggregator<T0> {
        let v0 = PriceAggregator<T0>{
            id                    : 0x2::object::new(arg5),
            market_id             : arg0,
            enabled               : true,
            max_staleness_ms      : arg1,
            source_rules          : 0x2::vec_map::empty<0x1::type_name::TypeName, SourceRule>(),
            min_total_weight_bps  : arg2,
            min_source_count      : arg3,
            outlier_tolerance_bps : arg4,
        };
        let v1 = AggregatorCreatedEvent{
            aggregator_id         : 0x2::object::id<PriceAggregator<T0>>(&v0),
            market_id             : arg0,
            max_staleness_ms      : arg1,
            min_total_weight_bps  : arg2,
            min_source_count      : arg3,
            outlier_tolerance_bps : arg4,
        };
        0x2::event::emit<AggregatorCreatedEvent>(v1);
        v0
    }

    public fun create_aggregator_by_ACL<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::ACL, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : PriceAggregator<T0> {
        0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::package_version::assert_current(arg0);
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::assert_has_role(arg1, arg0, 0x2::tx_context::sender(arg7), 0x1::string::utf8(b"oracle.create_aggregator"));
        assert_valid_max_staleness(arg3);
        assert_valid_threshold(arg4);
        assert_valid_min_source_count(arg5);
        assert_valid_tolerance(arg6);
        create_aggregator<T0>(arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun create_aggregator_by_admin_cap<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : PriceAggregator<T0> {
        0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::package_version::assert_current(arg0);
        assert_valid_max_staleness(arg3);
        assert_valid_threshold(arg4);
        assert_valid_min_source_count(arg5);
        assert_valid_tolerance(arg6);
        create_aggregator<T0>(arg2, arg3, arg4, arg5, arg6, arg7)
    }

    fun emit_policy_updated<T0: drop>(arg0: &PriceAggregator<T0>) {
        let v0 = AggregatorPolicyUpdatedEvent{
            aggregator_id         : 0x2::object::id<PriceAggregator<T0>>(arg0),
            enabled               : arg0.enabled,
            max_staleness_ms      : arg0.max_staleness_ms,
            min_total_weight_bps  : arg0.min_total_weight_bps,
            min_source_count      : arg0.min_source_count,
            outlier_tolerance_bps : arg0.outlier_tolerance_bps,
        };
        0x2::event::emit<AggregatorPolicyUpdatedEvent>(v0);
    }

    fun emit_source_rule_updated<T0: drop>(arg0: &PriceAggregator<T0>, arg1: 0x1::type_name::TypeName) {
        let v0 = 0x2::vec_map::get<0x1::type_name::TypeName, SourceRule>(&arg0.source_rules, &arg1);
        let v1 = SourceRuleUpdatedEvent{
            aggregator_id : 0x2::object::id<PriceAggregator<T0>>(arg0),
            source_type   : arg1,
            weight_bps    : v0.weight_bps,
            required      : v0.required,
            enabled       : v0.enabled,
        };
        0x2::event::emit<SourceRuleUpdatedEvent>(v1);
    }

    public fun enabled<T0: drop>(arg0: &PriceAggregator<T0>) : bool {
        arg0.enabled
    }

    fun exceeds_tolerance(arg0: u128, arg1: u128, arg2: u64) : bool {
        if (arg1 == 0) {
            return true
        };
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        (v0 as u256) * (10000 as u256) > (arg1 as u256) * (arg2 as u256)
    }

    public fun market_id<T0: drop>(arg0: &PriceAggregator<T0>) : 0x2::object::ID {
        arg0.market_id
    }

    public fun max_staleness_ms<T0: drop>(arg0: &PriceAggregator<T0>) : u64 {
        arg0.max_staleness_ms
    }

    public fun min_source_count<T0: drop>(arg0: &PriceAggregator<T0>) : u64 {
        arg0.min_source_count
    }

    public fun min_total_weight_bps<T0: drop>(arg0: &PriceAggregator<T0>) : u64 {
        arg0.min_total_weight_bps
    }

    public fun outlier_tolerance_bps<T0: drop>(arg0: &PriceAggregator<T0>) : u64 {
        arg0.outlier_tolerance_bps
    }

    fun quote_is_fresh(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg0 <= arg1 && arg1 - arg0 <= arg2
    }

    public fun remove_source_rule_by_admin_cap<T0: drop, T1: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg2: &mut PriceAggregator<T0>) {
        0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::package_version::assert_current(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, SourceRule>(&arg2.source_rules, &v0), 964);
        let (_, v2) = 0x2::vec_map::remove<0x1::type_name::TypeName, SourceRule>(&mut arg2.source_rules, &v0);
        let v3 = v2;
        let v4 = SourceRuleRemovedEvent{
            aggregator_id : 0x2::object::id<PriceAggregator<T0>>(arg2),
            market_id     : arg2.market_id,
            source_type   : v0,
            weight_bps    : v3.weight_bps,
            required      : v3.required,
            enabled       : v3.enabled,
        };
        0x2::event::emit<SourceRuleRemovedEvent>(v4);
    }

    public fun set_enabled<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::ACL, arg2: &mut PriceAggregator<T0>, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::package_version::assert_current(arg0);
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::assert_has_role(arg1, arg0, 0x2::tx_context::sender(arg4), 0x1::string::utf8(b"oracle.configure_aggregator"));
        arg2.enabled = arg3;
        emit_policy_updated<T0>(arg2);
    }

    public fun set_max_staleness_ms<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::ACL, arg2: &mut PriceAggregator<T0>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::package_version::assert_current(arg0);
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::assert_has_role(arg1, arg0, 0x2::tx_context::sender(arg4), 0x1::string::utf8(b"oracle.configure_aggregator"));
        assert_valid_max_staleness(arg3);
        arg2.max_staleness_ms = arg3;
        emit_policy_updated<T0>(arg2);
    }

    public fun set_min_source_count<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::ACL, arg2: &mut PriceAggregator<T0>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::package_version::assert_current(arg0);
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::assert_has_role(arg1, arg0, 0x2::tx_context::sender(arg4), 0x1::string::utf8(b"oracle.configure_aggregator"));
        assert_valid_min_source_count(arg3);
        arg2.min_source_count = arg3;
        emit_policy_updated<T0>(arg2);
    }

    public fun set_min_total_weight_bps<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::ACL, arg2: &mut PriceAggregator<T0>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::package_version::assert_current(arg0);
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::assert_has_role(arg1, arg0, 0x2::tx_context::sender(arg4), 0x1::string::utf8(b"oracle.configure_aggregator"));
        assert_valid_threshold(arg3);
        arg2.min_total_weight_bps = arg3;
        emit_policy_updated<T0>(arg2);
    }

    public fun set_outlier_tolerance_bps<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::ACL, arg2: &mut PriceAggregator<T0>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::package_version::assert_current(arg0);
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::assert_has_role(arg1, arg0, 0x2::tx_context::sender(arg4), 0x1::string::utf8(b"oracle.configure_aggregator"));
        assert_valid_tolerance(arg3);
        arg2.outlier_tolerance_bps = arg3;
        emit_policy_updated<T0>(arg2);
    }

    public fun set_source_rule<T0: drop, T1: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::ACL, arg2: &mut PriceAggregator<T0>, arg3: u16, arg4: bool, arg5: bool, arg6: &0x2::tx_context::TxContext) {
        0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::package_version::assert_current(arg0);
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::assert_has_role(arg1, arg0, 0x2::tx_context::sender(arg6), 0x1::string::utf8(b"oracle.configure_aggregator"));
        assert_valid_weight(arg3);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, SourceRule>(&arg2.source_rules, &v0), 964);
        let v1 = SourceRule{
            weight_bps : arg3,
            required   : arg4,
            enabled    : arg5,
        };
        *0x2::vec_map::get_mut<0x1::type_name::TypeName, SourceRule>(&mut arg2.source_rules, &v0) = v1;
        emit_source_rule_updated<T0>(arg2, v0);
    }

    public fun source_rules<T0: drop>(arg0: &PriceAggregator<T0>) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, SourceRule> {
        &arg0.source_rules
    }

    // decompiled from Move bytecode v7
}

