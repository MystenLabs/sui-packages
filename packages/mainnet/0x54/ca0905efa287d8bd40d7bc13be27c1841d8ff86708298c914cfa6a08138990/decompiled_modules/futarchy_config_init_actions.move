module 0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::futarchy_config_init_actions {
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
        conditional_metadata: 0x1::option::Option<0x1::option::Option<0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::dao_config::ConditionalMetadata>>,
    }

    struct SponsorshipConfigUpdateAction has copy, drop, store {
        enabled: 0x1::option::Option<bool>,
    }

    struct SyncTwapObservationAction has copy, drop, store {
        dummy_field: bool,
    }

    public fun add_sync_twap_observation_from_proposal_spec(arg0: &mut 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::Builder) {
        let v0 = SyncTwapObservationAction{dummy_field: false};
        0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::add(arg0, 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::config_actions::SyncTwapObservationFromProposal>(), 0x2::bcs::to_bytes<SyncTwapObservationAction>(&v0), 1));
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::emit_action_params(0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::new_builder(), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::source_type(arg0), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::source_id(arg0), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::config_actions::SyncTwapObservationFromProposal>())), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::next_action_index(arg0));
    }

    public fun add_terminate_dao_spec(arg0: &mut 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: u64) {
        assert!(0x1::string::length(&arg1) > 0, 0);
        let v0 = TerminateDaoAction{
            reason                      : arg1,
            dissolution_unlock_delay_ms : arg2,
        };
        0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::add(arg0, 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::config_actions::TerminateDao>(), 0x2::bcs::to_bytes<TerminateDaoAction>(&v0), 1));
        let v1 = 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::new_builder();
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_string(&mut v1, b"reason", arg1);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_u64(&mut v1, b"dissolution_unlock_delay_ms", arg2);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::emit_action_params(v1, 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::source_type(arg0), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::source_id(arg0), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::config_actions::TerminateDao>())), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::next_action_index(arg0));
    }

    public fun add_update_conditional_metadata_spec(arg0: &mut 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::Builder, arg1: 0x1::option::Option<bool>, arg2: 0x1::option::Option<0x1::option::Option<0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::dao_config::ConditionalMetadata>>) {
        let v0 = ConditionalMetadataUpdateAction{
            use_outcome_index    : arg1,
            conditional_metadata : arg2,
        };
        0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::add(arg0, 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::config_actions::UpdateConditionalMetadata>(), 0x2::bcs::to_bytes<ConditionalMetadataUpdateAction>(&v0), 1));
        let v1 = if (0x1::option::is_some<0x1::option::Option<0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::dao_config::ConditionalMetadata>>(&arg2)) {
            if (0x1::option::is_some<0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::dao_config::ConditionalMetadata>(0x1::option::borrow<0x1::option::Option<0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::dao_config::ConditionalMetadata>>(&arg2))) {
                0x1::option::some<0x1::string::String>(0x1::string::utf8(b"<ConditionalMetadata>"))
            } else {
                0x1::option::some<0x1::string::String>(0x1::string::utf8(b"null"))
            }
        } else {
            0x1::option::none<0x1::string::String>()
        };
        let v2 = v1;
        let v3 = 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::new_builder();
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_option_bool(&mut v3, b"use_outcome_index", arg1);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_option_string(&mut v3, b"conditional_metadata", &v2);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::emit_action_params(v3, 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::source_type(arg0), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::source_id(arg0), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::config_actions::UpdateConditionalMetadata>())), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::next_action_index(arg0));
    }

    public fun add_update_governance_spec(arg0: &mut 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::Builder, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<bool>) {
        validate_governance_update(&arg1, &arg2, &arg3, &arg4, &arg5);
        let v0 = GovernanceUpdateAction{
            max_outcomes              : arg1,
            max_actions_per_outcome   : arg2,
            proposal_intent_expiry_ms : arg3,
            proposal_creation_fee     : arg4,
            proposal_fee_per_outcome  : arg5,
            fee_in_asset_token        : arg6,
        };
        0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::add(arg0, 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::config_actions::GovernanceUpdate>(), 0x2::bcs::to_bytes<GovernanceUpdateAction>(&v0), 1));
        let v1 = 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::new_builder();
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_option_u64(&mut v1, b"max_outcomes", arg1);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_option_u64(&mut v1, b"max_actions_per_outcome", arg2);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_option_u64(&mut v1, b"proposal_intent_expiry_ms", arg3);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_option_u64(&mut v1, b"proposal_creation_fee", arg4);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_option_u64(&mut v1, b"proposal_fee_per_outcome", arg5);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_option_bool(&mut v1, b"fee_in_asset_token", arg6);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::emit_action_params(v1, 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::source_type(arg0), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::source_id(arg0), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::config_actions::GovernanceUpdate>())), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::next_action_index(arg0));
    }

    public fun add_update_metadata_spec(arg0: &mut 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::Builder, arg1: 0x1::option::Option<0x1::ascii::String>, arg2: 0x1::option::Option<0x2::url::Url>, arg3: 0x1::option::Option<0x1::string::String>) {
        validate_metadata_update(&arg1, &arg3);
        let v0 = MetadataUpdateAction{
            dao_name    : arg1,
            icon_url    : arg2,
            description : arg3,
        };
        0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::add(arg0, 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::config_actions::MetadataUpdate>(), 0x2::bcs::to_bytes<MetadataUpdateAction>(&v0), 1));
        let v1 = if (0x1::option::is_some<0x1::ascii::String>(&arg1)) {
            0x1::option::some<0x1::string::String>(0x1::string::from_ascii(*0x1::option::borrow<0x1::ascii::String>(&arg1)))
        } else {
            0x1::option::none<0x1::string::String>()
        };
        let v2 = v1;
        let v3 = if (0x1::option::is_some<0x2::url::Url>(&arg2)) {
            0x1::option::some<0x1::string::String>(0x1::string::from_ascii(0x2::url::inner_url(0x1::option::borrow<0x2::url::Url>(&arg2))))
        } else {
            0x1::option::none<0x1::string::String>()
        };
        let v4 = v3;
        let v5 = 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::new_builder();
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_option_string(&mut v5, b"dao_name", &v2);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_option_string(&mut v5, b"icon_url", &v4);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_option_string(&mut v5, b"description", &arg3);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::emit_action_params(v5, 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::source_type(arg0), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::source_id(arg0), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::config_actions::MetadataUpdate>())), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::next_action_index(arg0));
    }

    public fun add_update_metadata_table_spec(arg0: &mut 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::Builder, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>) {
        assert!(0x1::vector::length<0x1::string::String>(&arg1) == 0x1::vector::length<0x1::string::String>(&arg2), 4);
        let v0 = MetadataTableUpdateAction{
            keys           : arg1,
            values         : arg2,
            keys_to_remove : arg3,
        };
        0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::add(arg0, 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::config_actions::MetadataTableUpdate>(), 0x2::bcs::to_bytes<MetadataTableUpdateAction>(&v0), 1));
        let v1 = 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::new_builder();
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_vector_string(&mut v1, b"keys", &arg1);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_vector_string(&mut v1, b"values", &arg2);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_vector_string(&mut v1, b"keys_to_remove", &arg3);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::emit_action_params(v1, 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::source_type(arg0), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::source_id(arg0), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::config_actions::MetadataTableUpdate>())), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::next_action_index(arg0));
    }

    public fun add_update_name_spec(arg0: &mut 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::Builder, arg1: 0x1::string::String) {
        validate_update_name(&arg1);
        let v0 = UpdateNameAction{new_name: arg1};
        0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::add(arg0, 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::config_actions::UpdateName>(), 0x2::bcs::to_bytes<UpdateNameAction>(&v0), 1));
        let v1 = 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::new_builder();
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_string(&mut v1, b"new_name", arg1);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::emit_action_params(v1, 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::source_type(arg0), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::source_id(arg0), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::config_actions::UpdateName>())), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::next_action_index(arg0));
    }

    public fun add_update_sponsorship_config_spec(arg0: &mut 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::Builder, arg1: 0x1::option::Option<bool>) {
        let v0 = SponsorshipConfigUpdateAction{enabled: arg1};
        0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::add(arg0, 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::config_actions::SponsorshipConfigUpdate>(), 0x2::bcs::to_bytes<SponsorshipConfigUpdateAction>(&v0), 1));
        let v1 = 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::new_builder();
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_option_bool(&mut v1, b"enabled", arg1);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::emit_action_params(v1, 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::source_type(arg0), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::source_id(arg0), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::config_actions::SponsorshipConfigUpdate>())), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::next_action_index(arg0));
    }

    public fun add_update_trading_params_spec(arg0: &mut 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::Builder, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>) {
        validate_trading_params_update(&arg1, &arg2, &arg3, &arg4, &arg5, &arg6);
        let v0 = TradingParamsUpdateAction{
            min_asset_amount                    : arg1,
            min_stable_amount                   : arg2,
            review_period_ms                    : arg3,
            trading_period_ms                   : arg4,
            amm_total_fee_bps                   : arg5,
            conditional_liquidity_ratio_percent : arg6,
        };
        0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::add(arg0, 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::config_actions::TradingParamsUpdate>(), 0x2::bcs::to_bytes<TradingParamsUpdateAction>(&v0), 1));
        let v1 = 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::new_builder();
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_option_u64(&mut v1, b"min_asset_amount", arg1);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_option_u64(&mut v1, b"min_stable_amount", arg2);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_option_u64(&mut v1, b"review_period_ms", arg3);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_option_u64(&mut v1, b"trading_period_ms", arg4);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_option_u64(&mut v1, b"amm_total_fee_bps", arg5);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_option_u64(&mut v1, b"conditional_liquidity_ratio_percent", arg6);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::emit_action_params(v1, 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::source_type(arg0), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::source_id(arg0), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::config_actions::TradingParamsUpdate>())), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::next_action_index(arg0));
    }

    public fun add_update_twap_config_spec(arg0: &mut 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::Builder, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u128>, arg4: 0x1::option::Option<u128>, arg5: 0x1::option::Option<u128>) {
        validate_twap_config_update(&arg1, &arg2, &arg3, &arg4, &arg5);
        let v0 = TwapConfigUpdateAction{
            start_delay         : arg1,
            cap_ppm             : arg2,
            initial_observation : arg3,
            threshold           : arg4,
            sponsored_threshold : arg5,
        };
        0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::add(arg0, 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::config_actions::TwapConfigUpdate>(), 0x2::bcs::to_bytes<TwapConfigUpdateAction>(&v0), 1));
        let v1 = 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::new_builder();
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_option_u64(&mut v1, b"start_delay", arg1);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_option_u64(&mut v1, b"cap_ppm", arg2);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_option_u128(&mut v1, b"initial_observation", arg3);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_option_u128(&mut v1, b"threshold", arg4);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_option_u128(&mut v1, b"sponsored_threshold", arg5);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::emit_action_params(v1, 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::source_type(arg0), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::source_id(arg0), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::config_actions::TwapConfigUpdate>())), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::next_action_index(arg0));
    }

    fun assert_ascii_string(arg0: &0x1::string::String) {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            assert!(*0x1::vector::borrow<u8>(v0, v1) <= 127, 3);
            v1 = v1 + 1;
        };
    }

    fun validate_governance_update(arg0: &0x1::option::Option<u64>, arg1: &0x1::option::Option<u64>, arg2: &0x1::option::Option<u64>, arg3: &0x1::option::Option<u64>, arg4: &0x1::option::Option<u64>) {
        if (0x1::option::is_some<u64>(arg0)) {
            let v0 = *0x1::option::borrow<u64>(arg0);
            assert!(v0 >= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::min_outcomes(), 2);
            assert!(v0 <= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::protocol_max_outcomes(), 2);
        };
        if (0x1::option::is_some<u64>(arg1)) {
            let v1 = *0x1::option::borrow<u64>(arg1);
            assert!(v1 > 0, 2);
            assert!(v1 <= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::protocol_max_actions_per_outcome(), 2);
        };
        if (0x1::option::is_some<u64>(arg2)) {
            assert!(*0x1::option::borrow<u64>(arg2) >= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::min_proposal_intent_expiry_ms(), 2);
        };
        if (0x1::option::is_some<u64>(arg3)) {
            assert!(*0x1::option::borrow<u64>(arg3) <= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::max_proposal_creation_fee(), 2);
        };
        if (0x1::option::is_some<u64>(arg4)) {
            assert!(*0x1::option::borrow<u64>(arg4) <= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::max_proposal_fee_per_outcome(), 2);
        };
    }

    fun validate_metadata_update(arg0: &0x1::option::Option<0x1::ascii::String>, arg1: &0x1::option::Option<0x1::string::String>) {
        if (0x1::option::is_some<0x1::ascii::String>(arg0)) {
            assert!(0x1::ascii::length(0x1::option::borrow<0x1::ascii::String>(arg0)) > 0, 0);
        };
        if (0x1::option::is_some<0x1::string::String>(arg1)) {
            assert!(0x1::string::length(0x1::option::borrow<0x1::string::String>(arg1)) > 0, 0);
        };
    }

    fun validate_trading_params_update(arg0: &0x1::option::Option<u64>, arg1: &0x1::option::Option<u64>, arg2: &0x1::option::Option<u64>, arg3: &0x1::option::Option<u64>, arg4: &0x1::option::Option<u64>, arg5: &0x1::option::Option<u64>) {
        if (0x1::option::is_some<u64>(arg0)) {
            let v0 = *0x1::option::borrow<u64>(arg0);
            assert!(v0 > 0, 2);
            assert!(v0 >= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::protocol_min_liquidity_amount(), 2);
        };
        if (0x1::option::is_some<u64>(arg1)) {
            let v1 = *0x1::option::borrow<u64>(arg1);
            assert!(v1 > 0, 2);
            assert!(v1 >= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::protocol_min_liquidity_amount(), 2);
        };
        if (0x1::option::is_some<u64>(arg2)) {
            let v2 = *0x1::option::borrow<u64>(arg2);
            assert!(v2 >= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::min_review_period_ms(), 2);
            assert!(v2 <= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::max_trading_duration_ms(), 2);
        };
        if (0x1::option::is_some<u64>(arg3)) {
            let v3 = *0x1::option::borrow<u64>(arg3);
            assert!(v3 >= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::min_trading_period_ms(), 2);
            assert!(v3 <= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::max_trading_duration_ms(), 2);
        };
        if (0x1::option::is_some<u64>(arg4)) {
            assert!(*0x1::option::borrow<u64>(arg4) <= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::max_amm_fee_bps(), 2);
        };
        if (0x1::option::is_some<u64>(arg5)) {
            let v4 = *0x1::option::borrow<u64>(arg5);
            assert!(v4 >= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::min_conditional_liquidity_percent() && v4 <= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::max_conditional_liquidity_percent(), 2);
        };
    }

    fun validate_twap_config_update(arg0: &0x1::option::Option<u64>, arg1: &0x1::option::Option<u64>, arg2: &0x1::option::Option<u128>, arg3: &0x1::option::Option<u128>, arg4: &0x1::option::Option<u128>) {
        if (0x1::option::is_some<u64>(arg0)) {
            let v0 = *0x1::option::borrow<u64>(arg0);
            assert!(v0 < 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::one_week_ms(), 2);
            assert!(v0 % 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::twap_price_cap_window() == 0, 2);
        };
        if (0x1::option::is_some<u64>(arg1)) {
            let v1 = *0x1::option::borrow<u64>(arg1);
            assert!(v1 > 0, 2);
            assert!(v1 <= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::ppm_denominator(), 2);
        };
        if (0x1::option::is_some<u128>(arg2)) {
            assert!(*0x1::option::borrow<u128>(arg2) > 0, 2);
        };
        if (0x1::option::is_some<u128>(arg3)) {
            assert!(*0x1::option::borrow<u128>(arg3) <= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::twap_threshold_base(), 2);
        };
        if (0x1::option::is_some<u128>(arg4)) {
            assert!(*0x1::option::borrow<u128>(arg4) <= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::max_sponsored_threshold(), 2);
        };
    }

    fun validate_update_name(arg0: &0x1::string::String) {
        assert!(0x1::string::length(arg0) > 0, 0);
        assert_ascii_string(arg0);
    }

    // decompiled from Move bytecode v6
}

