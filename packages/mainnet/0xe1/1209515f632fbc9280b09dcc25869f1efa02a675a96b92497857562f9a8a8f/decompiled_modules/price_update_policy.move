module 0xe11209515f632fbc9280b09dcc25869f1efa02a675a96b92497857562f9a8a8f::price_update_policy {
    struct PriceUpdateRequest<phantom T0> {
        for: 0x2::object::ID,
        receipts: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        price_feeds: vector<0xe11209515f632fbc9280b09dcc25869f1efa02a675a96b92497857562f9a8a8f::price_feed::PriceFeed>,
    }

    struct PriceUpdatePolicy has store, key {
        id: 0x2::object::UID,
        rules: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct PriceUpdatePolicyCap has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    struct PriceUpdatePolicyRulesKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : (PriceUpdatePolicy, PriceUpdatePolicyCap) {
        let v0 = PriceUpdatePolicy{
            id    : 0x2::object::new(arg0),
            rules : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = PriceUpdatePolicyCap{
            id  : 0x2::object::new(arg0),
            for : 0x2::object::id<PriceUpdatePolicy>(&v0),
        };
        (v0, v1)
    }

    public fun add_price_feed<T0, T1: drop>(arg0: T1, arg1: &mut PriceUpdateRequest<T0>, arg2: 0xe11209515f632fbc9280b09dcc25869f1efa02a675a96b92497857562f9a8a8f::price_feed::PriceFeed) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.receipts, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0xe11209515f632fbc9280b09dcc25869f1efa02a675a96b92497857562f9a8a8f::price_feed::PriceFeed>(&mut arg1.price_feeds, arg2);
    }

    public fun add_rule<T0>(arg0: &mut PriceUpdatePolicy, arg1: &PriceUpdatePolicyCap) {
        assert!(0x2::object::id<PriceUpdatePolicy>(arg0) == arg1.for, 723);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.rules, 0x1::type_name::get<T0>());
    }

    public(friend) fun add_rule_v2<T0, T1>(arg0: &mut PriceUpdatePolicy, arg1: &PriceUpdatePolicyCap) {
        assert!(0x2::object::id<PriceUpdatePolicy>(arg0) == arg1.for, 723);
        let v0 = PriceUpdatePolicyRulesKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<PriceUpdatePolicyRulesKey, 0x2::table::Table<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>>(&mut arg0.id, v0);
        let v2 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(v1, v2)) {
            0x2::table::add<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(v1, v2, 0x2::vec_set::empty<0x1::type_name::TypeName>());
        };
        0x2::vec_set::insert<0x1::type_name::TypeName>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(v1, v2), 0x1::type_name::get<T1>());
    }

    public fun confirm_request<T0>(arg0: PriceUpdateRequest<T0>, arg1: &PriceUpdatePolicy) : vector<0xe11209515f632fbc9280b09dcc25869f1efa02a675a96b92497857562f9a8a8f::price_feed::PriceFeed> {
        let PriceUpdateRequest {
            for         : v0,
            receipts    : v1,
            price_feeds : v2,
        } = arg0;
        assert!(v0 == 0x2::object::id<PriceUpdatePolicy>(arg1), 722);
        let v3 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(v1);
        let v4 = 0x1::vector::length<0x1::type_name::TypeName>(&v3);
        let v5 = get_price_update_policy<T0>(arg1);
        assert!(v4 == 0x2::vec_set::size<0x1::type_name::TypeName>(&v5), 721);
        let v6 = 0;
        while (v6 < v4) {
            let v7 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v3);
            assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&v5, &v7), 721);
            v6 = v6 + 1;
        };
        v2
    }

    public fun get_price_update_policy<T0>(arg0: &PriceUpdatePolicy) : 0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        let v0 = PriceUpdatePolicyRulesKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<PriceUpdatePolicyRulesKey, 0x2::table::Table<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>>(&arg0.id, v0);
        let v2 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(v1, v2)) {
            return 0x2::vec_set::empty<0x1::type_name::TypeName>()
        };
        *0x2::table::borrow<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(v1, v2)
    }

    public(friend) fun init_rules_df_if_not_exist(arg0: &PriceUpdatePolicyCap, arg1: &mut PriceUpdatePolicy, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceUpdatePolicyRulesKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<PriceUpdatePolicyRulesKey>(&arg1.id, v0)) {
            let v1 = PriceUpdatePolicyRulesKey{dummy_field: false};
            0x2::dynamic_field::add<PriceUpdatePolicyRulesKey, 0x2::table::Table<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>>(&mut arg1.id, v1, 0x2::table::new<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(arg2));
        };
    }

    public fun new_request<T0>(arg0: &PriceUpdatePolicy) : PriceUpdateRequest<T0> {
        PriceUpdateRequest<T0>{
            for         : 0x2::object::id<PriceUpdatePolicy>(arg0),
            receipts    : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            price_feeds : 0x1::vector::empty<0xe11209515f632fbc9280b09dcc25869f1efa02a675a96b92497857562f9a8a8f::price_feed::PriceFeed>(),
        }
    }

    public fun remove_rule<T0>(arg0: &mut PriceUpdatePolicy, arg1: &PriceUpdatePolicyCap) {
        assert!(0x2::object::id<PriceUpdatePolicy>(arg0) == arg1.for, 723);
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.rules, &v0);
    }

    public(friend) fun remove_rule_v2<T0, T1>(arg0: &mut PriceUpdatePolicy, arg1: &PriceUpdatePolicyCap) {
        assert!(0x2::object::id<PriceUpdatePolicy>(arg0) == arg1.for, 723);
        let v0 = PriceUpdatePolicyRulesKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<PriceUpdatePolicyRulesKey, 0x2::table::Table<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>>(&mut arg0.id, v0);
        let v2 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(v1, v2)) {
            return
        };
        let v3 = 0x1::type_name::get<T1>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(v1, v2), &v3);
    }

    // decompiled from Move bytecode v6
}

