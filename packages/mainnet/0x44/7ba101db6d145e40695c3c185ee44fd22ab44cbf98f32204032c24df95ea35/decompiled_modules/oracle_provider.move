module 0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::oracle_provider {
    struct PriceData has copy, drop {
        price: u64,
        timestamp: u64,
        is_fresh: bool,
    }

    struct OracleProvider has key {
        id: 0x2::object::UID,
        version: u64,
        name: 0x1::string::String,
        price_feeds: 0x2::table::Table<0x1::string::String, PriceFeedConfig>,
        staleness_threshold: u64,
        is_paused: bool,
        manual_price_configs: 0x2::table::Table<0x1::string::String, ManualPriceConfig>,
        price_update_requests: 0x2::table::Table<u64, PriceUpdateRequest>,
        next_request_id: u64,
        owner: address,
    }

    struct PriceFeedConfig has copy, drop, store {
        asset_id: 0x1::string::String,
        pyth_feed_id: vector<u8>,
        token_decimals: u8,
    }

    struct ManualPriceConfig has copy, drop, store {
        asset_id: 0x1::string::String,
        enabled: bool,
        current_price: u64,
        last_update_timestamp: u64,
        last_direct_update_timestamp: u64,
        last_updater: address,
        authorized_admins: vector<address>,
        price_change_threshold_bp: u64,
        direct_update_cooldown_ms: u64,
        required_signatures: u64,
    }

    struct PriceUpdateRequest has copy, drop, store {
        request_id: u64,
        asset_id: 0x1::string::String,
        old_price: u64,
        new_price: u64,
        change_percentage_bp: u64,
        proposer: address,
        signatures: vector<address>,
        created_at: u64,
        expires_at: u64,
        executed: bool,
    }

    struct ManualPriceDirectUpdateEvent has copy, drop {
        asset_id: 0x1::string::String,
        old_price: u64,
        new_price: u64,
        change_percentage_bp: u64,
        updater: address,
        timestamp: u64,
    }

    struct PriceUpdateRequestCreatedEvent has copy, drop {
        asset_id: 0x1::string::String,
        request_id: u64,
        old_price: u64,
        new_price: u64,
        change_percentage_bp: u64,
        proposer: address,
        required_signatures: u64,
        timestamp: u64,
    }

    struct PriceUpdateRequestSignedEvent has copy, drop {
        asset_id: 0x1::string::String,
        request_id: u64,
        signer: address,
        signature_count: u64,
        timestamp: u64,
    }

    struct PriceUpdateRequestExecutedEvent has copy, drop {
        asset_id: 0x1::string::String,
        request_id: u64,
        old_price: u64,
        new_price: u64,
        executor: address,
        timestamp: u64,
    }

    struct ManualPriceConfigUpdatedEvent has copy, drop {
        asset_id: 0x1::string::String,
        enabled: bool,
        authorized_admins: vector<address>,
        price_change_threshold_bp: u64,
        direct_update_cooldown_ms: u64,
        required_signatures: u64,
        timestamp: u64,
    }

    struct ORACLE_PROVIDER has drop {
        dummy_field: bool,
    }

    fun calculate_price_change_percentage(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            return 10000
        };
        let v0 = if (arg1 > arg0) {
            arg1 - arg0
        } else {
            arg0 - arg1
        };
        (((v0 as u128) * 10000 / (arg0 as u128)) as u64)
    }

    public fun configure_price_feed(arg0: &mut OracleProvider, arg1: 0x1::string::String, arg2: vector<u8>, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 16);
        assert!(arg3 <= 18, 7);
        let v0 = PriceFeedConfig{
            asset_id       : arg1,
            pyth_feed_id   : arg2,
            token_decimals : arg3,
        };
        if (0x2::table::contains<0x1::string::String, PriceFeedConfig>(&arg0.price_feeds, arg1)) {
            0x2::table::remove<0x1::string::String, PriceFeedConfig>(&mut arg0.price_feeds, arg1);
        };
        0x2::table::add<0x1::string::String, PriceFeedConfig>(&mut arg0.price_feeds, arg1, v0);
    }

    public fun create_and_share_provider(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleProvider{
            id                    : 0x2::object::new(arg0),
            version               : 1000000,
            name                  : 0x1::string::utf8(b"Pyth Oracle v1.0.0"),
            price_feeds           : 0x2::table::new<0x1::string::String, PriceFeedConfig>(arg0),
            staleness_threshold   : 300000,
            is_paused             : false,
            manual_price_configs  : 0x2::table::new<0x1::string::String, ManualPriceConfig>(arg0),
            price_update_requests : 0x2::table::new<u64, PriceUpdateRequest>(arg0),
            next_request_id       : 0,
            owner                 : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<OracleProvider>(v0);
    }

    public fun create_price_update_request(arg0: &mut OracleProvider, arg1: 0x1::string::String, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        assert!(arg2 > 0, 15);
        assert!(0x2::table::contains<0x1::string::String, ManualPriceConfig>(&arg0.manual_price_configs, arg1), 14);
        let v0 = 0x2::table::borrow<0x1::string::String, ManualPriceConfig>(&arg0.manual_price_configs, arg1);
        assert!(v0.enabled, 14);
        let v1 = 0x2::tx_context::sender(arg4);
        verify_authorized_admin(v0, v1);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = calculate_price_change_percentage(v0.current_price, arg2);
        let v4 = arg0.next_request_id;
        arg0.next_request_id = arg0.next_request_id + 1;
        let v5 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v5, v1);
        let v6 = PriceUpdateRequest{
            request_id           : v4,
            asset_id             : arg1,
            old_price            : v0.current_price,
            new_price            : arg2,
            change_percentage_bp : v3,
            proposer             : v1,
            signatures           : v5,
            created_at           : v2,
            expires_at           : v2 + 86400000,
            executed             : false,
        };
        0x2::table::add<u64, PriceUpdateRequest>(&mut arg0.price_update_requests, v4, v6);
        let v7 = PriceUpdateRequestCreatedEvent{
            asset_id             : arg1,
            request_id           : v4,
            old_price            : v0.current_price,
            new_price            : arg2,
            change_percentage_bp : v3,
            proposer             : v1,
            required_signatures  : v0.required_signatures,
            timestamp            : v2,
        };
        0x2::event::emit<PriceUpdateRequestCreatedEvent>(v7);
        v4
    }

    public fun get_asset_price(arg0: &OracleProvider, arg1: 0x1::string::String, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) : u64 {
        assert!(!arg0.is_paused, 5);
        if (0x2::table::contains<0x1::string::String, ManualPriceConfig>(&arg0.manual_price_configs, arg1)) {
            let v0 = 0x2::table::borrow<0x1::string::String, ManualPriceConfig>(&arg0.manual_price_configs, arg1);
            if (v0.enabled) {
                return v0.current_price
            };
        };
        get_pyth_price(arg0, arg1, arg2, arg3, arg4)
    }

    public fun get_asset_price_data(arg0: &OracleProvider, arg1: 0x1::string::String, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) : PriceData {
        assert!(!arg0.is_paused, 5);
        if (0x2::table::contains<0x1::string::String, ManualPriceConfig>(&arg0.manual_price_configs, arg1)) {
            let v0 = 0x2::table::borrow<0x1::string::String, ManualPriceConfig>(&arg0.manual_price_configs, arg1);
            if (v0.enabled) {
                return PriceData{
                    price     : v0.current_price,
                    timestamp : v0.last_update_timestamp,
                    is_fresh  : true,
                }
            };
        };
        get_pyth_price_data(arg0, arg1, arg2, arg3, arg4)
    }

    fun get_current_price_from_pyth(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &vector<u8>, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1) == *arg2, 4);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price(arg0, arg1, arg3);
        assert!(0x2::clock::timestamp_ms(arg3) - 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v2) <= 300000, 1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v2);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v3), 2);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v2);
        let v5 = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v4)) {
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v4);
            if (v6 > (8 as u64)) {
                (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3) as u128) / 0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::math_utils::safe_pow(10, ((v6 - (8 as u64)) as u128))
            } else {
                0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::math_utils::safe_mul_u128((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3) as u128), 0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::math_utils::safe_pow(10, (((8 as u64) - v6) as u128)))
            }
        } else {
            0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::math_utils::safe_mul_u128((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3) as u128), 0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::math_utils::safe_pow(10, ((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4) + (8 as u64)) as u128)))
        };
        assert!(v5 <= 18446744073709551615, 3);
        (v5 as u64)
    }

    public fun get_manual_price_config(arg0: &OracleProvider, arg1: 0x1::string::String) : &ManualPriceConfig {
        0x2::table::borrow<0x1::string::String, ManualPriceConfig>(&arg0.manual_price_configs, arg1)
    }

    public fun get_manual_price_data(arg0: &OracleProvider, arg1: 0x1::string::String, arg2: &0x2::clock::Clock) : PriceData {
        let v0 = 0x2::table::borrow<0x1::string::String, ManualPriceConfig>(&arg0.manual_price_configs, arg1);
        PriceData{
            price     : v0.current_price,
            timestamp : v0.last_update_timestamp,
            is_fresh  : true,
        }
    }

    fun get_price_data_from_pyth(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &vector<u8>, arg3: &0x2::clock::Clock) : PriceData {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1) == *arg2, 4);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price(arg0, arg1, arg3);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v2);
        let v4 = 0x2::clock::timestamp_ms(arg3) - v3 <= 300000;
        assert!(v4, 1);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v2);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v5), 2);
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v2);
        let v7 = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v6)) {
            let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v6);
            if (v8 > (8 as u64)) {
                (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v5) as u128) / 0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::math_utils::safe_pow(10, ((v8 - (8 as u64)) as u128))
            } else {
                0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::math_utils::safe_mul_u128((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v5) as u128), 0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::math_utils::safe_pow(10, (((8 as u64) - v8) as u128)))
            }
        } else {
            0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::math_utils::safe_mul_u128((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v5) as u128), 0x447ba101db6d145e40695c3c185ee44fd22ab44cbf98f32204032c24df95ea35::math_utils::safe_pow(10, ((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v6) + (8 as u64)) as u128)))
        };
        assert!(v7 <= 18446744073709551615, 3);
        PriceData{
            price     : (v7 as u64),
            timestamp : v3,
            is_fresh  : v4,
        }
    }

    public fun get_price_decimals(arg0: &OracleProvider) : u8 {
        8
    }

    public fun get_price_timestamp(arg0: &PriceData) : u64 {
        arg0.timestamp
    }

    public fun get_price_update_request(arg0: &OracleProvider, arg1: u64) : &PriceUpdateRequest {
        0x2::table::borrow<u64, PriceUpdateRequest>(&arg0.price_update_requests, arg1)
    }

    public fun get_price_value(arg0: &PriceData) : u64 {
        arg0.price
    }

    public fun get_provider_name(arg0: &OracleProvider) : 0x1::string::String {
        arg0.name
    }

    fun get_pyth_price(arg0: &OracleProvider, arg1: 0x1::string::String, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) : u64 {
        assert!(0x2::table::contains<0x1::string::String, PriceFeedConfig>(&arg0.price_feeds, arg1), 6);
        get_current_price_from_pyth(arg2, arg3, &0x2::table::borrow<0x1::string::String, PriceFeedConfig>(&arg0.price_feeds, arg1).pyth_feed_id, arg4)
    }

    fun get_pyth_price_data(arg0: &OracleProvider, arg1: 0x1::string::String, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) : PriceData {
        assert!(0x2::table::contains<0x1::string::String, PriceFeedConfig>(&arg0.price_feeds, arg1), 6);
        get_price_data_from_pyth(arg2, arg3, &0x2::table::borrow<0x1::string::String, PriceFeedConfig>(&arg0.price_feeds, arg1).pyth_feed_id, arg4)
    }

    public fun get_token_decimals(arg0: &OracleProvider, arg1: 0x1::string::String) : u8 {
        assert!(0x2::table::contains<0x1::string::String, PriceFeedConfig>(&arg0.price_feeds, arg1), 6);
        0x2::table::borrow<0x1::string::String, PriceFeedConfig>(&arg0.price_feeds, arg1).token_decimals
    }

    public fun get_version(arg0: &OracleProvider) : u64 {
        arg0.version
    }

    fun init(arg0: ORACLE_PROVIDER, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun initialize_manual_price(arg0: &mut OracleProvider, arg1: 0x1::string::String, arg2: u64, arg3: vector<address>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == arg0.owner, 16);
        assert!(arg2 > 0, 15);
        assert!(0x1::vector::length<address>(&arg3) > 0, 8);
        assert!(arg6 > 0, 13);
        assert!(arg6 <= 0x1::vector::length<address>(&arg3), 13);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = ManualPriceConfig{
            asset_id                     : arg1,
            enabled                      : true,
            current_price                : arg2,
            last_update_timestamp        : v0,
            last_direct_update_timestamp : 0,
            last_updater                 : 0x2::tx_context::sender(arg8),
            authorized_admins            : arg3,
            price_change_threshold_bp    : arg4,
            direct_update_cooldown_ms    : arg5,
            required_signatures          : arg6,
        };
        if (0x2::table::contains<0x1::string::String, ManualPriceConfig>(&arg0.manual_price_configs, arg1)) {
            0x2::table::remove<0x1::string::String, ManualPriceConfig>(&mut arg0.manual_price_configs, arg1);
        };
        0x2::table::add<0x1::string::String, ManualPriceConfig>(&mut arg0.manual_price_configs, arg1, v1);
        let v2 = ManualPriceConfigUpdatedEvent{
            asset_id                  : arg1,
            enabled                   : true,
            authorized_admins         : v1.authorized_admins,
            price_change_threshold_bp : arg4,
            direct_update_cooldown_ms : arg5,
            required_signatures       : arg6,
            timestamp                 : v0,
        };
        0x2::event::emit<ManualPriceConfigUpdatedEvent>(v2);
    }

    public fun is_authorized_admin(arg0: &OracleProvider, arg1: 0x1::string::String, arg2: address) : bool {
        if (!0x2::table::contains<0x1::string::String, ManualPriceConfig>(&arg0.manual_price_configs, arg1)) {
            return false
        };
        0x1::vector::contains<address>(&0x2::table::borrow<0x1::string::String, ManualPriceConfig>(&arg0.manual_price_configs, arg1).authorized_admins, &arg2)
    }

    public fun is_manual_price_enabled(arg0: &OracleProvider, arg1: 0x1::string::String) : bool {
        if (!0x2::table::contains<0x1::string::String, ManualPriceConfig>(&arg0.manual_price_configs, arg1)) {
            return false
        };
        0x2::table::borrow<0x1::string::String, ManualPriceConfig>(&arg0.manual_price_configs, arg1).enabled
    }

    public fun is_paused(arg0: &OracleProvider) : bool {
        arg0.is_paused
    }

    public fun is_price_data_fresh(arg0: &PriceData) : bool {
        arg0.is_fresh
    }

    public fun is_price_fresh(arg0: &OracleProvider, arg1: 0x1::string::String, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) : bool {
        if (is_manual_price_enabled(arg0, arg1)) {
            return true
        };
        if (!0x2::table::contains<0x1::string::String, PriceFeedConfig>(&arg0.price_feeds, arg1)) {
            return false
        };
        is_pyth_price_fresh(arg2, arg3, arg4)
    }

    fun is_pyth_price_fresh(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : bool {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price(arg0, arg1, arg2);
        0x2::clock::timestamp_ms(arg2) - 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0) <= 300000
    }

    public fun set_paused(arg0: &mut OracleProvider, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 16);
        if (arg0.is_paused == arg1) {
            return
        };
        arg0.is_paused = arg1;
    }

    public fun sign_price_update_request(arg0: &mut OracleProvider, arg1: 0x1::string::String, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, PriceUpdateRequest>(&arg0.price_update_requests, arg2), 11);
        let v0 = 0x2::table::borrow_mut<u64, PriceUpdateRequest>(&mut arg0.price_update_requests, arg2);
        assert!(!v0.executed, 18);
        assert!(v0.asset_id == arg1, 11);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 <= v0.expires_at, 17);
        let v2 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<0x1::string::String, ManualPriceConfig>(&arg0.manual_price_configs, arg1), 14);
        let v3 = 0x2::table::borrow<0x1::string::String, ManualPriceConfig>(&arg0.manual_price_configs, arg1);
        verify_authorized_admin(v3, v2);
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(&v0.signatures)) {
            assert!(*0x1::vector::borrow<address>(&v0.signatures, v4) != v2, 12);
            v4 = v4 + 1;
        };
        0x1::vector::push_back<address>(&mut v0.signatures, v2);
        let v5 = 0x1::vector::length<address>(&v0.signatures);
        let v6 = PriceUpdateRequestSignedEvent{
            asset_id        : arg1,
            request_id      : arg2,
            signer          : v2,
            signature_count : v5,
            timestamp       : v1,
        };
        0x2::event::emit<PriceUpdateRequestSignedEvent>(v6);
        if (v5 >= v3.required_signatures) {
            let v7 = 0x2::table::borrow_mut<0x1::string::String, ManualPriceConfig>(&mut arg0.manual_price_configs, arg1);
            v7.current_price = v0.new_price;
            v7.last_update_timestamp = v1;
            v7.last_updater = v2;
            v0.executed = true;
            let v8 = PriceUpdateRequestExecutedEvent{
                asset_id   : arg1,
                request_id : arg2,
                old_price  : v7.current_price,
                new_price  : v0.new_price,
                executor   : v2,
                timestamp  : v1,
            };
            0x2::event::emit<PriceUpdateRequestExecutedEvent>(v8);
        };
    }

    public fun transfer_ownership(arg0: &mut OracleProvider, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 16);
        if (arg0.owner == arg1) {
            return
        };
        arg0.owner = arg1;
    }

    public fun update_manual_price_direct(arg0: &mut OracleProvider, arg1: 0x1::string::String, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 15);
        assert!(0x2::table::contains<0x1::string::String, ManualPriceConfig>(&arg0.manual_price_configs, arg1), 14);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, ManualPriceConfig>(&mut arg0.manual_price_configs, arg1);
        assert!(v0.enabled, 14);
        let v1 = 0x2::tx_context::sender(arg4);
        verify_authorized_admin(v0, v1);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        verify_cooldown_period(v0, v2);
        let v3 = calculate_price_change_percentage(v0.current_price, arg2);
        assert!(v3 <= v0.price_change_threshold_bp, 9);
        v0.current_price = arg2;
        v0.last_update_timestamp = v2;
        v0.last_direct_update_timestamp = v2;
        v0.last_updater = v1;
        let v4 = ManualPriceDirectUpdateEvent{
            asset_id             : arg1,
            old_price            : v0.current_price,
            new_price            : arg2,
            change_percentage_bp : v3,
            updater              : v1,
            timestamp            : v2,
        };
        0x2::event::emit<ManualPriceDirectUpdateEvent>(v4);
    }

    public fun validate_price_feed(arg0: &OracleProvider, arg1: 0x1::string::String, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : bool {
        if (is_manual_price_enabled(arg0, arg1)) {
            return true
        };
        if (!0x2::table::contains<0x1::string::String, PriceFeedConfig>(&arg0.price_feeds, arg1)) {
            return false
        };
        validate_price_feed_id(arg2, &0x2::table::borrow<0x1::string::String, PriceFeedConfig>(&arg0.price_feeds, arg1).pyth_feed_id)
    }

    fun validate_price_feed_id(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &vector<u8>) : bool {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1) == *arg1
    }

    fun verify_authorized_admin(arg0: &ManualPriceConfig, arg1: address) {
        assert!(0x1::vector::contains<address>(&arg0.authorized_admins, &arg1), 8);
    }

    fun verify_cooldown_period(arg0: &ManualPriceConfig, arg1: u64) {
        let v0 = if (arg1 >= arg0.last_direct_update_timestamp) {
            arg1 - arg0.last_direct_update_timestamp
        } else {
            0
        };
        assert!(v0 >= arg0.direct_update_cooldown_ms, 10);
    }

    // decompiled from Move bytecode v6
}

