module 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Store has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        treasury: address,
        fee_bps: u64,
        refund_window_ms: u64,
        usdc_type: 0x1::ascii::String,
        max_age_s: u64,
        max_conf_bps: u64,
        min_price_e8: u64,
        max_price_e8: u64,
        slugs: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        studios: u64,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : Store {
        Store{
            id               : 0x2::object::new(arg0),
            version          : 1,
            paused           : false,
            treasury         : 0x2::tx_context::sender(arg0),
            fee_bps          : 500,
            refund_window_ms : 172800000,
            usdc_type        : 0x1::ascii::string(b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC"),
            max_age_s        : 60,
            max_conf_bps     : 100,
            min_price_e8     : 10000000,
            max_price_e8     : 2000000000,
            slugs            : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
            studios          : 0,
        }
    }

    public(friend) fun add_slug(arg0: &mut Store, arg1: 0x1::string::String, arg2: 0x2::object::ID) {
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.slugs, arg1), 112);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.slugs, arg1, arg2);
    }

    public(friend) fun assert_current(arg0: &Store) {
        assert!(arg0.version == 1, 101);
    }

    public(friend) fun assert_live(arg0: &Store) {
        assert_current(arg0);
        assert!(!arg0.paused, 102);
    }

    public(friend) fun assert_usdc<T0>(arg0: &Store) {
        assert!(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()) == arg0.usdc_type, 111);
    }

    public fun bps_of(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public(friend) fun count_studio(arg0: &mut Store) {
        arg0.studios = arg0.studios + 1;
    }

    public fun fee_bps(arg0: &Store) : u64 {
        arg0.fee_bps
    }

    public fun game_count(arg0: &Store) : u64 {
        0x2::table::length<0x1::string::String, 0x2::object::ID>(&arg0.slugs)
    }

    public fun game_id(arg0: &Store, arg1: 0x1::string::String) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.slugs, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.slugs, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new(arg0);
        0x2::transfer::share_object<Store>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Store) {
        assert!(arg1.version < 1, 113);
        arg1.version = 1;
    }

    public fun oracle_params(arg0: &Store) : (u64, u64, u64, u64) {
        (arg0.max_age_s, arg0.max_conf_bps, arg0.min_price_e8, arg0.max_price_e8)
    }

    public fun paused(arg0: &Store) : bool {
        arg0.paused
    }

    fun pow10(arg0: u64) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun read_price(arg0: &Store, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(arg1);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price_identifier(v0);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1) == x"23d7315113f5b1d3ba7a83604c44b94d79f4fd69af77f804fc7f920a6dc65744", 106);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(v0);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v2);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v3), 107);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3);
        assert!(v4 > 0, 107);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v2) + arg0.max_age_s >= 0x2::clock::timestamp_ms(arg2) / 1000, 108);
        assert!((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v2) as u128) * (10000 as u128) <= (v4 as u128) * (arg0.max_conf_bps as u128), 109);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v2);
        let v6 = to_e8(v4, &v5);
        assert!(v6 >= (arg0.min_price_e8 as u128) && v6 <= (arg0.max_price_e8 as u128), 110);
        (v6 as u64)
    }

    public fun refund_window_ms(arg0: &Store) : u64 {
        arg0.refund_window_ms
    }

    public fun set_fee_bps(arg0: &AdminCap, arg1: &mut Store, arg2: u64) {
        assert_current(arg1);
        assert!(arg2 <= 1000, 103);
        arg1.fee_bps = arg2;
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::events::fee_set(arg2);
    }

    public fun set_oracle_params(arg0: &AdminCap, arg1: &mut Store, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert_current(arg1);
        assert!(arg2 > 0 && arg2 <= 300, 105);
        assert!(arg3 > 0 && arg3 <= 500, 105);
        assert!(arg4 >= 1000000 && arg5 <= 100000000000, 105);
        assert!(arg4 < arg5, 105);
        arg1.max_age_s = arg2;
        arg1.max_conf_bps = arg3;
        arg1.min_price_e8 = arg4;
        arg1.max_price_e8 = arg5;
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::events::oracle_params_set(arg2, arg3, arg4, arg5);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Store, arg2: bool) {
        arg1.paused = arg2;
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::events::store_paused(arg2);
    }

    public fun set_refund_window_ms(arg0: &AdminCap, arg1: &mut Store, arg2: u64) {
        assert_current(arg1);
        assert!(arg2 <= 1209600000, 104);
        arg1.refund_window_ms = arg2;
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::events::refund_window_set(arg2);
    }

    public fun set_treasury(arg0: &AdminCap, arg1: &mut Store, arg2: address) {
        assert_current(arg1);
        arg1.treasury = arg2;
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::events::treasury_set(arg2);
    }

    public fun studio_count(arg0: &Store) : u64 {
        arg0.studios
    }

    fun to_e8(arg0: u64, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) : u128 {
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(arg1)) {
            let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(arg1);
            assert!(v1 <= 30, 107);
            if (v1 >= 8) {
                (arg0 as u128) / pow10(v1 - 8)
            } else {
                (arg0 as u128) * pow10(8 - v1)
            }
        } else {
            let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(arg1);
            assert!(v2 <= 10, 107);
            (arg0 as u128) * pow10(8 + v2)
        }
    }

    public fun treasury(arg0: &Store) : address {
        arg0.treasury
    }

    public fun usd_to_mist(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg1 as u128);
        ((((arg0 as u128) * 100000000000 + v0 - 1) / v0) as u64)
    }

    public fun usdc_type(arg0: &Store) : 0x1::ascii::String {
        arg0.usdc_type
    }

    public fun version(arg0: &Store) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

