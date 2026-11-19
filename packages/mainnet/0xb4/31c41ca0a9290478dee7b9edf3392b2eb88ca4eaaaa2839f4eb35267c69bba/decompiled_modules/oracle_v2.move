module 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle_v2 {
    struct AftermathFeedConfigKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AftermathFeedConfig has store {
        enabled: bool,
    }

    struct AftermathFeedConfigured has copy, drop {
        oracle_id: 0x2::object::ID,
        enabled: bool,
    }

    struct AftermathFeedPricesUpdated has copy, drop {
        oracle_id: 0x2::object::ID,
        sui_price: u64,
        usdc_price: u64,
        sui_published_ms: u64,
        usdc_published_ms: u64,
    }

    struct AftermathMarketPriceUpdated has copy, drop {
        oracle_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        price: u64,
        published_ms: u64,
    }

    struct OracleV2 has key {
        id: 0x2::object::UID,
        version: u64,
        authority: 0x2::vec_set::VecSet<address>,
        allow_delay_sec: u64,
        feed_id_map: 0x2::vec_map::VecMap<u32, 0x1::type_name::TypeName>,
        latest_price: 0x2::vec_map::VecMap<0x1::type_name::TypeName, Price>,
        settle_price: 0x2::vec_map::VecMap<0x1::type_name::TypeName, Price>,
        u64_padding: vector<u64>,
    }

    struct Price has copy, drop, store {
        feed_id: u32,
        token_type: 0x1::type_name::TypeName,
        price: u64,
        ema_price: u64,
        update_timestamp: u64,
        u64_padding: vector<u64>,
    }

    entry fun add_authority(arg0: &mut OracleV2, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 13906835235200303103);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.authority, &v0), 13906835243790237695);
        0x2::vec_set::insert<address>(&mut arg0.authority, arg1);
    }

    entry fun add_latest_price_new_token<T0>(arg0: &mut OracleV2, arg1: u32, arg2: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        do_add_latest_price_new_token(arg0, arg1, 0x1::type_name::with_defining_ids<T0>(), 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(&arg2), 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds(&arg2), arg3, arg4);
    }

    entry fun add_latest_price_new_token_v2<T0>(arg0: &mut OracleV2, arg1: u32, arg2: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        do_add_latest_price_new_token(arg0, arg1, 0x1::type_name::with_defining_ids<T0>(), 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::timestamp(&arg2), 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::feeds(&arg2), arg3, arg4);
    }

    entry fun add_settle_price_new_token<T0>(arg0: &mut OracleV2, arg1: u32, arg2: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        do_add_settle_price_new_token(arg0, arg1, 0x1::type_name::with_defining_ids<T0>(), 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(&arg2), 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds(&arg2), arg3, arg5);
    }

    entry fun add_settle_price_new_token_v2<T0>(arg0: &mut OracleV2, arg1: u32, arg2: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        do_add_settle_price_new_token(arg0, arg1, 0x1::type_name::with_defining_ids<T0>(), 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::timestamp(&arg2), 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::feeds(&arg2), arg3, arg5);
    }

    fun apply_aftermath_feed_enabled(arg0: &mut OracleV2, arg1: bool) {
        let v0 = AftermathFeedConfigKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<AftermathFeedConfigKey, AftermathFeedConfig>(&mut arg0.id, v0).enabled = arg1;
        arg0.latest_price = 0x2::vec_map::empty<0x1::type_name::TypeName, Price>();
        arg0.version = 3;
        arg0.allow_delay_sec = 20;
        let v1 = AftermathFeedConfigured{
            oracle_id : 0x2::object::id<OracleV2>(arg0),
            enabled   : arg1,
        };
        0x2::event::emit<AftermathFeedConfigured>(v1);
    }

    fun assert_aftermath_admin(arg0: &0x2::package::UpgradeCap) {
        let v0 = 0x2::object::id<0x2::package::UpgradeCap>(arg0);
        assert!(0x2::object::id_to_address(&v0) == @0x7f4749330bbd782e37e42c754e7ceca575ccd153ae38bf5ed4f687c3319e3243, 100);
    }

    fun assert_aftermath_tokens<T0, T1>() {
        assert!(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()) == 0x1::ascii::string(b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI"), 102);
        assert!(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()) == 0x1::ascii::string(b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC"), 102);
    }

    fun check_price_fresh(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg0 > arg1 && arg0 - arg1 < arg2 || arg1 - arg0 < arg2
    }

    public fun create_aftermath_feed_oracle<T0, T1>(arg0: &0x2::package::UpgradeCap, arg1: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg3: &mut 0x2::tx_context::TxContext) {
        assert_aftermath_admin(arg0);
        assert_aftermath_tokens<T0, T1>();
        let (_, _) = native_aftermath_feed(arg1, true);
        let (_, _) = native_aftermath_feed(arg2, false);
        let v4 = new_aftermath_feed_oracle(arg3);
        let v5 = AftermathFeedConfigured{
            oracle_id : 0x2::object::id<OracleV2>(&v4),
            enabled   : false,
        };
        0x2::event::emit<AftermathFeedConfigured>(v5);
        0x2::transfer::share_object<OracleV2>(v4);
    }

    entry fun create_oracle_v2(arg0: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::ManagerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleV2{
            id              : 0x2::object::new(arg2),
            version         : 3,
            authority       : 0x2::vec_set::singleton<address>(arg1),
            allow_delay_sec : 5,
            feed_id_map     : 0x2::vec_map::empty<u32, 0x1::type_name::TypeName>(),
            latest_price    : 0x2::vec_map::empty<0x1::type_name::TypeName, Price>(),
            settle_price    : 0x2::vec_map::empty<0x1::type_name::TypeName, Price>(),
            u64_padding     : vector[],
        };
        0x2::transfer::share_object<OracleV2>(v0);
    }

    fun do_add_latest_price_new_token(arg0: &mut OracleV2, arg1: u32, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: vector<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 13906835587387621375);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::vec_set::contains<address>(&arg0.authority, &v0), 13906835595977555967);
        let v1 = 0x2::clock::timestamp_ms(arg5) / 1000;
        assert!(check_price_fresh(arg3 / 1000000, v1, arg0.allow_delay_sec), 13906835617452392447);
        assert!(0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&arg4) == 1, 13906835626042327039);
        let v2 = Price{
            feed_id          : arg1,
            token_type       : arg2,
            price            : 0,
            ema_price        : 0,
            update_timestamp : 0,
            u64_padding      : vector[],
        };
        let v3 = &mut v2;
        update_price(v3, 0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&arg4, 0), v1, arg0.allow_delay_sec, false);
        if (!0x2::vec_map::contains<u32, 0x1::type_name::TypeName>(&arg0.feed_id_map, &arg1)) {
            0x2::vec_map::insert<u32, 0x1::type_name::TypeName>(&mut arg0.feed_id_map, arg1, arg2);
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, Price>(&mut arg0.latest_price, arg2, v2);
    }

    fun do_add_settle_price_new_token(arg0: &mut OracleV2, arg1: u32, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: vector<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 13906835870855462911);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::vec_set::contains<address>(&arg0.authority, &v0), 13906835879445397503);
        assert!(check_price_fresh(arg3 / 1000000, arg5, arg0.allow_delay_sec), 13906835896625266687);
        assert!(0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&arg4) == 1, 13906835905215201279);
        let v1 = Price{
            feed_id          : arg1,
            token_type       : arg2,
            price            : 0,
            ema_price        : 0,
            update_timestamp : 0,
            u64_padding      : vector[],
        };
        let v2 = &mut v1;
        update_price(v2, 0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&arg4, 0), arg5, arg0.allow_delay_sec, true);
        if (!0x2::vec_map::contains<u32, 0x1::type_name::TypeName>(&arg0.feed_id_map, &arg1)) {
            0x2::vec_map::insert<u32, 0x1::type_name::TypeName>(&mut arg0.feed_id_map, arg1, arg2);
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, Price>(&mut arg0.settle_price, arg2, v1);
    }

    fun do_update_latest_price(arg0: &mut OracleV2, arg1: u64, arg2: vector<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>, arg3: &0x2::clock::Clock) {
        assert!(arg0.version == 3, 13906836089898795007);
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        assert!(check_price_fresh(arg1 / 1000000, v0, arg0.allow_delay_sec), 13906836102783696895);
        0x1::vector::reverse<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&mut arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&arg2)) {
            let v2 = 0x1::vector::pop_back<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&mut arg2);
            let v3 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(&v2);
            let v4 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, Price>(&mut arg0.latest_price, 0x2::vec_map::get<u32, 0x1::type_name::TypeName>(&arg0.feed_id_map, &v3));
            update_price(v4, &v2, v0, arg0.allow_delay_sec, false);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(arg2);
    }

    fun do_update_settle_price(arg0: &mut OracleV2, arg1: u64, arg2: vector<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 13906836265992454143);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.authority, &v0), 13906836270287421439);
        assert!(check_price_fresh(arg1 / 1000000, arg3, arg0.allow_delay_sec), 13906836283172323327);
        0x1::vector::reverse<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&mut arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&arg2)) {
            let v2 = 0x1::vector::pop_back<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&mut arg2);
            let v3 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(&v2);
            let v4 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, Price>(&mut arg0.settle_price, 0x2::vec_map::get<u32, 0x1::type_name::TypeName>(&arg0.feed_id_map, &v3));
            update_price(v4, &v2, arg3, arg0.allow_delay_sec, true);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(arg2);
    }

    public fun get_latest_price(arg0: &OracleV2, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : vector<u64> {
        assert!(arg0.version == 3, 13906836351891800063);
        let v0 = 0x2::vec_map::get<0x1::type_name::TypeName, Price>(&arg0.latest_price, &arg1);
        assert!(check_price_fresh(v0.update_timestamp, 0x2::clock::timestamp_ms(arg2) / 1000, arg0.allow_delay_sec), 13906836373366636543);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, v0.price);
        0x1::vector::push_back<u64>(v2, v0.ema_price);
        v1
    }

    public fun get_settle_price(arg0: &OracleV2, arg1: 0x1::type_name::TypeName, arg2: u64) : vector<u64> {
        assert!(arg0.version == 3, 13906836412021342207);
        let v0 = 0x2::vec_map::get<0x1::type_name::TypeName, Price>(&arg0.settle_price, &arg1);
        assert!(check_price_fresh(v0.update_timestamp, arg2, 1), 13906836429201211391);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, v0.price);
        0x1::vector::push_back<u64>(v2, v0.ema_price);
        v1
    }

    fun native_aftermath_feed(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg1: bool) : (u128, u64) {
        let v0 = 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::price_feed(arg0, 1);
        let v1 = 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg0);
        let v2 = 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::from(v0);
        0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::aftermath_feed_guard::validate_storage(arg1, 0x2::object::id_to_address(&v1), 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::storage_id(arg0), 0x1::string::into_bytes(0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::symbol(arg0)), 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::source_id(v0), 0x2::object::id_to_address(&v2));
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::price_and_timestamp_ms(v0)
    }

    fun new_aftermath_feed_oracle(arg0: &mut 0x2::tx_context::TxContext) : OracleV2 {
        let v0 = OracleV2{
            id              : 0x2::object::new(arg0),
            version         : 3,
            authority       : 0x2::vec_set::empty<address>(),
            allow_delay_sec : 20,
            feed_id_map     : 0x2::vec_map::empty<u32, 0x1::type_name::TypeName>(),
            latest_price    : 0x2::vec_map::empty<0x1::type_name::TypeName, Price>(),
            settle_price    : 0x2::vec_map::empty<0x1::type_name::TypeName, Price>(),
            u64_padding     : vector[],
        };
        let v1 = AftermathFeedConfigKey{dummy_field: false};
        let v2 = AftermathFeedConfig{enabled: false};
        0x2::dynamic_field::add<AftermathFeedConfigKey, AftermathFeedConfig>(&mut v0.id, v1, v2);
        v0
    }

    fun publish_aftermath_price<T0>(arg0: &mut OracleV2, arg1: u64, arg2: u64, arg3: u32) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, arg2);
        let v2 = Price{
            feed_id          : arg3,
            token_type       : v0,
            price            : arg1,
            ema_price        : arg1,
            update_timestamp : arg2 / 1000,
            u64_padding      : v1,
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, Price>(&arg0.latest_price, &v0)) {
            let v3 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, Price>(&mut arg0.latest_price, &v0);
            assert!(arg2 >= *0x1::vector::borrow<u64>(&v3.u64_padding, 0), 103);
            if (arg2 == *0x1::vector::borrow<u64>(&v3.u64_padding, 0)) {
                assert!(arg1 == v3.price, 103);
                return
            };
            *v3 = v2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, Price>(&mut arg0.latest_price, v0, v2);
        };
    }

    public fun refresh_aftermath_market_price<T0>(arg0: &mut OracleV2, arg1: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::aftermath_feed_guard::market_feed_id(0x1::ascii::into_bytes(0x1::type_name::into_string(v0)));
        let v2 = AftermathFeedConfigKey{dummy_field: false};
        assert!(0x2::dynamic_field::borrow<AftermathFeedConfigKey, AftermathFeedConfig>(&arg0.id, v2).enabled, 101);
        assert!(arg0.version == 3 && arg0.allow_delay_sec == 20, 102);
        let v3 = 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config>(arg2);
        assert!(0x2::object::id_to_address(&v3) == @0xd41beee10826d597570e36e781a67a7398e3e6fdf9dbcb297e76b88e89a3aba6, 102);
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::assert_package_version(arg2);
        assert!(!0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::is_frozen(arg2), 104);
        let v4 = 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::price_feed(arg1, 1);
        let v5 = 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg1);
        let v6 = 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::from(v4);
        0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::aftermath_feed_guard::validate_market_storage(v1, 0x2::object::id_to_address(&v5), 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::storage_id(arg1), 0x1::string::into_bytes(0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::symbol(arg1)), 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::source_id(v4), 0x2::object::id_to_address(&v6));
        let (v7, v8) = 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::price_and_timestamp_ms(v4);
        let v9 = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::aftermath_feed_guard::normalize(v7, v8, 0x2::clock::timestamp_ms(arg3));
        publish_aftermath_price<T0>(arg0, v9, v8, v1);
        let v10 = AftermathMarketPriceUpdated{
            oracle_id    : 0x2::object::id<OracleV2>(arg0),
            token_type   : v0,
            price        : v9,
            published_ms : v8,
        };
        0x2::event::emit<AftermathMarketPriceUpdated>(v10);
    }

    public fun refresh_aftermath_prices<T0, T1>(arg0: &mut OracleV2, arg1: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config, arg4: &0x2::clock::Clock) {
        assert_aftermath_tokens<T0, T1>();
        let v0 = AftermathFeedConfigKey{dummy_field: false};
        assert!(0x2::dynamic_field::borrow<AftermathFeedConfigKey, AftermathFeedConfig>(&arg0.id, v0).enabled, 101);
        assert!(arg0.version == 3 && arg0.allow_delay_sec == 20, 102);
        let v1 = 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config>(arg3);
        assert!(0x2::object::id_to_address(&v1) == @0xd41beee10826d597570e36e781a67a7398e3e6fdf9dbcb297e76b88e89a3aba6, 102);
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::assert_package_version(arg3);
        assert!(!0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::is_frozen(arg3), 104);
        let (v2, v3) = native_aftermath_feed(arg1, true);
        let (v4, v5) = native_aftermath_feed(arg2, false);
        let v6 = 0x2::clock::timestamp_ms(arg4);
        let v7 = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::aftermath_feed_guard::normalize(v2, v3, v6);
        let v8 = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::aftermath_feed_guard::normalize(v4, v5, v6);
        publish_aftermath_price<T0>(arg0, v7, v3, 11);
        publish_aftermath_price<T1>(arg0, v8, v5, 7);
        let v9 = AftermathFeedPricesUpdated{
            oracle_id         : 0x2::object::id<OracleV2>(arg0),
            sui_price         : v7,
            usdc_price        : v8,
            sui_published_ms  : v3,
            usdc_published_ms : v5,
        };
        0x2::event::emit<AftermathFeedPricesUpdated>(v9);
    }

    entry fun remove_authority(arg0: &mut OracleV2, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 13906835286739910655);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.authority, &v0), 13906835295329845247);
        assert!(0x2::vec_set::length<address>(&arg0.authority) > 1, 13906835312509714431);
        0x2::vec_set::remove<address>(&mut arg0.authority, &arg1);
    }

    public fun set_aftermath_feed_enabled(arg0: &mut OracleV2, arg1: &0x2::package::UpgradeCap, arg2: bool) {
        assert_aftermath_admin(arg1);
        apply_aftermath_feed_enabled(arg0, arg2);
    }

    fun to_decimal(arg0: u64, arg1: u16) : u64 {
        if (arg1 > 8) {
            arg0 / 0x1::u64::pow(10, ((arg1 - 8) as u8))
        } else {
            arg0 * 0x1::u64::pow(10, ((8 - arg1) as u8))
        }
    }

    entry fun update_allow_delay_sec(arg0: &mut OracleV2, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 3, 13906835355459387391);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.authority, &v0), 13906835364049321983);
        assert!(arg1 > 0, 13906835381229191167);
        arg0.allow_delay_sec = arg1;
    }

    public fun update_latest_price(arg0: &mut OracleV2, arg1: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        do_update_latest_price(arg0, 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(&arg1), 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds(&arg1), arg2);
    }

    public fun update_latest_price_v2(arg0: &mut OracleV2, arg1: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        do_update_latest_price(arg0, 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::timestamp(&arg1), 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::feeds(&arg1), arg2);
    }

    fun update_price(arg0: &mut Price, arg1: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed, arg2: u64, arg3: u64, arg4: bool) {
        assert!(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(arg1) == arg0.feed_id, 13906836450676047871);
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::price(arg1);
        let v1 = 0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v0);
        let v2 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v1);
        let v3 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::ema_price(arg1);
        let v4 = 0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v3);
        let v5 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v4);
        let v6 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(arg1);
        let v7 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&mut v6);
        let v8 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v7);
        let v9 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_update_timestamp(arg1);
        let v10 = 0x1::option::extract<0x1::option::Option<u64>>(&mut v9);
        let v11 = 0x1::option::extract<u64>(&mut v10) / 1000000;
        let v12 = v11;
        assert!(check_price_fresh(v11, arg2, arg3), 13906836476445851647);
        if (arg4) {
            let v13 = v11 / 600 * 600;
            v12 = v13;
            if (arg0.update_timestamp == v13) {
                return
            };
        } else if (arg0.update_timestamp >= v11) {
            return
        };
        let v14 = to_decimal(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v2), v8);
        let v15 = to_decimal(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v5), v8);
        assert!(v14 > 0 && v15 > 0, 13906836558050230271);
        arg0.price = v14;
        arg0.ema_price = v15;
        arg0.update_timestamp = v12;
    }

    public fun update_settle_price(arg0: &mut OracleV2, arg1: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        do_update_settle_price(arg0, 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(&arg1), 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds(&arg1), arg2, arg4);
    }

    public fun update_settle_price_v2(arg0: &mut OracleV2, arg1: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        do_update_settle_price(arg0, 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::timestamp(&arg1), 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::feeds(&arg1), arg2, arg4);
    }

    entry fun upgrade(arg0: &mut OracleV2, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.authority, &v0), 13906835192250630143);
        arg0.version = 3;
    }

    // decompiled from Move bytecode v7
}

