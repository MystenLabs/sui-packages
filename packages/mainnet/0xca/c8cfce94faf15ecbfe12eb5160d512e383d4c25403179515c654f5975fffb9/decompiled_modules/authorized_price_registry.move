module 0xcac8cfce94faf15ecbfe12eb5160d512e383d4c25403179515c654f5975fffb9::authorized_price_registry {
    struct PriceRange has drop, store {
        min_price: 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::Decimal,
        max_price: 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::Decimal,
    }

    struct PriceData has drop, store {
        price: u64,
        last_updated: u64,
    }

    struct AuthorizedPriceRegistry has key {
        id: 0x2::object::UID,
        authorized_addresses: 0x2::vec_set::VecSet<address>,
        price_ranges: 0x2::table::Table<0x1::type_name::TypeName, PriceRange>,
        prices: 0x2::table::Table<0x1::type_name::TypeName, PriceData>,
        price_valid_duration: u64,
    }

    struct AuthorizedPriceRegistryCap has store, key {
        id: 0x2::object::UID,
        parent: 0x2::object::ID,
    }

    struct AddAuthorizedAddressEvent has copy, drop {
        addr: address,
    }

    struct RemoveAuthorizedAddressEvent has copy, drop {
        addr: address,
    }

    struct SetPriceRangeEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        min_price: u64,
        max_price: u64,
        decimals: u8,
    }

    struct RemovePriceRangeEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
    }

    struct SetPriceEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        price: u64,
        last_updated: u64,
        set_by: address,
    }

    struct SetPriceValidDurationEvent has copy, drop {
        price_valid_duration: u64,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : (AuthorizedPriceRegistry, AuthorizedPriceRegistryCap) {
        let v0 = AuthorizedPriceRegistry{
            id                   : 0x2::object::new(arg0),
            authorized_addresses : 0x2::vec_set::empty<address>(),
            price_ranges         : 0x2::table::new<0x1::type_name::TypeName, PriceRange>(arg0),
            prices               : 0x2::table::new<0x1::type_name::TypeName, PriceData>(arg0),
            price_valid_duration : 60,
        };
        let v1 = AuthorizedPriceRegistryCap{
            id     : 0x2::object::new(arg0),
            parent : 0x2::object::id<AuthorizedPriceRegistry>(&v0),
        };
        (v0, v1)
    }

    public fun add_authorized_address(arg0: &mut AuthorizedPriceRegistry, arg1: &AuthorizedPriceRegistryCap, arg2: address) {
        assert_cap(arg0, arg1);
        assert!(!0x2::vec_set::contains<address>(&arg0.authorized_addresses, &arg2), 70915);
        0x2::vec_set::insert<address>(&mut arg0.authorized_addresses, arg2);
        let v0 = AddAuthorizedAddressEvent{addr: arg2};
        0x2::event::emit<AddAuthorizedAddressEvent>(v0);
    }

    public fun assert_authorized(arg0: &AuthorizedPriceRegistry, arg1: address) {
        assert!(is_authorized(arg0, arg1), 70914);
    }

    fun assert_cap(arg0: &AuthorizedPriceRegistry, arg1: &AuthorizedPriceRegistryCap) {
        assert!(0x2::object::id<AuthorizedPriceRegistry>(arg0) == arg1.parent, 70913);
    }

    public fun assert_price_in_range<T0>(arg0: &AuthorizedPriceRegistry, arg1: u64) {
        let (v0, v1) = price_range<T0>(arg0);
        let v2 = 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::div(0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from(arg1), 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from(0x1::u64::pow(10, 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::decimals())));
        assert!(0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::ge(v2, v0) && 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::le(v2, v1), 70919);
    }

    public fun get_price<T0>(arg0: &AuthorizedPriceRegistry, arg1: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, PriceData>(&arg0.prices, v0), 70921);
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, PriceData>(&arg0.prices, v0);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 <= v1.last_updated + arg0.price_valid_duration, 70922);
        assert_price_in_range<T0>(arg0, v1.price);
        (v1.price, v1.last_updated)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new(arg0);
        0x2::transfer::share_object<AuthorizedPriceRegistry>(v0);
        0x2::transfer::transfer<AuthorizedPriceRegistryCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_authorized(arg0: &AuthorizedPriceRegistry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.authorized_addresses, &arg1)
    }

    public fun price_range<T0>(arg0: &AuthorizedPriceRegistry) : (0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::Decimal, 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::Decimal) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, PriceRange>(&arg0.price_ranges, v0), 70918);
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, PriceRange>(&arg0.price_ranges, v0);
        (v1.min_price, v1.max_price)
    }

    public fun price_valid_duration(arg0: &AuthorizedPriceRegistry) : u64 {
        arg0.price_valid_duration
    }

    public fun remove_authorized_address(arg0: &mut AuthorizedPriceRegistry, arg1: &AuthorizedPriceRegistryCap, arg2: address) {
        assert_cap(arg0, arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.authorized_addresses, &arg2), 70916);
        0x2::vec_set::remove<address>(&mut arg0.authorized_addresses, &arg2);
        let v0 = RemoveAuthorizedAddressEvent{addr: arg2};
        0x2::event::emit<RemoveAuthorizedAddressEvent>(v0);
    }

    public fun remove_price_range<T0>(arg0: &mut AuthorizedPriceRegistry, arg1: &AuthorizedPriceRegistryCap) {
        assert_cap(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, PriceRange>(&arg0.price_ranges, v0), 70918);
        0x2::table::remove<0x1::type_name::TypeName, PriceRange>(&mut arg0.price_ranges, v0);
        let v1 = RemovePriceRangeEvent{coin_type: v0};
        0x2::event::emit<RemovePriceRangeEvent>(v1);
    }

    public fun set_price<T0>(arg0: &mut AuthorizedPriceRegistry, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_authorized(arg0, 0x2::tx_context::sender(arg3));
        assert_price_in_range<T0>(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, PriceData>(&arg0.prices, v1)) {
            let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, PriceData>(&mut arg0.prices, v1);
            v2.price = arg1;
            v2.last_updated = v0;
        } else {
            let v3 = PriceData{
                price        : arg1,
                last_updated : v0,
            };
            0x2::table::add<0x1::type_name::TypeName, PriceData>(&mut arg0.prices, v1, v3);
        };
        let v4 = SetPriceEvent{
            coin_type    : v1,
            price        : arg1,
            last_updated : v0,
            set_by       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SetPriceEvent>(v4);
    }

    public fun set_price_range<T0>(arg0: &mut AuthorizedPriceRegistry, arg1: &AuthorizedPriceRegistryCap, arg2: u64, arg3: u64, arg4: u8) {
        assert_cap(arg0, arg1);
        assert!(arg4 <= 18, 70920);
        assert!(arg2 > 0, 70917);
        assert!(arg2 <= arg3, 70917);
        let v0 = 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from(0x1::u64::pow(10, arg4));
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, PriceRange>(&arg0.price_ranges, v1)) {
            let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, PriceRange>(&mut arg0.price_ranges, v1);
            v2.min_price = 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::div(0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from(arg2), v0);
            v2.max_price = 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::div(0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from(arg3), v0);
        } else {
            let v3 = PriceRange{
                min_price : 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::div(0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from(arg2), v0),
                max_price : 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::div(0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from(arg3), v0),
            };
            0x2::table::add<0x1::type_name::TypeName, PriceRange>(&mut arg0.price_ranges, v1, v3);
        };
        let v4 = SetPriceRangeEvent{
            coin_type : v1,
            min_price : arg2,
            max_price : arg3,
            decimals  : arg4,
        };
        0x2::event::emit<SetPriceRangeEvent>(v4);
    }

    public fun set_price_valid_duration(arg0: &mut AuthorizedPriceRegistry, arg1: &AuthorizedPriceRegistryCap, arg2: u64) {
        assert_cap(arg0, arg1);
        assert!(arg2 > 0, 70923);
        arg0.price_valid_duration = arg2;
        let v0 = SetPriceValidDurationEvent{price_valid_duration: arg2};
        0x2::event::emit<SetPriceValidDurationEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

