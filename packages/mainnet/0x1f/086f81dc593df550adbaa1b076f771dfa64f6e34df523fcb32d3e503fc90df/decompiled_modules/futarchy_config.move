module 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config {
    struct FutarchyConfig has copy, drop, store {
        asset_type: 0x1::string::String,
        stable_type: 0x1::string::String,
        config: 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::DaoConfig,
        launchpad_initial_price: 0x1::option::Option<u128>,
        spot_pool_id: 0x1::option::Option<0x2::object::ID>,
        dao_state: DaoState,
        quota_registry: 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::proposal_quota_registry::ProposalQuotaRegistry,
    }

    struct DaoState has copy, drop, store {
        operational_state: u8,
        terminated_at_ms: 0x1::option::Option<u64>,
        dissolution_unlock_delay_ms: 0x1::option::Option<u64>,
        dissolution_capability_created: bool,
        redemption_pool_created: bool,
    }

    struct DaoStateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SpotAMMKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FeeManagerKey has copy, drop, store {
        dummy_field: bool,
    }

    struct OperatingAgreementKey has copy, drop, store {
        dummy_field: bool,
    }

    struct TreasuryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MetadataTableKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FutarchyOutcome has copy, drop, store {
        intent_key: 0x1::string::String,
        proposal_id: 0x1::option::Option<0x2::object::ID>,
        market_id: 0x1::option::Option<0x2::object::ID>,
        approved: bool,
        min_execution_time: u64,
    }

    struct ConfigWitness has copy, drop {
        dummy_field: bool,
    }

    public fun delete_expired_intent(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::Expired {
        let v0 = ConfigWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::delete_expired_intent<FutarchyOutcome, ConfigWitness>(arg0, arg1, arg2, v0, arg3)
    }

    public fun new<T0, T1>(arg0: 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::DaoConfig, arg1: 0x1::option::Option<u128>) : FutarchyConfig {
        let v0 = FutarchyConfig{
            asset_type              : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())),
            stable_type             : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>())),
            config                  : arg0,
            launchpad_initial_price : 0x1::option::none<u128>(),
            spot_pool_id            : 0x1::option::none<0x2::object::ID>(),
            dao_state               : new_dao_state(),
            quota_registry          : 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::proposal_quota_registry::new(),
        };
        if (0x1::option::is_some<u128>(&arg1)) {
            let v1 = &mut v0;
            set_launchpad_initial_price(v1, 0x1::option::destroy_some<u128>(arg1));
        };
        v0
    }

    public fun dao_config(arg0: &FutarchyConfig) : &0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::DaoConfig {
        &arg0.config
    }

    public fun conditional_amm_fee_bps(arg0: &FutarchyConfig) : u64 {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::conditional_amm_fee_bps(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::trading_params(&arg0.config))
    }

    public fun conditional_liquidity_ratio_percent(arg0: &FutarchyConfig) : u64 {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::conditional_liquidity_ratio_percent(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::trading_params(&arg0.config))
    }

    public fun fee_in_asset_token(arg0: &FutarchyConfig) : bool {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::fee_in_asset_token(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::governance_config(&arg0.config))
    }

    public fun max_actions_per_outcome(arg0: &FutarchyConfig) : u64 {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::max_actions_per_outcome(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::governance_config(&arg0.config))
    }

    public fun max_outcomes(arg0: &FutarchyConfig) : u64 {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::max_outcomes(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::governance_config(&arg0.config))
    }

    public fun min_asset_amount(arg0: &FutarchyConfig) : u64 {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::min_asset_amount(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::trading_params(&arg0.config))
    }

    public fun min_stable_amount(arg0: &FutarchyConfig) : u64 {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::min_stable_amount(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::trading_params(&arg0.config))
    }

    public fun proposal_creation_fee(arg0: &FutarchyConfig) : u64 {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::proposal_creation_fee(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::governance_config(&arg0.config))
    }

    public fun proposal_fee_per_outcome(arg0: &FutarchyConfig) : u64 {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::proposal_fee_per_outcome(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::governance_config(&arg0.config))
    }

    public fun review_period_ms(arg0: &FutarchyConfig) : u64 {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::review_period_ms(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::trading_params(&arg0.config))
    }

    public fun set_conditional_amm_fee_bps(arg0: &mut FutarchyConfig, arg1: u64) {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::set_conditional_amm_fee_bps(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::trading_params_mut(&mut arg0.config), arg1);
    }

    public fun set_conditional_liquidity_ratio_percent(arg0: &mut FutarchyConfig, arg1: u64) {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::set_conditional_liquidity_ratio_percent(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::trading_params_mut(&mut arg0.config), arg1);
    }

    public fun set_conditional_metadata(arg0: &mut FutarchyConfig, arg1: 0x1::option::Option<0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::ConditionalMetadata>) {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::set_conditional_metadata(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::conditional_coin_config_mut(&mut arg0.config), arg1);
    }

    public fun set_description(arg0: &mut FutarchyConfig, arg1: 0x1::string::String) {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::set_description(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::metadata_config_mut(&mut arg0.config), arg1);
    }

    public fun set_fee_in_asset_token(arg0: &mut FutarchyConfig, arg1: bool) {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::set_fee_in_asset_token(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::governance_config_mut(&mut arg0.config), arg1);
    }

    public fun set_max_actions_per_outcome(arg0: &mut FutarchyConfig, arg1: u64) {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::set_max_actions_per_outcome(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::governance_config_mut(&mut arg0.config), arg1);
    }

    public fun set_max_outcomes(arg0: &mut FutarchyConfig, arg1: u64) {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::set_max_outcomes(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::governance_config_mut(&mut arg0.config), arg1);
    }

    public fun set_min_asset_amount(arg0: &mut FutarchyConfig, arg1: u64) {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::set_min_asset_amount(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::trading_params_mut(&mut arg0.config), arg1);
    }

    public fun set_min_stable_amount(arg0: &mut FutarchyConfig, arg1: u64) {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::set_min_stable_amount(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::trading_params_mut(&mut arg0.config), arg1);
    }

    public fun set_proposal_creation_fee(arg0: &mut FutarchyConfig, arg1: u64) {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::set_proposal_creation_fee(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::governance_config_mut(&mut arg0.config), arg1);
    }

    public fun set_proposal_fee_per_outcome(arg0: &mut FutarchyConfig, arg1: u64) {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::set_proposal_fee_per_outcome(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::governance_config_mut(&mut arg0.config), arg1);
    }

    public fun set_proposal_intent_expiry_ms(arg0: &mut FutarchyConfig, arg1: u64) {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::set_proposal_intent_expiry_ms(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::governance_config_mut(&mut arg0.config), arg1);
    }

    public fun set_review_period_ms(arg0: &mut FutarchyConfig, arg1: u64) {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::set_review_period_ms(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::trading_params_mut(&mut arg0.config), arg1);
    }

    public fun set_sponsored_threshold(arg0: &mut FutarchyConfig, arg1: u128) {
        assert!(arg1 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::max_sponsored_threshold(), 102);
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::set_sponsored_threshold(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::twap_config_mut(&mut arg0.config), arg1);
    }

    public fun set_sponsorship_enabled(arg0: &mut FutarchyConfig, arg1: bool) {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::set_sponsorship_enabled(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::sponsorship_config_mut(&mut arg0.config), arg1);
    }

    public fun set_trading_period_ms(arg0: &mut FutarchyConfig, arg1: u64) {
        assert!(arg1 > 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::start_delay(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::twap_config(&arg0.config)), 114);
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::set_trading_period_ms(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::trading_params_mut(&mut arg0.config), arg1);
    }

    public fun set_use_outcome_index(arg0: &mut FutarchyConfig, arg1: bool) {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::set_use_outcome_index(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::conditional_coin_config_mut(&mut arg0.config), arg1);
    }

    public fun sponsored_threshold(arg0: &FutarchyConfig) : u128 {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::sponsored_threshold(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::twap_config(&arg0.config))
    }

    public fun trading_period_ms(arg0: &FutarchyConfig) : u64 {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::trading_period_ms(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::trading_params(&arg0.config))
    }

    public fun amm_twap_cap_ppm(arg0: &FutarchyConfig) : u64 {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::cap_ppm(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::twap_config(&arg0.config))
    }

    public fun amm_twap_initial_observation(arg0: &FutarchyConfig) : 0x1::option::Option<u128> {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::initial_observation(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::twap_config(&arg0.config))
    }

    public fun amm_twap_start_delay(arg0: &FutarchyConfig) : u64 {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::start_delay(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::twap_config(&arg0.config))
    }

    public fun apply_conditional_metadata_from_execution<T0: store, T1: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>, arg3: T1, arg4: 0x1::option::Option<bool>, arg5: 0x1::option::Option<0x1::option::Option<0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::ConditionalMetadata>>) {
        let v0 = internal_config_mut<T0, T1>(arg0, arg1, arg2, arg3);
        if (0x1::option::is_some<bool>(&arg4)) {
            set_use_outcome_index(v0, *0x1::option::borrow<bool>(&arg4));
        };
        if (0x1::option::is_some<0x1::option::Option<0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::ConditionalMetadata>>(&arg5)) {
            set_conditional_metadata(v0, *0x1::option::borrow<0x1::option::Option<0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::ConditionalMetadata>>(&arg5));
        };
    }

    public fun apply_governance_updates_from_execution<T0: store, T1: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>, arg3: T1, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<bool>) {
        let v0 = internal_config_mut<T0, T1>(arg0, arg1, arg2, arg3);
        if (0x1::option::is_some<u64>(&arg4)) {
            set_max_outcomes(v0, *0x1::option::borrow<u64>(&arg4));
        };
        if (0x1::option::is_some<u64>(&arg5)) {
            set_max_actions_per_outcome(v0, *0x1::option::borrow<u64>(&arg5));
        };
        if (0x1::option::is_some<u64>(&arg6)) {
            set_proposal_intent_expiry_ms(v0, *0x1::option::borrow<u64>(&arg6));
        };
        if (0x1::option::is_some<u64>(&arg7)) {
            set_proposal_creation_fee(v0, *0x1::option::borrow<u64>(&arg7));
        };
        if (0x1::option::is_some<u64>(&arg8)) {
            set_proposal_fee_per_outcome(v0, *0x1::option::borrow<u64>(&arg8));
        };
        if (0x1::option::is_some<bool>(&arg9)) {
            set_fee_in_asset_token(v0, *0x1::option::borrow<bool>(&arg9));
        };
    }

    public fun apply_metadata_from_execution<T0: store, T1: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>, arg3: T1, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x1::option::Option<0x1::string::String>) {
        let v0 = internal_config_mut<T0, T1>(arg0, arg1, arg2, arg3);
        if (0x1::option::is_some<0x1::string::String>(&arg4)) {
            set_dao_name(v0, *0x1::option::borrow<0x1::string::String>(&arg4));
        };
        if (0x1::option::is_some<0x1::string::String>(&arg5)) {
            set_icon_url(v0, *0x1::option::borrow<0x1::string::String>(&arg5));
        };
        if (0x1::option::is_some<0x1::string::String>(&arg6)) {
            set_description(v0, *0x1::option::borrow<0x1::string::String>(&arg6));
        };
    }

    public fun apply_sponsorship_config_from_execution<T0: store, T1: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>, arg3: T1, arg4: 0x1::option::Option<bool>) {
        let v0 = internal_config_mut<T0, T1>(arg0, arg1, arg2, arg3);
        if (0x1::option::is_some<bool>(&arg4)) {
            set_sponsorship_enabled(v0, *0x1::option::borrow<bool>(&arg4));
        };
    }

    public fun apply_trading_params_from_execution<T0: store, T1: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>, arg3: T1, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u64>) {
        let v0 = internal_config_mut<T0, T1>(arg0, arg1, arg2, arg3);
        if (0x1::option::is_some<u64>(&arg4)) {
            set_min_asset_amount(v0, *0x1::option::borrow<u64>(&arg4));
        };
        if (0x1::option::is_some<u64>(&arg5)) {
            set_min_stable_amount(v0, *0x1::option::borrow<u64>(&arg5));
        };
        if (0x1::option::is_some<u64>(&arg6)) {
            set_review_period_ms(v0, *0x1::option::borrow<u64>(&arg6));
        };
        if (0x1::option::is_some<u64>(&arg7)) {
            set_trading_period_ms(v0, *0x1::option::borrow<u64>(&arg7));
        };
        if (0x1::option::is_some<u64>(&arg8)) {
            set_conditional_amm_fee_bps(v0, *0x1::option::borrow<u64>(&arg8));
        };
        if (0x1::option::is_some<u64>(&arg9)) {
            set_conditional_liquidity_ratio_percent(v0, *0x1::option::borrow<u64>(&arg9));
        };
    }

    public fun apply_twap_config_from_execution<T0: store, T1: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>, arg3: T1, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u128>, arg7: 0x1::option::Option<u128>, arg8: 0x1::option::Option<u128>) {
        let v0 = internal_config_mut<T0, T1>(arg0, arg1, arg2, arg3);
        if (0x1::option::is_some<u64>(&arg4)) {
            set_amm_twap_start_delay(v0, *0x1::option::borrow<u64>(&arg4));
        };
        if (0x1::option::is_some<u64>(&arg5)) {
            set_amm_twap_cap_ppm(v0, *0x1::option::borrow<u64>(&arg5));
        };
        if (0x1::option::is_some<u128>(&arg6)) {
            set_amm_twap_initial_observation(v0, *0x1::option::borrow<u128>(&arg6));
        };
        if (0x1::option::is_some<u128>(&arg7)) {
            set_twap_threshold(v0, *0x1::option::borrow<u128>(&arg7));
        };
        if (0x1::option::is_some<u128>(&arg8)) {
            set_sponsored_threshold(v0, *0x1::option::borrow<u128>(&arg8));
        };
    }

    fun assert_authorized_account_creator(arg0: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::VersionWitness) {
        assert!(is_orchestrator_package(arg0, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::package_addr(arg1)), 116);
    }

    public fun assert_not_terminated(arg0: &DaoState) {
        assert!(arg0.operational_state == 0, 103);
    }

    public fun asset_type(arg0: &FutarchyConfig) : &0x1::string::String {
        &arg0.asset_type
    }

    public fun cancel_shared_intent<T0: drop + store>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::VersionWitness, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(is_orchestrator_package(arg1, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::package_addr(&arg3)), 117);
        assert!(0x2::clock::timestamp_ms(arg4) >= 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::expiration_time<T0>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::get<T0>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::intents(arg0), arg2)), 119);
        let v0 = ConfigWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::drain_and_destroy_expired(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::cancel_intent<T0, ConfigWitness>(arg0, arg2, v0, arg5));
    }

    public fun check_sponsor_quota_available(arg0: &FutarchyConfig, arg1: address, arg2: &0x2::clock::Clock) : (bool, u64) {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::proposal_quota_registry::check_sponsor_quota_available(&arg0.quota_registry, arg1, arg2)
    }

    public(friend) fun config_witness(arg0: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account) : ConfigWitness {
        ConfigWitness{dummy_field: false}
    }

    public fun consume_dissolution_capability_creation(arg0: &mut FutarchyConfig) : (u64, u64) {
        let v0 = &mut arg0.dao_state;
        assert!(operational_state(v0) == state_terminated(), 108);
        assert!(!dissolution_capability_created(v0), 107);
        let v1 = dissolution_unlock_time(v0);
        assert!(0x1::option::is_some<u64>(&v1), 108);
        let v2 = terminated_at(v0);
        mark_dissolution_capability_created(v0);
        (*0x1::option::borrow<u64>(&v1), *0x1::option::borrow<u64>(&v2))
    }

    public fun consume_feeless_quota(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg2, 112);
        let v0 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::config_mut_authorized<FutarchyConfig>(arg0, arg1, 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_version::current());
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::proposal_quota_registry::use_feeless_quota(quota_registry_mut(v0), 0x2::object::id<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account>(arg0), arg2, arg3);
    }

    public fun consume_redemption_pool_creation(arg0: &mut FutarchyConfig) {
        let v0 = &mut arg0.dao_state;
        assert!(!v0.redemption_pool_created, 107);
        v0.redemption_pool_created = true;
    }

    public fun consume_sponsor_quota(arg0: &mut FutarchyConfig, arg1: 0x2::object::ID, arg2: address, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg2, 115);
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::proposal_quota_registry::use_sponsor_quota(&mut arg0.quota_registry, arg1, arg2, arg3, arg4);
    }

    public(friend) fun create_config_executable<T0: copy + store>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (T0, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>) {
        let v0 = ConfigWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::create_executable<FutarchyConfig, T0, ConfigWitness>(arg0, arg1, arg2, arg3, v0, arg4)
    }

    public fun create_futarchy_executable(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::VersionWitness, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (FutarchyOutcome, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<FutarchyOutcome>) {
        assert!(is_orchestrator_package(arg1, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::package_addr(&arg3)), 118);
        let (v0, v1) = create_config_executable<FutarchyOutcome>(arg0, arg1, arg2, arg4, arg5);
        let v2 = v0;
        assert!(v2.approved, 120);
        (v2, v1)
    }

    public fun create_init_executable<T0: copy + store>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::VersionWitness, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (T0, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>) {
        assert!(is_orchestrator_package(arg1, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::package_addr(&arg3)), 118);
        create_config_executable<T0>(arg0, arg1, arg2, arg4, arg5)
    }

    public(friend) fun dao_config_mut(arg0: &mut FutarchyConfig) : &mut 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::DaoConfig {
        &mut arg0.config
    }

    public fun dao_state(arg0: &FutarchyConfig) : &DaoState {
        &arg0.dao_state
    }

    public(friend) fun dao_state_mut(arg0: &mut FutarchyConfig) : &mut DaoState {
        &mut arg0.dao_state
    }

    public fun dissolution_capability_created(arg0: &DaoState) : bool {
        arg0.dissolution_capability_created
    }

    public fun dissolution_unlock_time(arg0: &DaoState) : 0x1::option::Option<u64> {
        if (0x1::option::is_some<u64>(&arg0.terminated_at_ms) && 0x1::option::is_some<u64>(&arg0.dissolution_unlock_delay_ms)) {
            let v1 = *0x1::option::borrow<u64>(&arg0.terminated_at_ms);
            let v2 = *0x1::option::borrow<u64>(&arg0.dissolution_unlock_delay_ms);
            assert!(v1 <= 18446744073709551615 - v2, 109);
            0x1::option::some<u64>(v1 + v2)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun force_cancel_shared_intent<T0: drop + store>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::VersionWitness, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_factory_package(arg1, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::package_addr(&arg3)), 117);
        let v0 = ConfigWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::drain_and_destroy_expired(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::cancel_intent<T0, ConfigWitness>(arg0, arg2, v0, arg4));
    }

    public fun get_launchpad_initial_price(arg0: &FutarchyConfig) : 0x1::option::Option<u128> {
        arg0.launchpad_initial_price
    }

    public fun get_spot_pool_id(arg0: &FutarchyConfig) : 0x1::option::Option<0x2::object::ID> {
        arg0.spot_pool_id
    }

    public(friend) fun internal_config_mut<T0: store, T1: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>, arg3: T1) : &mut FutarchyConfig {
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::config_mut_from_execution<FutarchyConfig, T0, T1>(arg0, arg1, arg2, arg3)
    }

    fun is_factory_package(arg0: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg1: address) : bool {
        if (!is_orchestrator_package(arg0, arg1)) {
            return false
        };
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::get_package_name(arg0, arg1) == 0x1::string::utf8(b"FutarchyFactory")
    }

    public fun is_operational(arg0: &DaoState) : bool {
        arg0.operational_state == 0
    }

    fun is_orchestrator_package(arg0: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg1: address) : bool {
        if (!0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::contains_package_addr(arg0, arg1)) {
            return false
        };
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::get_category_by_addr(arg0, arg1) == 0x1::string::utf8(b"orchestrator")
    }

    public fun is_terminated(arg0: &DaoState) : bool {
        arg0.operational_state == 1
    }

    public fun mark_account_initialized(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account) {
        let v0 = ConfigWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::mark_initialized<ConfigWitness>(arg0, v0);
    }

    public fun mark_dissolution_capability_created(arg0: &mut DaoState) {
        assert!(!arg0.dissolution_capability_created, 107);
        arg0.dissolution_capability_created = true;
    }

    public fun mark_redemption_pool_created(arg0: &mut DaoState) {
        arg0.redemption_pool_created = true;
    }

    public fun new_dao_state() : DaoState {
        DaoState{
            operational_state              : 0,
            terminated_at_ms               : 0x1::option::none<u64>(),
            dissolution_unlock_delay_ms    : 0x1::option::none<u64>(),
            dissolution_capability_created : false,
            redemption_pool_created        : false,
        }
    }

    public fun new_dao_state_key() : DaoStateKey {
        DaoStateKey{dummy_field: false}
    }

    public fun new_futarchy_outcome(arg0: 0x1::string::String, arg1: u64) : FutarchyOutcome {
        FutarchyOutcome{
            intent_key         : arg0,
            proposal_id        : 0x1::option::none<0x2::object::ID>(),
            market_id          : 0x1::option::none<0x2::object::ID>(),
            approved           : false,
            min_execution_time : arg1,
        }
    }

    public fun new_futarchy_outcome_full(arg0: 0x1::string::String, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x1::option::Option<0x2::object::ID>, arg3: bool, arg4: u64) : FutarchyOutcome {
        FutarchyOutcome{
            intent_key         : arg0,
            proposal_id        : arg1,
            market_id          : arg2,
            approved           : arg3,
            min_execution_time : arg4,
        }
    }

    public fun new_metadata_table_key() : MetadataTableKey {
        MetadataTableKey{dummy_field: false}
    }

    public fun new_with_package_registry(arg0: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg1: FutarchyConfig, arg2: u8, arg3: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::VersionWitness, arg4: &mut 0x2::tx_context::TxContext) : 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account {
        assert_authorized_account_creator(arg0, &arg3);
        let v0 = ConfigWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::new<FutarchyConfig, ConfigWitness>(arg1, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::metadata::empty(), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::deps::new_with_level(arg0, arg2), v0, arg4)
    }

    public fun operational_state(arg0: &DaoState) : u8 {
        arg0.operational_state
    }

    public fun outcome_approved(arg0: &FutarchyOutcome) : bool {
        arg0.approved
    }

    public fun outcome_market_id(arg0: &FutarchyOutcome) : 0x1::option::Option<0x2::object::ID> {
        arg0.market_id
    }

    public fun outcome_min_execution_time(arg0: &FutarchyOutcome) : u64 {
        arg0.min_execution_time
    }

    public fun outcome_proposal_id(arg0: &FutarchyOutcome) : 0x1::option::Option<0x2::object::ID> {
        arg0.proposal_id
    }

    public fun protocol_max_threshold() : u128 {
        0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::max_sponsored_threshold()
    }

    public fun quota_registry(arg0: &FutarchyConfig) : &0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::proposal_quota_registry::ProposalQuotaRegistry {
        &arg0.quota_registry
    }

    public(friend) fun quota_registry_mut(arg0: &mut FutarchyConfig) : &mut 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::proposal_quota_registry::ProposalQuotaRegistry {
        &mut arg0.quota_registry
    }

    public fun redemption_pool_created(arg0: &DaoState) : bool {
        arg0.redemption_pool_created
    }

    public fun set_amm_twap_cap_ppm(arg0: &mut FutarchyConfig, arg1: u64) {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::set_cap_ppm(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::twap_config_mut(&mut arg0.config), arg1);
    }

    public fun set_amm_twap_initial_observation(arg0: &mut FutarchyConfig, arg1: u128) {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::set_initial_observation(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::twap_config_mut(&mut arg0.config), arg1);
    }

    public fun set_amm_twap_start_delay(arg0: &mut FutarchyConfig, arg1: u64) {
        assert!(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::trading_period_ms(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::trading_params(&arg0.config)) > arg1, 114);
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::set_start_delay(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::twap_config_mut(&mut arg0.config), arg1);
    }

    public fun set_dao_name(arg0: &mut FutarchyConfig, arg1: 0x1::string::String) {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::set_dao_name_string(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::metadata_config_mut(&mut arg0.config), arg1);
    }

    public fun set_dao_name_from_execution<T0: store, T1: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>, arg3: T1, arg4: 0x1::string::String) {
        let v0 = internal_config_mut<T0, T1>(arg0, arg1, arg2, arg3);
        set_dao_name(v0, arg4);
    }

    public fun set_dissolution_params(arg0: &mut DaoState, arg1: u64, arg2: u64) {
        assert!(arg0.operational_state == 1, 108);
        assert!(0x1::option::is_none<u64>(&arg0.terminated_at_ms), 106);
        assert!(0x1::option::is_none<u64>(&arg0.dissolution_unlock_delay_ms), 106);
        assert!(arg1 <= 18446744073709551615 - arg2, 109);
        arg0.terminated_at_ms = 0x1::option::some<u64>(arg1);
        arg0.dissolution_unlock_delay_ms = 0x1::option::some<u64>(arg2);
    }

    public fun set_icon_url(arg0: &mut FutarchyConfig, arg1: 0x1::string::String) {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::set_icon_url_string(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::metadata_config_mut(&mut arg0.config), arg1);
    }

    public fun set_launchpad_initial_price(arg0: &mut FutarchyConfig, arg1: u128) {
        assert!(0x1::option::is_none<u128>(&arg0.launchpad_initial_price), 101);
        assert!(arg1 > 0, 113);
        arg0.launchpad_initial_price = 0x1::option::some<u128>(arg1);
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::set_initial_observation(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::twap_config_mut(&mut arg0.config), arg1);
    }

    public fun set_launchpad_initial_price_from_execution<T0: store, T1: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>, arg3: T1, arg4: u128) {
        let v0 = internal_config_mut<T0, T1>(arg0, arg1, arg2, arg3);
        set_launchpad_initial_price(v0, arg4);
    }

    public fun set_operational_state(arg0: &mut DaoState, arg1: u8) {
        assert!(arg1 == 0 || arg1 == 1, 104);
        let v0 = arg1 == 0 && arg0.operational_state == 1;
        assert!(!v0, 104);
        arg0.operational_state = arg1;
    }

    public fun set_outcome_approved(arg0: &mut FutarchyOutcome, arg1: bool) {
        let v0 = arg0.approved && !arg1;
        assert!(!v0, 111);
        arg0.approved = arg1;
    }

    public fun set_outcome_proposal_and_market(arg0: &mut FutarchyOutcome, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.proposal_id), 110);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.market_id), 110);
        arg0.proposal_id = 0x1::option::some<0x2::object::ID>(arg1);
        arg0.market_id = 0x1::option::some<0x2::object::ID>(arg2);
    }

    public fun set_quotas_from_execution<T0: store, T1: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>, arg3: T1, arg4: vector<address>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account>(arg0);
        let v1 = internal_config_mut<T0, T1>(arg0, arg1, arg2, arg3);
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::proposal_quota_registry::set_quotas(quota_registry_mut(v1), v0, arg4, arg5, arg6, arg7, arg8);
    }

    public fun set_spot_pool_id(arg0: &mut FutarchyConfig, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.spot_pool_id), 105);
        arg0.spot_pool_id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public fun set_trading_period_and_twap_delay(arg0: &mut FutarchyConfig, arg1: u64, arg2: u64) {
        assert!(arg1 > arg2, 114);
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::set_trading_period_ms(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::trading_params_mut(&mut arg0.config), arg1);
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::set_start_delay(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::twap_config_mut(&mut arg0.config), arg2);
    }

    public fun set_twap_initial_observation_from_execution<T0: store, T1: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>, arg3: T1, arg4: u128) {
        let v0 = internal_config_mut<T0, T1>(arg0, arg1, arg2, arg3);
        set_amm_twap_initial_observation(v0, arg4);
    }

    public fun set_twap_threshold(arg0: &mut FutarchyConfig, arg1: u128) {
        assert!(arg1 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::twap_threshold_base(), 102);
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::set_threshold(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::twap_config_mut(&mut arg0.config), arg1);
    }

    public fun stable_type(arg0: &FutarchyConfig) : &0x1::string::String {
        &arg0.stable_type
    }

    public fun stage_intent<T0: drop + store, T1: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::Intent<T0>, arg3: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::VersionWitness, arg4: T1) {
        assert!(is_orchestrator_package(arg1, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::package_addr(&arg3)), 117);
        let v0 = ConfigWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::insert_intent<FutarchyConfig, T0, ConfigWitness, T1>(arg0, arg1, arg2, v0, arg4);
    }

    public fun state_active() : u8 {
        0
    }

    public(friend) fun state_mut_from_account(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry) : &mut DaoState {
        &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::config_mut_authorized<FutarchyConfig>(arg0, arg1, 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_version::current()).dao_state
    }

    public fun state_terminated() : u8 {
        1
    }

    public fun terminate_dao_from_execution<T0: store, T1: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T0>, arg3: T1, arg4: u64, arg5: u64) {
        let v0 = internal_config_mut<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = dao_state_mut(v0);
        assert!(operational_state(v1) == state_active(), 103);
        set_operational_state(v1, state_terminated());
        set_dissolution_params(v1, arg4, arg5);
    }

    public fun terminated_at(arg0: &DaoState) : 0x1::option::Option<u64> {
        arg0.terminated_at_ms
    }

    public fun twap_scale() : u128 {
        (0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::price_precision_scale() as u128)
    }

    public fun twap_threshold(arg0: &FutarchyConfig) : u128 {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::threshold(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::dao_config::twap_config(&arg0.config))
    }

    public(friend) fun witness() : ConfigWitness {
        ConfigWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

