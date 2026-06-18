module 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::aggregator {
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

    public fun aggregate<T0: drop>(arg0: &PriceAggregator<T0>, arg1: &0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::collector::PriceCollector<T0>, arg2: &0x2::clock::Clock) : 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0> {
        let v0 = arg0.market_id;
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.enabled, 959);
        assert!(0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::collector::market_id<T0>(arg1) == v0, 953);
        let v2 = 0x2::vec_map::keys<0x1::type_name::TypeName, SourceRule>(&arg0.source_rules);
        let v3 = 0x1::vector::length<0x1::type_name::TypeName>(&v2);
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        while (v6 < v3) {
            let v7 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v6);
            let v8 = *0x2::vec_map::get<0x1::type_name::TypeName, SourceRule>(&arg0.source_rules, &v7);
            if (v8.enabled) {
                if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::collector::SourceQuote>(0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::collector::contents<T0>(arg1), &v7)) {
                    assert!(!v8.required, 954);
                } else {
                    let v9 = 0x2::vec_map::get<0x1::type_name::TypeName, 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::collector::SourceQuote>(0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::collector::contents<T0>(arg1), &v7);
                    if (!quote_is_fresh(0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::collector::updated_at(v9), v1, arg0.max_staleness_ms)) {
                        assert!(!v8.required, 955);
                    } else {
                        v4 = v4 + (0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::collector::sy_index(v9) as u256) * (v8.weight_bps as u256);
                        v5 = v5 + (v8.weight_bps as u64);
                    };
                };
            };
            v6 = v6 + 1;
        };
        assert!(v5 >= arg0.min_total_weight_bps, 957);
        let v10 = 0;
        let v11 = 0;
        let v12 = 0;
        let v13 = v1;
        let v14 = false;
        let v15 = 0;
        while (v15 < v3) {
            let v16 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v15);
            let v17 = *0x2::vec_map::get<0x1::type_name::TypeName, SourceRule>(&arg0.source_rules, &v16);
            if (v17.enabled && 0x2::vec_map::contains<0x1::type_name::TypeName, 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::collector::SourceQuote>(0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::collector::contents<T0>(arg1), &v16)) {
                let v18 = 0x2::vec_map::get<0x1::type_name::TypeName, 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::collector::SourceQuote>(0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::collector::contents<T0>(arg1), &v16);
                let v19 = 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::collector::updated_at(v18);
                if (quote_is_fresh(v19, v1, arg0.max_staleness_ms)) {
                    let v20 = 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::collector::sy_index(v18);
                    if (exceeds_tolerance(v20, ((v4 / (v5 as u256)) as u128), arg0.outlier_tolerance_bps)) {
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
        assert!(v11 >= arg0.min_total_weight_bps, 957);
        assert!(v12 >= arg0.min_source_count, 962);
        let v21 = ((v10 / (v11 as u256)) as u128);
        let v22 = PriceAggregatedEvent{
            aggregator_id    : 0x2::object::id<PriceAggregator<T0>>(arg0),
            market_id        : v0,
            source_count     : v12,
            total_weight_bps : v11,
            sy_index         : v21,
            updated_at       : v13,
        };
        0x2::event::emit<PriceAggregatedEvent>(v22);
        0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::create<T0>(v0, v21, v13, arg0.max_staleness_ms, arg2)
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

    public fun create_aggregator_by_ACL<T0: drop>(arg0: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::ACL, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : PriceAggregator<T0> {
        0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::assert_has_role(arg0, 0x2::tx_context::sender(arg6), 0x1::string::utf8(b"oracle.create_aggregator"));
        assert_valid_max_staleness(arg2);
        assert_valid_threshold(arg3);
        assert_valid_min_source_count(arg4);
        assert_valid_tolerance(arg5);
        create_aggregator<T0>(arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun create_aggregator_by_admin_cap<T0: drop>(arg0: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : PriceAggregator<T0> {
        assert_valid_max_staleness(arg2);
        assert_valid_threshold(arg3);
        assert_valid_min_source_count(arg4);
        assert_valid_tolerance(arg5);
        create_aggregator<T0>(arg1, arg2, arg3, arg4, arg5, arg6)
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

    public fun remove_source_rule<T0: drop, T1: drop>(arg0: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::ACL, arg1: &mut PriceAggregator<T0>, arg2: &0x2::tx_context::TxContext) {
        0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::assert_has_role(arg0, 0x2::tx_context::sender(arg2), 0x1::string::utf8(b"oracle.configure_aggregator"));
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, SourceRule>(&arg1.source_rules, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, SourceRule>(&mut arg1.source_rules, &v0);
        };
    }

    public fun set_enabled<T0: drop>(arg0: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::ACL, arg1: &mut PriceAggregator<T0>, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::assert_has_role(arg0, 0x2::tx_context::sender(arg3), 0x1::string::utf8(b"oracle.configure_aggregator"));
        arg1.enabled = arg2;
        emit_policy_updated<T0>(arg1);
    }

    public fun set_max_staleness_ms<T0: drop>(arg0: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::ACL, arg1: &mut PriceAggregator<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::assert_has_role(arg0, 0x2::tx_context::sender(arg3), 0x1::string::utf8(b"oracle.configure_aggregator"));
        assert_valid_max_staleness(arg2);
        arg1.max_staleness_ms = arg2;
        emit_policy_updated<T0>(arg1);
    }

    public fun set_min_source_count<T0: drop>(arg0: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::ACL, arg1: &mut PriceAggregator<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::assert_has_role(arg0, 0x2::tx_context::sender(arg3), 0x1::string::utf8(b"oracle.configure_aggregator"));
        assert_valid_min_source_count(arg2);
        arg1.min_source_count = arg2;
        emit_policy_updated<T0>(arg1);
    }

    public fun set_min_total_weight_bps<T0: drop>(arg0: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::ACL, arg1: &mut PriceAggregator<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::assert_has_role(arg0, 0x2::tx_context::sender(arg3), 0x1::string::utf8(b"oracle.configure_aggregator"));
        assert_valid_threshold(arg2);
        arg1.min_total_weight_bps = arg2;
        emit_policy_updated<T0>(arg1);
    }

    public fun set_outlier_tolerance_bps<T0: drop>(arg0: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::ACL, arg1: &mut PriceAggregator<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::assert_has_role(arg0, 0x2::tx_context::sender(arg3), 0x1::string::utf8(b"oracle.configure_aggregator"));
        assert_valid_tolerance(arg2);
        arg1.outlier_tolerance_bps = arg2;
        emit_policy_updated<T0>(arg1);
    }

    public fun set_source_rule<T0: drop, T1: drop>(arg0: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::ACL, arg1: &mut PriceAggregator<T0>, arg2: u16, arg3: bool, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::assert_has_role(arg0, 0x2::tx_context::sender(arg5), 0x1::string::utf8(b"oracle.configure_aggregator"));
        assert_valid_weight(arg2);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = SourceRule{
            weight_bps : arg2,
            required   : arg3,
            enabled    : arg4,
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, SourceRule>(&arg1.source_rules, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, SourceRule>(&mut arg1.source_rules, &v0) = v1;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, SourceRule>(&mut arg1.source_rules, v0, v1);
        };
        let v2 = SourceRuleUpdatedEvent{
            aggregator_id : 0x2::object::id<PriceAggregator<T0>>(arg1),
            source_type   : v0,
            weight_bps    : arg2,
            required      : arg3,
            enabled       : arg4,
        };
        0x2::event::emit<SourceRuleUpdatedEvent>(v2);
    }

    public fun source_rules<T0: drop>(arg0: &PriceAggregator<T0>) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, SourceRule> {
        &arg0.source_rules
    }

    // decompiled from Move bytecode v7
}

