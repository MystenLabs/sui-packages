module 0x3cc22293978bd3279959469f781629dd92337c3cb83ae33b9d14addeb788febb::config_actions {
    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct TerminateDao has drop {
        dummy_field: bool,
    }

    struct UpdateName has drop {
        dummy_field: bool,
    }

    struct TradingParamsUpdate has drop {
        dummy_field: bool,
    }

    struct MetadataUpdate has drop {
        dummy_field: bool,
    }

    struct TwapConfigUpdate has drop {
        dummy_field: bool,
    }

    struct GovernanceUpdate has drop {
        dummy_field: bool,
    }

    struct MetadataTableUpdate has drop {
        dummy_field: bool,
    }

    struct SponsorshipConfigUpdate has drop {
        dummy_field: bool,
    }

    struct UpdateConditionalMetadata has drop {
        dummy_field: bool,
    }

    struct SyncTwapObservationFromProposal has drop {
        dummy_field: bool,
    }

    struct ConfigActionsWitness has drop {
        dummy_field: bool,
    }

    struct ProposalsEnabledChanged has copy, drop {
        account_id: 0x2::object::ID,
        enabled: bool,
        timestamp: u64,
    }

    struct DaoTerminated has copy, drop {
        account_id: 0x2::object::ID,
        reason: 0x1::string::String,
        timestamp: u64,
    }

    struct DaoNameChanged has copy, drop {
        account_id: 0x2::object::ID,
        new_name: 0x1::string::String,
        timestamp: u64,
    }

    struct TradingParamsChanged has copy, drop {
        account_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct MetadataChanged has copy, drop {
        account_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct TwapConfigChanged has copy, drop {
        account_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct GovernanceSettingsChanged has copy, drop {
        account_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct ConditionalMetadataChanged has copy, drop {
        account_id: 0x2::object::ID,
        has_fallback_metadata: bool,
        use_outcome_index: bool,
        timestamp: u64,
    }

    struct SponsorshipConfigChanged has copy, drop {
        account_id: 0x2::object::ID,
        enabled: bool,
        timestamp: u64,
    }

    struct TwapObservationSynced has copy, drop {
        account_id: 0x2::object::ID,
        new_observation: u128,
        source: u8,
        timestamp: u64,
    }

    struct TerminateDaoAction has copy, drop, store {
        reason: 0x1::string::String,
        dissolution_unlock_delay_ms: u64,
    }

    struct UpdateNameAction has copy, drop, store {
        new_name: 0x1::string::String,
    }

    struct TradingParamsUpdateAction has copy, drop, store {
        min_asset_amount: 0x1::option::Option<u64>,
        min_stable_amount: 0x1::option::Option<u64>,
        review_period_ms: 0x1::option::Option<u64>,
        trading_period_ms: 0x1::option::Option<u64>,
        amm_total_fee_bps: 0x1::option::Option<u64>,
        conditional_liquidity_ratio_percent: 0x1::option::Option<u64>,
    }

    struct MetadataUpdateAction has copy, drop, store {
        dao_name: 0x1::option::Option<0x1::ascii::String>,
        icon_url: 0x1::option::Option<0x2::url::Url>,
        description: 0x1::option::Option<0x1::string::String>,
    }

    struct TwapConfigUpdateAction has copy, drop, store {
        start_delay: 0x1::option::Option<u64>,
        cap_ppm: 0x1::option::Option<u64>,
        initial_observation: 0x1::option::Option<u128>,
        threshold: 0x1::option::Option<u128>,
        sponsored_threshold: 0x1::option::Option<u128>,
    }

    struct GovernanceUpdateAction has copy, drop, store {
        max_outcomes: 0x1::option::Option<u64>,
        max_actions_per_outcome: 0x1::option::Option<u64>,
        proposal_intent_expiry_ms: 0x1::option::Option<u64>,
        proposal_creation_fee: 0x1::option::Option<u64>,
        proposal_fee_per_outcome: 0x1::option::Option<u64>,
        fee_in_asset_token: 0x1::option::Option<bool>,
    }

    struct MetadataTableUpdateAction has copy, drop, store {
        keys: vector<0x1::string::String>,
        values: vector<0x1::string::String>,
        keys_to_remove: vector<0x1::string::String>,
    }

    struct ConditionalMetadataUpdateAction has copy, drop, store {
        use_outcome_index: 0x1::option::Option<bool>,
        conditional_metadata: 0x1::option::Option<0x1::option::Option<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::dao_config::ConditionalMetadata>>,
    }

    struct SponsorshipConfigUpdateAction has copy, drop, store {
        enabled: 0x1::option::Option<bool>,
    }

    struct SyncTwapObservationAction has copy, drop, store {
        dummy_field: bool,
    }

    fun assert_account_authority<T0: store>(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T0>, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account) {
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::assert_is_account<T0>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T0>(arg0), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(arg1));
    }

    fun assert_ascii_string(arg0: &0x1::string::String) {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            assert!(*0x1::vector::borrow<u8>(v0, v1) <= 127, 14);
            v1 = v1 + 1;
        };
    }

    public fun destroy_governance_update(arg0: GovernanceUpdateAction) {
        let GovernanceUpdateAction {
            max_outcomes              : _,
            max_actions_per_outcome   : _,
            proposal_intent_expiry_ms : _,
            proposal_creation_fee     : _,
            proposal_fee_per_outcome  : _,
            fee_in_asset_token        : _,
        } = arg0;
    }

    public fun destroy_metadata_table_update(arg0: MetadataTableUpdateAction) {
        let MetadataTableUpdateAction {
            keys           : _,
            values         : _,
            keys_to_remove : _,
        } = arg0;
    }

    public fun destroy_metadata_update(arg0: MetadataUpdateAction) {
        let MetadataUpdateAction {
            dao_name    : _,
            icon_url    : _,
            description : _,
        } = arg0;
    }

    public fun destroy_sponsorship_config_update(arg0: SponsorshipConfigUpdateAction) {
        let SponsorshipConfigUpdateAction {  } = arg0;
    }

    public fun destroy_trading_params_update(arg0: TradingParamsUpdateAction) {
        let TradingParamsUpdateAction {
            min_asset_amount                    : _,
            min_stable_amount                   : _,
            review_period_ms                    : _,
            trading_period_ms                   : _,
            amm_total_fee_bps                   : _,
            conditional_liquidity_ratio_percent : _,
        } = arg0;
    }

    public fun destroy_twap_config_update(arg0: TwapConfigUpdateAction) {
        let TwapConfigUpdateAction {
            start_delay         : _,
            cap_ppm             : _,
            initial_observation : _,
            threshold           : _,
            sponsored_threshold : _,
        } = arg0;
    }

    public fun destroy_update_name(arg0: UpdateNameAction) {
        let UpdateNameAction {  } = arg0;
    }

    public fun do_sync_twap_observation_from_proposal<T0, T1, T2: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::FutarchyOutcome>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: &0xacef61a4fb7f001f9e4aa06b5ad1c5ef4ad2849179ce56e1d0c9a581e0daba59::proposal::Proposal<T0, T1>, arg4: T2, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_account_authority<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::FutarchyOutcome>(arg0, arg1);
        assert!(0xacef61a4fb7f001f9e4aa06b5ad1c5ef4ad2849179ce56e1d0c9a581e0daba59::proposal::get_dao_id<T0, T1>(arg3) == 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1), 11);
        let v0 = 0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::outcome_proposal_id(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::outcome<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::FutarchyOutcome>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::FutarchyOutcome>(arg0)));
        assert!(0x1::option::is_some<0x2::object::ID>(&v0) && *0x1::option::borrow<0x2::object::ID>(&v0) == 0x2::object::id<0xacef61a4fb7f001f9e4aa06b5ad1c5ef4ad2849179ce56e1d0c9a581e0daba59::proposal::Proposal<T0, T1>>(arg3), 13);
        let v1 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::FutarchyOutcome>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::FutarchyOutcome>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::FutarchyOutcome>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<SyncTwapObservationFromProposal>(v1);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v1) == 1, 8);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(0x2::bcs::new(*0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v1)));
        let v2 = 0xacef61a4fb7f001f9e4aa06b5ad1c5ef4ad2849179ce56e1d0c9a581e0daba59::proposal::get_winning_twap<T0, T1>(arg3);
        let v3 = ExecutionProgressWitness{dummy_field: false};
        0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::set_twap_initial_observation_from_execution<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::FutarchyOutcome, ExecutionProgressWitness>(arg1, arg2, arg0, v3, v2);
        let v4 = TwapObservationSynced{
            account_id      : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            new_observation : v2,
            source          : 1,
            timestamp       : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<TwapObservationSynced>(v4);
        let v5 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::FutarchyOutcome, SyncTwapObservationFromProposal, ExecutionProgressWitness>(arg0, arg2, v5);
    }

    public fun do_terminate_dao<T0: store, T1: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T0>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: T1, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_account_authority<T0>(arg0, arg1);
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T0>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T0>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T0>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<TerminateDao>(v0);
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 8);
        let v2 = 0x2::bcs::new(*v1);
        let v3 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v2);
        assert!(0x1::string::length(&v3) > 0, 3);
        assert!(0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::operational_state(0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::dao_state(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::config<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::FutarchyConfig>(arg1))) == 0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::state_active(), 9);
        let v4 = ExecutionProgressWitness{dummy_field: false};
        0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::terminate_dao_from_execution<T0, ExecutionProgressWitness>(arg1, arg2, arg0, v4, 0x2::clock::timestamp_ms(arg4), 0x2::bcs::peel_u64(&mut v2));
        let v5 = DaoTerminated{
            account_id : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            reason     : v3,
            timestamp  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<DaoTerminated>(v5);
        let v6 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T0, TerminateDao, ExecutionProgressWitness>(arg0, arg2, v6);
    }

    public fun do_update_conditional_metadata<T0: store, T1: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T0>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: T1, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_account_authority<T0>(arg0, arg1);
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T0>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T0>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T0>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<UpdateConditionalMetadata>(v0);
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 8);
        let v2 = 0x2::bcs::new(*v1);
        let v3 = &mut v2;
        let v4 = if (0x2::bcs::peel_bool(v3)) {
            0x1::option::some<bool>(0x2::bcs::peel_bool(v3))
        } else {
            0x1::option::none<bool>()
        };
        let v5 = &mut v2;
        let v6 = if (0x2::bcs::peel_bool(v5)) {
            let v7 = if (0x2::bcs::peel_bool(v5)) {
                0x1::option::some<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::dao_config::ConditionalMetadata>(0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::dao_config::new_conditional_metadata(0x2::bcs::peel_u8(v5), 0x1::ascii::string(0x2::bcs::peel_vec_u8(v5)), 0x2::url::new_unsafe(0x1::ascii::string(0x2::bcs::peel_vec_u8(v5)))))
            } else {
                0x1::option::none<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::dao_config::ConditionalMetadata>()
            };
            0x1::option::some<0x1::option::Option<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::dao_config::ConditionalMetadata>>(v7)
        } else {
            0x1::option::none<0x1::option::Option<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::dao_config::ConditionalMetadata>>()
        };
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v2);
        let v8 = ExecutionProgressWitness{dummy_field: false};
        0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::apply_conditional_metadata_from_execution<T0, ExecutionProgressWitness>(arg1, arg2, arg0, v8, v4, v6);
        let v9 = 0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::dao_config::conditional_coin_config(0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::dao_config(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::config<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::FutarchyConfig>(arg1)));
        let v10 = ConditionalMetadataChanged{
            account_id            : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            has_fallback_metadata : 0x1::option::is_some<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::dao_config::ConditionalMetadata>(0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::dao_config::conditional_metadata(v9)),
            use_outcome_index     : 0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::dao_config::use_outcome_index(v9),
            timestamp             : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ConditionalMetadataChanged>(v10);
        let v11 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T0, UpdateConditionalMetadata, ExecutionProgressWitness>(arg0, arg2, v11);
    }

    public fun do_update_governance<T0: store, T1: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T0>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: T1, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_account_authority<T0>(arg0, arg1);
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T0>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T0>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T0>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<GovernanceUpdate>(v0);
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 8);
        let v2 = 0x2::bcs::new(*v1);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v2);
        let v3 = GovernanceUpdateAction{
            max_outcomes              : 0x2::bcs::peel_option_u64(&mut v2),
            max_actions_per_outcome   : 0x2::bcs::peel_option_u64(&mut v2),
            proposal_intent_expiry_ms : 0x2::bcs::peel_option_u64(&mut v2),
            proposal_creation_fee     : 0x2::bcs::peel_option_u64(&mut v2),
            proposal_fee_per_outcome  : 0x2::bcs::peel_option_u64(&mut v2),
            fee_in_asset_token        : 0x2::bcs::peel_option_bool(&mut v2),
        };
        validate_governance_update(&v3);
        let v4 = ExecutionProgressWitness{dummy_field: false};
        0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::apply_governance_updates_from_execution<T0, ExecutionProgressWitness>(arg1, arg2, arg0, v4, v3.max_outcomes, v3.max_actions_per_outcome, v3.proposal_intent_expiry_ms, v3.proposal_creation_fee, v3.proposal_fee_per_outcome, v3.fee_in_asset_token);
        let v5 = GovernanceSettingsChanged{
            account_id : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            timestamp  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<GovernanceSettingsChanged>(v5);
        let v6 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T0, GovernanceUpdate, ExecutionProgressWitness>(arg0, arg2, v6);
    }

    public fun do_update_metadata<T0: store, T1: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T0>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: T1, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_account_authority<T0>(arg0, arg1);
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T0>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T0>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T0>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<MetadataUpdate>(v0);
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 8);
        let v2 = 0x2::bcs::new(*v1);
        let v3 = if (0x2::bcs::peel_bool(&mut v2)) {
            0x1::option::some<0x1::ascii::String>(0x1::ascii::string(0x2::bcs::peel_vec_u8(&mut v2)))
        } else {
            0x1::option::none<0x1::ascii::String>()
        };
        let v4 = if (0x2::bcs::peel_bool(&mut v2)) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v2)))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let v5 = if (0x2::bcs::peel_bool(&mut v2)) {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)))
        } else {
            0x1::option::none<0x1::string::String>()
        };
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v2);
        let v6 = MetadataUpdateAction{
            dao_name    : v3,
            icon_url    : v4,
            description : v5,
        };
        validate_metadata_update(&v6);
        let v7 = if (0x1::option::is_some<0x1::ascii::String>(&v6.dao_name)) {
            0x1::option::some<0x1::string::String>(0x1::string::from_ascii(*0x1::option::borrow<0x1::ascii::String>(&v6.dao_name)))
        } else {
            0x1::option::none<0x1::string::String>()
        };
        let v8 = if (0x1::option::is_some<0x2::url::Url>(&v6.icon_url)) {
            let v9 = *0x1::option::borrow<0x2::url::Url>(&v6.icon_url);
            0x1::option::some<0x1::string::String>(0x1::string::from_ascii(0x2::url::inner_url(&v9)))
        } else {
            0x1::option::none<0x1::string::String>()
        };
        let v10 = ExecutionProgressWitness{dummy_field: false};
        0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::apply_metadata_from_execution<T0, ExecutionProgressWitness>(arg1, arg2, arg0, v10, v7, v8, v6.description);
        let v11 = MetadataChanged{
            account_id : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            timestamp  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<MetadataChanged>(v11);
        let v12 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T0, MetadataUpdate, ExecutionProgressWitness>(arg0, arg2, v12);
    }

    public fun do_update_metadata_table<T0: store, T1: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T0>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: T1, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_account_authority<T0>(arg0, arg1);
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T0>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T0>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T0>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<MetadataTableUpdate>(v0);
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 8);
        let v2 = 0x2::bcs::new(*v1);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = 0;
        while (v4 < 0x2::bcs::peel_vec_length(&mut v2)) {
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)));
            v4 = v4 + 1;
        };
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = 0;
        while (v6 < 0x2::bcs::peel_vec_length(&mut v2)) {
            0x1::vector::push_back<0x1::string::String>(&mut v5, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)));
            v6 = v6 + 1;
        };
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = 0;
        while (v8 < 0x2::bcs::peel_vec_length(&mut v2)) {
            0x1::vector::push_back<0x1::string::String>(&mut v7, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)));
            v8 = v8 + 1;
        };
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v2);
        let v9 = MetadataTableUpdateAction{
            keys           : v3,
            values         : v5,
            keys_to_remove : v7,
        };
        assert!(0x1::vector::length<0x1::string::String>(&v9.keys) == 0x1::vector::length<0x1::string::String>(&v9.values), 4);
        let v10 = 0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::new_metadata_table_key();
        if (!0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::has_managed_data<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::MetadataTableKey>(arg1, v10)) {
            let v11 = ExecutionProgressWitness{dummy_field: false};
            0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::add_managed_data<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::MetadataTableKey, 0x2::table::Table<0x1::string::String, 0x1::string::String>, T0, ExecutionProgressWitness>(arg1, arg2, v10, 0x2::table::new<0x1::string::String, 0x1::string::String>(arg5), arg0, v11);
        };
        let v12 = ExecutionProgressWitness{dummy_field: false};
        let v13 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_mut<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::MetadataTableKey, 0x2::table::Table<0x1::string::String, 0x1::string::String>, T0, ExecutionProgressWitness>(arg1, arg2, v10, arg0, v12);
        let v14 = 0;
        while (v14 < 0x1::vector::length<0x1::string::String>(&v9.keys)) {
            let v15 = *0x1::vector::borrow<0x1::string::String>(&v9.keys, v14);
            if (0x2::table::contains<0x1::string::String, 0x1::string::String>(v13, v15)) {
                *0x2::table::borrow_mut<0x1::string::String, 0x1::string::String>(v13, v15) = *0x1::vector::borrow<0x1::string::String>(&v9.values, v14);
            } else {
                0x2::table::add<0x1::string::String, 0x1::string::String>(v13, v15, *0x1::vector::borrow<0x1::string::String>(&v9.values, v14));
            };
            v14 = v14 + 1;
        };
        let v16 = 0;
        while (v16 < 0x1::vector::length<0x1::string::String>(&v9.keys_to_remove)) {
            let v17 = *0x1::vector::borrow<0x1::string::String>(&v9.keys_to_remove, v16);
            if (0x2::table::contains<0x1::string::String, 0x1::string::String>(v13, v17)) {
                0x2::table::remove<0x1::string::String, 0x1::string::String>(v13, v17);
            };
            v16 = v16 + 1;
        };
        let v18 = MetadataChanged{
            account_id : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            timestamp  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<MetadataChanged>(v18);
        let v19 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T0, MetadataTableUpdate, ExecutionProgressWitness>(arg0, arg2, v19);
    }

    public fun do_update_name<T0: store, T1: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T0>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: T1, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_account_authority<T0>(arg0, arg1);
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T0>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T0>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T0>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<UpdateName>(v0);
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 8);
        let v2 = 0x2::bcs::new(*v1);
        let v3 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v2);
        assert!(0x1::string::length(&v3) > 0, 1);
        assert_ascii_string(&v3);
        let v4 = ExecutionProgressWitness{dummy_field: false};
        0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::set_dao_name_from_execution<T0, ExecutionProgressWitness>(arg1, arg2, arg0, v4, v3);
        let v5 = DaoNameChanged{
            account_id : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            new_name   : v3,
            timestamp  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<DaoNameChanged>(v5);
        let v6 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T0, UpdateName, ExecutionProgressWitness>(arg0, arg2, v6);
    }

    public fun do_update_sponsorship_config<T0: store, T1: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T0>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: T1, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_account_authority<T0>(arg0, arg1);
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T0>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T0>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T0>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<SponsorshipConfigUpdate>(v0);
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 8);
        let v2 = 0x2::bcs::new(*v1);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v2);
        let v3 = ExecutionProgressWitness{dummy_field: false};
        0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::apply_sponsorship_config_from_execution<T0, ExecutionProgressWitness>(arg1, arg2, arg0, v3, 0x2::bcs::peel_option_bool(&mut v2));
        let v4 = SponsorshipConfigChanged{
            account_id : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            enabled    : 0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::dao_config::sponsorship_enabled(0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::dao_config::sponsorship_config(0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::dao_config(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::config<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::FutarchyConfig>(arg1)))),
            timestamp  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<SponsorshipConfigChanged>(v4);
        let v5 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T0, SponsorshipConfigUpdate, ExecutionProgressWitness>(arg0, arg2, v5);
    }

    public fun do_update_trading_params<T0: store, T1: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T0>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: T1, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_account_authority<T0>(arg0, arg1);
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T0>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T0>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T0>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<TradingParamsUpdate>(v0);
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 8);
        let v2 = 0x2::bcs::new(*v1);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v2);
        let v3 = TradingParamsUpdateAction{
            min_asset_amount                    : 0x2::bcs::peel_option_u64(&mut v2),
            min_stable_amount                   : 0x2::bcs::peel_option_u64(&mut v2),
            review_period_ms                    : 0x2::bcs::peel_option_u64(&mut v2),
            trading_period_ms                   : 0x2::bcs::peel_option_u64(&mut v2),
            amm_total_fee_bps                   : 0x2::bcs::peel_option_u64(&mut v2),
            conditional_liquidity_ratio_percent : 0x2::bcs::peel_option_u64(&mut v2),
        };
        validate_trading_params_update(&v3);
        let v4 = ExecutionProgressWitness{dummy_field: false};
        0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::apply_trading_params_from_execution<T0, ExecutionProgressWitness>(arg1, arg2, arg0, v4, v3.min_asset_amount, v3.min_stable_amount, v3.review_period_ms, v3.trading_period_ms, v3.amm_total_fee_bps, v3.conditional_liquidity_ratio_percent);
        let v5 = TradingParamsChanged{
            account_id : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            timestamp  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<TradingParamsChanged>(v5);
        let v6 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T0, TradingParamsUpdate, ExecutionProgressWitness>(arg0, arg2, v6);
    }

    public fun do_update_twap_config<T0: store, T1: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T0>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: T1, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_account_authority<T0>(arg0, arg1);
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T0>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T0>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T0>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<TwapConfigUpdate>(v0);
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 8);
        let v2 = 0x2::bcs::new(*v1);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v2);
        let v3 = TwapConfigUpdateAction{
            start_delay         : 0x2::bcs::peel_option_u64(&mut v2),
            cap_ppm             : 0x2::bcs::peel_option_u64(&mut v2),
            initial_observation : 0x2::bcs::peel_option_u128(&mut v2),
            threshold           : 0x2::bcs::peel_option_u128(&mut v2),
            sponsored_threshold : 0x2::bcs::peel_option_u128(&mut v2),
        };
        validate_twap_config_update(&v3);
        let v4 = ExecutionProgressWitness{dummy_field: false};
        0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::apply_twap_config_from_execution<T0, ExecutionProgressWitness>(arg1, arg2, arg0, v4, v3.start_delay, v3.cap_ppm, v3.initial_observation, v3.threshold, v3.sponsored_threshold);
        let v5 = TwapConfigChanged{
            account_id : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            timestamp  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<TwapConfigChanged>(v5);
        let v6 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T0, TwapConfigUpdate, ExecutionProgressWitness>(arg0, arg2, v6);
    }

    public fun do_update_twap_params<T0: store, T1: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T0>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: T1, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        do_update_twap_config<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun get_governance_fields(arg0: &GovernanceUpdateAction) : (&0x1::option::Option<u64>, &0x1::option::Option<u64>, &0x1::option::Option<u64>, &0x1::option::Option<u64>, &0x1::option::Option<u64>, &0x1::option::Option<bool>) {
        (&arg0.max_outcomes, &arg0.max_actions_per_outcome, &arg0.proposal_intent_expiry_ms, &arg0.proposal_creation_fee, &arg0.proposal_fee_per_outcome, &arg0.fee_in_asset_token)
    }

    public fun get_metadata_fields(arg0: &MetadataUpdateAction) : (&0x1::option::Option<0x1::ascii::String>, &0x1::option::Option<0x2::url::Url>, &0x1::option::Option<0x1::string::String>) {
        (&arg0.dao_name, &arg0.icon_url, &arg0.description)
    }

    public fun get_metadata_table_fields(arg0: &MetadataTableUpdateAction) : (&vector<0x1::string::String>, &vector<0x1::string::String>, &vector<0x1::string::String>) {
        (&arg0.keys, &arg0.values, &arg0.keys_to_remove)
    }

    public fun get_metadata_value(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: &0x1::string::String) : 0x1::option::Option<0x1::string::String> {
        let v0 = 0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::new_metadata_table_key();
        if (!0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::has_managed_data<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::MetadataTableKey>(arg0, v0)) {
            return 0x1::option::none<0x1::string::String>()
        };
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_with_package_witness<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::MetadataTableKey, 0x2::table::Table<0x1::string::String, 0x1::string::String>>(arg0, arg1, v0, 0x3cc22293978bd3279959469f781629dd92337c3cb83ae33b9d14addeb788febb::futarchy_actions_version::current());
        if (0x2::table::contains<0x1::string::String, 0x1::string::String>(v1, *arg2)) {
            0x1::option::some<0x1::string::String>(*0x2::table::borrow<0x1::string::String, 0x1::string::String>(v1, *arg2))
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    public fun get_new_name(arg0: &UpdateNameAction) : 0x1::string::String {
        arg0.new_name
    }

    public fun get_trading_params_fields(arg0: &TradingParamsUpdateAction) : (&0x1::option::Option<u64>, &0x1::option::Option<u64>, &0x1::option::Option<u64>, &0x1::option::Option<u64>, &0x1::option::Option<u64>, &0x1::option::Option<u64>) {
        (&arg0.min_asset_amount, &arg0.min_stable_amount, &arg0.review_period_ms, &arg0.trading_period_ms, &arg0.amm_total_fee_bps, &arg0.conditional_liquidity_ratio_percent)
    }

    public fun get_twap_config_fields(arg0: &TwapConfigUpdateAction) : (&0x1::option::Option<u64>, &0x1::option::Option<u64>, &0x1::option::Option<u128>, &0x1::option::Option<u128>, &0x1::option::Option<u128>) {
        (&arg0.start_delay, &arg0.cap_ppm, &arg0.initial_observation, &arg0.threshold, &arg0.sponsored_threshold)
    }

    public(friend) fun governance_update_action_from_bytes(arg0: vector<u8>) : GovernanceUpdateAction {
        let v0 = 0x2::bcs::new(arg0);
        GovernanceUpdateAction{
            max_outcomes              : 0x2::bcs::peel_option_u64(&mut v0),
            max_actions_per_outcome   : 0x2::bcs::peel_option_u64(&mut v0),
            proposal_intent_expiry_ms : 0x2::bcs::peel_option_u64(&mut v0),
            proposal_creation_fee     : 0x2::bcs::peel_option_u64(&mut v0),
            proposal_fee_per_outcome  : 0x2::bcs::peel_option_u64(&mut v0),
            fee_in_asset_token        : 0x2::bcs::peel_option_bool(&mut v0),
        }
    }

    public(friend) fun governance_update_marker() : GovernanceUpdate {
        GovernanceUpdate{dummy_field: false}
    }

    public fun has_metadata_table(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account) : bool {
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::has_managed_data<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::MetadataTableKey>(arg0, 0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::futarchy_config::new_metadata_table_key())
    }

    public(friend) fun metadata_table_update_action_from_bytes(arg0: vector<u8>) : MetadataTableUpdateAction {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0;
        while (v2 < 0x2::bcs::peel_vec_length(&mut v0)) {
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)));
            v2 = v2 + 1;
        };
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = 0;
        while (v4 < 0x2::bcs::peel_vec_length(&mut v0)) {
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)));
            v4 = v4 + 1;
        };
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = 0;
        while (v6 < 0x2::bcs::peel_vec_length(&mut v0)) {
            0x1::vector::push_back<0x1::string::String>(&mut v5, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)));
            v6 = v6 + 1;
        };
        assert!(0x1::vector::length<0x1::string::String>(&v1) == 0x1::vector::length<0x1::string::String>(&v3), 4);
        MetadataTableUpdateAction{
            keys           : v1,
            values         : v3,
            keys_to_remove : v5,
        }
    }

    public(friend) fun metadata_table_update_marker() : MetadataTableUpdate {
        MetadataTableUpdate{dummy_field: false}
    }

    public(friend) fun metadata_update_action_from_bytes(arg0: vector<u8>) : MetadataUpdateAction {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = if (0x2::bcs::peel_bool(&mut v0)) {
            0x1::option::some<0x1::ascii::String>(0x1::ascii::string(0x2::bcs::peel_vec_u8(&mut v0)))
        } else {
            0x1::option::none<0x1::ascii::String>()
        };
        let v2 = if (0x2::bcs::peel_bool(&mut v0)) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0)))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let v3 = if (0x2::bcs::peel_bool(&mut v0)) {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)))
        } else {
            0x1::option::none<0x1::string::String>()
        };
        MetadataUpdateAction{
            dao_name    : v1,
            icon_url    : v2,
            description : v3,
        }
    }

    public(friend) fun metadata_update_marker() : MetadataUpdate {
        MetadataUpdate{dummy_field: false}
    }

    public fun new_conditional_metadata_update_action(arg0: 0x1::option::Option<bool>, arg1: 0x1::option::Option<0x1::option::Option<0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::dao_config::ConditionalMetadata>>) : ConditionalMetadataUpdateAction {
        ConditionalMetadataUpdateAction{
            use_outcome_index    : arg0,
            conditional_metadata : arg1,
        }
    }

    public fun new_governance_update<T0, T1: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Intent<T0>, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<bool>, arg7: T1) {
        let v0 = GovernanceUpdateAction{
            max_outcomes              : arg1,
            max_actions_per_outcome   : arg2,
            proposal_intent_expiry_ms : arg3,
            proposal_creation_fee     : arg4,
            proposal_fee_per_outcome  : arg5,
            fee_in_asset_token        : arg6,
        };
        validate_governance_update(&v0);
        let v1 = GovernanceUpdate{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::add_typed_action<T0, GovernanceUpdate, T1>(arg0, v1, 0x2::bcs::to_bytes<GovernanceUpdateAction>(&v0), arg7);
        destroy_governance_update(v0);
    }

    public fun new_governance_update_action(arg0: 0x1::option::Option<u64>, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<bool>) : GovernanceUpdateAction {
        let v0 = GovernanceUpdateAction{
            max_outcomes              : arg0,
            max_actions_per_outcome   : arg1,
            proposal_intent_expiry_ms : arg2,
            proposal_creation_fee     : arg3,
            proposal_fee_per_outcome  : arg4,
            fee_in_asset_token        : arg5,
        };
        validate_governance_update(&v0);
        v0
    }

    public fun new_metadata_table_update<T0, T1: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Intent<T0>, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: T1) {
        assert!(0x1::vector::length<0x1::string::String>(&arg1) == 0x1::vector::length<0x1::string::String>(&arg2), 4);
        let v0 = MetadataTableUpdateAction{
            keys           : arg1,
            values         : arg2,
            keys_to_remove : arg3,
        };
        let v1 = MetadataTableUpdate{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::add_typed_action<T0, MetadataTableUpdate, T1>(arg0, v1, 0x2::bcs::to_bytes<MetadataTableUpdateAction>(&v0), arg4);
        destroy_metadata_table_update(v0);
    }

    public fun new_metadata_table_update_action(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>) : MetadataTableUpdateAction {
        assert!(0x1::vector::length<0x1::string::String>(&arg0) == 0x1::vector::length<0x1::string::String>(&arg1), 4);
        MetadataTableUpdateAction{
            keys           : arg0,
            values         : arg1,
            keys_to_remove : arg2,
        }
    }

    public fun new_metadata_update<T0, T1: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Intent<T0>, arg1: 0x1::option::Option<0x1::ascii::String>, arg2: 0x1::option::Option<0x2::url::Url>, arg3: 0x1::option::Option<0x1::string::String>, arg4: T1) {
        let v0 = MetadataUpdateAction{
            dao_name    : arg1,
            icon_url    : arg2,
            description : arg3,
        };
        validate_metadata_update(&v0);
        let v1 = MetadataUpdate{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::add_typed_action<T0, MetadataUpdate, T1>(arg0, v1, 0x2::bcs::to_bytes<MetadataUpdateAction>(&v0), arg4);
        destroy_metadata_update(v0);
    }

    public fun new_metadata_update_action(arg0: 0x1::option::Option<0x1::ascii::String>, arg1: 0x1::option::Option<0x2::url::Url>, arg2: 0x1::option::Option<0x1::string::String>) : MetadataUpdateAction {
        let v0 = MetadataUpdateAction{
            dao_name    : arg0,
            icon_url    : arg1,
            description : arg2,
        };
        validate_metadata_update(&v0);
        v0
    }

    public fun new_sponsorship_config_update_action(arg0: 0x1::option::Option<bool>) : SponsorshipConfigUpdateAction {
        SponsorshipConfigUpdateAction{enabled: arg0}
    }

    public fun new_trading_params_update<T0, T1: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Intent<T0>, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: T1) {
        let v0 = TradingParamsUpdateAction{
            min_asset_amount                    : arg1,
            min_stable_amount                   : arg2,
            review_period_ms                    : arg3,
            trading_period_ms                   : arg4,
            amm_total_fee_bps                   : arg5,
            conditional_liquidity_ratio_percent : arg6,
        };
        validate_trading_params_update(&v0);
        let v1 = TradingParamsUpdate{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::add_typed_action<T0, TradingParamsUpdate, T1>(arg0, v1, 0x2::bcs::to_bytes<TradingParamsUpdateAction>(&v0), arg7);
        destroy_trading_params_update(v0);
    }

    public fun new_trading_params_update_action(arg0: 0x1::option::Option<u64>, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>) : TradingParamsUpdateAction {
        let v0 = TradingParamsUpdateAction{
            min_asset_amount                    : arg0,
            min_stable_amount                   : arg1,
            review_period_ms                    : arg2,
            trading_period_ms                   : arg3,
            amm_total_fee_bps                   : arg4,
            conditional_liquidity_ratio_percent : arg5,
        };
        validate_trading_params_update(&v0);
        v0
    }

    public fun new_twap_config_update<T0, T1: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Intent<T0>, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u128>, arg4: 0x1::option::Option<u128>, arg5: 0x1::option::Option<u128>, arg6: T1) {
        let v0 = TwapConfigUpdateAction{
            start_delay         : arg1,
            cap_ppm             : arg2,
            initial_observation : arg3,
            threshold           : arg4,
            sponsored_threshold : arg5,
        };
        validate_twap_config_update(&v0);
        let v1 = TwapConfigUpdate{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::add_typed_action<T0, TwapConfigUpdate, T1>(arg0, v1, 0x2::bcs::to_bytes<TwapConfigUpdateAction>(&v0), arg6);
        destroy_twap_config_update(v0);
    }

    public fun new_twap_config_update_action(arg0: 0x1::option::Option<u64>, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u128>, arg3: 0x1::option::Option<u128>, arg4: 0x1::option::Option<u128>) : TwapConfigUpdateAction {
        let v0 = TwapConfigUpdateAction{
            start_delay         : arg0,
            cap_ppm             : arg1,
            initial_observation : arg2,
            threshold           : arg3,
            sponsored_threshold : arg4,
        };
        validate_twap_config_update(&v0);
        v0
    }

    public fun new_update_name<T0, T1: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Intent<T0>, arg1: 0x1::string::String, arg2: T1) {
        assert!(0x1::string::length(&arg1) > 0, 1);
        assert_ascii_string(&arg1);
        let v0 = UpdateNameAction{new_name: arg1};
        let v1 = UpdateName{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::add_typed_action<T0, UpdateName, T1>(arg0, v1, 0x2::bcs::to_bytes<UpdateNameAction>(&v0), arg2);
        destroy_update_name(v0);
    }

    public fun new_update_name_action(arg0: 0x1::string::String) : UpdateNameAction {
        assert!(0x1::string::length(&arg0) > 0, 1);
        assert_ascii_string(&arg0);
        UpdateNameAction{new_name: arg0}
    }

    public(friend) fun sponsorship_config_update_action_from_bytes(arg0: vector<u8>) : SponsorshipConfigUpdateAction {
        let v0 = 0x2::bcs::new(arg0);
        SponsorshipConfigUpdateAction{enabled: 0x2::bcs::peel_option_bool(&mut v0)}
    }

    public(friend) fun sponsorship_config_update_marker() : SponsorshipConfigUpdate {
        SponsorshipConfigUpdate{dummy_field: false}
    }

    public(friend) fun sync_twap_observation_from_proposal_marker() : SyncTwapObservationFromProposal {
        SyncTwapObservationFromProposal{dummy_field: false}
    }

    public(friend) fun terminate_dao_marker() : TerminateDao {
        TerminateDao{dummy_field: false}
    }

    public(friend) fun trading_params_update_action_from_bytes(arg0: vector<u8>) : TradingParamsUpdateAction {
        let v0 = 0x2::bcs::new(arg0);
        TradingParamsUpdateAction{
            min_asset_amount                    : 0x2::bcs::peel_option_u64(&mut v0),
            min_stable_amount                   : 0x2::bcs::peel_option_u64(&mut v0),
            review_period_ms                    : 0x2::bcs::peel_option_u64(&mut v0),
            trading_period_ms                   : 0x2::bcs::peel_option_u64(&mut v0),
            amm_total_fee_bps                   : 0x2::bcs::peel_option_u64(&mut v0),
            conditional_liquidity_ratio_percent : 0x2::bcs::peel_option_u64(&mut v0),
        }
    }

    public(friend) fun trading_params_update_marker() : TradingParamsUpdate {
        TradingParamsUpdate{dummy_field: false}
    }

    public(friend) fun twap_config_update_action_from_bytes(arg0: vector<u8>) : TwapConfigUpdateAction {
        let v0 = 0x2::bcs::new(arg0);
        TwapConfigUpdateAction{
            start_delay         : 0x2::bcs::peel_option_u64(&mut v0),
            cap_ppm             : 0x2::bcs::peel_option_u64(&mut v0),
            initial_observation : 0x2::bcs::peel_option_u128(&mut v0),
            threshold           : 0x2::bcs::peel_option_u128(&mut v0),
            sponsored_threshold : 0x2::bcs::peel_option_u128(&mut v0),
        }
    }

    public(friend) fun twap_config_update_marker() : TwapConfigUpdate {
        TwapConfigUpdate{dummy_field: false}
    }

    public(friend) fun update_conditional_metadata_marker() : UpdateConditionalMetadata {
        UpdateConditionalMetadata{dummy_field: false}
    }

    public(friend) fun update_name_action_from_bytes(arg0: vector<u8>) : UpdateNameAction {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = UpdateNameAction{new_name: 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0))};
        assert!(0x1::string::length(&v1.new_name) > 0, 1);
        assert_ascii_string(&v1.new_name);
        v1
    }

    public(friend) fun update_name_marker() : UpdateName {
        UpdateName{dummy_field: false}
    }

    fun validate_governance_update(arg0: &GovernanceUpdateAction) {
        if (0x1::option::is_some<u64>(&arg0.max_outcomes)) {
            let v0 = *0x1::option::borrow<u64>(&arg0.max_outcomes);
            assert!(v0 >= 0xb13367f558316916b876e5aa40dbd828e765b65241c161509c59ca7260dca9a3::constants::min_outcomes(), 2);
            assert!(v0 <= 0xb13367f558316916b876e5aa40dbd828e765b65241c161509c59ca7260dca9a3::constants::protocol_max_outcomes(), 2);
        };
        if (0x1::option::is_some<u64>(&arg0.max_actions_per_outcome)) {
            let v1 = *0x1::option::borrow<u64>(&arg0.max_actions_per_outcome);
            assert!(v1 > 0, 2);
            assert!(v1 <= 0xb13367f558316916b876e5aa40dbd828e765b65241c161509c59ca7260dca9a3::constants::protocol_max_actions_per_outcome(), 2);
        };
        if (0x1::option::is_some<u64>(&arg0.proposal_intent_expiry_ms)) {
            assert!(*0x1::option::borrow<u64>(&arg0.proposal_intent_expiry_ms) >= 0xb13367f558316916b876e5aa40dbd828e765b65241c161509c59ca7260dca9a3::constants::min_proposal_intent_expiry_ms(), 2);
        };
        if (0x1::option::is_some<u64>(&arg0.proposal_creation_fee)) {
            assert!(*0x1::option::borrow<u64>(&arg0.proposal_creation_fee) <= 0xb13367f558316916b876e5aa40dbd828e765b65241c161509c59ca7260dca9a3::constants::max_proposal_creation_fee(), 2);
        };
        if (0x1::option::is_some<u64>(&arg0.proposal_fee_per_outcome)) {
            assert!(*0x1::option::borrow<u64>(&arg0.proposal_fee_per_outcome) <= 0xb13367f558316916b876e5aa40dbd828e765b65241c161509c59ca7260dca9a3::constants::max_proposal_fee_per_outcome(), 2);
        };
    }

    fun validate_metadata_update(arg0: &MetadataUpdateAction) {
        if (0x1::option::is_some<0x1::ascii::String>(&arg0.dao_name)) {
            assert!(0x1::ascii::length(0x1::option::borrow<0x1::ascii::String>(&arg0.dao_name)) > 0, 3);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg0.description)) {
            assert!(0x1::string::length(0x1::option::borrow<0x1::string::String>(&arg0.description)) > 0, 3);
        };
    }

    fun validate_trading_params_update(arg0: &TradingParamsUpdateAction) {
        if (0x1::option::is_some<u64>(&arg0.min_asset_amount)) {
            let v0 = *0x1::option::borrow<u64>(&arg0.min_asset_amount);
            assert!(v0 > 0, 2);
            assert!(v0 >= 0xb13367f558316916b876e5aa40dbd828e765b65241c161509c59ca7260dca9a3::constants::protocol_min_liquidity_amount(), 2);
        };
        if (0x1::option::is_some<u64>(&arg0.min_stable_amount)) {
            let v1 = *0x1::option::borrow<u64>(&arg0.min_stable_amount);
            assert!(v1 > 0, 2);
            assert!(v1 >= 0xb13367f558316916b876e5aa40dbd828e765b65241c161509c59ca7260dca9a3::constants::protocol_min_liquidity_amount(), 2);
        };
        if (0x1::option::is_some<u64>(&arg0.review_period_ms)) {
            let v2 = *0x1::option::borrow<u64>(&arg0.review_period_ms);
            assert!(v2 >= 0xb13367f558316916b876e5aa40dbd828e765b65241c161509c59ca7260dca9a3::constants::min_review_period_ms(), 2);
            assert!(v2 <= 0xb13367f558316916b876e5aa40dbd828e765b65241c161509c59ca7260dca9a3::constants::max_trading_duration_ms(), 2);
        };
        if (0x1::option::is_some<u64>(&arg0.trading_period_ms)) {
            let v3 = *0x1::option::borrow<u64>(&arg0.trading_period_ms);
            assert!(v3 >= 0xb13367f558316916b876e5aa40dbd828e765b65241c161509c59ca7260dca9a3::constants::min_trading_period_ms(), 2);
            assert!(v3 <= 0xb13367f558316916b876e5aa40dbd828e765b65241c161509c59ca7260dca9a3::constants::max_trading_duration_ms(), 2);
        };
        if (0x1::option::is_some<u64>(&arg0.amm_total_fee_bps)) {
            assert!(*0x1::option::borrow<u64>(&arg0.amm_total_fee_bps) <= 0xb13367f558316916b876e5aa40dbd828e765b65241c161509c59ca7260dca9a3::constants::max_amm_fee_bps(), 2);
        };
        if (0x1::option::is_some<u64>(&arg0.conditional_liquidity_ratio_percent)) {
            let v4 = *0x1::option::borrow<u64>(&arg0.conditional_liquidity_ratio_percent);
            assert!(v4 >= 0xb13367f558316916b876e5aa40dbd828e765b65241c161509c59ca7260dca9a3::constants::min_conditional_liquidity_percent() && v4 <= 0xb13367f558316916b876e5aa40dbd828e765b65241c161509c59ca7260dca9a3::constants::max_conditional_liquidity_percent(), 2);
        };
    }

    fun validate_twap_config_update(arg0: &TwapConfigUpdateAction) {
        if (0x1::option::is_some<u64>(&arg0.start_delay)) {
            let v0 = *0x1::option::borrow<u64>(&arg0.start_delay);
            assert!(v0 < 0xb13367f558316916b876e5aa40dbd828e765b65241c161509c59ca7260dca9a3::constants::one_week_ms(), 2);
            assert!(v0 % 0xb13367f558316916b876e5aa40dbd828e765b65241c161509c59ca7260dca9a3::constants::twap_price_cap_window() == 0, 2);
        };
        if (0x1::option::is_some<u64>(&arg0.cap_ppm)) {
            let v1 = *0x1::option::borrow<u64>(&arg0.cap_ppm);
            assert!(v1 > 0, 2);
            assert!(v1 <= 0xb13367f558316916b876e5aa40dbd828e765b65241c161509c59ca7260dca9a3::constants::ppm_denominator(), 2);
        };
        if (0x1::option::is_some<u128>(&arg0.initial_observation)) {
            assert!(*0x1::option::borrow<u128>(&arg0.initial_observation) > 0, 2);
        };
        if (0x1::option::is_some<u128>(&arg0.threshold)) {
            assert!(*0x1::option::borrow<u128>(&arg0.threshold) <= 0xb13367f558316916b876e5aa40dbd828e765b65241c161509c59ca7260dca9a3::constants::twap_threshold_base(), 2);
        };
        if (0x1::option::is_some<u128>(&arg0.sponsored_threshold)) {
            assert!(*0x1::option::borrow<u128>(&arg0.sponsored_threshold) <= 0xb13367f558316916b876e5aa40dbd828e765b65241c161509c59ca7260dca9a3::constants::max_sponsored_threshold(), 2);
        };
    }

    // decompiled from Move bytecode v6
}

