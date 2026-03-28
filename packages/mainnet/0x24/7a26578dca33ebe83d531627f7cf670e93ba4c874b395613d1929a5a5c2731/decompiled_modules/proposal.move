module 0x247a26578dca33ebe83d531627f7cf670e93ba4c874b395613d1929a5a5c2731::proposal {
    struct MarketStateMutationWitness has drop {
        dummy_field: bool,
    }

    struct EscrowMutationWitness has drop {
        dummy_field: bool,
    }

    struct SpotPoolMutationWitness has drop {
        dummy_field: bool,
    }

    struct ConditionalCoinKey has copy, drop, store {
        outcome_index: u64,
        is_asset: bool,
    }

    struct FeeBalanceKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ProposalTiming has store {
        created_at: u64,
        market_initialized_at: 0x1::option::Option<u64>,
        trading_started_at: 0x1::option::Option<u64>,
        review_period_ms: u64,
        trading_period_ms: u64,
        last_twap_update: u64,
        twap_start_delay: u64,
    }

    struct LiquidityConfig has store {
        min_asset_liquidity: u64,
        min_stable_liquidity: u64,
        asset_amounts: vector<u64>,
        stable_amounts: vector<u64>,
    }

    struct TwapConfig has store {
        twap_prices: vector<u128>,
        twap_initial_observation: 0x1::option::Option<u128>,
        twap_cap_ppm: u64,
        twap_threshold: u128,
        sponsored_threshold: u128,
    }

    struct OutcomeData has store {
        outcome_count: u64,
        outcome_messages: vector<0x1::string::String>,
        outcome_creators: vector<address>,
        intent_specs: vector<0x1::option::Option<vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>>>,
        actions_per_outcome: vector<u64>,
        winning_outcome: 0x1::option::Option<u64>,
    }

    struct Proposal<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        state: u8,
        dao_id: 0x2::object::ID,
        proposer: address,
        liquidity_provider: 0x1::option::Option<address>,
        withdraw_only_mode: bool,
        used_feeless_quota: bool,
        outcome_sponsorship: vector<u8>,
        sponsor_quota_used_for_proposal: bool,
        sponsor_quota_user: 0x1::option::Option<address>,
        escrow_id: 0x1::option::Option<0x2::object::ID>,
        market_state_id: 0x1::option::Option<0x2::object::ID>,
        conditional_treasury_caps: 0x2::bag::Bag,
        conditional_metadata_caps: 0x2::bag::Bag,
        conditional_asset_types: vector<0x1::ascii::String>,
        conditional_stable_types: vector<0x1::ascii::String>,
        title: 0x1::string::String,
        introduction_details: 0x1::string::String,
        details: vector<0x1::string::String>,
        metadata: 0x1::string::String,
        timing: ProposalTiming,
        liquidity_config: LiquidityConfig,
        twap_config: TwapConfig,
        outcome_data: OutcomeData,
        amm_total_fee_bps: u64,
        conditional_liquidity_ratio_percent: u64,
        fee_escrow: 0x2::bag::Bag,
        fee_paid_in_asset: bool,
        total_fee_paid: u64,
        max_outcomes: u64,
    }

    struct CancelWitness has drop {
        proposal: address,
        outcome_index: u64,
    }

    struct ProposalCreated has copy, drop {
        proposal_id: 0x2::object::ID,
        dao_id: 0x2::object::ID,
        proposer: address,
        outcome_count: u64,
        outcome_messages: vector<0x1::string::String>,
        created_at: u64,
        asset_type: 0x1::ascii::String,
        stable_type: 0x1::ascii::String,
        review_period_ms: u64,
        trading_period_ms: u64,
        title: 0x1::string::String,
        metadata: 0x1::string::String,
    }

    struct ProposalMarketInitialized has copy, drop {
        proposal_id: 0x2::object::ID,
        dao_id: 0x2::object::ID,
        market_state_id: 0x2::object::ID,
        escrow_id: 0x2::object::ID,
        timestamp: u64,
        conditional_asset_types: vector<0x1::ascii::String>,
        conditional_stable_types: vector<0x1::ascii::String>,
    }

    struct ProposalSponsorshipsUpdated has copy, drop {
        proposal_id: 0x2::object::ID,
        dao_id: 0x2::object::ID,
        applied_count: u64,
        sponsorship_types: vector<u8>,
    }

    struct ProposalSponsorshipUpdated has copy, drop {
        proposal_id: 0x2::object::ID,
        dao_id: 0x2::object::ID,
        outcome_index: u64,
        sponsorship_type: u8,
        applied: bool,
    }

    struct ProposalSponsorQuotaMarked has copy, drop {
        proposal_id: 0x2::object::ID,
        dao_id: 0x2::object::ID,
        sponsor: address,
    }

    struct ProposalSponsorshipsCleared has copy, drop {
        proposal_id: 0x2::object::ID,
        dao_id: 0x2::object::ID,
        cleared_count: u64,
    }

    public fun market_state_id<T0, T1>(arg0: &Proposal<T0, T1>) : 0x2::object::ID {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.market_state_id), 2);
        *0x1::option::borrow<0x2::object::ID>(&arg0.market_state_id)
    }

    public fun get_id<T0, T1>(arg0: &Proposal<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun outcome_count<T0, T1>(arg0: &Proposal<T0, T1>) : u64 {
        arg0.outcome_data.outcome_count
    }

    public fun proposal_id<T0, T1>(arg0: &Proposal<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun add_outcome_coins<T0, T1, T2, T3>(arg0: &mut Proposal<T0, T1>, arg1: &mut 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::TokenEscrow<T0, T1>, arg2: u64, arg3: 0x2::coin::TreasuryCap<T2>, arg4: &mut 0x2::coin_registry::Currency<T2>, arg5: 0x2::coin_registry::MetadataCap<T2>, arg6: 0x2::coin::TreasuryCap<T3>, arg7: &mut 0x2::coin_registry::Currency<T3>, arg8: 0x2::coin_registry::MetadataCap<T3>, arg9: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg10: &0x2::coin_registry::Currency<T0>, arg11: &0x2::coin_registry::Currency<T1>) {
        assert!(arg0.state == 0, 2);
        assert!(arg2 < arg0.outcome_data.outcome_count, 7);
        assert!(0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account>(arg9) == arg0.dao_id, 43);
        let v0 = 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::get_market_state<T0, T1>(arg1);
        assert!(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::proposal_id(v0) == 0x2::object::id<Proposal<T0, T1>>(arg0), 37);
        assert!(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::dao_id(v0) == arg0.dao_id, 37);
        let v1 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::dao_config(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::config<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig>(arg9));
        validate_and_update_conditional_metadata<T0, T1, T2>(arg2, true, &arg3, arg4, &arg5, v1, arg10, arg11);
        validate_and_update_conditional_metadata<T0, T1, T3>(arg2, false, &arg6, arg7, &arg8, v1, arg10, arg11);
        0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::register_conditional_caps<T0, T1, T2, T3>(arg1, arg2, arg3, arg6);
        let v2 = ConditionalCoinKey{
            outcome_index : arg2,
            is_asset      : true,
        };
        let v3 = ConditionalCoinKey{
            outcome_index : arg2,
            is_asset      : false,
        };
        0x2::bag::add<ConditionalCoinKey, 0x2::coin_registry::MetadataCap<T2>>(&mut arg0.conditional_metadata_caps, v2, arg5);
        0x2::bag::add<ConditionalCoinKey, 0x2::coin_registry::MetadataCap<T3>>(&mut arg0.conditional_metadata_caps, v3, arg8);
        *0x1::vector::borrow_mut<0x1::ascii::String>(&mut arg0.conditional_asset_types, arg2) = 0x1::type_name::into_string(0x1::type_name::get<T2>());
        *0x1::vector::borrow_mut<0x1::ascii::String>(&mut arg0.conditional_stable_types, arg2) = 0x1::type_name::into_string(0x1::type_name::get<T3>());
    }

    public fun add_outcome_coins_10<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18, T19, T20, T21>(arg0: &mut Proposal<T0, T1>, arg1: &mut 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::TokenEscrow<T0, T1>, arg2: 0x2::coin::TreasuryCap<T2>, arg3: &mut 0x2::coin_registry::Currency<T2>, arg4: 0x2::coin_registry::MetadataCap<T2>, arg5: 0x2::coin::TreasuryCap<T3>, arg6: &mut 0x2::coin_registry::Currency<T3>, arg7: 0x2::coin_registry::MetadataCap<T3>, arg8: 0x2::coin::TreasuryCap<T4>, arg9: &mut 0x2::coin_registry::Currency<T4>, arg10: 0x2::coin_registry::MetadataCap<T4>, arg11: 0x2::coin::TreasuryCap<T5>, arg12: &mut 0x2::coin_registry::Currency<T5>, arg13: 0x2::coin_registry::MetadataCap<T5>, arg14: 0x2::coin::TreasuryCap<T6>, arg15: &mut 0x2::coin_registry::Currency<T6>, arg16: 0x2::coin_registry::MetadataCap<T6>, arg17: 0x2::coin::TreasuryCap<T7>, arg18: &mut 0x2::coin_registry::Currency<T7>, arg19: 0x2::coin_registry::MetadataCap<T7>, arg20: 0x2::coin::TreasuryCap<T8>, arg21: &mut 0x2::coin_registry::Currency<T8>, arg22: 0x2::coin_registry::MetadataCap<T8>, arg23: 0x2::coin::TreasuryCap<T9>, arg24: &mut 0x2::coin_registry::Currency<T9>, arg25: 0x2::coin_registry::MetadataCap<T9>, arg26: 0x2::coin::TreasuryCap<T10>, arg27: &mut 0x2::coin_registry::Currency<T10>, arg28: 0x2::coin_registry::MetadataCap<T10>, arg29: 0x2::coin::TreasuryCap<T11>, arg30: &mut 0x2::coin_registry::Currency<T11>, arg31: 0x2::coin_registry::MetadataCap<T11>, arg32: 0x2::coin::TreasuryCap<T12>, arg33: &mut 0x2::coin_registry::Currency<T12>, arg34: 0x2::coin_registry::MetadataCap<T12>, arg35: 0x2::coin::TreasuryCap<T13>, arg36: &mut 0x2::coin_registry::Currency<T13>, arg37: 0x2::coin_registry::MetadataCap<T13>, arg38: 0x2::coin::TreasuryCap<T14>, arg39: &mut 0x2::coin_registry::Currency<T14>, arg40: 0x2::coin_registry::MetadataCap<T14>, arg41: 0x2::coin::TreasuryCap<T15>, arg42: &mut 0x2::coin_registry::Currency<T15>, arg43: 0x2::coin_registry::MetadataCap<T15>, arg44: 0x2::coin::TreasuryCap<T16>, arg45: &mut 0x2::coin_registry::Currency<T16>, arg46: 0x2::coin_registry::MetadataCap<T16>, arg47: 0x2::coin::TreasuryCap<T17>, arg48: &mut 0x2::coin_registry::Currency<T17>, arg49: 0x2::coin_registry::MetadataCap<T17>, arg50: 0x2::coin::TreasuryCap<T18>, arg51: &mut 0x2::coin_registry::Currency<T18>, arg52: 0x2::coin_registry::MetadataCap<T18>, arg53: 0x2::coin::TreasuryCap<T19>, arg54: &mut 0x2::coin_registry::Currency<T19>, arg55: 0x2::coin_registry::MetadataCap<T19>, arg56: 0x2::coin::TreasuryCap<T20>, arg57: &mut 0x2::coin_registry::Currency<T20>, arg58: 0x2::coin_registry::MetadataCap<T20>, arg59: 0x2::coin::TreasuryCap<T21>, arg60: &mut 0x2::coin_registry::Currency<T21>, arg61: 0x2::coin_registry::MetadataCap<T21>, arg62: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg63: &0x2::coin_registry::Currency<T0>, arg64: &0x2::coin_registry::Currency<T1>, arg65: u64) {
        assert!(0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account>(arg62) == arg0.dao_id, 43);
        let v0 = 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::get_market_state<T0, T1>(arg1);
        assert!(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::proposal_id(v0) == 0x2::object::id<Proposal<T0, T1>>(arg0), 37);
        assert!(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::dao_id(v0) == arg0.dao_id, 37);
        let v1 = arg0.outcome_data.outcome_count;
        if (arg65 + 0 < v1) {
            add_outcome_coins<T0, T1, T2, T3>(arg0, arg1, arg65 + 0, arg2, arg3, arg4, arg5, arg6, arg7, arg62, arg63, arg64);
        } else {
            destroy_unused_caps<T2>(arg2, arg4);
            destroy_unused_caps<T3>(arg5, arg7);
        };
        if (arg65 + 1 < v1) {
            add_outcome_coins<T0, T1, T4, T5>(arg0, arg1, arg65 + 1, arg8, arg9, arg10, arg11, arg12, arg13, arg62, arg63, arg64);
        } else {
            destroy_unused_caps<T4>(arg8, arg10);
            destroy_unused_caps<T5>(arg11, arg13);
        };
        if (arg65 + 2 < v1) {
            add_outcome_coins<T0, T1, T6, T7>(arg0, arg1, arg65 + 2, arg14, arg15, arg16, arg17, arg18, arg19, arg62, arg63, arg64);
        } else {
            destroy_unused_caps<T6>(arg14, arg16);
            destroy_unused_caps<T7>(arg17, arg19);
        };
        if (arg65 + 3 < v1) {
            add_outcome_coins<T0, T1, T8, T9>(arg0, arg1, arg65 + 3, arg20, arg21, arg22, arg23, arg24, arg25, arg62, arg63, arg64);
        } else {
            destroy_unused_caps<T8>(arg20, arg22);
            destroy_unused_caps<T9>(arg23, arg25);
        };
        if (arg65 + 4 < v1) {
            add_outcome_coins<T0, T1, T10, T11>(arg0, arg1, arg65 + 4, arg26, arg27, arg28, arg29, arg30, arg31, arg62, arg63, arg64);
        } else {
            destroy_unused_caps<T10>(arg26, arg28);
            destroy_unused_caps<T11>(arg29, arg31);
        };
        if (arg65 + 5 < v1) {
            add_outcome_coins<T0, T1, T12, T13>(arg0, arg1, arg65 + 5, arg32, arg33, arg34, arg35, arg36, arg37, arg62, arg63, arg64);
        } else {
            destroy_unused_caps<T12>(arg32, arg34);
            destroy_unused_caps<T13>(arg35, arg37);
        };
        if (arg65 + 6 < v1) {
            add_outcome_coins<T0, T1, T14, T15>(arg0, arg1, arg65 + 6, arg38, arg39, arg40, arg41, arg42, arg43, arg62, arg63, arg64);
        } else {
            destroy_unused_caps<T14>(arg38, arg40);
            destroy_unused_caps<T15>(arg41, arg43);
        };
        if (arg65 + 7 < v1) {
            add_outcome_coins<T0, T1, T16, T17>(arg0, arg1, arg65 + 7, arg44, arg45, arg46, arg47, arg48, arg49, arg62, arg63, arg64);
        } else {
            destroy_unused_caps<T16>(arg44, arg46);
            destroy_unused_caps<T17>(arg47, arg49);
        };
        if (arg65 + 8 < v1) {
            add_outcome_coins<T0, T1, T18, T19>(arg0, arg1, arg65 + 8, arg50, arg51, arg52, arg53, arg54, arg55, arg62, arg63, arg64);
        } else {
            destroy_unused_caps<T18>(arg50, arg52);
            destroy_unused_caps<T19>(arg53, arg55);
        };
        if (arg65 + 9 < v1) {
            add_outcome_coins<T0, T1, T20, T21>(arg0, arg1, arg65 + 9, arg56, arg57, arg58, arg59, arg60, arg61, arg62, arg63, arg64);
        } else {
            destroy_unused_caps<T20>(arg56, arg58);
            destroy_unused_caps<T21>(arg59, arg61);
        };
    }

    public fun advance_state<T0, T1, T2>(arg0: &mut Proposal<T0, T1>, arg1: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::proposal_mutation_auth::ProposalMutationAuth, arg2: &mut 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::TokenEscrow<T0, T1>, arg3: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::market_state_mutation_auth::MarketStateMutationRegistry, arg4: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::escrow_mutation_auth::EscrowMutationRegistry, arg5: &0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg6: 0x2::object::ID, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : bool {
        assert!(0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::proposal_mutation_auth::target_id(arg1) == 0x2::object::id<Proposal<T0, T1>>(arg0), 50);
        assert!(0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg5) == arg6, 44);
        assert_escrow_matches_proposal<T0, T1>(arg0, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = if (0x1::option::is_some<u64>(&arg0.timing.market_initialized_at)) {
            *0x1::option::borrow<u64>(&arg0.timing.market_initialized_at)
        } else {
            arg0.timing.created_at
        };
        if (arg0.state == 1) {
            if (v0 >= v1 + arg0.timing.review_period_ms) {
                arg0.state = 2;
                arg0.timing.trading_started_at = 0x1::option::some<u64>(v0);
                let v2 = MarketStateMutationWitness{dummy_field: false};
                let v3 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::market_state_mutation_auth::create<MarketStateMutationWitness>(arg3, v2);
                let v4 = EscrowMutationWitness{dummy_field: false};
                let v5 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::escrow_mutation_auth::create<EscrowMutationWitness>(arg4, v4);
                let v6 = arg0.twap_config.twap_initial_observation;
                if (0x1::option::is_none<u128>(&v6)) {
                    v6 = derive_twap_initial_observation_from_spot_pool<T0, T1, T2>(arg5);
                    if (0x1::option::is_some<u128>(&v6)) {
                        arg0.twap_config.twap_initial_observation = v6;
                    };
                };
                let v7 = 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::get_market_state_mut<T0, T1>(arg2, &v5);
                0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::set_amm_pools(v7, 0x247a26578dca33ebe83d531627f7cf670e93ba4c874b395613d1929a5a5c2731::liquidity_initialize::create_outcome_markets<T0, T1>(arg2, arg0.outcome_data.outcome_count, arg0.timing.twap_start_delay, v6, arg0.twap_config.twap_cap_ppm, arg0.amm_total_fee_bps, &v3, arg7, arg8), &v3);
                0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::start_trading(v7, arg0.timing.trading_period_ms, v0, arg7, &v3);
                let v8 = 0;
                while (v8 < 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::outcome_count(v7)) {
                    0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_amm::set_oracle_start_time(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::get_pool_mut_by_outcome(v7, v8, &v5), 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::market_id(v7), v0, &v3);
                    v8 = v8 + 1;
                };
                return true
            };
        };
        if (arg0.state == 2) {
            if (v0 >= *0x1::option::borrow<u64>(&arg0.timing.trading_started_at) + arg0.timing.trading_period_ms) {
                return true
            };
        };
        false
    }

    fun assert_escrow_matches_proposal<T0, T1>(arg0: &Proposal<T0, T1>, arg1: &0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::TokenEscrow<T0, T1>) {
        assert!(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::market_state_id<T0, T1>(arg1) == market_state_id<T0, T1>(arg0), 37);
        let v0 = 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::get_market_state<T0, T1>(arg1);
        assert!(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::proposal_id(v0) == 0x2::object::id<Proposal<T0, T1>>(arg0), 37);
        assert!(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::dao_id(v0) == arg0.dao_id, 37);
    }

    public fun begin_proposal<T0, T1>(arg0: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg1: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: address, arg8: bool, arg9: 0x2::coin::Coin<T1>, arg10: 0x2::coin::Coin<T0>, arg11: 0x1::option::Option<vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (Proposal<T0, T1>, 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::TokenEscrow<T0, T1>) {
        let v0 = 0x2::bag::new(arg13);
        let (v1, v2) = if (0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::fee_in_asset_token(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::config<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig>(arg0))) {
            assert!(0x2::coin::value<T1>(&arg9) == 0, 34);
            0x2::coin::destroy_zero<T1>(arg9);
            let v3 = 0x2::coin::value<T0>(&arg10);
            if (v3 > 0) {
                let v4 = FeeBalanceKey{dummy_field: false};
                0x2::bag::add<FeeBalanceKey, 0x2::balance::Balance<T0>>(&mut v0, v4, 0x2::coin::into_balance<T0>(arg10));
            } else {
                0x2::coin::destroy_zero<T0>(arg10);
            };
            (v3, true)
        } else {
            assert!(0x2::coin::value<T0>(&arg10) == 0, 34);
            0x2::coin::destroy_zero<T0>(arg10);
            let v5 = 0x2::coin::value<T1>(&arg9);
            if (v5 > 0) {
                let v6 = FeeBalanceKey{dummy_field: false};
                0x2::bag::add<FeeBalanceKey, 0x2::balance::Balance<T1>>(&mut v0, v6, 0x2::coin::into_balance<T1>(arg9));
            } else {
                0x2::coin::destroy_zero<T1>(arg9);
            };
            (v5, false)
        };
        let (v7, v8) = begin_proposal_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v0, v2, v1, arg11, arg12, arg13);
        if (arg8) {
            assert!(0x2::tx_context::sender(arg13) == arg7, 42);
            0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::consume_feeless_quota(arg0, arg1, arg7, arg12, arg13);
        };
        (v7, v8)
    }

    fun begin_proposal_internal<T0, T1>(arg0: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg1: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: address, arg8: bool, arg9: 0x2::bag::Bag, arg10: bool, arg11: u64, arg12: 0x1::option::Option<vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (Proposal<T0, T1>, 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::TokenEscrow<T0, T1>) {
        let v0 = 0x2::object::new(arg14);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x1::vector::length<0x1::string::String>(&arg5);
        assert!(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::deps::registry_id(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::deps(arg0)) == 0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry>(arg1), 45);
        let v3 = 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::config<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig>(arg0);
        0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::assert_not_terminated(0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::dao_state(v3));
        let v4 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::stable_type(v3);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())) == *0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::asset_type(v3), 23);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>())) == *v4, 24);
        let v5 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::review_period_ms(v3);
        let v6 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::trading_period_ms(v3);
        let v7 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::amm_twap_start_delay(v3);
        assert!(v6 > v7, 49);
        let v8 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::max_outcomes(v3);
        let v9 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::max_actions_per_outcome(v3);
        assert!(v2 >= 2, 11);
        assert!(v2 <= v8, 10);
        assert!(0x1::vector::length<0x1::string::String>(&arg6) == v2, 33);
        let v10 = if (arg8) {
            assert!(0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::proposal_quota_registry::check_feeless_quota_available(0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::quota_registry(v3), arg7, arg13), 36);
            0
        } else {
            0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::proposal_creation_fee(v3)
        };
        let v11 = if (v2 <= 2) {
            0
        } else {
            let v12 = ((v2 - 2) as u128) * (0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::proposal_fee_per_outcome(v3) as u128);
            assert!(v12 <= 18446744073709551615, 41);
            (v12 as u64)
        };
        assert!(v10 <= 18446744073709551615 - v11, 41);
        assert!(arg11 == v10 + v11, 25);
        let v13 = b"";
        let v14 = 0;
        while (v14 < v2) {
            0x1::vector::push_back<u8>(&mut v13, 0);
            v14 = v14 + 1;
        };
        let v15 = 0x1::vector::empty<0x1::ascii::String>();
        let v16 = 0;
        while (v16 < v2) {
            0x1::vector::push_back<0x1::ascii::String>(&mut v15, 0x1::ascii::string(b""));
            v16 = v16 + 1;
        };
        let v17 = 0x1::vector::empty<0x1::ascii::String>();
        let v18 = 0;
        while (v18 < v2) {
            0x1::vector::push_back<0x1::ascii::String>(&mut v17, 0x1::ascii::string(b""));
            v18 = v18 + 1;
        };
        let v19 = ProposalTiming{
            created_at            : 0x2::clock::timestamp_ms(arg13),
            market_initialized_at : 0x1::option::none<u64>(),
            trading_started_at    : 0x1::option::none<u64>(),
            review_period_ms      : v5,
            trading_period_ms     : v6,
            last_twap_update      : 0,
            twap_start_delay      : v7,
        };
        let v20 = LiquidityConfig{
            min_asset_liquidity  : 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::min_asset_amount(v3),
            min_stable_liquidity : 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::min_stable_amount(v3),
            asset_amounts        : 0x1::vector::empty<u64>(),
            stable_amounts       : 0x1::vector::empty<u64>(),
        };
        let v21 = TwapConfig{
            twap_prices              : 0x1::vector::empty<u128>(),
            twap_initial_observation : 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::amm_twap_initial_observation(v3),
            twap_cap_ppm             : 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::amm_twap_cap_ppm(v3),
            twap_threshold           : 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::twap_threshold(v3),
            sponsored_threshold      : 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::sponsored_threshold(v3),
        };
        let v22 = vector[];
        let v23 = 0;
        while (v23 < v2) {
            0x1::vector::push_back<address>(&mut v22, arg7);
            v23 = v23 + 1;
        };
        let v24 = 0x1::vector::empty<0x1::option::Option<vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>>>();
        let v25 = 0;
        while (v25 < v2) {
            0x1::vector::push_back<0x1::option::Option<vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>>>(&mut v24, 0x1::option::none<vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>>());
            v25 = v25 + 1;
        };
        let v26 = vector[];
        let v27 = 0;
        while (v27 < v2) {
            0x1::vector::push_back<u64>(&mut v26, 0);
            v27 = v27 + 1;
        };
        let v28 = OutcomeData{
            outcome_count       : v2,
            outcome_messages    : arg5,
            outcome_creators    : v22,
            intent_specs        : v24,
            actions_per_outcome : v26,
            winning_outcome     : 0x1::option::none<u64>(),
        };
        let v29 = Proposal<T0, T1>{
            id                                  : v0,
            state                               : 0,
            dao_id                              : 0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account>(arg0),
            proposer                            : arg7,
            liquidity_provider                  : 0x1::option::none<address>(),
            withdraw_only_mode                  : false,
            used_feeless_quota                  : arg8,
            outcome_sponsorship                 : v13,
            sponsor_quota_used_for_proposal     : false,
            sponsor_quota_user                  : 0x1::option::none<address>(),
            escrow_id                           : 0x1::option::none<0x2::object::ID>(),
            market_state_id                     : 0x1::option::none<0x2::object::ID>(),
            conditional_treasury_caps           : 0x2::bag::new(arg14),
            conditional_metadata_caps           : 0x2::bag::new(arg14),
            conditional_asset_types             : v15,
            conditional_stable_types            : v17,
            title                               : arg2,
            introduction_details                : arg3,
            details                             : arg6,
            metadata                            : arg4,
            timing                              : v19,
            liquidity_config                    : v20,
            twap_config                         : v21,
            outcome_data                        : v28,
            amm_total_fee_bps                   : 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::conditional_amm_fee_bps(v3),
            conditional_liquidity_ratio_percent : 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::conditional_liquidity_ratio_percent(v3),
            fee_escrow                          : arg9,
            fee_paid_in_asset                   : arg10,
            total_fee_paid                      : arg11,
            max_outcomes                        : v8,
        };
        if (0x1::option::is_some<vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>>(&arg12)) {
            let v30 = &mut v29;
            set_intent_spec_for_outcome_internal<T0, T1>(v30, 1, 0x1::option::destroy_some<vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>>(arg12), v9, arg0, arg1);
        } else {
            0x1::option::destroy_none<vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>>(arg12);
        };
        let v31 = ProposalCreated{
            proposal_id       : v1,
            dao_id            : v29.dao_id,
            proposer          : arg7,
            outcome_count     : v2,
            outcome_messages  : v29.outcome_data.outcome_messages,
            created_at        : v29.timing.created_at,
            asset_type        : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            stable_type       : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>()),
            review_period_ms  : v5,
            trading_period_ms : v6,
            title             : v29.title,
            metadata          : v29.metadata,
        };
        0x2::event::emit<ProposalCreated>(v31);
        (v29, 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::new<T0, T1>(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::new(v1, v29.dao_id, v2, v29.outcome_data.outcome_messages, arg13, arg14), arg14))
    }

    public fun borrow_uid<T0, T1>(arg0: &Proposal<T0, T1>) : &0x2::object::UID {
        &arg0.id
    }

    public fun cancel_witness_outcome_index(arg0: &CancelWitness) : u64 {
        arg0.outcome_index
    }

    public fun cancel_witness_proposal(arg0: &CancelWitness) : address {
        arg0.proposal
    }

    public fun clear_all_sponsorships<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::sponsorship_auth::SponsorshipAuth) {
        assert!(0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::sponsorship_auth::target_id(&arg1) == 0x2::object::id<Proposal<T0, T1>>(arg0), 50);
        let v0 = 0;
        let v1 = 1;
        while (v1 < 0x1::vector::length<u8>(&arg0.outcome_sponsorship)) {
            let v2 = 0x1::vector::borrow_mut<u8>(&mut arg0.outcome_sponsorship, v1);
            if (*v2 != 0) {
                v0 = v0 + 1;
            };
            *v2 = 0;
            v1 = v1 + 1;
        };
        arg0.sponsor_quota_used_for_proposal = false;
        arg0.sponsor_quota_user = 0x1::option::none<address>();
        let v3 = ProposalSponsorshipsCleared{
            proposal_id   : 0x2::object::id<Proposal<T0, T1>>(arg0),
            dao_id        : arg0.dao_id,
            cleared_count : v0,
        };
        0x2::event::emit<ProposalSponsorshipsCleared>(v3);
    }

    public fun clear_intent_spec_for_outcome<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: u64, arg2: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::proposal_mutation_auth::ProposalMutationAuth) {
        assert!(0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::proposal_mutation_auth::target_id(arg2) == 0x2::object::id<Proposal<T0, T1>>(arg0), 50);
        assert!(arg0.state == 0, 38);
        assert!(arg1 < arg0.outcome_data.outcome_count, 7);
        let v0 = 0x1::vector::borrow_mut<0x1::option::Option<vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>>>(&mut arg0.outcome_data.intent_specs, arg1);
        let v1 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_data.actions_per_outcome, arg1);
        if (0x1::option::is_some<vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>>(v0)) {
            *v0 = 0x1::option::none<vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>>();
            *v1 = 0;
        };
    }

    fun derive_twap_initial_observation_from_spot_pool<T0, T1, T2>(arg0: &0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>) : 0x1::option::Option<u128> {
        let (v0, v1) = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::get_initial_reserves<T0, T1, T2>(arg0);
        let v2 = v1;
        let v3 = v0;
        if (0x1::option::is_some<u64>(&v3) && 0x1::option::is_some<u64>(&v2)) {
            let v5 = *0x1::option::borrow<u64>(&v3);
            let v6 = *0x1::option::borrow<u64>(&v2);
            if (v5 > 0 && v6 > 0) {
                0x1::option::some<u128>(0x9770f391e82370d06c368c058fd9d6fad5ab036b29b2efd823a8de2c84317e0c::math::mul_div_to_128(v6, 0x9770f391e82370d06c368c058fd9d6fad5ab036b29b2efd823a8de2c84317e0c::constants::price_precision_scale(), v5))
            } else {
                0x1::option::none<u128>()
            }
        } else {
            0x1::option::none<u128>()
        }
    }

    fun destroy_unused_caps<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin_registry::MetadataCap<T0>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg0, @0x0);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<T0>>(arg1, @0x0);
    }

    public entry fun emergency_burn_conditional_metadata_cap<T0, T1, T2>(arg0: &mut Proposal<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::emergency_cap::EmergencyCap, arg5: &mut 0x2::tx_context::TxContext) {
        0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::emergency_cap::assert_ready(arg4, arg3);
        assert!(arg1 < arg0.outcome_data.outcome_count, 7);
        let v0 = ConditionalCoinKey{
            outcome_index : arg1,
            is_asset      : arg2,
        };
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<T2>>(0x2::bag::remove<ConditionalCoinKey, 0x2::coin_registry::MetadataCap<T2>>(&mut arg0.conditional_metadata_caps, v0), @0x0);
    }

    public entry fun emergency_take_conditional_metadata_cap_to_sender<T0, T1, T2>(arg0: &mut Proposal<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::emergency_cap::EmergencyCap, arg5: &mut 0x2::tx_context::TxContext) {
        0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::emergency_cap::assert_ready(arg4, arg3);
        assert!(arg1 < arg0.outcome_data.outcome_count, 7);
        let v0 = ConditionalCoinKey{
            outcome_index : arg1,
            is_asset      : arg2,
        };
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<T2>>(0x2::bag::remove<ConditionalCoinKey, 0x2::coin_registry::MetadataCap<T2>>(&mut arg0.conditional_metadata_caps, v0), 0x2::tx_context::sender(arg5));
    }

    public entry fun emergency_withdraw_fee_escrow<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::emergency_cap::EmergencyCap, arg3: &mut 0x2::tx_context::TxContext) {
        0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::emergency_cap::assert_ready(arg2, arg1);
        let v0 = FeeBalanceKey{dummy_field: false};
        assert!(0x2::bag::contains<FeeBalanceKey>(&arg0.fee_escrow, v0), 39);
        if (arg0.fee_paid_in_asset) {
            let v1 = FeeBalanceKey{dummy_field: false};
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::bag::remove<FeeBalanceKey, 0x2::balance::Balance<T0>>(&mut arg0.fee_escrow, v1), arg3), 0x2::tx_context::sender(arg3));
        } else {
            let v2 = FeeBalanceKey{dummy_field: false};
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::bag::remove<FeeBalanceKey, 0x2::balance::Balance<T1>>(&mut arg0.fee_escrow, v2), arg3), 0x2::tx_context::sender(arg3));
        };
    }

    public fun escrow_id<T0, T1>(arg0: &Proposal<T0, T1>) : 0x2::object::ID {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.escrow_id), 2);
        *0x1::option::borrow<0x2::object::ID>(&arg0.escrow_id)
    }

    public fun execution_window_ms() : u64 {
        0x9770f391e82370d06c368c058fd9d6fad5ab036b29b2efd823a8de2c84317e0c::constants::execution_window_ms()
    }

    public fun fee_paid_in_asset<T0, T1>(arg0: &Proposal<T0, T1>) : bool {
        arg0.fee_paid_in_asset
    }

    public fun finalize_proposal<T0, T1, T2>(arg0: Proposal<T0, T1>, arg1: 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::TokenEscrow<T0, T1>, arg2: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg3: &mut 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg4: &0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 2);
        assert!(0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account>(arg2) == arg0.dao_id, 43);
        let v0 = 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::get_market_state<T0, T1>(&arg1);
        assert!(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::proposal_id(v0) == 0x2::object::id<Proposal<T0, T1>>(&arg0), 37);
        assert!(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::dao_id(v0) == arg0.dao_id, 37);
        let v1 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::get_spot_pool_id(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::config<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig>(arg2));
        assert!(0x1::option::is_some<0x2::object::ID>(&v1) && *0x1::option::borrow<0x2::object::ID>(&v1) == 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg3), 44);
        let v2 = arg0.outcome_data.outcome_count;
        assert!(0x2::bag::length(&arg0.conditional_metadata_caps) == v2 * 2, 32);
        assert!(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::caps_registered_count<T0, T1>(&arg1) == v2, 32);
        let (v3, v4) = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::get_reserves<T0, T1, T2>(arg3);
        assert!(v3 >= arg0.liquidity_config.min_asset_liquidity, 4);
        assert!(v4 >= arg0.liquidity_config.min_stable_liquidity, 5);
        let v5 = 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::market_id(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::get_market_state<T0, T1>(&arg1));
        let v6 = 0x2::object::id<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::TokenEscrow<T0, T1>>(&arg1);
        0x1::option::fill<0x2::object::ID>(&mut arg0.market_state_id, v5);
        0x1::option::fill<0x2::object::ID>(&mut arg0.escrow_id, v6);
        0x1::option::fill<u64>(&mut arg0.timing.market_initialized_at, 0x2::clock::timestamp_ms(arg5));
        0x1::option::fill<address>(&mut arg0.liquidity_provider, arg0.proposer);
        arg0.state = 1;
        let v7 = SpotPoolMutationWitness{dummy_field: false};
        0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::store_active_escrow<T0, T1, T2>(arg3, arg1, 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg4, v7, 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg3)));
        let v8 = ProposalMarketInitialized{
            proposal_id              : 0x2::object::id<Proposal<T0, T1>>(&arg0),
            dao_id                   : arg0.dao_id,
            market_state_id          : v5,
            escrow_id                : v6,
            timestamp                : 0x2::clock::timestamp_ms(arg5),
            conditional_asset_types  : arg0.conditional_asset_types,
            conditional_stable_types : arg0.conditional_stable_types,
        };
        0x2::event::emit<ProposalMarketInitialized>(v8);
        0x2::transfer::public_share_object<Proposal<T0, T1>>(arg0);
    }

    public fun get_actions_for_outcome<T0, T1>(arg0: &Proposal<T0, T1>, arg1: u64) : u64 {
        assert!(arg1 < arg0.outcome_data.outcome_count, 7);
        *0x1::vector::borrow<u64>(&arg0.outcome_data.actions_per_outcome, arg1)
    }

    public fun get_amm_pool_ids<T0, T1>(arg0: &Proposal<T0, T1>, arg1: &0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::TokenEscrow<T0, T1>) : vector<0x2::object::ID> {
        assert_escrow_matches_proposal<T0, T1>(arg0, arg1);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        let v2 = 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::borrow_amm_pools(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::get_market_state<T0, T1>(arg1));
        while (v1 < 0x1::vector::length<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_amm::LiquidityPool>(v2)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_amm::get_id(0x1::vector::borrow<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_amm::LiquidityPool>(v2, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_amm_pools<T0, T1>(arg0: &Proposal<T0, T1>, arg1: &0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::TokenEscrow<T0, T1>) : &vector<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_amm::LiquidityPool> {
        assert_escrow_matches_proposal<T0, T1>(arg0, arg1);
        0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::borrow_amm_pools(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::get_market_state<T0, T1>(arg1))
    }

    public fun get_amm_total_fee_bps<T0, T1>(arg0: &Proposal<T0, T1>) : u64 {
        arg0.amm_total_fee_bps
    }

    public fun get_created_at<T0, T1>(arg0: &Proposal<T0, T1>) : u64 {
        arg0.timing.created_at
    }

    public fun get_dao_id<T0, T1>(arg0: &Proposal<T0, T1>) : 0x2::object::ID {
        arg0.dao_id
    }

    public fun get_intent_spec_for_outcome<T0, T1>(arg0: &Proposal<T0, T1>, arg1: u64) : &0x1::option::Option<vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>> {
        0x1::vector::borrow<0x1::option::Option<vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>>>(&arg0.outcome_data.intent_specs, arg1)
    }

    public fun get_introduction_details<T0, T1>(arg0: &Proposal<T0, T1>) : &0x1::string::String {
        &arg0.introduction_details
    }

    public fun get_last_twap_update<T0, T1>(arg0: &Proposal<T0, T1>) : u64 {
        arg0.timing.last_twap_update
    }

    public fun get_liquidity_provider<T0, T1>(arg0: &Proposal<T0, T1>) : 0x1::option::Option<address> {
        arg0.liquidity_provider
    }

    public fun get_market_initialized_at<T0, T1>(arg0: &Proposal<T0, T1>) : u64 {
        assert!(0x1::option::is_some<u64>(&arg0.timing.market_initialized_at), 2);
        *0x1::option::borrow<u64>(&arg0.timing.market_initialized_at)
    }

    public fun get_metadata<T0, T1>(arg0: &Proposal<T0, T1>) : &0x1::string::String {
        &arg0.metadata
    }

    public fun get_num_outcomes<T0, T1>(arg0: &Proposal<T0, T1>) : u64 {
        arg0.outcome_data.outcome_count
    }

    public fun get_oracle_state_by_outcome<T0, T1>(arg0: &Proposal<T0, T1>, arg1: &0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::TokenEscrow<T0, T1>, arg2: u8) : (u128, u64, u256, u256, u64, u128, 0x1::option::Option<u64>, u128, u64, u64, u64, u64) {
        assert_escrow_matches_proposal<T0, T1>(arg0, arg1);
        assert!((arg2 as u64) < arg0.outcome_data.outcome_count, 7);
        let v0 = 0x1::vector::borrow<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_amm::LiquidityPool>(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::borrow_amm_pools(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::get_market_state<T0, T1>(arg1)), (arg2 as u64));
        let (v1, v2, v3, v4, v5, v6, v7, v8, v9, v10) = 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_amm::get_oracle_full_state(v0);
        let (v11, v12) = 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_amm::get_reserves(v0);
        (v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12)
    }

    public fun get_outcome_creator<T0, T1>(arg0: &Proposal<T0, T1>, arg1: u64) : address {
        assert!(arg1 < arg0.outcome_data.outcome_count, 7);
        *0x1::vector::borrow<address>(&arg0.outcome_data.outcome_creators, arg1)
    }

    public fun get_outcome_creators<T0, T1>(arg0: &Proposal<T0, T1>) : &vector<address> {
        &arg0.outcome_data.outcome_creators
    }

    public fun get_outcome_messages<T0, T1>(arg0: &Proposal<T0, T1>) : &vector<0x1::string::String> {
        &arg0.outcome_data.outcome_messages
    }

    public fun get_outcome_sponsorship_type<T0, T1>(arg0: &Proposal<T0, T1>, arg1: u64) : u8 {
        assert!(arg1 < arg0.outcome_data.outcome_count, 7);
        *0x1::vector::borrow<u8>(&arg0.outcome_sponsorship, arg1)
    }

    public fun get_outcome_sponsorship_types<T0, T1>(arg0: &Proposal<T0, T1>) : vector<u8> {
        arg0.outcome_sponsorship
    }

    public fun get_pool_by_outcome<T0, T1>(arg0: &Proposal<T0, T1>, arg1: &0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::TokenEscrow<T0, T1>, arg2: u8) : &0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_amm::LiquidityPool {
        assert_escrow_matches_proposal<T0, T1>(arg0, arg1);
        assert!((arg2 as u64) < arg0.outcome_data.outcome_count, 7);
        let v0 = 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::borrow_amm_pools(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::get_market_state<T0, T1>(arg1));
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_amm::LiquidityPool>(v0)) {
            let v2 = 0x1::vector::borrow<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_amm::LiquidityPool>(v0, v1);
            if (0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_amm::get_outcome_idx(v2) == arg2) {
                return v2
            };
            v1 = v1 + 1;
        };
        abort 6
    }

    public fun get_proposer<T0, T1>(arg0: &Proposal<T0, T1>) : address {
        arg0.proposer
    }

    public fun get_review_period_ms<T0, T1>(arg0: &Proposal<T0, T1>) : u64 {
        arg0.timing.review_period_ms
    }

    public fun get_sponsor_quota_user<T0, T1>(arg0: &Proposal<T0, T1>) : 0x1::option::Option<address> {
        arg0.sponsor_quota_user
    }

    public fun get_sponsored_threshold<T0, T1>(arg0: &Proposal<T0, T1>) : u128 {
        arg0.twap_config.sponsored_threshold
    }

    public fun get_state<T0, T1>(arg0: &Proposal<T0, T1>) : u8 {
        arg0.state
    }

    public fun get_total_fee_paid<T0, T1>(arg0: &Proposal<T0, T1>) : u64 {
        arg0.total_fee_paid
    }

    public fun get_trading_period_ms<T0, T1>(arg0: &Proposal<T0, T1>) : u64 {
        arg0.timing.trading_period_ms
    }

    public fun get_trading_started_at<T0, T1>(arg0: &Proposal<T0, T1>) : u64 {
        assert!(0x1::option::is_some<u64>(&arg0.timing.trading_started_at), 2);
        *0x1::option::borrow<u64>(&arg0.timing.trading_started_at)
    }

    public fun get_twap_by_outcome<T0, T1>(arg0: &Proposal<T0, T1>, arg1: u64) : u128 {
        assert!(arg0.state == 4, 12);
        let v0 = &arg0.twap_config.twap_prices;
        assert!(!0x1::vector::is_empty<u128>(v0), 13);
        assert!(arg1 < 0x1::vector::length<u128>(v0), 7);
        *0x1::vector::borrow<u128>(v0, arg1)
    }

    public fun get_twap_cap_ppm<T0, T1>(arg0: &Proposal<T0, T1>) : u64 {
        arg0.twap_config.twap_cap_ppm
    }

    public fun get_twap_initial_observation<T0, T1>(arg0: &Proposal<T0, T1>) : 0x1::option::Option<u128> {
        arg0.twap_config.twap_initial_observation
    }

    public fun get_twap_prices<T0, T1>(arg0: &Proposal<T0, T1>) : &vector<u128> {
        &arg0.twap_config.twap_prices
    }

    public fun get_twap_start_delay<T0, T1>(arg0: &Proposal<T0, T1>) : u64 {
        arg0.timing.twap_start_delay
    }

    public fun get_twap_threshold<T0, T1>(arg0: &Proposal<T0, T1>) : u128 {
        arg0.twap_config.twap_threshold
    }

    public fun get_twaps_for_proposal<T0, T1, T2>(arg0: &mut Proposal<T0, T1>, arg1: &mut 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg2: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::escrow_mutation_auth::EscrowMutationRegistry, arg3: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::market_state_mutation_auth::MarketStateMutationRegistry, arg4: &0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg5: &0x2::clock::Clock) : vector<u128> {
        assert!(is_live<T0, T1>(arg0), 2);
        let v0 = SpotPoolMutationWitness{dummy_field: false};
        let v1 = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg4, v0, 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg1));
        let v2 = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::borrow_active_escrow_mut<T0, T1, T2>(arg1, &v1);
        assert_escrow_matches_proposal<T0, T1>(arg0, v2);
        let v3 = EscrowMutationWitness{dummy_field: false};
        let v4 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::escrow_mutation_auth::create<EscrowMutationWitness>(arg2, v3);
        let v5 = MarketStateMutationWitness{dummy_field: false};
        let v6 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::market_state_mutation_auth::create<MarketStateMutationWitness>(arg3, v5);
        let v7 = 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::get_market_state_mut<T0, T1>(v2, &v4);
        let v8 = 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::get_trading_end_time(v7);
        assert!(0x1::option::is_some<u64>(&v8), 38);
        assert!(0x2::clock::timestamp_ms(arg5) <= *0x1::option::borrow<u64>(&v8), 53);
        let v9 = vector[];
        let v10 = 0;
        while (v10 < 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::outcome_count(v7)) {
            0x1::vector::push_back<u128>(&mut v9, 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_amm::get_twap(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::get_pool_mut_by_outcome(v7, v10, &v4), arg5, &v6));
            v10 = v10 + 1;
        };
        v9
    }

    public fun get_twaps_for_proposal_at<T0, T1, T2>(arg0: &mut Proposal<T0, T1>, arg1: &mut 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg2: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::escrow_mutation_auth::EscrowMutationRegistry, arg3: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::market_state_mutation_auth::MarketStateMutationRegistry, arg4: &0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg5: u64, arg6: &0x2::clock::Clock) : vector<u128> {
        assert!(is_live<T0, T1>(arg0), 2);
        let v0 = SpotPoolMutationWitness{dummy_field: false};
        let v1 = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg4, v0, 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg1));
        let v2 = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::borrow_active_escrow_mut<T0, T1, T2>(arg1, &v1);
        assert_escrow_matches_proposal<T0, T1>(arg0, v2);
        let v3 = EscrowMutationWitness{dummy_field: false};
        let v4 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::escrow_mutation_auth::create<EscrowMutationWitness>(arg2, v3);
        let v5 = MarketStateMutationWitness{dummy_field: false};
        let v6 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::market_state_mutation_auth::create<MarketStateMutationWitness>(arg3, v5);
        let v7 = 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::get_market_state_mut<T0, T1>(v2, &v4);
        let v8 = 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::get_trading_end_time(v7);
        assert!(0x1::option::is_some<u64>(&v8), 38);
        assert!(arg5 == *0x1::option::borrow<u64>(&v8), 54);
        let v9 = vector[];
        let v10 = 0;
        while (v10 < 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::outcome_count(v7)) {
            0x1::vector::push_back<u128>(&mut v9, 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_amm::get_twap_at(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::get_pool_mut_by_outcome(v7, v10, &v4), arg5, arg6, &v6));
            v10 = v10 + 1;
        };
        v9
    }

    public fun get_used_feeless_quota<T0, T1>(arg0: &Proposal<T0, T1>) : bool {
        arg0.used_feeless_quota
    }

    public fun get_winning_outcome<T0, T1>(arg0: &Proposal<T0, T1>) : u64 {
        assert!(0x1::option::is_some<u64>(&arg0.outcome_data.winning_outcome), 2);
        *0x1::option::borrow<u64>(&arg0.outcome_data.winning_outcome)
    }

    public fun get_winning_twap<T0, T1>(arg0: &Proposal<T0, T1>) : u128 {
        assert!(arg0.state == 4, 12);
        assert!(0x1::option::is_some<u64>(&arg0.outcome_data.winning_outcome), 2);
        assert!(!0x1::vector::is_empty<u128>(&arg0.twap_config.twap_prices), 13);
        get_twap_by_outcome<T0, T1>(arg0, *0x1::option::borrow<u64>(&arg0.outcome_data.winning_outcome))
    }

    public fun has_fee_escrow<T0, T1>(arg0: &Proposal<T0, T1>) : bool {
        let v0 = FeeBalanceKey{dummy_field: false};
        0x2::bag::contains<FeeBalanceKey>(&arg0.fee_escrow, v0)
    }

    public fun has_intent_spec<T0, T1>(arg0: &Proposal<T0, T1>, arg1: u64) : bool {
        assert!(arg1 < arg0.outcome_data.outcome_count, 7);
        0x1::option::is_some<vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>>(0x1::vector::borrow<0x1::option::Option<vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>>>(&arg0.outcome_data.intent_specs, arg1))
    }

    public fun id_address<T0, T1>(arg0: &Proposal<T0, T1>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun is_awaiting_execution<T0, T1>(arg0: &Proposal<T0, T1>) : bool {
        arg0.state == 3
    }

    public fun is_finalized<T0, T1>(arg0: &Proposal<T0, T1>) : bool {
        arg0.state == 4
    }

    public fun is_live<T0, T1>(arg0: &Proposal<T0, T1>) : bool {
        arg0.state == 2 || arg0.state == 3
    }

    public fun is_outcome_sponsored<T0, T1>(arg0: &Proposal<T0, T1>, arg1: u64) : bool {
        assert!(arg1 < arg0.outcome_data.outcome_count, 7);
        *0x1::vector::borrow<u8>(&arg0.outcome_sponsorship, arg1) != 0
    }

    public fun is_sponsor_quota_used<T0, T1>(arg0: &Proposal<T0, T1>) : bool {
        arg0.sponsor_quota_used_for_proposal
    }

    public fun is_sponsored<T0, T1>(arg0: &Proposal<T0, T1>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg0.outcome_sponsorship)) {
            if (*0x1::vector::borrow<u8>(&arg0.outcome_sponsorship, v0) != 0) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_trading_period_ended<T0, T1>(arg0: &Proposal<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        if (0x1::option::is_none<u64>(&arg0.timing.trading_started_at)) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) >= *0x1::option::borrow<u64>(&arg0.timing.trading_started_at) + arg0.timing.trading_period_ms
    }

    public fun is_winning_outcome_set<T0, T1>(arg0: &Proposal<T0, T1>) : bool {
        0x1::option::is_some<u64>(&arg0.outcome_data.winning_outcome)
    }

    public fun is_withdraw_only<T0, T1>(arg0: &Proposal<T0, T1>) : bool {
        arg0.withdraw_only_mode
    }

    public fun make_cancel_witness<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: u64, arg2: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::proposal_mutation_auth::ProposalMutationAuth) : 0x1::option::Option<CancelWitness> {
        assert!(0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::proposal_mutation_auth::target_id(arg2) == 0x2::object::id<Proposal<T0, T1>>(arg0), 50);
        assert!(arg1 < arg0.outcome_data.outcome_count, 7);
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        let v1 = take_intent_spec_for_outcome<T0, T1>(arg0, arg1, arg2);
        if (0x1::option::is_some<vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>>(&v1)) {
            0x1::option::destroy_some<vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>>(v1);
            let v3 = CancelWitness{
                proposal      : v0,
                outcome_index : arg1,
            };
            0x1::option::some<CancelWitness>(v3)
        } else {
            0x1::option::none<CancelWitness>()
        }
    }

    public fun mark_sponsor_quota_used<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: address, arg2: 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::sponsorship_auth::SponsorshipAuth) {
        assert!(0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::sponsorship_auth::target_id(&arg2) == 0x2::object::id<Proposal<T0, T1>>(arg0), 50);
        arg0.sponsor_quota_used_for_proposal = true;
        arg0.sponsor_quota_user = 0x1::option::some<address>(arg1);
        let v0 = ProposalSponsorQuotaMarked{
            proposal_id : 0x2::object::id<Proposal<T0, T1>>(arg0),
            dao_id      : arg0.dao_id,
            sponsor     : arg1,
        };
        0x2::event::emit<ProposalSponsorQuotaMarked>(v0);
    }

    public fun new_action_builder<T0, T1>(arg0: &Proposal<T0, T1>, arg1: u64) : 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::Builder {
        0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::new(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::source_proposal(), 0x2::object::id<Proposal<T0, T1>>(arg0), arg1)
    }

    public fun set_intent_spec_for_outcome<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: u64, arg2: vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>, arg3: u64, arg4: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg5: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg6: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::proposal_mutation_auth::ProposalMutationAuth) {
        assert!(0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::proposal_mutation_auth::target_id(arg6) == 0x2::object::id<Proposal<T0, T1>>(arg0), 50);
        let v0 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::max_actions_per_outcome(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::config<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig>(arg4));
        let v1 = if (arg3 < v0) {
            arg3
        } else {
            v0
        };
        set_intent_spec_for_outcome_internal<T0, T1>(arg0, arg1, arg2, v1, arg4, arg5);
    }

    fun set_intent_spec_for_outcome_internal<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: u64, arg2: vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>, arg3: u64, arg4: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg5: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry) {
        assert!(arg0.state == 0, 38);
        assert!(arg1 < arg0.outcome_data.outcome_count, 7);
        assert!(0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account>(arg4) == arg0.dao_id, 43);
        assert!(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::deps::registry_id(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::deps(arg4)) == 0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry>(arg5), 45);
        assert!(arg1 > 0, 22);
        let v0 = 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::deps(arg4);
        let v1 = 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::account_deps(arg4);
        let v2 = 0x1::vector::length<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>(&arg2);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = 0;
        while (v4 < v2) {
            let v5 = 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_spec_type(0x1::vector::borrow<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>(&arg2, v4));
            assert!(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::deps::is_package_authorized(v0, arg5, v1, 0x2::address::from_bytes(0x2::hex::decode(0x1::ascii::into_bytes(0x1::type_name::address_string(&v5)))), 0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account>(arg4)), 27);
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::from_ascii(0x1::type_name::into_string(v5)));
            v4 = v4 + 1;
        };
        let v6 = 0x1::vector::borrow_mut<0x1::option::Option<vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>>>(&mut arg0.outcome_data.intent_specs, arg1);
        let v7 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_data.actions_per_outcome, arg1);
        assert!(v2 <= arg3, 14);
        *v6 = 0x1::option::some<vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>>(arg2);
        *v7 = v2;
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::emit_intent_actions(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::source_proposal(), 0x2::object::id<Proposal<T0, T1>>(arg0), arg1, v3);
    }

    public fun set_last_twap_update<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: u64, arg2: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::proposal_mutation_auth::ProposalMutationAuth) {
        assert!(0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::proposal_mutation_auth::target_id(arg2) == 0x2::object::id<Proposal<T0, T1>>(arg0), 50);
        arg0.timing.last_twap_update = arg1;
    }

    public fun set_outcome_sponsorship<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: u64, arg2: 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::sponsorship_auth::SponsorshipAuth) {
        assert!(0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::sponsorship_auth::target_id(&arg2) == 0x2::object::id<Proposal<T0, T1>>(arg0), 50);
        let v0 = if (arg0.state == 0) {
            true
        } else if (arg0.state == 1) {
            true
        } else {
            arg0.state == 2
        };
        assert!(v0, 2);
        assert!(arg1 > 0, 26);
        assert!(arg1 < arg0.outcome_data.outcome_count, 7);
        let v1 = false;
        let v2 = 0x1::vector::borrow_mut<u8>(&mut arg0.outcome_sponsorship, arg1);
        if (*v2 == 0) {
            *v2 = 1;
            v1 = true;
        };
        let v3 = ProposalSponsorshipUpdated{
            proposal_id      : 0x2::object::id<Proposal<T0, T1>>(arg0),
            dao_id           : arg0.dao_id,
            outcome_index    : arg1,
            sponsorship_type : *0x1::vector::borrow<u8>(&arg0.outcome_sponsorship, arg1),
            applied          : v1,
        };
        0x2::event::emit<ProposalSponsorshipUpdated>(v3);
    }

    public fun set_outcome_sponsorships<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: vector<u8>, arg2: 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::sponsorship_auth::SponsorshipAuth) {
        assert!(0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::sponsorship_auth::target_id(&arg2) == 0x2::object::id<Proposal<T0, T1>>(arg0), 50);
        let v0 = if (arg0.state == 0) {
            true
        } else if (arg0.state == 1) {
            true
        } else {
            arg0.state == 2
        };
        assert!(v0, 2);
        assert!(0x1::vector::length<u8>(&arg1) == arg0.outcome_data.outcome_count, 7);
        assert!(*0x1::vector::borrow<u8>(&arg1, 0) == 0, 26);
        let v1 = 0;
        let v2 = 1;
        while (v2 < 0x1::vector::length<u8>(&arg1)) {
            let v3 = *0x1::vector::borrow<u8>(&arg1, v2);
            let v4 = 0x1::vector::borrow_mut<u8>(&mut arg0.outcome_sponsorship, v2);
            if (v3 != 0 && *v4 == 0) {
                assert!(v3 <= 2, 18);
                *v4 = v3;
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        let v5 = ProposalSponsorshipsUpdated{
            proposal_id       : 0x2::object::id<Proposal<T0, T1>>(arg0),
            dao_id            : arg0.dao_id,
            applied_count     : v1,
            sponsorship_types : arg0.outcome_sponsorship,
        };
        0x2::event::emit<ProposalSponsorshipsUpdated>(v5);
    }

    public fun set_state<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: u8, arg2: 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::proposal_mutation_auth::ProposalMutationAuth) {
        assert!(0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::proposal_mutation_auth::target_id(&arg2) == 0x2::object::id<Proposal<T0, T1>>(arg0), 50);
        assert!(arg1 <= 4, 51);
        assert!(arg1 == arg0.state + 1 || arg0.state == 2 && arg1 == 4, 51);
        arg0.state = arg1;
    }

    public fun set_twap_prices<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: vector<u128>, arg2: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::proposal_mutation_auth::ProposalMutationAuth) {
        assert!(0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::proposal_mutation_auth::target_id(arg2) == 0x2::object::id<Proposal<T0, T1>>(arg0), 50);
        assert!(0x1::vector::length<u128>(&arg1) == arg0.outcome_data.outcome_count, 33);
        arg0.twap_config.twap_prices = arg1;
    }

    public fun set_winning_outcome<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: u64, arg2: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::proposal_mutation_auth::ProposalMutationAuth) {
        assert!(0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::proposal_mutation_auth::target_id(arg2) == 0x2::object::id<Proposal<T0, T1>>(arg0), 50);
        assert!(arg1 < arg0.outcome_data.outcome_count, 7);
        arg0.outcome_data.winning_outcome = 0x1::option::some<u64>(arg1);
    }

    public entry fun set_withdraw_only_mode<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.state == 1, 38);
        assert!(0x1::option::is_some<address>(&arg0.liquidity_provider), 17);
        assert!(0x2::tx_context::sender(arg2) == *0x1::option::borrow<address>(&arg0.liquidity_provider), 17);
        arg0.withdraw_only_mode = arg1;
    }

    public fun sponsorship_negative_discount() : u8 {
        2
    }

    public fun sponsorship_none() : u8 {
        0
    }

    public fun sponsorship_zero_threshold() : u8 {
        1
    }

    public fun state<T0, T1>(arg0: &Proposal<T0, T1>) : u8 {
        arg0.state
    }

    public fun state_awaiting_execution() : u8 {
        3
    }

    public fun state_finalized() : u8 {
        4
    }

    public fun state_premarket() : u8 {
        0
    }

    public fun state_review() : u8 {
        1
    }

    public fun state_trading() : u8 {
        2
    }

    public fun take_fee_escrow_asset<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::proposal_mutation_auth::ProposalMutationAuth) : 0x2::balance::Balance<T0> {
        assert!(0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::proposal_mutation_auth::target_id(arg1) == 0x2::object::id<Proposal<T0, T1>>(arg0), 50);
        assert!(arg0.fee_paid_in_asset, 34);
        let v0 = FeeBalanceKey{dummy_field: false};
        assert!(0x2::bag::contains<FeeBalanceKey>(&arg0.fee_escrow, v0), 39);
        let v1 = FeeBalanceKey{dummy_field: false};
        0x2::bag::remove<FeeBalanceKey, 0x2::balance::Balance<T0>>(&mut arg0.fee_escrow, v1)
    }

    public fun take_fee_escrow_stable<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::proposal_mutation_auth::ProposalMutationAuth) : 0x2::balance::Balance<T1> {
        assert!(0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::proposal_mutation_auth::target_id(arg1) == 0x2::object::id<Proposal<T0, T1>>(arg0), 50);
        assert!(!arg0.fee_paid_in_asset, 34);
        let v0 = FeeBalanceKey{dummy_field: false};
        assert!(0x2::bag::contains<FeeBalanceKey>(&arg0.fee_escrow, v0), 39);
        let v1 = FeeBalanceKey{dummy_field: false};
        0x2::bag::remove<FeeBalanceKey, 0x2::balance::Balance<T1>>(&mut arg0.fee_escrow, v1)
    }

    public fun take_intent_spec_for_outcome<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: u64, arg2: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::proposal_mutation_auth::ProposalMutationAuth) : 0x1::option::Option<vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>> {
        assert!(0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::proposal_mutation_auth::target_id(arg2) == 0x2::object::id<Proposal<T0, T1>>(arg0), 50);
        let v0 = if (arg0.state == 2) {
            true
        } else if (arg0.state == 3) {
            true
        } else {
            arg0.state == 4
        };
        assert!(v0, 38);
        assert!(arg1 < arg0.outcome_data.outcome_count, 7);
        let v1 = 0x1::vector::borrow_mut<0x1::option::Option<vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>>>(&mut arg0.outcome_data.intent_specs, arg1);
        *v1 = 0x1::option::none<vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>>();
        *0x1::vector::borrow_mut<u64>(&mut arg0.outcome_data.actions_per_outcome, arg1) = 0;
        *v1
    }

    public fun used_feeless_quota<T0, T1>(arg0: &Proposal<T0, T1>) : bool {
        arg0.used_feeless_quota
    }

    fun validate_and_update_conditional_metadata<T0, T1, T2>(arg0: u64, arg1: bool, arg2: &0x2::coin::TreasuryCap<T2>, arg3: &mut 0x2::coin_registry::Currency<T2>, arg4: &0x2::coin_registry::MetadataCap<T2>, arg5: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::dao_config::DaoConfig, arg6: &0x2::coin_registry::Currency<T0>, arg7: &0x2::coin_registry::Currency<T1>) {
        assert!(0x2::coin::total_supply<T2>(arg2) == 0, 19);
        assert!(!0x2::coin_registry::is_regulated<T2>(arg3), 52);
        assert!(0x2::coin_registry::symbol<T2>(arg3) == 0x1::string::utf8(b"Govex Conditional"), 35);
        let v0 = 0x2::coin_registry::name<T2>(arg3);
        assert!(0x1::string::is_empty(&v0), 28);
        let v1 = 0x2::coin_registry::description<T2>(arg3);
        assert!(0x1::string::is_empty(&v1), 31);
        let v2 = 0x2::coin_registry::icon_url<T2>(arg3);
        assert!(0x1::string::is_empty(&v2), 30);
        let (v3, v4, v5) = if (arg1) {
            let v6 = 0x1::ascii::try_string(0x1::string::into_bytes(0x2::coin_registry::symbol<T0>(arg6)));
            let v7 = if (0x1::option::is_some<0x1::ascii::String>(&v6)) {
                0x1::option::destroy_some<0x1::ascii::String>(v6)
            } else {
                0x1::option::destroy_none<0x1::ascii::String>(v6);
                0x1::ascii::string(b"TOKEN")
            };
            (0x2::coin_registry::name<T0>(arg6), v7, 0x2::coin_registry::icon_url<T0>(arg6))
        } else {
            let v8 = 0x1::ascii::try_string(0x1::string::into_bytes(0x2::coin_registry::symbol<T1>(arg7)));
            let v9 = if (0x1::option::is_some<0x1::ascii::String>(&v8)) {
                0x1::option::destroy_some<0x1::ascii::String>(v8)
            } else {
                0x1::option::destroy_none<0x1::ascii::String>(v8);
                0x1::ascii::string(b"TOKEN")
            };
            (0x2::coin_registry::name<T1>(arg7), v9, 0x2::coin_registry::icon_url<T1>(arg7))
        };
        let v10 = v5;
        let v11 = v4;
        let v12 = v3;
        0x247a26578dca33ebe83d531627f7cf670e93ba4c874b395613d1929a5a5c2731::conditional_coin_utils::update_conditional_metadata<T2>(arg3, arg4, 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::dao_config::conditional_coin_config(arg5), arg0, 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::dao_config::dao_name(0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::dao_config::metadata_config(arg5)), &v12, &v11, &v10);
    }

    // decompiled from Move bytecode v6
}

