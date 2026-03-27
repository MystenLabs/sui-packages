module 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config {
    struct TradingParams has copy, drop, store {
        min_asset_amount: u64,
        min_stable_amount: u64,
        review_period_ms: u64,
        trading_period_ms: u64,
        conditional_amm_fee_bps: u64,
        conditional_liquidity_ratio_percent: u64,
    }

    struct TwapConfig has copy, drop, store {
        start_delay: u64,
        cap_ppm: u64,
        initial_observation: 0x1::option::Option<u128>,
        threshold: u128,
        sponsored_threshold: u128,
    }

    struct GovernanceConfig has copy, drop, store {
        max_outcomes: u64,
        max_actions_per_outcome: u64,
        proposal_creation_fee: u64,
        proposal_fee_per_outcome: u64,
        fee_in_asset_token: bool,
        proposal_intent_expiry_ms: u64,
    }

    struct MetadataConfig has copy, drop, store {
        dao_name: 0x1::ascii::String,
        icon_url: 0x2::url::Url,
        description: 0x1::string::String,
    }

    struct ConditionalCoinConfig has copy, drop, store {
        use_outcome_index: bool,
        conditional_metadata: 0x1::option::Option<ConditionalMetadata>,
    }

    struct ConditionalMetadata has copy, drop, store {
        decimals: u8,
        coin_name_prefix: 0x1::ascii::String,
        coin_icon_url: 0x2::url::Url,
    }

    struct SponsorshipConfig has copy, drop, store {
        enabled: bool,
    }

    struct DaoConfig has copy, drop, store {
        trading_params: TradingParams,
        twap_config: TwapConfig,
        governance_config: GovernanceConfig,
        metadata_config: MetadataConfig,
        conditional_coin_config: ConditionalCoinConfig,
        sponsorship_config: SponsorshipConfig,
    }

    public fun icon_url(arg0: &MetadataConfig) : &0x2::url::Url {
        &arg0.icon_url
    }

    public fun cap_ppm(arg0: &TwapConfig) : u64 {
        arg0.cap_ppm
    }

    public fun coin_name_prefix(arg0: &ConditionalCoinConfig) : 0x1::option::Option<0x1::ascii::String> {
        if (0x1::option::is_some<ConditionalMetadata>(&arg0.conditional_metadata)) {
            0x1::option::some<0x1::ascii::String>(0x1::option::borrow<ConditionalMetadata>(&arg0.conditional_metadata).coin_name_prefix)
        } else {
            0x1::option::none<0x1::ascii::String>()
        }
    }

    public fun conditional_amm_fee_bps(arg0: &TradingParams) : u64 {
        arg0.conditional_amm_fee_bps
    }

    public fun conditional_coin_config(arg0: &DaoConfig) : &ConditionalCoinConfig {
        &arg0.conditional_coin_config
    }

    public(friend) fun conditional_coin_config_mut(arg0: &mut DaoConfig) : &mut ConditionalCoinConfig {
        &mut arg0.conditional_coin_config
    }

    public fun conditional_coin_icon_url(arg0: &ConditionalMetadata) : &0x2::url::Url {
        &arg0.coin_icon_url
    }

    public fun conditional_coin_name_prefix(arg0: &ConditionalMetadata) : &0x1::ascii::String {
        &arg0.coin_name_prefix
    }

    public fun conditional_decimals(arg0: &ConditionalMetadata) : u8 {
        arg0.decimals
    }

    public fun conditional_liquidity_ratio_percent(arg0: &TradingParams) : u64 {
        arg0.conditional_liquidity_ratio_percent
    }

    public fun conditional_metadata(arg0: &ConditionalCoinConfig) : &0x1::option::Option<ConditionalMetadata> {
        &arg0.conditional_metadata
    }

    public fun conditional_metadata_decimals(arg0: &ConditionalMetadata) : u8 {
        arg0.decimals
    }

    public fun conditional_metadata_icon(arg0: &ConditionalMetadata) : 0x2::url::Url {
        arg0.coin_icon_url
    }

    public fun conditional_metadata_prefix(arg0: &ConditionalMetadata) : 0x1::ascii::String {
        arg0.coin_name_prefix
    }

    public fun dao_name(arg0: &MetadataConfig) : &0x1::ascii::String {
        &arg0.dao_name
    }

    public fun default_conditional_coin_config() : ConditionalCoinConfig {
        ConditionalCoinConfig{
            use_outcome_index    : true,
            conditional_metadata : 0x1::option::none<ConditionalMetadata>(),
        }
    }

    public fun default_governance_config() : GovernanceConfig {
        GovernanceConfig{
            max_outcomes              : 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::default_max_outcomes(),
            max_actions_per_outcome   : 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::default_max_actions_per_outcome(),
            proposal_creation_fee     : 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::default_proposal_creation_fee(),
            proposal_fee_per_outcome  : 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::default_proposal_fee_per_outcome(),
            fee_in_asset_token        : false,
            proposal_intent_expiry_ms : 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::default_proposal_intent_expiry_ms(),
        }
    }

    public fun default_sponsorship_config() : SponsorshipConfig {
        SponsorshipConfig{enabled: false}
    }

    public fun default_trading_params() : TradingParams {
        TradingParams{
            min_asset_amount                    : 1000000,
            min_stable_amount                   : 1000000,
            review_period_ms                    : 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::one_day_ms(),
            trading_period_ms                   : 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::one_week_ms(),
            conditional_amm_fee_bps             : 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::default_conditional_amm_fee_bps(),
            conditional_liquidity_ratio_percent : 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::default_conditional_liquidity_percent(),
        }
    }

    public fun default_twap_config() : TwapConfig {
        TwapConfig{
            start_delay         : 0,
            cap_ppm             : 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::default_twap_max_movement_ppm(),
            initial_observation : 0x1::option::none<u128>(),
            threshold           : (0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::default_twap_threshold() as u128),
            sponsored_threshold : 0,
        }
    }

    public fun derive_conditional_metadata_from_currency<T0>(arg0: &0x2::coin_registry::Currency<T0>) : (u8, 0x1::ascii::String, 0x2::url::Url) {
        let v0 = 0x2::coin_registry::icon_url<T0>(arg0);
        let v1 = 0x1::ascii::try_string(0x1::string::into_bytes(0x2::coin_registry::symbol<T0>(arg0)));
        let v2 = if (0x1::option::is_some<0x1::ascii::String>(&v1)) {
            0x1::option::destroy_some<0x1::ascii::String>(v1)
        } else {
            0x1::option::destroy_none<0x1::ascii::String>(v1);
            0x1::ascii::string(b"TOKEN")
        };
        let v3 = 0x1::ascii::string(b"c_");
        0x1::ascii::append(&mut v3, v2);
        0x1::ascii::append(&mut v3, 0x1::ascii::string(b"_"));
        let v4 = if (0x1::string::is_empty(&v0)) {
            0x1::ascii::string(b"https://govex.ai/default-conditional-icon.png")
        } else {
            let v5 = 0x1::ascii::try_string(0x1::string::into_bytes(v0));
            if (0x1::option::is_some<0x1::ascii::String>(&v5)) {
                0x1::option::destroy_some<0x1::ascii::String>(v5)
            } else {
                0x1::option::destroy_none<0x1::ascii::String>(v5);
                0x1::ascii::string(b"https://govex.ai/default-conditional-icon.png")
            }
        };
        (0x2::coin_registry::decimals<T0>(arg0), v3, 0x2::url::new_unsafe(v4))
    }

    public fun description(arg0: &MetadataConfig) : &0x1::string::String {
        &arg0.description
    }

    public fun fee_in_asset_token(arg0: &GovernanceConfig) : bool {
        arg0.fee_in_asset_token
    }

    public fun get_conditional_metadata_from_config(arg0: &ConditionalCoinConfig) : (u8, 0x1::ascii::String, 0x2::url::Url) {
        assert!(0x1::option::is_some<ConditionalMetadata>(&arg0.conditional_metadata), 15);
        let v0 = 0x1::option::borrow<ConditionalMetadata>(&arg0.conditional_metadata);
        (v0.decimals, v0.coin_name_prefix, v0.coin_icon_url)
    }

    public fun governance_config(arg0: &DaoConfig) : &GovernanceConfig {
        &arg0.governance_config
    }

    public(friend) fun governance_config_mut(arg0: &mut DaoConfig) : &mut GovernanceConfig {
        &mut arg0.governance_config
    }

    public fun initial_observation(arg0: &TwapConfig) : 0x1::option::Option<u128> {
        arg0.initial_observation
    }

    public fun max_actions_per_outcome(arg0: &GovernanceConfig) : u64 {
        arg0.max_actions_per_outcome
    }

    public fun max_outcomes(arg0: &GovernanceConfig) : u64 {
        arg0.max_outcomes
    }

    public fun metadata_config(arg0: &DaoConfig) : &MetadataConfig {
        &arg0.metadata_config
    }

    public(friend) fun metadata_config_mut(arg0: &mut DaoConfig) : &mut MetadataConfig {
        &mut arg0.metadata_config
    }

    public fun min_asset_amount(arg0: &TradingParams) : u64 {
        arg0.min_asset_amount
    }

    public fun min_stable_amount(arg0: &TradingParams) : u64 {
        arg0.min_stable_amount
    }

    public fun new_conditional_coin_config(arg0: bool, arg1: 0x1::option::Option<ConditionalMetadata>) : ConditionalCoinConfig {
        ConditionalCoinConfig{
            use_outcome_index    : arg0,
            conditional_metadata : arg1,
        }
    }

    public fun new_conditional_metadata(arg0: u8, arg1: 0x1::ascii::String, arg2: 0x2::url::Url) : ConditionalMetadata {
        ConditionalMetadata{
            decimals         : arg0,
            coin_name_prefix : arg1,
            coin_icon_url    : arg2,
        }
    }

    public fun new_dao_config(arg0: TradingParams, arg1: TwapConfig, arg2: GovernanceConfig, arg3: MetadataConfig, arg4: ConditionalCoinConfig, arg5: SponsorshipConfig) : DaoConfig {
        assert!(arg0.trading_period_ms > arg1.start_delay, 7);
        DaoConfig{
            trading_params          : arg0,
            twap_config             : arg1,
            governance_config       : arg2,
            metadata_config         : arg3,
            conditional_coin_config : arg4,
            sponsorship_config      : arg5,
        }
    }

    public fun new_governance_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u64) : GovernanceConfig {
        assert!(arg0 >= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::min_outcomes(), 3);
        assert!(arg0 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::protocol_max_outcomes(), 10);
        assert!(arg1 > 0 && arg1 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::protocol_max_actions_per_outcome(), 11);
        assert!(arg2 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::max_proposal_creation_fee(), 19);
        assert!(arg3 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::max_proposal_fee_per_outcome(), 19);
        assert!(arg5 >= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::min_proposal_intent_expiry_ms(), 8);
        assert!(arg5 <= 9223372036854775807, 8);
        GovernanceConfig{
            max_outcomes              : arg0,
            max_actions_per_outcome   : arg1,
            proposal_creation_fee     : arg2,
            proposal_fee_per_outcome  : arg3,
            fee_in_asset_token        : arg4,
            proposal_intent_expiry_ms : arg5,
        }
    }

    public fun new_metadata_config(arg0: 0x1::ascii::String, arg1: 0x2::url::Url, arg2: 0x1::string::String) : MetadataConfig {
        MetadataConfig{
            dao_name    : arg0,
            icon_url    : arg1,
            description : arg2,
        }
    }

    public fun new_sponsorship_config(arg0: bool) : SponsorshipConfig {
        SponsorshipConfig{enabled: arg0}
    }

    public fun new_trading_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : TradingParams {
        assert!(arg0 > 0, 0);
        assert!(arg1 > 0, 0);
        assert!(arg0 >= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::protocol_min_liquidity_amount(), 16);
        assert!(arg1 >= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::protocol_min_liquidity_amount(), 16);
        assert!(arg2 >= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::min_review_period_ms(), 1);
        assert!(arg2 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::max_trading_duration_ms(), 1);
        assert!(arg3 >= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::min_trading_period_ms(), 1);
        assert!(arg3 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::max_trading_duration_ms(), 1);
        assert!(arg4 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::max_amm_fee_bps(), 2);
        assert!(arg5 >= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::min_conditional_liquidity_percent() && arg5 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::max_conditional_liquidity_percent(), 2);
        TradingParams{
            min_asset_amount                    : arg0,
            min_stable_amount                   : arg1,
            review_period_ms                    : arg2,
            trading_period_ms                   : arg3,
            conditional_amm_fee_bps             : arg4,
            conditional_liquidity_ratio_percent : arg5,
        }
    }

    public fun new_twap_config(arg0: u64, arg1: u64, arg2: 0x1::option::Option<u128>, arg3: u128) : TwapConfig {
        assert!(arg0 < 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::one_week_ms(), 7);
        assert!(arg0 % 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::twap_price_cap_window() == 0, 7);
        assert!(arg1 > 0, 7);
        assert!(arg1 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::ppm_denominator(), 7);
        if (0x1::option::is_some<u128>(&arg2)) {
            assert!(*0x1::option::borrow<u128>(&arg2) > 0, 7);
        };
        assert!(arg3 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::twap_threshold_base(), 7);
        TwapConfig{
            start_delay         : arg0,
            cap_ppm             : arg1,
            initial_observation : arg2,
            threshold           : arg3,
            sponsored_threshold : 0,
        }
    }

    public fun new_twap_config_with_sponsored_threshold(arg0: u64, arg1: u64, arg2: 0x1::option::Option<u128>, arg3: u128, arg4: u128) : TwapConfig {
        assert!(arg0 < 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::one_week_ms(), 7);
        assert!(arg0 % 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::twap_price_cap_window() == 0, 7);
        assert!(arg1 > 0, 7);
        assert!(arg1 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::ppm_denominator(), 7);
        if (0x1::option::is_some<u128>(&arg2)) {
            assert!(*0x1::option::borrow<u128>(&arg2) > 0, 7);
        };
        assert!(arg3 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::twap_threshold_base(), 7);
        assert!(arg4 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::max_sponsored_threshold(), 7);
        TwapConfig{
            start_delay         : arg0,
            cap_ppm             : arg1,
            initial_observation : arg2,
            threshold           : arg3,
            sponsored_threshold : arg4,
        }
    }

    public fun proposal_creation_fee(arg0: &GovernanceConfig) : u64 {
        arg0.proposal_creation_fee
    }

    public fun proposal_fee_per_outcome(arg0: &GovernanceConfig) : u64 {
        arg0.proposal_fee_per_outcome
    }

    public fun proposal_intent_expiry_ms(arg0: &GovernanceConfig) : u64 {
        arg0.proposal_intent_expiry_ms
    }

    public fun review_period_ms(arg0: &TradingParams) : u64 {
        arg0.review_period_ms
    }

    public(friend) fun set_cap_ppm(arg0: &mut TwapConfig, arg1: u64) {
        assert!(arg1 > 0, 7);
        assert!(arg1 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::ppm_denominator(), 7);
        arg0.cap_ppm = arg1;
    }

    public(friend) fun set_conditional_amm_fee_bps(arg0: &mut TradingParams, arg1: u64) {
        assert!(arg1 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::max_amm_fee_bps(), 2);
        arg0.conditional_amm_fee_bps = arg1;
    }

    public(friend) fun set_conditional_liquidity_ratio_percent(arg0: &mut TradingParams, arg1: u64) {
        assert!(arg1 >= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::min_conditional_liquidity_percent() && arg1 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::max_conditional_liquidity_percent(), 2);
        arg0.conditional_liquidity_ratio_percent = arg1;
    }

    public(friend) fun set_conditional_metadata(arg0: &mut ConditionalCoinConfig, arg1: 0x1::option::Option<ConditionalMetadata>) {
        arg0.conditional_metadata = arg1;
    }

    public(friend) fun set_dao_name(arg0: &mut MetadataConfig, arg1: 0x1::ascii::String) {
        arg0.dao_name = arg1;
    }

    public(friend) fun set_dao_name_string(arg0: &mut MetadataConfig, arg1: 0x1::string::String) {
        arg0.dao_name = 0x1::string::to_ascii(arg1);
    }

    public(friend) fun set_description(arg0: &mut MetadataConfig, arg1: 0x1::string::String) {
        arg0.description = arg1;
    }

    public(friend) fun set_fee_in_asset_token(arg0: &mut GovernanceConfig, arg1: bool) {
        arg0.fee_in_asset_token = arg1;
    }

    public(friend) fun set_icon_url(arg0: &mut MetadataConfig, arg1: 0x2::url::Url) {
        arg0.icon_url = arg1;
    }

    public(friend) fun set_icon_url_string(arg0: &mut MetadataConfig, arg1: 0x1::string::String) {
        arg0.icon_url = 0x2::url::new_unsafe(0x1::string::to_ascii(arg1));
    }

    public(friend) fun set_initial_observation(arg0: &mut TwapConfig, arg1: u128) {
        assert!(arg1 > 0, 7);
        arg0.initial_observation = 0x1::option::some<u128>(arg1);
    }

    public(friend) fun set_max_actions_per_outcome(arg0: &mut GovernanceConfig, arg1: u64) {
        assert!(arg1 > 0 && arg1 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::protocol_max_actions_per_outcome(), 11);
        arg0.max_actions_per_outcome = arg1;
    }

    public(friend) fun set_max_outcomes(arg0: &mut GovernanceConfig, arg1: u64) {
        assert!(arg1 >= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::min_outcomes(), 3);
        assert!(arg1 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::protocol_max_outcomes(), 10);
        arg0.max_outcomes = arg1;
    }

    public(friend) fun set_min_asset_amount(arg0: &mut TradingParams, arg1: u64) {
        assert!(arg1 > 0, 0);
        assert!(arg1 >= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::protocol_min_liquidity_amount(), 16);
        arg0.min_asset_amount = arg1;
    }

    public(friend) fun set_min_stable_amount(arg0: &mut TradingParams, arg1: u64) {
        assert!(arg1 > 0, 0);
        assert!(arg1 >= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::protocol_min_liquidity_amount(), 16);
        arg0.min_stable_amount = arg1;
    }

    public(friend) fun set_proposal_creation_fee(arg0: &mut GovernanceConfig, arg1: u64) {
        assert!(arg1 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::max_proposal_creation_fee(), 19);
        arg0.proposal_creation_fee = arg1;
    }

    public(friend) fun set_proposal_fee_per_outcome(arg0: &mut GovernanceConfig, arg1: u64) {
        assert!(arg1 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::max_proposal_fee_per_outcome(), 19);
        arg0.proposal_fee_per_outcome = arg1;
    }

    public(friend) fun set_proposal_intent_expiry_ms(arg0: &mut GovernanceConfig, arg1: u64) {
        assert!(arg1 >= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::min_proposal_intent_expiry_ms(), 8);
        assert!(arg1 <= 9223372036854775807, 8);
        arg0.proposal_intent_expiry_ms = arg1;
    }

    public(friend) fun set_review_period_ms(arg0: &mut TradingParams, arg1: u64) {
        assert!(arg1 >= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::min_review_period_ms(), 1);
        assert!(arg1 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::max_trading_duration_ms(), 1);
        arg0.review_period_ms = arg1;
    }

    public(friend) fun set_sponsored_threshold(arg0: &mut TwapConfig, arg1: u128) {
        assert!(arg1 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::max_sponsored_threshold(), 7);
        arg0.sponsored_threshold = arg1;
    }

    public(friend) fun set_sponsorship_enabled(arg0: &mut SponsorshipConfig, arg1: bool) {
        arg0.enabled = arg1;
    }

    public(friend) fun set_start_delay(arg0: &mut TwapConfig, arg1: u64) {
        assert!(arg1 < 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::one_week_ms(), 7);
        assert!(arg1 % 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::twap_price_cap_window() == 0, 7);
        arg0.start_delay = arg1;
    }

    public(friend) fun set_threshold(arg0: &mut TwapConfig, arg1: u128) {
        assert!(arg1 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::twap_threshold_base(), 7);
        arg0.threshold = arg1;
    }

    public(friend) fun set_trading_period_ms(arg0: &mut TradingParams, arg1: u64) {
        assert!(arg1 >= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::min_trading_period_ms(), 1);
        assert!(arg1 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::max_trading_duration_ms(), 1);
        arg0.trading_period_ms = arg1;
    }

    public(friend) fun set_use_outcome_index(arg0: &mut ConditionalCoinConfig, arg1: bool) {
        arg0.use_outcome_index = arg1;
    }

    public fun sponsored_threshold(arg0: &TwapConfig) : u128 {
        arg0.sponsored_threshold
    }

    public fun sponsorship_config(arg0: &DaoConfig) : &SponsorshipConfig {
        &arg0.sponsorship_config
    }

    public(friend) fun sponsorship_config_mut(arg0: &mut DaoConfig) : &mut SponsorshipConfig {
        &mut arg0.sponsorship_config
    }

    public fun sponsorship_enabled(arg0: &SponsorshipConfig) : bool {
        arg0.enabled
    }

    public fun start_delay(arg0: &TwapConfig) : u64 {
        arg0.start_delay
    }

    public fun threshold(arg0: &TwapConfig) : u128 {
        arg0.threshold
    }

    public fun trading_params(arg0: &DaoConfig) : &TradingParams {
        &arg0.trading_params
    }

    public(friend) fun trading_params_mut(arg0: &mut DaoConfig) : &mut TradingParams {
        &mut arg0.trading_params
    }

    public fun trading_period_ms(arg0: &TradingParams) : u64 {
        arg0.trading_period_ms
    }

    public fun twap_config(arg0: &DaoConfig) : &TwapConfig {
        &arg0.twap_config
    }

    public(friend) fun twap_config_mut(arg0: &mut DaoConfig) : &mut TwapConfig {
        &mut arg0.twap_config
    }

    public fun use_outcome_index(arg0: &ConditionalCoinConfig) : bool {
        arg0.use_outcome_index
    }

    // decompiled from Move bytecode v6
}

