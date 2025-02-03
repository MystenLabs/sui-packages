module 0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::price_update_policy {
    struct PriceUpdateRequest<phantom T0> {
        for: 0x2::object::ID,
        receipts: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        price_feeds: vector<0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::price_feed::PriceFeed>,
    }

    struct PriceUpdatePolicy has store, key {
        id: 0x2::object::UID,
        rules: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct PriceUpdatePolicyCap has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
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

    public fun add_price_feed<T0, T1: drop>(arg0: T1, arg1: &mut PriceUpdateRequest<T0>, arg2: 0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::price_feed::PriceFeed) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.receipts, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::price_feed::PriceFeed>(&mut arg1.price_feeds, arg2);
    }

    public fun add_rule<T0>(arg0: &mut PriceUpdatePolicy, arg1: &PriceUpdatePolicyCap) {
        assert!(0x2::object::id<PriceUpdatePolicy>(arg0) == arg1.for, 723);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.rules, 0x1::type_name::get<T0>());
    }

    public fun confirm_request<T0>(arg0: PriceUpdateRequest<T0>, arg1: &PriceUpdatePolicy) : vector<0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::price_feed::PriceFeed> {
        let PriceUpdateRequest {
            for         : v0,
            receipts    : v1,
            price_feeds : v2,
        } = arg0;
        assert!(v0 == 0x2::object::id<PriceUpdatePolicy>(arg1), 722);
        let v3 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(v1);
        let v4 = 0x1::vector::length<0x1::type_name::TypeName>(&v3);
        assert!(v4 == 0x2::vec_set::size<0x1::type_name::TypeName>(&arg1.rules), 721);
        let v5 = 0;
        while (v5 < v4) {
            let v6 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v3);
            assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.rules, &v6), 721);
            v5 = v5 + 1;
        };
        v2
    }

    public fun new_request<T0>(arg0: &PriceUpdatePolicy) : PriceUpdateRequest<T0> {
        PriceUpdateRequest<T0>{
            for         : 0x2::object::id<PriceUpdatePolicy>(arg0),
            receipts    : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            price_feeds : 0x1::vector::empty<0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::price_feed::PriceFeed>(),
        }
    }

    public fun remove_rule<T0>(arg0: &mut PriceUpdatePolicy, arg1: &PriceUpdatePolicyCap) {
        assert!(0x2::object::id<PriceUpdatePolicy>(arg0) == arg1.for, 723);
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.rules, &v0);
    }

    // decompiled from Move bytecode v6
}

