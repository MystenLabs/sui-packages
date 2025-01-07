module 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::config {
    struct OracleConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        vec_feeds: vector<address>,
        feeds: 0x2::table::Table<address, PriceFeed>,
    }

    struct PriceFeed has store {
        id: 0x2::object::UID,
        enable: bool,
        max_timestamp_diff: u64,
        price_diff_threshold1: u64,
        price_diff_threshold2: u64,
        max_duration_within_thresholds: u64,
        diff_threshold2_timer: u64,
        maximum_allowed_span_percentage: u64,
        maximum_effective_price: u256,
        minimum_effective_price: u256,
        oracle_id: u8,
        coin_type: 0x1::ascii::String,
        primary: 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider,
        secondary: 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider,
        oracle_provider_configs: 0x2::table::Table<0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider, 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProviderConfig>,
        historical_price_ttl: u64,
        history: History,
    }

    struct History has copy, store {
        price: u256,
        updated_time: u64,
    }

    struct ConfigCreated has copy, drop {
        sender: address,
        id: address,
    }

    struct ConfigSetPaused has copy, drop {
        config: address,
        value: bool,
        before_value: bool,
    }

    struct PriceFeedCreated has copy, drop {
        sender: address,
        config: address,
        feed_id: address,
    }

    struct PriceFeedSetEnable has copy, drop {
        config: address,
        feed_id: address,
        value: bool,
        before_value: bool,
    }

    struct PriceFeedSetMaxTimestampDiff has copy, drop {
        config: address,
        feed_id: address,
        value: u64,
        before_value: u64,
    }

    struct PriceFeedSetPriceDiffRatio1 has copy, drop {
        config: address,
        feed_id: address,
        value: u64,
        before_value: u64,
    }

    struct PriceFeedSetPriceDiffRatio2 has copy, drop {
        config: address,
        feed_id: address,
        value: u64,
        before_value: u64,
    }

    struct PriceFeedSetMaximumAllowedRatio2TTL has copy, drop {
        config: address,
        feed_id: address,
        value: u64,
        before_value: u64,
    }

    struct PriceFeedSetMaximumAllowedSpanPercentage has copy, drop {
        config: address,
        feed_id: address,
        value: u64,
        before_value: u64,
    }

    struct PriceFeedSetMaximumEffectivePrice has copy, drop {
        config: address,
        feed_id: address,
        value: u256,
        before_value: u256,
    }

    struct PriceFeedSetMinimumEffectivePrice has copy, drop {
        config: address,
        feed_id: address,
        value: u256,
        before_value: u256,
    }

    struct PriceFeedSetOracleId has copy, drop {
        config: address,
        feed_id: address,
        value: u8,
        before_value: u8,
    }

    struct SetOracleProvider has copy, drop {
        config: address,
        feed_id: address,
        is_primary: bool,
        provider: vector<u8>,
        before_provider: vector<u8>,
    }

    struct OracleProviderConfigCreated has copy, drop {
        config: address,
        feed_id: address,
        provider: 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider,
        pair_id: vector<u8>,
    }

    struct OracleProviderConfigSetPairId has copy, drop {
        config: address,
        feed_id: address,
        provider: 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider,
        value: vector<u8>,
        before_value: vector<u8>,
    }

    struct OracleProviderConfigSetEnable has copy, drop {
        config: address,
        feed_id: address,
        provider: 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider,
        value: bool,
        before_value: bool,
    }

    struct PriceFeedSetHistoricalPriceTTL has copy, drop {
        config: address,
        feed_id: address,
        value: u64,
        before_value: u64,
    }

    struct PriceFeedRatio2UsageStartTimeUpdated has copy, drop {
        feed_id: address,
        updated_at: u64,
    }

    struct PriceFeedRatio2UsageStartTimeReset has copy, drop {
        feed_id: address,
        started_at: u64,
    }

    public fun get_coin_type(arg0: &OracleConfig, arg1: address) : 0x1::ascii::String {
        get_price_feed(arg0, arg1).coin_type
    }

    public fun get_coin_type_from_feed(arg0: &PriceFeed) : 0x1::ascii::String {
        arg0.coin_type
    }

    public fun get_config_id_to_address(arg0: &OracleConfig) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun get_diff_threshold2_timer(arg0: &OracleConfig, arg1: address) : u64 {
        get_price_feed(arg0, arg1).diff_threshold2_timer
    }

    public fun get_diff_threshold2_timer_from_feed(arg0: &PriceFeed) : u64 {
        arg0.diff_threshold2_timer
    }

    public fun get_feeds(arg0: &OracleConfig) : &0x2::table::Table<address, PriceFeed> {
        &arg0.feeds
    }

    public fun get_historical_price_ttl(arg0: &PriceFeed) : u64 {
        arg0.historical_price_ttl
    }

    public fun get_history_price_data_from_feed(arg0: &PriceFeed) : (u256, u64) {
        let v0 = &arg0.history;
        (v0.price, v0.updated_time)
    }

    public fun get_history_price_from_feed(arg0: &PriceFeed) : History {
        arg0.history
    }

    public fun get_max_duration_within_thresholds(arg0: &OracleConfig, arg1: address) : u64 {
        get_price_feed(arg0, arg1).max_duration_within_thresholds
    }

    public fun get_max_duration_within_thresholds_from_feed(arg0: &PriceFeed) : u64 {
        arg0.max_duration_within_thresholds
    }

    public fun get_max_timestamp_diff(arg0: &OracleConfig, arg1: address) : u64 {
        get_price_feed(arg0, arg1).max_timestamp_diff
    }

    public fun get_max_timestamp_diff_from_feed(arg0: &PriceFeed) : u64 {
        arg0.max_timestamp_diff
    }

    public fun get_maximum_allowed_span_percentage(arg0: &OracleConfig, arg1: address) : u64 {
        get_price_feed(arg0, arg1).maximum_allowed_span_percentage
    }

    public fun get_maximum_allowed_span_percentage_from_feed(arg0: &PriceFeed) : u64 {
        arg0.maximum_allowed_span_percentage
    }

    public fun get_maximum_effective_price(arg0: &OracleConfig, arg1: address) : u256 {
        get_price_feed(arg0, arg1).maximum_effective_price
    }

    public fun get_maximum_effective_price_from_feed(arg0: &PriceFeed) : u256 {
        arg0.maximum_effective_price
    }

    public fun get_minimum_effective_price(arg0: &OracleConfig, arg1: address) : u256 {
        get_price_feed(arg0, arg1).minimum_effective_price
    }

    public fun get_minimum_effective_price_from_feed(arg0: &PriceFeed) : u256 {
        arg0.minimum_effective_price
    }

    public fun get_oracle_id(arg0: &OracleConfig, arg1: address) : u8 {
        get_price_feed(arg0, arg1).oracle_id
    }

    public fun get_oracle_id_from_feed(arg0: &PriceFeed) : u8 {
        arg0.oracle_id
    }

    public fun get_oracle_provider_config(arg0: &OracleConfig, arg1: address, arg2: 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider) : &0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProviderConfig {
        let v0 = get_price_feed(arg0, arg1);
        assert!(0x2::table::contains<0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider, 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProviderConfig>(&v0.oracle_provider_configs, arg2), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::oracle_provider_config_not_found());
        0x2::table::borrow<0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider, 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProviderConfig>(&v0.oracle_provider_configs, arg2)
    }

    public fun get_oracle_provider_config_from_feed(arg0: &PriceFeed, arg1: 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider) : &0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProviderConfig {
        assert!(0x2::table::contains<0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider, 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProviderConfig>(&arg0.oracle_provider_configs, arg1), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::oracle_provider_config_not_found());
        0x2::table::borrow<0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider, 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProviderConfig>(&arg0.oracle_provider_configs, arg1)
    }

    public fun get_oracle_provider_configs(arg0: &OracleConfig, arg1: address) : &0x2::table::Table<0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider, 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProviderConfig> {
        &get_price_feed(arg0, arg1).oracle_provider_configs
    }

    public fun get_oracle_provider_configs_from_feed(arg0: &PriceFeed) : &0x2::table::Table<0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider, 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProviderConfig> {
        &arg0.oracle_provider_configs
    }

    public fun get_oracle_provider_from_oracle_provider_config(arg0: &0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProviderConfig) : 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider {
        0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::get_provider_from_oracle_provider_config(arg0)
    }

    public fun get_pair_id(arg0: &OracleConfig, arg1: address, arg2: 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider) : vector<u8> {
        0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::get_pair_id_from_oracle_provider_config(get_oracle_provider_config(arg0, arg1, arg2))
    }

    public fun get_pair_id_from_feed(arg0: &PriceFeed, arg1: 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider) : vector<u8> {
        0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::get_pair_id_from_oracle_provider_config(get_oracle_provider_config_from_feed(arg0, arg1))
    }

    public fun get_pair_id_from_oracle_provider_config(arg0: &0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProviderConfig) : vector<u8> {
        0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::get_pair_id_from_oracle_provider_config(arg0)
    }

    public fun get_price_diff_threshold1(arg0: &OracleConfig, arg1: address) : u64 {
        get_price_feed(arg0, arg1).price_diff_threshold1
    }

    public fun get_price_diff_threshold1_from_feed(arg0: &PriceFeed) : u64 {
        arg0.price_diff_threshold1
    }

    public fun get_price_diff_threshold2(arg0: &OracleConfig, arg1: address) : u64 {
        get_price_feed(arg0, arg1).price_diff_threshold2
    }

    public fun get_price_diff_threshold2_from_feed(arg0: &PriceFeed) : u64 {
        arg0.price_diff_threshold2
    }

    public fun get_price_feed(arg0: &OracleConfig, arg1: address) : &PriceFeed {
        assert!(0x2::table::contains<address, PriceFeed>(&arg0.feeds, arg1), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::price_feed_not_found());
        0x2::table::borrow<address, PriceFeed>(&arg0.feeds, arg1)
    }

    public fun get_price_feed_id(arg0: &OracleConfig, arg1: address) : address {
        0x2::object::uid_to_address(&get_price_feed(arg0, arg1).id)
    }

    public fun get_price_feed_id_from_feed(arg0: &PriceFeed) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public(friend) fun get_price_feed_mut(arg0: &mut OracleConfig, arg1: address) : &mut PriceFeed {
        assert!(0x2::table::contains<address, PriceFeed>(&arg0.feeds, arg1), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::price_feed_not_found());
        0x2::table::borrow_mut<address, PriceFeed>(&mut arg0.feeds, arg1)
    }

    public fun get_price_from_history(arg0: &History) : u256 {
        arg0.price
    }

    public fun get_primary_oracle_provider(arg0: &PriceFeed) : &0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider {
        &arg0.primary
    }

    public fun get_primary_oracle_provider_config(arg0: &PriceFeed) : &0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProviderConfig {
        get_oracle_provider_config_from_feed(arg0, arg0.primary)
    }

    public fun get_secondary_oracle_provider(arg0: &PriceFeed) : &0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider {
        &arg0.secondary
    }

    public fun get_secondary_source_config(arg0: &PriceFeed) : &0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProviderConfig {
        get_oracle_provider_config_from_feed(arg0, arg0.secondary)
    }

    public fun get_updated_time_from_history(arg0: &History) : u64 {
        arg0.updated_time
    }

    public fun get_vec_feeds(arg0: &OracleConfig) : vector<address> {
        arg0.vec_feeds
    }

    public fun is_oracle_provider_config_enable(arg0: &0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProviderConfig) : bool {
        0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::is_oracle_provider_config_enable(arg0)
    }

    public fun is_paused(arg0: &OracleConfig) : bool {
        arg0.paused
    }

    public fun is_price_feed_enable(arg0: &PriceFeed) : bool {
        arg0.enable
    }

    public fun is_price_feed_exists<T0>(arg0: &OracleConfig) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.vec_feeds)) {
            if (0x2::table::borrow<address, PriceFeed>(&arg0.feeds, *0x1::vector::borrow<address>(&arg0.vec_feeds, v0)).coin_type == 0x1::type_name::into_string(0x1::type_name::get<T0>())) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_secondary_oracle_available(arg0: &PriceFeed) : bool {
        let v0 = &arg0.secondary;
        if (0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::is_empty(v0)) {
            return false
        };
        if (v0 == &arg0.primary) {
            return false
        };
        0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::is_oracle_provider_config_enable(0x2::table::borrow<0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider, 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProviderConfig>(&arg0.oracle_provider_configs, *v0))
    }

    public(friend) fun keep_history_update(arg0: &mut PriceFeed, arg1: u256, arg2: u64) {
        let v0 = &mut arg0.history;
        v0.price = arg1;
        v0.updated_time = arg2;
    }

    public(friend) fun new_config(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = OracleConfig{
            id        : v0,
            version   : 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_version::this_version(),
            paused    : false,
            vec_feeds : 0x1::vector::empty<address>(),
            feeds     : 0x2::table::new<address, PriceFeed>(arg0),
        };
        0x2::transfer::share_object<OracleConfig>(v1);
        let v2 = ConfigCreated{
            sender : 0x2::tx_context::sender(arg0),
            id     : 0x2::object::uid_to_address(&v0),
        };
        0x2::event::emit<ConfigCreated>(v2);
    }

    public(friend) fun new_oracle_provider_config(arg0: &mut OracleConfig, arg1: address, arg2: 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider, arg3: vector<u8>, arg4: bool) {
        assert!(0x2::table::contains<address, PriceFeed>(&arg0.feeds, arg1), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::price_feed_not_found());
        let v0 = 0x2::table::borrow_mut<address, PriceFeed>(&mut arg0.feeds, arg1);
        assert!(!0x2::table::contains<0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider, 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProviderConfig>(&v0.oracle_provider_configs, arg2), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::oracle_config_already_exists());
        0x2::table::add<0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider, 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProviderConfig>(&mut v0.oracle_provider_configs, arg2, 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::new_oracle_provider_config(arg2, arg4, arg3));
        let v1 = OracleProviderConfigCreated{
            config   : 0x2::object::uid_to_address(&arg0.id),
            feed_id  : arg1,
            provider : arg2,
            pair_id  : arg3,
        };
        0x2::event::emit<OracleProviderConfigCreated>(v1);
    }

    public(friend) fun new_price_feed<T0>(arg0: &mut OracleConfig, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u256, arg8: u256, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!is_price_feed_exists<T0>(arg0), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::price_feed_already_exists());
        let v0 = 0x2::object::new(arg10);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = History{
            price        : 0,
            updated_time : 0,
        };
        let v3 = PriceFeed{
            id                              : v0,
            enable                          : true,
            max_timestamp_diff              : arg2,
            price_diff_threshold1           : arg3,
            price_diff_threshold2           : arg4,
            max_duration_within_thresholds  : arg5,
            diff_threshold2_timer           : 0,
            maximum_allowed_span_percentage : arg6,
            maximum_effective_price         : arg7,
            minimum_effective_price         : arg8,
            oracle_id                       : arg1,
            coin_type                       : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            primary                         : 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::new_empty_provider(),
            secondary                       : 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::new_empty_provider(),
            oracle_provider_configs         : 0x2::table::new<0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider, 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProviderConfig>(arg10),
            historical_price_ttl            : arg9,
            history                         : v2,
        };
        0x2::table::add<address, PriceFeed>(&mut arg0.feeds, v1, v3);
        0x1::vector::push_back<address>(&mut arg0.vec_feeds, v1);
        let v4 = PriceFeedCreated{
            sender  : 0x2::tx_context::sender(arg10),
            config  : 0x2::object::uid_to_address(&arg0.id),
            feed_id : v1,
        };
        0x2::event::emit<PriceFeedCreated>(v4);
    }

    public(friend) fun reset_diff_threshold2_timer(arg0: &mut PriceFeed) {
        let v0 = arg0.diff_threshold2_timer;
        if (v0 == 0) {
            return
        };
        arg0.diff_threshold2_timer = 0;
        let v1 = PriceFeedRatio2UsageStartTimeReset{
            feed_id    : get_price_feed_id_from_feed(arg0),
            started_at : v0,
        };
        0x2::event::emit<PriceFeedRatio2UsageStartTimeReset>(v1);
    }

    public(friend) fun set_enable_to_price_feed(arg0: &mut OracleConfig, arg1: address, arg2: bool) {
        assert!(0x2::table::contains<address, PriceFeed>(&arg0.feeds, arg1), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::price_feed_not_found());
        let v0 = 0x2::table::borrow_mut<address, PriceFeed>(&mut arg0.feeds, arg1);
        v0.enable = arg2;
        let v1 = PriceFeedSetEnable{
            config       : 0x2::object::uid_to_address(&arg0.id),
            feed_id      : arg1,
            value        : arg2,
            before_value : v0.enable,
        };
        0x2::event::emit<PriceFeedSetEnable>(v1);
    }

    public(friend) fun set_historical_price_ttl_to_price_feed(arg0: &mut OracleConfig, arg1: address, arg2: u64) {
        assert!(0x2::table::contains<address, PriceFeed>(&arg0.feeds, arg1), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::price_feed_not_found());
        let v0 = 0x2::table::borrow_mut<address, PriceFeed>(&mut arg0.feeds, arg1);
        v0.historical_price_ttl = arg2;
        let v1 = PriceFeedSetHistoricalPriceTTL{
            config       : 0x2::object::uid_to_address(&arg0.id),
            feed_id      : arg1,
            value        : arg2,
            before_value : v0.historical_price_ttl,
        };
        0x2::event::emit<PriceFeedSetHistoricalPriceTTL>(v1);
    }

    public(friend) fun set_max_duration_within_thresholds_to_price_feed(arg0: &mut OracleConfig, arg1: address, arg2: u64) {
        assert!(0x2::table::contains<address, PriceFeed>(&arg0.feeds, arg1), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::price_feed_not_found());
        let v0 = 0x2::table::borrow_mut<address, PriceFeed>(&mut arg0.feeds, arg1);
        v0.max_duration_within_thresholds = arg2;
        let v1 = PriceFeedSetMaximumAllowedRatio2TTL{
            config       : 0x2::object::uid_to_address(&arg0.id),
            feed_id      : arg1,
            value        : arg2,
            before_value : v0.max_duration_within_thresholds,
        };
        0x2::event::emit<PriceFeedSetMaximumAllowedRatio2TTL>(v1);
    }

    public(friend) fun set_max_timestamp_diff_to_price_feed(arg0: &mut OracleConfig, arg1: address, arg2: u64) {
        assert!(0x2::table::contains<address, PriceFeed>(&arg0.feeds, arg1), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::price_feed_not_found());
        let v0 = 0x2::table::borrow_mut<address, PriceFeed>(&mut arg0.feeds, arg1);
        v0.max_timestamp_diff = arg2;
        let v1 = PriceFeedSetMaxTimestampDiff{
            config       : 0x2::object::uid_to_address(&arg0.id),
            feed_id      : arg1,
            value        : arg2,
            before_value : v0.max_timestamp_diff,
        };
        0x2::event::emit<PriceFeedSetMaxTimestampDiff>(v1);
    }

    public(friend) fun set_maximum_allowed_span_percentage_to_price_feed(arg0: &mut OracleConfig, arg1: address, arg2: u64) {
        assert!(0x2::table::contains<address, PriceFeed>(&arg0.feeds, arg1), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::price_feed_not_found());
        let v0 = 0x2::table::borrow_mut<address, PriceFeed>(&mut arg0.feeds, arg1);
        v0.maximum_allowed_span_percentage = arg2;
        let v1 = PriceFeedSetMaximumAllowedSpanPercentage{
            config       : 0x2::object::uid_to_address(&arg0.id),
            feed_id      : arg1,
            value        : arg2,
            before_value : v0.maximum_allowed_span_percentage,
        };
        0x2::event::emit<PriceFeedSetMaximumAllowedSpanPercentage>(v1);
    }

    public(friend) fun set_maximum_effective_price_to_price_feed(arg0: &mut OracleConfig, arg1: address, arg2: u256) {
        assert!(0x2::table::contains<address, PriceFeed>(&arg0.feeds, arg1), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::price_feed_not_found());
        let v0 = 0x2::table::borrow_mut<address, PriceFeed>(&mut arg0.feeds, arg1);
        v0.maximum_effective_price = arg2;
        let v1 = PriceFeedSetMaximumEffectivePrice{
            config       : 0x2::object::uid_to_address(&arg0.id),
            feed_id      : arg1,
            value        : arg2,
            before_value : v0.maximum_effective_price,
        };
        0x2::event::emit<PriceFeedSetMaximumEffectivePrice>(v1);
    }

    public(friend) fun set_minimum_effective_price_to_price_feed(arg0: &mut OracleConfig, arg1: address, arg2: u256) {
        assert!(0x2::table::contains<address, PriceFeed>(&arg0.feeds, arg1), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::price_feed_not_found());
        let v0 = 0x2::table::borrow_mut<address, PriceFeed>(&mut arg0.feeds, arg1);
        v0.minimum_effective_price = arg2;
        let v1 = PriceFeedSetMinimumEffectivePrice{
            config       : 0x2::object::uid_to_address(&arg0.id),
            feed_id      : arg1,
            value        : arg2,
            before_value : v0.minimum_effective_price,
        };
        0x2::event::emit<PriceFeedSetMinimumEffectivePrice>(v1);
    }

    public(friend) fun set_oracle_id_to_price_feed(arg0: &mut OracleConfig, arg1: address, arg2: u8) {
        assert!(0x2::table::contains<address, PriceFeed>(&arg0.feeds, arg1), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::price_feed_not_found());
        let v0 = 0x2::table::borrow_mut<address, PriceFeed>(&mut arg0.feeds, arg1);
        v0.oracle_id = arg2;
        let v1 = PriceFeedSetOracleId{
            config       : 0x2::object::uid_to_address(&arg0.id),
            feed_id      : arg1,
            value        : arg2,
            before_value : v0.oracle_id,
        };
        0x2::event::emit<PriceFeedSetOracleId>(v1);
    }

    public(friend) fun set_oracle_provider_config_enable(arg0: &mut OracleConfig, arg1: address, arg2: 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider, arg3: bool) {
        assert!(0x2::table::contains<address, PriceFeed>(&arg0.feeds, arg1), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::price_feed_not_found());
        let v0 = 0x2::table::borrow_mut<address, PriceFeed>(&mut arg0.feeds, arg1);
        assert!(0x2::table::contains<0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider, 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProviderConfig>(&v0.oracle_provider_configs, arg2), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::oracle_provider_config_not_found());
        assert!(v0.primary != arg2, 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::provider_is_being_used_in_primary());
        let v1 = 0x2::table::borrow_mut<0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider, 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProviderConfig>(&mut v0.oracle_provider_configs, arg2);
        0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::set_enable_to_oracle_provider_config(v1, arg3);
        let v2 = OracleProviderConfigSetEnable{
            config       : 0x2::object::uid_to_address(&arg0.id),
            feed_id      : arg1,
            provider     : arg2,
            value        : arg3,
            before_value : 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::is_oracle_provider_config_enable(v1),
        };
        0x2::event::emit<OracleProviderConfigSetEnable>(v2);
    }

    public(friend) fun set_oracle_provider_config_pair_id(arg0: &mut OracleConfig, arg1: address, arg2: 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider, arg3: vector<u8>) {
        assert!(0x2::table::contains<address, PriceFeed>(&arg0.feeds, arg1), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::price_feed_not_found());
        let v0 = 0x2::table::borrow_mut<address, PriceFeed>(&mut arg0.feeds, arg1);
        assert!(0x2::table::contains<0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider, 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProviderConfig>(&v0.oracle_provider_configs, arg2), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::oracle_provider_config_not_found());
        let v1 = 0x2::table::borrow_mut<0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider, 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProviderConfig>(&mut v0.oracle_provider_configs, arg2);
        0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::set_pair_id_to_oracle_provider_config(v1, arg3);
        let v2 = OracleProviderConfigSetPairId{
            config       : 0x2::object::uid_to_address(&arg0.id),
            feed_id      : arg1,
            provider     : arg2,
            value        : arg3,
            before_value : 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::get_pair_id_from_oracle_provider_config(v1),
        };
        0x2::event::emit<OracleProviderConfigSetPairId>(v2);
    }

    public(friend) fun set_pause(arg0: &mut OracleConfig, arg1: bool) {
        arg0.paused = arg1;
        let v0 = ConfigSetPaused{
            config       : 0x2::object::uid_to_address(&arg0.id),
            value        : arg1,
            before_value : arg0.paused,
        };
        0x2::event::emit<ConfigSetPaused>(v0);
    }

    public(friend) fun set_price_diff_threshold1_to_price_feed(arg0: &mut OracleConfig, arg1: address, arg2: u64) {
        assert!(0x2::table::contains<address, PriceFeed>(&arg0.feeds, arg1), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::price_feed_not_found());
        let v0 = 0x2::table::borrow_mut<address, PriceFeed>(&mut arg0.feeds, arg1);
        v0.price_diff_threshold1 = arg2;
        let v1 = PriceFeedSetPriceDiffRatio1{
            config       : 0x2::object::uid_to_address(&arg0.id),
            feed_id      : arg1,
            value        : arg2,
            before_value : v0.price_diff_threshold1,
        };
        0x2::event::emit<PriceFeedSetPriceDiffRatio1>(v1);
    }

    public(friend) fun set_price_diff_threshold2_to_price_feed(arg0: &mut OracleConfig, arg1: address, arg2: u64) {
        assert!(0x2::table::contains<address, PriceFeed>(&arg0.feeds, arg1), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::price_feed_not_found());
        let v0 = 0x2::table::borrow_mut<address, PriceFeed>(&mut arg0.feeds, arg1);
        v0.price_diff_threshold2 = arg2;
        let v1 = PriceFeedSetPriceDiffRatio2{
            config       : 0x2::object::uid_to_address(&arg0.id),
            feed_id      : arg1,
            value        : arg2,
            before_value : v0.price_diff_threshold2,
        };
        0x2::event::emit<PriceFeedSetPriceDiffRatio2>(v1);
    }

    public(friend) fun set_primary_oracle_provider(arg0: &mut OracleConfig, arg1: address, arg2: 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider) {
        assert!(0x2::table::contains<address, PriceFeed>(&arg0.feeds, arg1), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::price_feed_not_found());
        let v0 = 0x2::table::borrow_mut<address, PriceFeed>(&mut arg0.feeds, arg1);
        if (v0.primary == arg2) {
            return
        };
        let v1 = v0.primary;
        assert!(0x2::table::contains<0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider, 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProviderConfig>(&v0.oracle_provider_configs, arg2), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::provider_config_not_found());
        v0.primary = arg2;
        let v2 = SetOracleProvider{
            config          : 0x2::object::uid_to_address(&arg0.id),
            feed_id         : arg1,
            is_primary      : true,
            provider        : 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::to_bytes(&arg2),
            before_provider : 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::to_bytes(&v1),
        };
        0x2::event::emit<SetOracleProvider>(v2);
    }

    public(friend) fun set_secondary_oracle_provider(arg0: &mut OracleConfig, arg1: address, arg2: 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider) {
        assert!(0x2::table::contains<address, PriceFeed>(&arg0.feeds, arg1), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::price_feed_not_found());
        let v0 = 0x2::table::borrow_mut<address, PriceFeed>(&mut arg0.feeds, arg1);
        if (v0.secondary == arg2) {
            return
        };
        let v1 = v0.secondary;
        if (!0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::is_empty(&v0.secondary)) {
            assert!(0x2::table::contains<0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProvider, 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::OracleProviderConfig>(&v0.oracle_provider_configs, arg2), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::provider_config_not_found());
        };
        v0.secondary = arg2;
        let v2 = SetOracleProvider{
            config          : 0x2::object::uid_to_address(&arg0.id),
            feed_id         : arg1,
            is_primary      : false,
            provider        : 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::to_bytes(&arg2),
            before_provider : 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider::to_bytes(&v1),
        };
        0x2::event::emit<SetOracleProvider>(v2);
    }

    public(friend) fun start_or_continue_diff_threshold2_timer(arg0: &mut PriceFeed, arg1: u64) {
        if (arg0.diff_threshold2_timer > 0) {
            return
        };
        arg0.diff_threshold2_timer = arg1;
        let v0 = PriceFeedRatio2UsageStartTimeUpdated{
            feed_id    : get_price_feed_id_from_feed(arg0),
            updated_at : arg1,
        };
        0x2::event::emit<PriceFeedRatio2UsageStartTimeUpdated>(v0);
    }

    public(friend) fun version_migrate(arg0: &mut OracleConfig) {
        assert!(arg0.version < 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_version::this_version(), 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_error::not_available_version());
        arg0.version = 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_version::this_version();
    }

    public fun version_verification(arg0: &OracleConfig) {
        0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_version::pre_check_version(arg0.version);
    }

    // decompiled from Move bytecode v6
}

