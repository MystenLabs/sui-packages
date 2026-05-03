module 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config {
    struct FutarchyConfig has copy, drop, store {
        asset_type: 0x1::string::String,
        stable_type: 0x1::string::String,
        config: 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::DaoConfig,
        launchpad_initial_price: 0x1::option::Option<u128>,
        spot_pool_id: 0x1::option::Option<0x2::object::ID>,
        dao_state: DaoState,
        quota_registry: 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::proposal_quota_registry::ProposalQuotaRegistry,
    }

    struct DaoState has copy, drop, store {
        operational_state: u8,
        terminated_at_ms: 0x1::option::Option<u64>,
        dissolution_unlock_delay_ms: 0x1::option::Option<u64>,
        dissolution_total_asset_supply: 0x1::option::Option<u64>,
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

    public fun delete_expired_intent(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::Expired {
        let v0 = ConfigWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::delete_expired_intent<FutarchyOutcome, ConfigWitness>(arg0, arg1, arg2, v0, arg3)
    }

    public fun new<T0, T1>(arg0: 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::DaoConfig, arg1: 0x1::option::Option<u128>) : FutarchyConfig {
        let v0 = FutarchyConfig{
            asset_type              : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())),
            stable_type             : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>())),
            config                  : arg0,
            launchpad_initial_price : 0x1::option::none<u128>(),
            spot_pool_id            : 0x1::option::none<0x2::object::ID>(),
            dao_state               : new_dao_state(),
            quota_registry          : 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::proposal_quota_registry::new(),
        };
        if (0x1::option::is_some<u128>(&arg1)) {
            let v1 = &mut v0;
            set_launchpad_initial_price(v1, 0x1::option::destroy_some<u128>(arg1));
        };
        v0
    }

    public fun dao_config(arg0: &FutarchyConfig) : &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::DaoConfig {
        &arg0.config
    }

    public fun conditional_amm_fee_bps(arg0: &FutarchyConfig) : u64 {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::conditional_amm_fee_bps(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::trading_params(&arg0.config))
    }

    public fun conditional_liquidity_ratio_percent(arg0: &FutarchyConfig) : u64 {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::conditional_liquidity_ratio_percent(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::trading_params(&arg0.config))
    }

    public fun fee_in_asset_token(arg0: &FutarchyConfig) : bool {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::fee_in_asset_token(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::governance_config(&arg0.config))
    }

    public fun max_actions_per_outcome(arg0: &FutarchyConfig) : u64 {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::max_actions_per_outcome(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::governance_config(&arg0.config))
    }

    public fun max_outcomes(arg0: &FutarchyConfig) : u64 {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::max_outcomes(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::governance_config(&arg0.config))
    }

    public fun min_asset_amount(arg0: &FutarchyConfig) : u64 {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::min_asset_amount(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::trading_params(&arg0.config))
    }

    public fun min_stable_amount(arg0: &FutarchyConfig) : u64 {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::min_stable_amount(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::trading_params(&arg0.config))
    }

    public fun proposal_creation_fee(arg0: &FutarchyConfig) : u64 {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::proposal_creation_fee(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::governance_config(&arg0.config))
    }

    public fun proposal_fee_per_outcome(arg0: &FutarchyConfig) : u64 {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::proposal_fee_per_outcome(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::governance_config(&arg0.config))
    }

    public fun review_period_ms(arg0: &FutarchyConfig) : u64 {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::review_period_ms(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::trading_params(&arg0.config))
    }

    public fun set_conditional_amm_fee_bps(arg0: &mut FutarchyConfig, arg1: u64) {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::set_conditional_amm_fee_bps(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::trading_params_mut(&mut arg0.config), arg1);
    }

    public fun set_conditional_liquidity_ratio_percent(arg0: &mut FutarchyConfig, arg1: u64) {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::set_conditional_liquidity_ratio_percent(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::trading_params_mut(&mut arg0.config), arg1);
    }

    public fun set_conditional_metadata(arg0: &mut FutarchyConfig, arg1: 0x1::option::Option<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::ConditionalMetadata>) {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::set_conditional_metadata(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::conditional_coin_config_mut(&mut arg0.config), arg1);
    }

    public fun set_description(arg0: &mut FutarchyConfig, arg1: 0x1::string::String) {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::set_description(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::metadata_config_mut(&mut arg0.config), arg1);
    }

    public fun set_fee_in_asset_token(arg0: &mut FutarchyConfig, arg1: bool) {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::set_fee_in_asset_token(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::governance_config_mut(&mut arg0.config), arg1);
    }

    public fun set_max_actions_per_outcome(arg0: &mut FutarchyConfig, arg1: u64) {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::set_max_actions_per_outcome(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::governance_config_mut(&mut arg0.config), arg1);
    }

    public fun set_max_outcomes(arg0: &mut FutarchyConfig, arg1: u64) {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::set_max_outcomes(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::governance_config_mut(&mut arg0.config), arg1);
    }

    public fun set_min_asset_amount(arg0: &mut FutarchyConfig, arg1: u64) {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::set_min_asset_amount(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::trading_params_mut(&mut arg0.config), arg1);
    }

    public fun set_min_stable_amount(arg0: &mut FutarchyConfig, arg1: u64) {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::set_min_stable_amount(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::trading_params_mut(&mut arg0.config), arg1);
    }

    public fun set_proposal_creation_fee(arg0: &mut FutarchyConfig, arg1: u64) {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::set_proposal_creation_fee(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::governance_config_mut(&mut arg0.config), arg1);
    }

    public fun set_proposal_fee_per_outcome(arg0: &mut FutarchyConfig, arg1: u64) {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::set_proposal_fee_per_outcome(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::governance_config_mut(&mut arg0.config), arg1);
    }

    public fun set_proposal_intent_expiry_ms(arg0: &mut FutarchyConfig, arg1: u64) {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::set_proposal_intent_expiry_ms(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::governance_config_mut(&mut arg0.config), arg1);
    }

    public fun set_review_period_ms(arg0: &mut FutarchyConfig, arg1: u64) {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::set_review_period_ms(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::trading_params_mut(&mut arg0.config), arg1);
    }

    public fun set_sponsored_threshold(arg0: &mut FutarchyConfig, arg1: u128) {
        assert!(arg1 <= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_sponsored_threshold(), 102);
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::set_sponsored_threshold(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::twap_config_mut(&mut arg0.config), arg1);
    }

    public fun set_sponsorship_enabled(arg0: &mut FutarchyConfig, arg1: bool) {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::set_sponsorship_enabled(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::sponsorship_config_mut(&mut arg0.config), arg1);
    }

    public fun set_trading_period_ms(arg0: &mut FutarchyConfig, arg1: u64) {
        assert!(arg1 > 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::start_delay(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::twap_config(&arg0.config)), 114);
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::set_trading_period_ms(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::trading_params_mut(&mut arg0.config), arg1);
    }

    public fun set_use_outcome_index(arg0: &mut FutarchyConfig, arg1: bool) {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::set_use_outcome_index(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::conditional_coin_config_mut(&mut arg0.config), arg1);
    }

    public fun sponsored_threshold(arg0: &FutarchyConfig) : u128 {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::sponsored_threshold(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::twap_config(&arg0.config))
    }

    public fun trading_period_ms(arg0: &FutarchyConfig) : u64 {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::trading_period_ms(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::trading_params(&arg0.config))
    }

    public fun amm_twap_cap_ppm(arg0: &FutarchyConfig) : u64 {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::cap_ppm(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::twap_config(&arg0.config))
    }

    public fun amm_twap_initial_observation(arg0: &FutarchyConfig) : 0x1::option::Option<u128> {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::initial_observation(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::twap_config(&arg0.config))
    }

    public fun amm_twap_start_delay(arg0: &FutarchyConfig) : u64 {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::start_delay(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::twap_config(&arg0.config))
    }

    public fun apply_conditional_metadata_from_execution<T0: store, T1: drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<T0>, arg3: T1, arg4: 0x1::option::Option<bool>, arg5: 0x1::option::Option<0x1::option::Option<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::ConditionalMetadata>>) {
        let v0 = internal_config_mut<T0, T1>(arg0, arg1, arg2, arg3);
        assert_config_active(v0);
        if (0x1::option::is_some<bool>(&arg4)) {
            set_use_outcome_index(v0, *0x1::option::borrow<bool>(&arg4));
        };
        if (0x1::option::is_some<0x1::option::Option<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::ConditionalMetadata>>(&arg5)) {
            set_conditional_metadata(v0, *0x1::option::borrow<0x1::option::Option<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::ConditionalMetadata>>(&arg5));
        };
    }

    public fun apply_governance_updates_from_execution<T0: store, T1: drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<T0>, arg3: T1, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<bool>) {
        let v0 = internal_config_mut<T0, T1>(arg0, arg1, arg2, arg3);
        assert_config_active(v0);
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

    public fun apply_metadata_from_execution<T0: store, T1: drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<T0>, arg3: T1, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x1::option::Option<0x1::string::String>) {
        let v0 = internal_config_mut<T0, T1>(arg0, arg1, arg2, arg3);
        assert_config_active(v0);
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

    public fun apply_sponsorship_config_from_execution<T0: store, T1: drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<T0>, arg3: T1, arg4: 0x1::option::Option<bool>) {
        let v0 = internal_config_mut<T0, T1>(arg0, arg1, arg2, arg3);
        assert_config_active(v0);
        if (0x1::option::is_some<bool>(&arg4)) {
            set_sponsorship_enabled(v0, *0x1::option::borrow<bool>(&arg4));
        };
    }

    public fun apply_trading_params_from_execution<T0: store, T1: drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<T0>, arg3: T1, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u64>) {
        let v0 = internal_config_mut<T0, T1>(arg0, arg1, arg2, arg3);
        assert_config_active(v0);
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

    public fun apply_twap_config_from_execution<T0: store, T1: drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<T0>, arg3: T1, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u128>, arg7: 0x1::option::Option<u128>, arg8: 0x1::option::Option<u128>) {
        let v0 = internal_config_mut<T0, T1>(arg0, arg1, arg2, arg3);
        assert_config_active(v0);
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

    fun assert_authorized_account_creator(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::version_witness::VersionWitness) {
        assert!(is_known_orchestrator_package(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::version_witness::package_addr(arg1)), 116);
    }

    fun assert_config_active(arg0: &FutarchyConfig) {
        assert_not_terminated(&arg0.dao_state);
    }

    fun assert_config_wrapper_caller<T0: drop>(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg1: T0, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 125);
        let v1 = 0x1::type_name::address_string(&v0);
        let v2 = 0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1));
        assert!(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::contains_package_addr(arg0, v2), 125);
        assert!(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::get_package_name(arg0, v2) == 0x1::string::utf8(arg2), 125);
        let v3 = 0x1::type_name::module_string(&v0);
        assert!(0x1::ascii::as_bytes(&v3) == &arg3, 125);
        let v4 = struct_name_bytes(&v0);
        assert!(&v4 == &arg4, 125);
    }

    public fun assert_not_terminated(arg0: &DaoState) {
        assert!(arg0.operational_state == 0, 103);
    }

    public fun asset_type(arg0: &FutarchyConfig) : &0x1::string::String {
        &arg0.asset_type
    }

    public fun cancel_shared_intent<T0: drop + store>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::version_witness::VersionWitness, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(is_accepted_orchestrator_package(arg0, arg1, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::version_witness::package_addr(&arg3)), 117);
        assert!(0x2::clock::timestamp_ms(arg4) >= 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::expiration_time<T0>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::get<T0>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::intents(arg0), arg2)), 119);
        let v0 = ConfigWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::drain_and_destroy_expired(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::cancel_intent<T0, ConfigWitness>(arg0, arg2, v0, arg5));
    }

    public fun check_and_consume_sponsor_quota_from_account<T0: drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0x2::object::ID, arg3: address, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext, arg7: T0) : (bool, u64) {
        assert_config_wrapper_caller<T0>(arg1, arg7, b"FutarchyGovernance", b"proposal_sponsorship", b"Witness");
        let v0 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config_mut_authorized<FutarchyConfig>(arg0, arg1, 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_version::current());
        let (v1, v2) = check_sponsor_quota_available(v0, arg3, arg5);
        if (v1) {
            consume_sponsor_quota(v0, arg2, arg3, arg4, arg5, arg6);
        };
        (v1, v2)
    }

    public fun check_sponsor_quota_available(arg0: &FutarchyConfig, arg1: address, arg2: &0x2::clock::Clock) : (bool, u64) {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::proposal_quota_registry::check_sponsor_quota_available(&arg0.quota_registry, arg1, arg2)
    }

    public(friend) fun config_witness(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account) : ConfigWitness {
        ConfigWitness{dummy_field: false}
    }

    public fun consume_dissolution_capability_creation(arg0: &mut FutarchyConfig) : (u64, u64, u64) {
        let v0 = &mut arg0.dao_state;
        assert!(operational_state(v0) == state_terminated(), 108);
        assert!(!dissolution_capability_created(v0), 107);
        let v1 = dissolution_unlock_time(v0);
        assert!(0x1::option::is_some<u64>(&v1), 108);
        let v2 = dissolution_total_asset_supply(v0);
        assert!(0x1::option::is_some<u64>(&v2), 108);
        let v3 = terminated_at(v0);
        mark_dissolution_capability_created(v0);
        (*0x1::option::borrow<u64>(&v1), *0x1::option::borrow<u64>(&v3), *0x1::option::borrow<u64>(&v2))
    }

    public fun consume_dissolution_capability_creation_from_account<T0: drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: T0) : (u64, u64, u64) {
        assert_config_wrapper_caller<T0>(arg1, arg2, b"FutarchyActions", b"dissolution_actions", b"ExecutionProgressWitness");
        let v0 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config_mut_authorized<FutarchyConfig>(arg0, arg1, 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_version::current());
        consume_dissolution_capability_creation(v0)
    }

    public fun consume_feeless_quota(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg2, 112);
        let v0 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config_mut_authorized<FutarchyConfig>(arg0, arg1, 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_version::current());
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::proposal_quota_registry::use_feeless_quota(quota_registry_mut(v0), 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg0), arg2, arg3);
    }

    public(friend) fun consume_redemption_pool_creation(arg0: &mut FutarchyConfig) {
        let v0 = &mut arg0.dao_state;
        assert!(operational_state(v0) == state_terminated(), 108);
        assert!(!v0.redemption_pool_created, 122);
        v0.redemption_pool_created = true;
    }

    public fun consume_redemption_pool_creation_from_execution<T0: store, T1: drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<T0>, arg3: T1) {
        let v0 = internal_config_mut<T0, T1>(arg0, arg1, arg2, arg3);
        consume_redemption_pool_creation(v0);
    }

    public fun consume_sponsor_quota(arg0: &mut FutarchyConfig, arg1: 0x2::object::ID, arg2: address, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg2, 115);
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::proposal_quota_registry::use_sponsor_quota(&mut arg0.quota_registry, arg1, arg2, arg3, arg4);
    }

    public(friend) fun create_config_executable<T0: copy + store>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (T0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<T0>) {
        let v0 = ConfigWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::create_executable<FutarchyConfig, T0, ConfigWitness>(arg0, arg1, arg2, arg3, v0, arg4)
    }

    public fun create_futarchy_executable(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::version_witness::VersionWitness, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (FutarchyOutcome, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<FutarchyOutcome>) {
        assert!(is_accepted_orchestrator_package(arg0, arg1, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::version_witness::package_addr(&arg3)), 118);
        let (v0, v1) = create_config_executable<FutarchyOutcome>(arg0, arg1, arg2, arg4, arg5);
        let v2 = v0;
        assert!(v2.approved, 120);
        assert!(0x2::clock::timestamp_ms(arg4) >= v2.min_execution_time, 123);
        (v2, v1)
    }

    public fun create_init_executable<T0: copy + store>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::version_witness::VersionWitness, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (T0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<T0>) {
        assert!(0x1::type_name::with_original_ids<T0>() != 0x1::type_name::with_original_ids<FutarchyOutcome>(), 121);
        assert!(is_factory_package(arg0, arg1, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::version_witness::package_addr(&arg3)), 118);
        create_config_executable<T0>(arg0, arg1, arg2, arg4, arg5)
    }

    public(friend) fun dao_config_mut(arg0: &mut FutarchyConfig) : &mut 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::DaoConfig {
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

    public fun dissolution_total_asset_supply(arg0: &DaoState) : 0x1::option::Option<u64> {
        arg0.dissolution_total_asset_supply
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

    public fun force_cancel_shared_intent<T0: drop + store>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::version_witness::VersionWitness, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_factory_package(arg0, arg1, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::version_witness::package_addr(&arg3)), 117);
        let v0 = ConfigWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::drain_and_destroy_expired(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::cancel_intent<T0, ConfigWitness>(arg0, arg2, v0, arg4));
    }

    public fun get_launchpad_initial_price(arg0: &FutarchyConfig) : 0x1::option::Option<u128> {
        arg0.launchpad_initial_price
    }

    public fun get_spot_pool_id(arg0: &FutarchyConfig) : 0x1::option::Option<0x2::object::ID> {
        arg0.spot_pool_id
    }

    public(friend) fun internal_config_mut<T0: store, T1: drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<T0>, arg3: T1) : &mut FutarchyConfig {
        let v0 = ConfigWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config_mut_from_execution<FutarchyConfig, T0, T1, ConfigWitness>(arg0, arg1, arg2, arg3, v0)
    }

    fun is_accepted_orchestrator_package(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: address) : bool {
        if (0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::deps::registry_id(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::deps(arg0)) != 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry>(arg1)) {
            return false
        };
        if (!0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::contains_package_addr(arg1, arg2)) {
            return false
        };
        let v0 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::get_package_name(arg1, arg2);
        is_known_orchestrator_name(&v0)
    }

    fun is_factory_package(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: address) : bool {
        if (!is_accepted_orchestrator_package(arg0, arg1, arg2)) {
            return false
        };
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::get_package_name(arg1, arg2) == 0x1::string::utf8(b"FutarchyFactory")
    }

    fun is_known_orchestrator_name(arg0: &0x1::string::String) : bool {
        if (*arg0 == 0x1::string::utf8(b"FutarchyFactory")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"FutarchyGovernance")) {
            true
        } else {
            *arg0 == 0x1::string::utf8(b"FutarchyGovernanceActions")
        }
    }

    fun is_known_orchestrator_package(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg1: address) : bool {
        if (!0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::contains_package_addr(arg0, arg1)) {
            return false
        };
        let v0 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::get_package_name(arg0, arg1);
        is_known_orchestrator_name(&v0)
    }

    public fun is_operational(arg0: &DaoState) : bool {
        arg0.operational_state == 0
    }

    public fun is_terminated(arg0: &DaoState) : bool {
        arg0.operational_state == 1
    }

    public fun mark_account_initialized(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account) {
        let v0 = ConfigWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::mark_initialized<ConfigWitness>(arg0, v0);
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
            dissolution_total_asset_supply : 0x1::option::none<u64>(),
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

    public fun new_with_package_registry(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg1: FutarchyConfig, arg2: u8, arg3: 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::version_witness::VersionWitness, arg4: &mut 0x2::tx_context::TxContext) : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account {
        assert_authorized_account_creator(arg0, &arg3);
        let v0 = ConfigWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::new<FutarchyConfig, ConfigWitness>(arg1, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::metadata::empty(), 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::deps::new_with_level(arg0, arg2), v0, arg4)
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
        0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_sponsored_threshold()
    }

    public fun quota_registry(arg0: &FutarchyConfig) : &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::proposal_quota_registry::ProposalQuotaRegistry {
        &arg0.quota_registry
    }

    public(friend) fun quota_registry_mut(arg0: &mut FutarchyConfig) : &mut 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::proposal_quota_registry::ProposalQuotaRegistry {
        &mut arg0.quota_registry
    }

    public fun redemption_pool_created(arg0: &DaoState) : bool {
        arg0.redemption_pool_created
    }

    public fun set_amm_twap_cap_ppm(arg0: &mut FutarchyConfig, arg1: u64) {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::set_cap_ppm(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::twap_config_mut(&mut arg0.config), arg1);
    }

    public fun set_amm_twap_initial_observation(arg0: &mut FutarchyConfig, arg1: u128) {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::set_initial_observation(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::twap_config_mut(&mut arg0.config), arg1);
    }

    public fun set_amm_twap_start_delay(arg0: &mut FutarchyConfig, arg1: u64) {
        assert!(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::trading_period_ms(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::trading_params(&arg0.config)) > arg1, 114);
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::set_start_delay(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::twap_config_mut(&mut arg0.config), arg1);
    }

    public fun set_dao_name(arg0: &mut FutarchyConfig, arg1: 0x1::string::String) {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::set_dao_name_string(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::metadata_config_mut(&mut arg0.config), arg1);
    }

    public fun set_dao_name_from_execution<T0: store, T1: drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<T0>, arg3: T1, arg4: 0x1::string::String) {
        let v0 = internal_config_mut<T0, T1>(arg0, arg1, arg2, arg3);
        assert_config_active(v0);
        set_dao_name(v0, arg4);
    }

    public fun set_dissolution_params(arg0: &mut DaoState, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg0.operational_state == 1, 108);
        assert!(0x1::option::is_none<u64>(&arg0.terminated_at_ms), 106);
        assert!(0x1::option::is_none<u64>(&arg0.dissolution_unlock_delay_ms), 106);
        assert!(0x1::option::is_none<u64>(&arg0.dissolution_total_asset_supply), 106);
        assert!(arg3 > 0, 124);
        assert!(arg1 <= 18446744073709551615 - arg2, 109);
        arg0.terminated_at_ms = 0x1::option::some<u64>(arg1);
        arg0.dissolution_unlock_delay_ms = 0x1::option::some<u64>(arg2);
        arg0.dissolution_total_asset_supply = 0x1::option::some<u64>(arg3);
    }

    public fun set_icon_url(arg0: &mut FutarchyConfig, arg1: 0x1::string::String) {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::set_icon_url_string(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::metadata_config_mut(&mut arg0.config), arg1);
    }

    public fun set_launchpad_initial_price(arg0: &mut FutarchyConfig, arg1: u128) {
        assert!(0x1::option::is_none<u128>(&arg0.launchpad_initial_price), 101);
        assert!(arg1 > 0, 113);
        arg0.launchpad_initial_price = 0x1::option::some<u128>(arg1);
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::set_initial_observation(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::twap_config_mut(&mut arg0.config), arg1);
    }

    public fun set_launchpad_initial_price_from_execution<T0: store, T1: drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<T0>, arg3: T1, arg4: u128) {
        let v0 = internal_config_mut<T0, T1>(arg0, arg1, arg2, arg3);
        assert_config_active(v0);
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

    public fun set_quotas_from_execution<T0: store, T1: drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<T0>, arg3: T1, arg4: vector<address>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg0);
        let v1 = internal_config_mut<T0, T1>(arg0, arg1, arg2, arg3);
        assert_config_active(v1);
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::proposal_quota_registry::set_quotas(quota_registry_mut(v1), v0, arg4, arg5, arg6, arg7, arg8);
    }

    public fun set_spot_pool_id(arg0: &mut FutarchyConfig, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.spot_pool_id), 105);
        arg0.spot_pool_id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public fun set_spot_pool_id_from_account<T0: drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0x2::object::ID, arg3: T0) {
        assert_config_wrapper_caller<T0>(arg1, arg3, b"FutarchyActions", b"liquidity_init_actions", b"ExecutionProgressWitness");
        let v0 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config_mut_authorized<FutarchyConfig>(arg0, arg1, 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_version::current());
        set_spot_pool_id(v0, arg2);
    }

    public fun set_trading_period_and_twap_delay(arg0: &mut FutarchyConfig, arg1: u64, arg2: u64) {
        assert!(arg1 > arg2, 114);
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::set_trading_period_ms(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::trading_params_mut(&mut arg0.config), arg1);
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::set_start_delay(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::twap_config_mut(&mut arg0.config), arg2);
    }

    public fun set_twap_initial_observation_from_execution<T0: store, T1: drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<T0>, arg3: T1, arg4: u128) {
        let v0 = internal_config_mut<T0, T1>(arg0, arg1, arg2, arg3);
        assert_config_active(v0);
        set_amm_twap_initial_observation(v0, arg4);
    }

    public fun set_twap_threshold(arg0: &mut FutarchyConfig, arg1: u128) {
        assert!(arg1 <= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::twap_threshold_base(), 102);
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::set_threshold(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::twap_config_mut(&mut arg0.config), arg1);
    }

    public fun stable_type(arg0: &FutarchyConfig) : &0x1::string::String {
        &arg0.stable_type
    }

    public fun stage_intent<T0: drop + store, T1: drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::PendingIntent<T0>, arg3: 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::version_witness::VersionWitness, arg4: T1) {
        assert!(is_accepted_orchestrator_package(arg0, arg1, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::version_witness::package_addr(&arg3)), 117);
        let v0 = ConfigWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::insert_intent<FutarchyConfig, T0, ConfigWitness, T1>(arg0, arg1, arg2, v0, arg4);
    }

    public fun state_active() : u8 {
        0
    }

    public(friend) fun state_mut_from_account(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry) : &mut DaoState {
        &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config_mut_authorized<FutarchyConfig>(arg0, arg1, 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_version::current()).dao_state
    }

    public fun state_terminated() : u8 {
        1
    }

    fun struct_name_bytes(arg0: &0x1::type_name::TypeName) : vector<u8> {
        let v0 = 0x1::ascii::as_bytes(0x1::type_name::as_string(arg0));
        let v1 = 0x1::type_name::address_string(arg0);
        let v2 = 0x1::type_name::module_string(arg0);
        let v3 = 0x1::vector::length<u8>(0x1::ascii::as_bytes(&v1)) + 2 + 0x1::vector::length<u8>(0x1::ascii::as_bytes(&v2)) + 2;
        if (v3 >= 0x1::vector::length<u8>(v0)) {
            return b""
        };
        let v4 = b"";
        while (v3 < 0x1::vector::length<u8>(v0)) {
            let v5 = *0x1::vector::borrow<u8>(v0, v3);
            if (v5 == 60) {
                break
            };
            0x1::vector::push_back<u8>(&mut v4, v5);
            v3 = v3 + 1;
        };
        v4
    }

    public fun terminate_dao_from_execution<T0: store, T1: drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<T0>, arg3: T1, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = internal_config_mut<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = dao_state_mut(v0);
        assert!(operational_state(v1) == state_active(), 103);
        set_operational_state(v1, state_terminated());
        set_dissolution_params(v1, arg4, arg5, arg6);
    }

    public fun terminated_at(arg0: &DaoState) : 0x1::option::Option<u64> {
        arg0.terminated_at_ms
    }

    public fun twap_scale() : u128 {
        (0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::price_precision_scale() as u128)
    }

    public fun twap_threshold(arg0: &FutarchyConfig) : u128 {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::threshold(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::twap_config(&arg0.config))
    }

    public(friend) fun witness() : ConfigWitness {
        ConfigWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

