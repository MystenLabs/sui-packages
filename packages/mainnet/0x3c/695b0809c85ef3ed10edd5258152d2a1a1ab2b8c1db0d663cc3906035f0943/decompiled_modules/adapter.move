module 0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter {
    struct AdapterAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeedEntry has store {
        feed_id: vector<u8>,
        price_usdc: u64,
        publish_time_ms: u64,
        conf_raw: u64,
        raw_price: u64,
        raw_expo: u64,
    }

    struct PriceCache has key {
        id: 0x2::object::UID,
        version: u64,
        feeds: 0x2::table::Table<0x1::type_name::TypeName, FeedEntry>,
        admin: address,
    }

    struct SourceKey has copy, drop, store {
        token_type: 0x1::type_name::TypeName,
    }

    struct ConfidenceCheckKey has copy, drop, store {
        token_type: 0x1::type_name::TypeName,
    }

    struct CacheCreated has copy, drop {
        cache_id: 0x2::object::ID,
        admin: address,
    }

    struct FeedRegistered has copy, drop {
        token_type: 0x1::type_name::TypeName,
        feed_id: vector<u8>,
    }

    struct FeedRemoved has copy, drop {
        token_type: 0x1::type_name::TypeName,
    }

    struct PricePushed has copy, drop {
        token_type: 0x1::type_name::TypeName,
        price_usdc: u64,
        publish_time_ms: u64,
        conf_raw: u64,
        pushed_by: address,
    }

    struct ManualPricePushed has copy, drop {
        token_type: 0x1::type_name::TypeName,
        price_usdc: u64,
        publish_time_ms: u64,
        pushed_by: address,
    }

    public fun age_ms(arg0: &PriceCache, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : u64 {
        let v0 = publish_time_ms(arg0, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (v1 <= v0) {
            0
        } else {
            v1 - v0
        }
    }

    public fun cache_admin(arg0: &PriceCache) : address {
        arg0.admin
    }

    public fun cache_version(arg0: &PriceCache) : u64 {
        arg0.version
    }

    fun decode_pair_index(arg0: &vector<u8>) : u32 {
        assert!(0x1::vector::length<u8>(arg0) == 4, 108);
        let v0 = 0x2::bcs::new(*arg0);
        0x2::bcs::peel_u32(&mut v0)
    }

    public fun feed_id_of(arg0: &PriceCache, arg1: 0x1::type_name::TypeName) : vector<u8> {
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedEntry>(&arg0.feeds, arg1), 100);
        0x2::table::borrow<0x1::type_name::TypeName, FeedEntry>(&arg0.feeds, arg1).feed_id
    }

    public fun has_feed(arg0: &PriceCache, arg1: 0x1::type_name::TypeName) : bool {
        0x2::table::contains<0x1::type_name::TypeName, FeedEntry>(&arg0.feeds, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdapterAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdapterAdminCap>(v1, v0);
        let v2 = PriceCache{
            id      : 0x2::object::new(arg0),
            version : 1,
            feeds   : 0x2::table::new<0x1::type_name::TypeName, FeedEntry>(arg0),
            admin   : v0,
        };
        let v3 = CacheCreated{
            cache_id : 0x2::object::id<PriceCache>(&v2),
            admin    : v0,
        };
        0x2::event::emit<CacheCreated>(v3);
        0x2::transfer::share_object<PriceCache>(v2);
    }

    fun normalise_supra_to_usdc_scale(arg0: u128, arg1: u16) : u64 {
        assert!(arg1 <= 18, 107);
        let v0 = (arg1 as u128);
        if (v0 == 6) {
            (arg0 as u64)
        } else if (v0 > 6) {
            ((arg0 / (pow10(((v0 - 6) as u64)) as u128)) as u64)
        } else {
            ((arg0 * (pow10(((6 - v0) as u64)) as u128)) as u64)
        }
    }

    fun normalise_to_usdc_scale(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 6) {
            arg0
        } else if (arg1 > 6) {
            (((arg0 as u128) / (pow10(arg1 - 6) as u128)) as u64)
        } else {
            (((arg0 as u128) * (pow10(6 - arg1) as u128)) as u64)
        }
    }

    fun pow10(arg0: u64) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun price_usdc(arg0: &PriceCache, arg1: 0x1::type_name::TypeName) : u64 {
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedEntry>(&arg0.feeds, arg1), 100);
        0x2::table::borrow<0x1::type_name::TypeName, FeedEntry>(&arg0.feeds, arg1).price_usdc
    }

    public fun publish_time_ms(arg0: &PriceCache, arg1: 0x1::type_name::TypeName) : u64 {
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedEntry>(&arg0.feeds, arg1), 100);
        0x2::table::borrow<0x1::type_name::TypeName, FeedEntry>(&arg0.feeds, arg1).publish_time_ms
    }

    public fun push<T0>(arg0: &mut PriceCache, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedEntry>(&arg0.feeds, v0), 100);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price_identifier(v2);
        let v4 = 0x2::table::borrow_mut<0x1::type_name::TypeName, FeedEntry>(&mut arg0.feeds, v0);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v3) == v4.feed_id, 102);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(v2);
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v5);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v6), 103);
        let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v6);
        assert!(v7 > 0, 104);
        let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v5);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v8), 105);
        let v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v8);
        assert!(v9 <= 18, 105);
        let v10 = normalise_to_usdc_scale(v7, v9);
        assert!(v10 > 0, 104);
        let v11 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v5) * 1000;
        v4.price_usdc = v10;
        v4.publish_time_ms = v11;
        v4.conf_raw = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v5);
        v4.raw_price = v7;
        v4.raw_expo = v9;
        let v12 = PricePushed{
            token_type      : v0,
            price_usdc      : v10,
            publish_time_ms : v11,
            conf_raw        : v4.conf_raw,
            pushed_by       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PricePushed>(v12);
    }

    public fun push_manual_price<T0>(arg0: &mut PriceCache, arg1: &AdapterAdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 106);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedEntry>(&arg0.feeds, v0), 100);
        assert!(arg2 > 0, 104);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, FeedEntry>(&mut arg0.feeds, v0);
        v2.price_usdc = arg2;
        v2.publish_time_ms = v1;
        v2.conf_raw = 0;
        write_confidence_check(arg0, v0, false);
        let v3 = ManualPricePushed{
            token_type      : v0,
            price_usdc      : arg2,
            publish_time_ms : v1,
            pushed_by       : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ManualPricePushed>(v3);
    }

    public fun read(arg0: &PriceCache, arg1: 0x1::type_name::TypeName) : (u64, u64, u64, u64) {
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedEntry>(&arg0.feeds, arg1), 100);
        let v0 = 0x2::table::borrow<0x1::type_name::TypeName, FeedEntry>(&arg0.feeds, arg1);
        (v0.price_usdc, v0.publish_time_ms, v0.conf_raw, v0.raw_price)
    }

    entry fun register_feed<T0>(arg0: &mut PriceCache, arg1: &AdapterAdminCap, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 106);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, FeedEntry>(&arg0.feeds, v0), 101);
        let v1 = FeedEntry{
            feed_id         : arg2,
            price_usdc      : 0,
            publish_time_ms : 0,
            conf_raw        : 0,
            raw_price       : 0,
            raw_expo        : 0,
        };
        0x2::table::add<0x1::type_name::TypeName, FeedEntry>(&mut arg0.feeds, v0, v1);
        let v2 = FeedRegistered{
            token_type : v0,
            feed_id    : arg2,
        };
        0x2::event::emit<FeedRegistered>(v2);
    }

    entry fun remove_feed<T0>(arg0: &mut PriceCache, arg1: &AdapterAdminCap, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 106);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedEntry>(&arg0.feeds, v0), 100);
        let FeedEntry {
            feed_id         : _,
            price_usdc      : _,
            publish_time_ms : _,
            conf_raw        : _,
            raw_price       : _,
            raw_expo        : _,
        } = 0x2::table::remove<0x1::type_name::TypeName, FeedEntry>(&mut arg0.feeds, v0);
        let v7 = FeedRemoved{token_type: v0};
        0x2::event::emit<FeedRemoved>(v7);
    }

    public fun requires_confidence_check(arg0: &PriceCache, arg1: 0x1::type_name::TypeName) : bool {
        let v0 = ConfidenceCheckKey{token_type: arg1};
        0x2::dynamic_field::exists_<ConfidenceCheckKey>(&arg0.id, v0) && *0x2::dynamic_field::borrow<ConfidenceCheckKey, bool>(&arg0.id, v0) || true
    }

    entry fun set_requires_confidence_check<T0>(arg0: &mut PriceCache, arg1: &AdapterAdminCap, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 106);
        write_confidence_check(arg0, 0x1::type_name::get<T0>(), arg2);
    }

    entry fun set_source<T0>(arg0: &mut PriceCache, arg1: &AdapterAdminCap, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 106);
        write_source(arg0, 0x1::type_name::get<T0>(), arg2);
    }

    public fun source_of(arg0: &PriceCache, arg1: 0x1::type_name::TypeName) : u8 {
        let v0 = SourceKey{token_type: arg1};
        if (0x2::dynamic_field::exists_<SourceKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<SourceKey, u8>(&arg0.id, v0)
        } else {
            0
        }
    }

    public fun sync_supra<T0>(arg0: &mut PriceCache, arg1: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedEntry>(&arg0.feeds, v0), 100);
        let (v1, v2, v3, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg1, decode_pair_index(&0x2::table::borrow<0x1::type_name::TypeName, FeedEntry>(&arg0.feeds, v0).feed_id));
        assert!(v1 > 0, 104);
        let v5 = normalise_supra_to_usdc_scale(v1, v2);
        assert!(v5 > 0, 104);
        let v6 = (v3 as u64);
        let v7 = 0x2::table::borrow_mut<0x1::type_name::TypeName, FeedEntry>(&mut arg0.feeds, v0);
        v7.price_usdc = v5;
        v7.publish_time_ms = v6;
        v7.conf_raw = 0;
        v7.raw_price = (v1 as u64);
        v7.raw_expo = (v2 as u64);
        write_source(arg0, v0, 1);
        write_confidence_check(arg0, v0, false);
        let v8 = PricePushed{
            token_type      : v0,
            price_usdc      : v5,
            publish_time_ms : v6,
            conf_raw        : 0,
            pushed_by       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PricePushed>(v8);
    }

    entry fun transfer_admin(arg0: &mut PriceCache, arg1: &AdapterAdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 106);
        arg0.admin = arg2;
    }

    public fun usdc_scale() : u64 {
        1000000
    }

    fun write_confidence_check(arg0: &mut PriceCache, arg1: 0x1::type_name::TypeName, arg2: bool) {
        let v0 = ConfidenceCheckKey{token_type: arg1};
        if (0x2::dynamic_field::exists_<ConfidenceCheckKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<ConfidenceCheckKey, bool>(&mut arg0.id, v0) = arg2;
        } else {
            0x2::dynamic_field::add<ConfidenceCheckKey, bool>(&mut arg0.id, v0, arg2);
        };
    }

    fun write_source(arg0: &mut PriceCache, arg1: 0x1::type_name::TypeName, arg2: u8) {
        assert!(arg2 <= 2, 109);
        let v0 = SourceKey{token_type: arg1};
        if (0x2::dynamic_field::exists_<SourceKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<SourceKey, u8>(&mut arg0.id, v0) = arg2;
        } else {
            0x2::dynamic_field::add<SourceKey, u8>(&mut arg0.id, v0, arg2);
        };
    }

    // decompiled from Move bytecode v7
}

