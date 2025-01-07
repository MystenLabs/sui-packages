module 0x413a75a7420645cc7ec77f5627d2c601c4a545bd374106c45665a840b761d114::hive_dao {
    struct VestingVoteCap has store, key {
        id: 0x2::object::UID,
    }

    struct HiveDaoGovernor has key {
        id: 0x2::object::UID,
        dao_cap: 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::HiveDaoCapability,
        governor_profile: 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveProfile,
        managed_buzzes: 0x2::linked_table::LinkedTable<0x1::ascii::String, SystemBuzz>,
        vesting_power: u128,
        next_proposal_id: u64,
        proposal_list: 0x2::linked_table::LinkedTable<u64, Proposal>,
        supported_apps: 0x2::linked_table::LinkedTable<0x1::ascii::String, HiveApp>,
        vote_config: VoteConfig,
        module_version: u64,
    }

    struct SystemBuzz has store {
        buzz: 0x1::string::String,
    }

    struct VoteConfig has store {
        proposal_required_deposit: u64,
        voting_start_delay: u64,
        voting_period_length: u64,
        execution_delay: u64,
        execution_period_length: u64,
        proposal_required_quorum: u64,
        proposal_approval_threshold: u64,
    }

    struct HiveGovernorBuzzes has store, key {
        id: 0x2::object::UID,
        governor_buzzes: 0x2::linked_table::LinkedTable<u64, GovernorBuzz>,
        count: u64,
    }

    struct GovernorBuzz has store {
        buzz: 0x1::string::String,
        likes: 0x2::linked_table::LinkedTable<address, bool>,
        profile_buzzes: 0x2::linked_table::LinkedTable<address, Dialogues>,
    }

    struct Dialogues has store {
        dialogues: 0x2::linked_table::LinkedTable<u64, Dialogue>,
    }

    struct Dialogue has store {
        buzz: 0x1::string::String,
        upvotes: 0x2::linked_table::LinkedTable<address, bool>,
    }

    struct HiveApp has store {
        name: 0x1::ascii::String,
        url: 0x1::string::String,
        description: 0x1::string::String,
        total_hive_gems_ported: u64,
    }

    struct Proposal has store {
        proposal_id: u64,
        proposer: address,
        deposit: 0x2::balance::Balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>,
        title: 0x1::string::String,
        description: 0x1::string::String,
        link: 0x1::string::String,
        proposal_type: u64,
        voting_start_epoch: u64,
        voting_end_epoch: u64,
        execution_start_epoch: u64,
        execution_end_epoch: u64,
        proposal_status: u64,
        yes_votes: u64,
        no_votes: u64,
        votes: 0x2::table::Table<address, Vote>,
        add_app_to_hive_store: 0x1::option::Option<KraftCapForNewHiveApp>,
        config_add_coins_transition: 0x1::option::Option<AddPrecisionForCoinsTransition>,
        config_stable_identifier_transition: 0x1::option::Option<AddStableIdentifierTransition>,
        amm_default_fee_transition: 0x1::option::Option<DefaultAmmFeeTransition>,
        treasury_transition: 0x1::option::Option<AccessTreasuryOrBeesUpdate>,
        dsui_vault_config_transition: 0x1::option::Option<DSuiVaultConfigTransition>,
        amm_transition_params: 0x1::option::Option<AmmTransition>,
        pol_transition_params: 0x1::option::Option<PolParamTransition>,
        pools_governor_transition: 0x1::option::Option<PoolsGovernorTransition>,
        profile_config_transition: 0x1::option::Option<ProfileConfigTransition>,
        hive_transition: 0x1::option::Option<HiveTransition>,
    }

    struct Vote has drop, store {
        power: u64,
        vote: bool,
    }

    struct KraftCapForNewHiveApp has drop, store {
        name: 0x1::ascii::String,
        url: 0x1::string::String,
        description: 0x1::string::String,
        only_owner_can_add_app: bool,
        only_owner_can_access_app: bool,
        only_owner_can_remove_app: bool,
        recepient: address,
    }

    struct AddPrecisionForCoinsTransition has drop, store {
        coin_identifiers: vector<0x1::string::String>,
        decimals: vector<u8>,
    }

    struct AddStableIdentifierTransition has drop, store {
        identifier_type_name: 0x1::type_name::TypeName,
        to_add: bool,
    }

    struct DefaultAmmFeeTransition has drop, store {
        curve_type: 0x1::type_name::TypeName,
        total_fee_bps: u64,
        hive_fee_percent: u64,
    }

    struct AccessTreasuryOrBeesUpdate has drop, store {
        new_treasury_percent: u64,
        to_distribute_dsui: u64,
        to_distribute_bees: u64,
        new_bees_per_epoch: u64,
        recepient: address,
    }

    struct AmmTransition has drop, store {
        new_fee: u64,
        for_2_amm: bool,
        for_3_amm: bool,
        to_update_oracle: bool,
        new_sui_hive_pool_addr: 0x1::option::Option<address>,
        new_usdc_sui_pool_addr: 0x1::option::Option<address>,
        new_window_size: u64,
        new_tolerance: u64,
    }

    struct PolParamTransition has drop, store {
        third_pool_addr: 0x1::option::Option<address>,
        sui_for_hive_pool_pct: u64,
        sui_for_bee_pool_pct: u64,
    }

    struct PoolsGovernorTransition has drop, store {
        new_params: vector<u64>,
        bees_to_deposit: u64,
        pool_hive_addrs: vector<address>,
        hive_points_for_pool_hives: vector<u64>,
        bee_points_for_pool_hives: vector<u64>,
        to_update_per_epoch_points: bool,
        new_hive_per_epoch: u64,
        new_bee_per_epoch: u64,
    }

    struct ProfileConfigTransition has drop, store {
        new_max_bids: u64,
        new_min_bid: u64,
        new_profile_kraft_fee: u64,
        social_fee_gems: u64,
        social_multiplier_for_gems: u64,
        social_multiplier_for_power: u64,
        royalty_num: u64,
        royalty_denom: u64,
        assets_dispersal_percent: u64,
        creators_royalty_percent: u64,
        gems_royalty_num: u64,
        gems_royalty_denom: u64,
        gems_treasury_percent: u64,
        gems_burn_percent: u64,
    }

    struct HiveTransition has drop, store {
        to_update_config: bool,
        new_live_status: bool,
        new_buzzes_count: u64,
        tax_on_bid: u64,
        winning_bid_points: u64,
        hive_per_ad_slot: u64,
        bees_per_ad_slot: u64,
        first_rank_assets_limit: u64,
        second_rank_assets_limit: u64,
        third_rank_assets_limit: u64,
        max_streams_to_store: u64,
        hive_to_spend: u64,
        recepient_addr: address,
    }

    struct DSuiVaultConfigTransition has drop, store {
        validators_list: vector<address>,
        to_add: bool,
        protocol_fee_percent: u64,
        service_fee_percent: u64,
        treasury_percent: u64,
        execute_emergency_operation: bool,
        pause_stake: bool,
    }

    struct TotalHiveDaoPowerUpdated has copy, drop {
        power_to_add: u64,
        power_to_subtract: u64,
        vesting_power: u128,
    }

    struct NewProposalKrafted has copy, drop {
        proposal_id: u64,
        proposer: address,
        title: 0x1::string::String,
        description: 0x1::string::String,
        link: 0x1::string::String,
        voting_start_epoch: u64,
        voting_end_epoch: u64,
        execution_start_epoch: u64,
        execution_end_epoch: u64,
        proposal_type: u64,
    }

    struct VoteCasted has copy, drop {
        proposal_id: u64,
        voter_profile: address,
        vote: bool,
        yes_votes: u64,
        no_votes: u64,
        total_possible_votes: u128,
    }

    struct ProposalEvaluated has copy, drop {
        proposal_id: u64,
        proposal_status: u64,
        yes_votes: u64,
        no_votes: u64,
        total_possible_votes: u128,
        votes_quorum: u64,
        yes_votes_threshold: u64,
    }

    struct AddPrecisionForCoinsProposalKrafted has copy, drop {
        proposal_id: u64,
        coin_identifiers: vector<0x1::string::String>,
        decimals: vector<u8>,
    }

    struct NewHiveAppAddedToDegenHive has copy, drop {
        proposal_id: u64,
        recepient: address,
        app_name: 0x1::ascii::String,
        url: 0x1::string::String,
        description: 0x1::string::String,
        only_owner_can_add_app: bool,
        only_owner_can_access_app: bool,
        only_owner_can_remove_app: bool,
    }

    struct HiveTransitionProposalKrafted has copy, drop {
        proposal_id: u64,
        to_update_config: bool,
        new_live_status: bool,
        new_buzzes_count: u64,
        tax_on_bid: u64,
        winning_bid_points: u64,
        hive_per_ad_slot: u64,
        bees_per_ad_slot: u64,
        first_rank_assets_limit: u64,
        second_rank_assets_limit: u64,
        third_rank_assets_limit: u64,
        max_streams_to_store: u64,
        hive_to_spend: u64,
        recepient_addr: address,
    }

    struct IdentifierTransitionProposalKrafted has copy, drop {
        proposal_id: u64,
        identifier_type_name: 0x1::type_name::TypeName,
        to_add: bool,
    }

    struct DefaultAmmFeeTransitionProposalKrafted has copy, drop {
        proposal_id: u64,
        curve_type: 0x1::type_name::TypeName,
        total_fee_bps: u64,
        hive_fee_percent: u64,
    }

    struct TreasuryTransitionProposalKrafted has copy, drop {
        proposal_id: u64,
        new_treasury_percent: u64,
        to_distribute_dsui: u64,
        to_distribute_bees: u64,
        new_bees_per_epoch: u64,
        recepient: address,
    }

    struct AmmTransitionProposalKrafted has copy, drop {
        proposal_id: u64,
        new_fee: u64,
        for_2_amm: bool,
        for_3_amm: bool,
        to_update_oracle: bool,
        new_sui_hive_pool_addr: 0x1::option::Option<address>,
        new_usdc_sui_pool_addr: 0x1::option::Option<address>,
        new_window_size: u64,
        new_tolerance: u64,
    }

    struct PolParamTransitionProposalKrafted has copy, drop {
        proposal_id: u64,
        third_pool_addr: 0x1::option::Option<address>,
        sui_for_hive_pool_pct: u64,
        sui_for_bee_pool_pct: u64,
    }

    struct PoolsGovernorTransitionProposalKrafted has copy, drop {
        proposal_id: u64,
        new_params: vector<u64>,
        bees_to_deposit: u64,
        pool_hive_addrs: vector<address>,
        hive_points_for_pool_hives: vector<u64>,
        bee_points_for_pool_hives: vector<u64>,
        to_update_per_epoch_points: bool,
        new_hive_per_epoch: u64,
        new_bee_per_epoch: u64,
    }

    struct ProfileConfigTransitionProposalKrafted has copy, drop {
        proposal_id: u64,
        new_max_bids: u64,
        new_min_bid: u64,
        new_profile_kraft_fee: u64,
        social_fee_gems: u64,
        social_multiplier_for_gems: u64,
        social_multiplier_for_power: u64,
        royalty_num: u64,
        royalty_denom: u64,
        assets_dispersal_percent: u64,
        creators_royalty_percent: u64,
        gems_royalty_num: u64,
        gems_royalty_denom: u64,
        gems_treasury_percent: u64,
        gems_burn_percent: u64,
    }

    struct DSuiVaultTransitionProposalKrafted has copy, drop {
        validators_list: vector<address>,
        to_add: bool,
        protocol_fee_percent: u64,
        service_fee_percent: u64,
        treasury_percent: u64,
        execute_emergency_operation: bool,
        pause_stake: bool,
    }

    struct ProposalExecuted has copy, drop {
        proposal_id: u64,
        proposal_type: u64,
        yes_votes: u64,
        no_votes: u64,
    }

    struct ProposalDeleted has copy, drop {
        proposal_id: u64,
        proposal_type: u64,
        proposal_status: u64,
    }

    struct UserLikedHiveDaoBuzz has copy, drop {
        user_profile_addr: address,
        username: 0x1::string::String,
        buzz_index: u64,
    }

    struct UserBuzzOnHiveDaoBuzzDetected has copy, drop {
        user_profile_addr: address,
        username: 0x1::string::String,
        governance_buzz_index: u64,
        dialogue_index: u64,
        user_buzz: 0x1::string::String,
    }

    struct UserBuzzOnHiveDaoBuzzDeleted has copy, drop {
        user_profile_addr: address,
        username: 0x1::string::String,
        governance_buzz_index: u64,
        dialogue_index: u64,
    }

    struct NewHiveGovernanceBuzz has copy, drop {
        buzz_index: u64,
        buzz: 0x1::string::String,
    }

    struct UserUpvotedHiveGovernanceBuzz has copy, drop {
        user_profile_addr: address,
        username: 0x1::string::String,
        governance_buzz_index: u64,
        user_buzz_by_profile: address,
        dialogue_index: u64,
    }

    public fun add_app_support_to_asset(arg0: &mut HiveDaoGovernor, arg1: &0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveAppAccessCapability, arg2: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveProfile, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 9017);
        let v0 = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::get_hive_app_name(arg1);
        assert!(0x2::linked_table::contains<0x1::ascii::String, HiveApp>(&arg0.supported_apps, v0), 9003);
        0x2::linked_table::borrow_mut<0x1::ascii::String, HiveApp>(&mut arg0.supported_apps, v0);
        0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::add_app_support_to_asset(&arg0.dao_cap, arg1, arg2, arg3, arg4);
    }

    public fun castVote(arg0: &0x2::clock::Clock, arg1: &mut HiveDaoGovernor, arg2: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveManager, arg3: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg4: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveDisperser, arg5: u64, arg6: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveProfile, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::harvest_governance_rewards_and_transfer(arg0, arg2, arg3, arg4, arg6, arg8);
        let (v0, _) = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::get_voting_power_for_profile(arg0, arg6);
        internal_cast_vote(arg1, arg5, arg6, v0, arg7, 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::get_active_power(arg2), arg8);
    }

    public fun cast_vote_with_vested_hive(arg0: &VestingVoteCap, arg1: &0x2::clock::Clock, arg2: &mut HiveDaoGovernor, arg3: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveManager, arg4: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg5: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveDisperser, arg6: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveProfile, arg7: u64, arg8: u64, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.module_version == 0, 9017);
        0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::harvest_governance_rewards_and_transfer(arg1, arg3, arg4, arg5, arg6, arg10);
        let (v0, _) = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::get_voting_power_for_profile(arg1, arg6);
        internal_cast_vote(arg2, arg8, arg6, v0 + arg7, arg9, 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::get_active_power(arg3), arg10);
    }

    public entry fun claim_collected_degensui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut HiveDaoGovernor, arg2: &mut 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::DSuiVault, arg3: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Treasury<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg4: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 9017);
        0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::deposit_dsui_for_hive<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(arg4, 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::stake_sui_request(arg0, arg2, 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::claim_collected_lsd_fee(&arg1.dao_cap, arg0, arg2, arg3, arg5), 0x1::option::none<address>(), arg5));
    }

    public entry fun del_comment_from_governance_buzz(arg0: &mut HiveDaoGovernor, arg1: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveProfile, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 9017);
        let (v0, v1, v2, v3) = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::get_profile_meta_info(arg1);
        assert!(v2 || v3 == 0x2::tx_context::sender(arg4), 9020);
        let v4 = 0x2::linked_table::borrow_mut<u64, GovernorBuzz>(&mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes"))).governor_buzzes, arg2);
        assert!(0x2::linked_table::contains<address, Dialogues>(&v4.profile_buzzes, v0), 9030);
        let v5 = 0x2::linked_table::borrow_mut<address, Dialogues>(&mut v4.profile_buzzes, v0);
        assert!(0x2::linked_table::contains<u64, Dialogue>(&v5.dialogues, arg3), 9030);
        let Dialogue {
            buzz    : _,
            upvotes : v7,
        } = 0x2::linked_table::remove<u64, Dialogue>(&mut v5.dialogues, arg3);
        0x2::linked_table::drop<address, bool>(v7);
        let v8 = UserBuzzOnHiveDaoBuzzDeleted{
            user_profile_addr     : v0,
            username              : v1,
            governance_buzz_index : arg2,
            dialogue_index        : arg3,
        };
        0x2::event::emit<UserBuzzOnHiveDaoBuzzDeleted>(v8);
    }

    fun destroy_proposal(arg0: Proposal) : (u64, 0x2::balance::Balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>, u64, u64) {
        let Proposal {
            proposal_id                         : v0,
            proposer                            : _,
            deposit                             : v2,
            title                               : _,
            description                         : _,
            link                                : _,
            proposal_type                       : v6,
            voting_start_epoch                  : _,
            voting_end_epoch                    : _,
            execution_start_epoch               : _,
            execution_end_epoch                 : _,
            proposal_status                     : v11,
            yes_votes                           : _,
            no_votes                            : _,
            votes                               : v14,
            add_app_to_hive_store               : _,
            config_add_coins_transition         : _,
            config_stable_identifier_transition : _,
            amm_default_fee_transition          : _,
            treasury_transition                 : _,
            dsui_vault_config_transition        : _,
            amm_transition_params               : _,
            pol_transition_params               : _,
            pools_governor_transition           : _,
            profile_config_transition           : _,
            hive_transition                     : _,
        } = arg0;
        0x2::table::drop<address, Vote>(v14);
        (v0, v2, v6, v11)
    }

    public entry fun evaluateProposal(arg0: &mut HiveDaoGovernor, arg1: &mut 0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HiveVault, arg2: &0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveManager, arg3: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveDisperser, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg4), 9005);
        let v0 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg4);
        assert!(0x2::tx_context::epoch(arg5) > v0.voting_end_epoch && v0.proposal_status <= 1, 9007);
        let v1 = arg0.vesting_power + 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::get_active_power(arg2);
        let v2 = v0.yes_votes + v0.no_votes;
        let v3 = if (v1 == 0) {
            0
        } else {
            (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::voting_precision() as u256), (v2 as u256), (v1 as u256)) as u64)
        };
        let v4 = 0;
        let v5 = if (arg0.vote_config.proposal_required_quorum > v3) {
            v0.proposal_status = 5;
            0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::deposit_gems_for_hive(arg3, 0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::burn_hive_and_return_gems(arg1, 0x2::balance::withdraw_all<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&mut v0.deposit), v0.proposer, arg5));
            0x1::string::to_ascii(0x1::string::utf8(b"PROPOSAL_STATUS_CANCELLED"))
        } else {
            let v6 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u128((0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::voting_precision() as u128), (v0.yes_votes as u128), (v2 as u128));
            v4 = v6;
            let v5 = if (v6 >= arg0.vote_config.proposal_approval_threshold) {
                v0.proposal_status = 3;
                0x1::string::to_ascii(0x1::string::utf8(b"PROPOSAL_STATUS_PASSED"))
            } else {
                v0.proposal_status = 4;
                0x1::string::to_ascii(0x1::string::utf8(b"PROPOSAL_STATUS_REJECTED"))
            };
            0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(0x2::balance::withdraw_all<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&mut v0.deposit), v0.proposer, arg5);
            v5
        };
        let v7 = 0x1::string::utf8(b"");
        if (0x2::linked_table::contains<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v5)) {
            0x1::string::append(&mut v7, 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v5).buzz);
        };
        0x1::string::append(&mut v7, 0x1::string::utf8(b"Proposal ID: "));
        0x1::string::append(&mut v7, 0x1::string::utf8(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::u64_to_ascii(v0.proposal_id)));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a5469746c653a20"));
        0x1::string::append(&mut v7, v0.title);
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a566f74696e672073746174697374696373203a3a200a"));
        0x1::string::append(&mut v7, 0x1::string::utf8(b"Total votes casted: "));
        0x1::string::append(&mut v7, 0x1::string::utf8(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::u64_to_ascii(v2)));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a252070617274696369706174696f6e3a20"));
        0x1::string::append(&mut v7, 0x1::string::utf8(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::u64_to_ascii(v3 * 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::percent_precision() / 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::voting_precision())));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a59657320766f7465733a20"));
        0x1::string::append(&mut v7, 0x1::string::utf8(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::u64_to_ascii(v0.yes_votes)));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a4e6f20766f7465733a20"));
        0x1::string::append(&mut v7, 0x1::string::utf8(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::u64_to_ascii(v0.no_votes)));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a59657320766f746573207468726573686f6c643a20"));
        0x1::string::append(&mut v7, 0x1::string::utf8(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::u64_to_ascii(v4 * 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::percent_precision() / 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::voting_precision())));
        let v8 = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")));
        make_new_governor_buzz(v8, v7, arg5);
        let v9 = ProposalEvaluated{
            proposal_id          : v0.proposal_id,
            proposal_status      : v0.proposal_status,
            yes_votes            : v0.yes_votes,
            no_votes             : v0.no_votes,
            total_possible_votes : v1,
            votes_quorum         : v3,
            yes_votes_threshold  : v4,
        };
        0x2::event::emit<ProposalEvaluated>(v9);
    }

    public entry fun executeProposal_add_app_to_hive_store(arg0: &mut HiveDaoGovernor, arg1: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveProfileMappingStore, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg3);
        assert!(arg0.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg2), 9005);
        let v1 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg2);
        assert!(v1.proposal_type == 9 && v1.proposal_status == 3 && v0 >= v1.execution_start_epoch && v0 <= v1.execution_end_epoch, 9009);
        v1.proposal_status = 7;
        let v2 = 0x1::option::extract<KraftCapForNewHiveApp>(&mut v1.add_app_to_hive_store);
        0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::add_app_to_hive_store(&mut arg0.dao_cap, arg1, v2.name, v2.only_owner_can_add_app, v2.only_owner_can_access_app, v2.only_owner_can_remove_app, v2.recepient, arg3);
        let v3 = HiveApp{
            name                   : v2.name,
            url                    : v2.url,
            description            : v2.description,
            total_hive_gems_ported : 0,
        };
        0x2::linked_table::push_back<0x1::ascii::String, HiveApp>(&mut arg0.supported_apps, v2.name, v3);
        let v4 = ProposalExecuted{
            proposal_id   : v1.proposal_id,
            proposal_type : v1.proposal_type,
            yes_votes     : v1.yes_votes,
            no_votes      : v1.no_votes,
        };
        0x2::event::emit<ProposalExecuted>(v4);
    }

    public entry fun executeProposal_amm_transition(arg0: &mut HiveDaoGovernor, arg1: u64, arg2: &mut 0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::oracle::HiveOracle, arg3: &mut 0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::two_pool::PoolRegistry, arg4: &mut 0x199b86d922382421c4c7d45c98690b56e99b8d8e0cc28544b099c97d707cf2da::three_pool::PoolRegistry, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg5);
        assert!(arg0.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg1), 9005);
        let v1 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg1);
        assert!(v1.proposal_type == 4 && v1.proposal_status == 3 && v0 >= v1.execution_start_epoch && v0 <= v1.execution_end_epoch, 9009);
        v1.proposal_status = 7;
        let v2 = 0x1::option::extract<AmmTransition>(&mut v1.amm_transition_params);
        if (v2.for_2_amm) {
            0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::two_pool::update_kraft_fee(arg3, &arg0.dao_cap, v2.new_fee);
        };
        if (v2.to_update_oracle) {
            0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::oracle::update_hive_oracle(&arg0.dao_cap, arg2, v2.new_sui_hive_pool_addr, v2.new_usdc_sui_pool_addr, v2.new_window_size, v2.new_tolerance, arg5);
        };
        if (v2.for_3_amm) {
            0x199b86d922382421c4c7d45c98690b56e99b8d8e0cc28544b099c97d707cf2da::three_pool::update_kraft_fee(arg4, &arg0.dao_cap, v2.new_fee);
        };
        let v3 = ProposalExecuted{
            proposal_id   : v1.proposal_id,
            proposal_type : v1.proposal_type,
            yes_votes     : v1.yes_votes,
            no_votes      : v1.no_votes,
        };
        0x2::event::emit<ProposalExecuted>(v3);
    }

    public entry fun executeProposal_dSuiVault_transition(arg0: &mut HiveDaoGovernor, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::DSuiVault, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg4);
        assert!(arg0.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg3), 9005);
        let v1 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg3);
        assert!(v1.proposal_type == 8 && v1.proposal_status == 3 && v0 >= v1.execution_start_epoch && v0 <= v1.execution_end_epoch, 9009);
        v1.proposal_status = 7;
        let v2 = 0x1::option::extract<DSuiVaultConfigTransition>(&mut v1.dsui_vault_config_transition);
        if (0x1::vector::length<address>(&v2.validators_list) > 0) {
            0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::update_validator_list(&arg0.dao_cap, arg1, arg2, v2.validators_list, v2.to_add);
        };
        if (v2.protocol_fee_percent > 0 || v2.service_fee_percent > 0) {
            0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::update_dsui_fee_config(&arg0.dao_cap, arg2, v2.protocol_fee_percent, v2.service_fee_percent, v2.treasury_percent);
        };
        if (v2.execute_emergency_operation) {
            0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::emergency_pause_update(&arg0.dao_cap, arg2, v2.pause_stake);
        };
        let v3 = ProposalExecuted{
            proposal_id   : v1.proposal_id,
            proposal_type : v1.proposal_type,
            yes_votes     : v1.yes_votes,
            no_votes      : v1.no_votes,
        };
        0x2::event::emit<ProposalExecuted>(v3);
    }

    public entry fun executeProposal_hive_transition<T0>(arg0: &0x2::clock::Clock, arg1: &mut HiveDaoGovernor, arg2: &mut 0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HiveVault, arg3: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveManager, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg5);
        assert!(arg1.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg1.proposal_list, arg4), 9005);
        let v1 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg1.proposal_list, arg4);
        assert!(v1.proposal_type == 10 && v1.proposal_status == 3 && v0 >= v1.execution_start_epoch && v0 <= v1.execution_end_epoch, 9009);
        v1.proposal_status = 7;
        let HiveTransition {
            to_update_config         : v2,
            new_live_status          : v3,
            new_buzzes_count         : v4,
            tax_on_bid               : v5,
            winning_bid_points       : v6,
            hive_per_ad_slot         : v7,
            bees_per_ad_slot         : v8,
            first_rank_assets_limit  : v9,
            second_rank_assets_limit : v10,
            third_rank_assets_limit  : v11,
            max_streams_to_store     : v12,
            hive_to_spend            : v13,
            recepient_addr           : v14,
        } = 0x1::option::extract<HiveTransition>(&mut v1.hive_transition);
        if (v2) {
            0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::update_streamer_buzzes<T0>(arg0, &arg1.dao_cap, arg2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, arg5);
        };
        if (v13 > 0) {
            0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::transfer_hive_treasury_funds(&arg1.dao_cap, arg2, arg3, v13, v14, arg5);
        };
        let v15 = ProposalExecuted{
            proposal_id   : v1.proposal_id,
            proposal_type : v1.proposal_type,
            yes_votes     : v1.yes_votes,
            no_votes      : v1.no_votes,
        };
        0x2::event::emit<ProposalExecuted>(v15);
    }

    public entry fun executeProposal_pol_param_transition<T0, T1>(arg0: &mut HiveDaoGovernor, arg1: u64, arg2: &mut 0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::two_pool::PoolRegistry, arg3: &mut 0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::two_pool::LiquidityPool<0x2::sui::SUI, T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg4);
        assert!(arg0.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg1), 9005);
        let v1 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg1);
        assert!(v1.proposal_type == 5 && v1.proposal_status == 3 && v0 >= v1.execution_start_epoch && v0 <= v1.execution_end_epoch, 9009);
        v1.proposal_status = 7;
        let v2 = 0x1::option::extract<PolParamTransition>(&mut v1.pol_transition_params);
        if (0x1::option::is_some<address>(&v2.third_pool_addr)) {
            assert!(0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::two_pool::get_pool_id_as_address<0x2::sui::SUI, T0, T1>(arg2) == *0x1::option::borrow<address>(&v2.third_pool_addr), 9031);
            0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::two_pool::update_third_pool_for_pol<T0, T1>(arg2, &arg0.dao_cap, arg3);
        };
        if (v2.sui_for_hive_pool_pct > 0 || v2.sui_for_bee_pool_pct > 0) {
            0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::two_pool::update_sui_pol_distribution(arg2, &arg0.dao_cap, v2.sui_for_hive_pool_pct, v2.sui_for_bee_pool_pct);
        };
        let v3 = ProposalExecuted{
            proposal_id   : v1.proposal_id,
            proposal_type : v1.proposal_type,
            yes_votes     : v1.yes_votes,
            no_votes      : v1.no_votes,
        };
        0x2::event::emit<ProposalExecuted>(v3);
    }

    public entry fun executeProposal_pools_governor_transition(arg0: &mut HiveDaoGovernor, arg1: &mut 0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::PoolsGovernor, arg2: &mut 0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::bee_trade::BeesManager<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::bee::BEE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg4);
        assert!(arg0.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg3), 9005);
        let v1 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg3);
        assert!(v1.proposal_type == 6 && v1.proposal_status == 3 && v0 >= v1.execution_start_epoch && v0 <= v1.execution_end_epoch, 9009);
        v1.proposal_status = 7;
        let v2 = 0x1::option::extract<PoolsGovernorTransition>(&mut v1.pools_governor_transition);
        if (0x1::vector::length<u64>(&v2.new_params) > 8) {
            0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::update_pools_governance_params(arg1, &arg0.dao_cap, v2.new_params);
        };
        if (v2.bees_to_deposit > 0) {
            0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::deposit_bee_to_dex_dao(&arg0.dao_cap, arg1, arg2, v2.bees_to_deposit, arg4);
        };
        if (v2.to_update_per_epoch_points) {
            0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::update_lp_rewards_per_epoch(arg1, &arg0.dao_cap, v2.new_bee_per_epoch, v2.new_hive_per_epoch, arg4);
        };
        if (0x1::vector::length<u64>(&v2.hive_points_for_pool_hives) > 0) {
            0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::update_pool_hive_points(arg1, &arg0.dao_cap, v2.pool_hive_addrs, v2.hive_points_for_pool_hives);
        };
        if (0x1::vector::length<u64>(&v2.bee_points_for_pool_hives) > 0) {
            0xd3387a2ae2624555e3b592ebe602a44e6f13bd2532c3cf0ea0444a04487d5574::dex_dao::update_pool_bee_points(arg1, &arg0.dao_cap, v2.pool_hive_addrs, v2.bee_points_for_pool_hives);
        };
        let v3 = ProposalExecuted{
            proposal_id   : v1.proposal_id,
            proposal_type : v1.proposal_type,
            yes_votes     : v1.yes_votes,
            no_votes      : v1.no_votes,
        };
        0x2::event::emit<ProposalExecuted>(v3);
    }

    public entry fun executeProposal_update_degenhive_config<T0, T1>(arg0: &mut HiveDaoGovernor, arg1: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Config, arg2: &mut 0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::bee_trade::BeesManager<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::bee::BEE>, arg3: &mut 0x2::token::TokenPolicy<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::bee::BEE>, arg4: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::Treasury<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg6);
        assert!(arg0.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg5), 9005);
        let v1 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg5);
        assert!(v1.proposal_status == 3 && v0 >= v1.execution_start_epoch && v0 <= v1.execution_end_epoch, 9009);
        v1.proposal_status = 7;
        if (v1.proposal_type == 0) {
            let v2 = 0x1::option::extract<AddPrecisionForCoinsTransition>(&mut v1.config_add_coins_transition);
            0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::whitelist_decimal_precisions(arg1, &arg0.dao_cap, v2.coin_identifiers, v2.decimals);
        };
        if (v1.proposal_type == 1) {
            let v3 = 0x1::option::extract<AddStableIdentifierTransition>(&mut v1.config_stable_identifier_transition);
            if (v3.to_add) {
                0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::add_stable_identifier(arg1, &arg0.dao_cap, 0x1::type_name::into_string(v3.identifier_type_name));
            } else {
                0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::remove_stable_identifier(arg1, &arg0.dao_cap, 0x1::type_name::into_string(v3.identifier_type_name));
            };
        };
        if (v1.proposal_type == 2) {
            let v4 = 0x1::option::extract<DefaultAmmFeeTransition>(&mut v1.amm_default_fee_transition);
            assert!(v4.curve_type == 0x1::type_name::get<T1>(), 9010);
            0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::update_default_fee_for_curve<T1>(arg1, &arg0.dao_cap, v4.total_fee_bps, v4.hive_fee_percent);
        };
        if (v1.proposal_type == 3) {
            let v5 = 0x1::option::extract<AccessTreasuryOrBeesUpdate>(&mut v1.treasury_transition);
            if (v5.new_treasury_percent > 0) {
                0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::update_treasury_percent(arg1, &arg0.dao_cap, v5.new_treasury_percent);
            };
            if (v5.to_distribute_dsui > 0) {
                0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::distribute_treasury_resources<T0>(&arg0.dao_cap, arg4, v5.to_distribute_dsui, v5.recepient, arg6);
            };
            if (v5.to_distribute_bees > 0) {
                0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::bee_trade::transfer_bees_from_treasury(&arg0.dao_cap, arg2, arg3, v5.to_distribute_bees, v5.recepient, arg6);
            };
            if (v5.new_bees_per_epoch > 0) {
                0x6ddce619b9240f6a9f824f35cbe1ddb16a293f372811ce1cabf8f2bae1c2dd02::bee_trade::update_bee_for_engagement_per_epoch(&arg0.dao_cap, arg2, v5.new_bees_per_epoch, arg6);
            };
        };
        let v6 = ProposalExecuted{
            proposal_id   : v1.proposal_id,
            proposal_type : v1.proposal_type,
            yes_votes     : v1.yes_votes,
            no_votes      : v1.no_votes,
        };
        0x2::event::emit<ProposalExecuted>(v6);
    }

    public entry fun executeProposal_update_profile_config_transition(arg0: &mut HiveDaoGovernor, arg1: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg3);
        assert!(arg0.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg2), 9005);
        let v1 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg2);
        assert!(v1.proposal_type == 7 && v1.proposal_status == 3 && v0 >= v1.execution_start_epoch && v0 <= v1.execution_end_epoch, 9009);
        v1.proposal_status = 7;
        let v2 = 0x1::option::extract<ProfileConfigTransition>(&mut v1.profile_config_transition);
        if (v2.new_max_bids > 0 || v2.new_min_bid > 0 || v2.new_profile_kraft_fee > 0) {
            0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::update_hive_manager_params(&arg0.dao_cap, arg1, v2.new_max_bids, v2.new_min_bid, v2.new_profile_kraft_fee, v2.social_fee_gems, v2.social_multiplier_for_gems, v2.social_multiplier_for_power);
        };
        if (v2.royalty_num > 0 || v2.royalty_denom > 0 || v2.assets_dispersal_percent > 0 || v2.creators_royalty_percent > 0) {
            0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::update_royalty(&arg0.dao_cap, arg1, v2.royalty_num, v2.royalty_denom, v2.assets_dispersal_percent, v2.creators_royalty_percent, v2.gems_royalty_num, v2.gems_royalty_denom, v2.gems_treasury_percent, v2.gems_burn_percent);
        };
        let v3 = ProposalExecuted{
            proposal_id   : v1.proposal_id,
            proposal_type : v1.proposal_type,
            yes_votes     : v1.yes_votes,
            no_votes      : v1.no_votes,
        };
        0x2::event::emit<ProposalExecuted>(v3);
    }

    public fun get_user_vote(arg0: &HiveDaoGovernor, arg1: u64, arg2: address) : (u64, bool) {
        if (!0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg1)) {
            (0, false)
        } else {
            let v2 = 0x2::linked_table::borrow<u64, Proposal>(&arg0.proposal_list, arg1);
            if (0x2::table::contains<address, Vote>(&v2.votes, arg2)) {
                let v3 = 0x2::table::borrow<address, Vote>(&v2.votes, arg2);
                (v3.power, v3.vote)
            } else {
                (0, false)
            }
        }
    }

    public entry fun increment_hive_governor(arg0: &mut HiveDaoGovernor) {
        assert!(arg0.module_version < 0, 9018);
        arg0.module_version = 0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun init_hive_dao(arg0: &0x2::clock::Clock, arg1: 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::HiveDaoCapability, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::DSuiVault, arg4: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveProfileMappingStore, arg5: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveManager, arg6: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"HIVE DAO ::init_hive_dao() FUNCTION -::- ");
        0x1::debug::print<0x1::string::String>(&v0);
        let (v1, v2) = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::kraft_owned_hive_profile(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg15);
        let v3 = v1;
        let v4 = HiveGovernorBuzzes{
            id              : 0x2::object::new(arg15),
            governor_buzzes : 0x2::linked_table::new<u64, GovernorBuzz>(arg15),
            count           : 0,
        };
        0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::add_to_composable_profile<HiveGovernorBuzzes>(&mut v3, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")), v4);
        let v5 = VoteConfig{
            proposal_required_deposit   : arg10,
            voting_start_delay          : arg11,
            voting_period_length        : arg12,
            execution_delay             : arg13,
            execution_period_length     : arg14,
            proposal_required_quorum    : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::required_quorum(),
            proposal_approval_threshold : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::vote_threshold(),
        };
        let v6 = HiveDaoGovernor{
            id               : 0x2::object::new(arg15),
            dao_cap          : arg1,
            governor_profile : v3,
            managed_buzzes   : 0x2::linked_table::new<0x1::ascii::String, SystemBuzz>(arg15),
            vesting_power    : 0,
            next_proposal_id : 1,
            proposal_list    : 0x2::linked_table::new<u64, Proposal>(arg15),
            supported_apps   : 0x2::linked_table::new<0x1::ascii::String, HiveApp>(arg15),
            vote_config      : v5,
            module_version   : 0,
        };
        let v7 = VestingVoteCap{id: 0x2::object::new(arg15)};
        0x2::transfer::transfer<VestingVoteCap>(v7, 0x2::tx_context::sender(arg15));
        0x2::transfer::share_object<HiveDaoGovernor>(v6);
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v2, 0x2::tx_context::sender(arg15), arg15);
    }

    fun init_proposal(arg0: u64, arg1: u64, arg2: address, arg3: 0x2::balance::Balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &VoteConfig, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : Proposal {
        let v0 = Proposal{
            proposal_id                         : arg1,
            proposer                            : arg2,
            deposit                             : arg3,
            title                               : arg4,
            description                         : arg5,
            link                                : arg6,
            proposal_type                       : 0,
            voting_start_epoch                  : arg0 + arg7.voting_start_delay,
            voting_end_epoch                    : arg0 + arg7.voting_start_delay + arg7.voting_period_length,
            execution_start_epoch               : arg0 + arg7.voting_start_delay + arg7.voting_period_length + arg7.execution_delay,
            execution_end_epoch                 : arg0 + arg7.voting_start_delay + arg7.voting_period_length + arg7.execution_delay + arg7.execution_period_length,
            proposal_status                     : 0,
            yes_votes                           : 0,
            no_votes                            : 0,
            votes                               : 0x2::table::new<address, Vote>(arg9),
            add_app_to_hive_store               : 0x1::option::none<KraftCapForNewHiveApp>(),
            config_add_coins_transition         : 0x1::option::none<AddPrecisionForCoinsTransition>(),
            config_stable_identifier_transition : 0x1::option::none<AddStableIdentifierTransition>(),
            amm_default_fee_transition          : 0x1::option::none<DefaultAmmFeeTransition>(),
            treasury_transition                 : 0x1::option::none<AccessTreasuryOrBeesUpdate>(),
            dsui_vault_config_transition        : 0x1::option::none<DSuiVaultConfigTransition>(),
            amm_transition_params               : 0x1::option::none<AmmTransition>(),
            pol_transition_params               : 0x1::option::none<PolParamTransition>(),
            pools_governor_transition           : 0x1::option::none<PoolsGovernorTransition>(),
            profile_config_transition           : 0x1::option::none<ProfileConfigTransition>(),
            hive_transition                     : 0x1::option::none<HiveTransition>(),
        };
        let v1 = NewProposalKrafted{
            proposal_id           : v0.proposal_id,
            proposer              : v0.proposer,
            title                 : v0.title,
            description           : v0.description,
            link                  : v0.link,
            voting_start_epoch    : v0.voting_start_epoch,
            voting_end_epoch      : v0.voting_end_epoch,
            execution_start_epoch : v0.execution_start_epoch,
            execution_end_epoch   : v0.execution_end_epoch,
            proposal_type         : arg8,
        };
        0x2::event::emit<NewProposalKrafted>(v1);
        v0
    }

    public fun initiate_proposal_discussion(arg0: &mut HiveDaoGovernor, arg1: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveDisperser, arg2: &mut 0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HiveVault, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x2::coin::Coin<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 9017);
        let v0 = 0x2::tx_context::sender(arg7);
        0x2::tx_context::epoch(arg7);
        let v1 = 0x2::coin::into_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(arg6);
        assert!(arg0.vote_config.proposal_required_deposit / 10 <= 0x2::balance::value<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&v1), 9019);
        0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::deposit_gems_for_hive(arg1, 0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::burn_hive_and_return_gems(arg2, 0x2::balance::split<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&mut v1, arg0.vote_config.proposal_required_deposit / 10), 0x2::tx_context::sender(arg7), arg7));
        let v2 = 0x1::string::to_ascii(0x1::string::utf8(b"INITIATE_DISCUSSION"));
        let v3 = 0x1::string::utf8(b"");
        if (0x2::linked_table::contains<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v2)) {
            0x1::string::append(&mut v3, 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v2).buzz);
        };
        0x1::string::append(&mut v3, 0x1::string::utf8(x"0a5469746c653a20"));
        0x1::string::append(&mut v3, arg3);
        0x1::string::append(&mut v3, 0x1::string::utf8(x"0a4465736372697074696f6e3a20"));
        0x1::string::append(&mut v3, arg4);
        0x1::string::append(&mut v3, 0x1::string::utf8(x"0a4c696e6b3a20"));
        0x1::string::append(&mut v3, arg5);
        let v4 = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")));
        make_new_governor_buzz(v4, v3, arg7);
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(v1, v0, arg7);
    }

    public entry fun interact_with_governance_buzz(arg0: &0x2::clock::Clock, arg1: &0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveAppAccessCapability, arg2: &0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveManager, arg3: &mut HiveDaoGovernor, arg4: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveProfile, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.module_version == 0, 9017);
        let (v0, v1, v2, v3) = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::get_profile_meta_info(arg4);
        assert!(v2 || v3 == 0x2::tx_context::sender(arg9), 9020);
        let v4 = 0x2::linked_table::borrow_mut<u64, GovernorBuzz>(&mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg3.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes"))).governor_buzzes, arg5);
        if (0x2::linked_table::contains<address, Dialogues>(&v4.profile_buzzes, v0)) {
            let v5 = 0x2::linked_table::borrow_mut<address, Dialogues>(&mut v4.profile_buzzes, v0);
            if (0x2::linked_table::contains<u64, Dialogue>(&v5.dialogues, arg6)) {
                0x2::linked_table::borrow_mut<u64, Dialogue>(&mut v5.dialogues, arg6).buzz = arg7;
            } else {
                let v6 = Dialogue{
                    buzz    : arg7,
                    upvotes : 0x2::linked_table::new<address, bool>(arg9),
                };
                0x2::linked_table::push_back<u64, Dialogue>(&mut v5.dialogues, arg6, v6);
            };
        } else {
            let v7 = Dialogue{
                buzz    : arg7,
                upvotes : 0x2::linked_table::new<address, bool>(arg9),
            };
            let v8 = Dialogues{dialogues: 0x2::linked_table::new<u64, Dialogue>(arg9)};
            0x2::linked_table::push_back<u64, Dialogue>(&mut v8.dialogues, 0, v7);
            0x2::linked_table::push_back<address, Dialogues>(&mut v4.profile_buzzes, v0, v8);
        };
        0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::consume_entropy_of_profile(arg0, arg1, arg2, arg4, arg8, arg9);
        let v9 = UserBuzzOnHiveDaoBuzzDetected{
            user_profile_addr     : v0,
            username              : v1,
            governance_buzz_index : arg5,
            dialogue_index        : arg6,
            user_buzz             : arg7,
        };
        0x2::event::emit<UserBuzzOnHiveDaoBuzzDetected>(v9);
    }

    fun internal_cast_vote(arg0: &mut HiveDaoGovernor, arg1: u64, arg2: &0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveProfile, arg3: u64, arg4: bool, arg5: u128, arg6: &0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 9017);
        let v0 = 0x2::tx_context::epoch(arg6);
        let (v1, _, v3, v4) = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::get_profile_meta_info(arg2);
        assert!(v3 || v4 == 0x2::tx_context::sender(arg6), 9020);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg1), 9005);
        let v5 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg1);
        assert!(v0 >= v5.voting_start_epoch && v0 <= v5.voting_end_epoch, 9006);
        if (v5.proposal_status == 0) {
            v5.proposal_status = 1;
        };
        if (0x2::table::contains<address, Vote>(&v5.votes, v1)) {
            let v6 = 0x2::table::remove<address, Vote>(&mut v5.votes, v1);
            if (v6.vote) {
                v5.yes_votes = v5.yes_votes - v6.power;
            } else {
                v5.no_votes = v5.no_votes - v6.power;
            };
            let Vote {
                power : _,
                vote  : _,
            } = v6;
        };
        if (arg4) {
            v5.yes_votes = v5.yes_votes + arg3;
        } else {
            v5.no_votes = v5.no_votes + arg3;
        };
        let v9 = Vote{
            power : (arg3 as u64),
            vote  : arg4,
        };
        0x2::table::add<address, Vote>(&mut v5.votes, v1, v9);
        let v10 = VoteCasted{
            proposal_id          : v5.proposal_id,
            voter_profile        : v1,
            vote                 : arg4,
            yes_votes            : v5.yes_votes,
            no_votes             : v5.no_votes,
            total_possible_votes : arg0.vesting_power + arg5,
        };
        0x2::event::emit<VoteCasted>(v10);
    }

    public fun like_governor_buzz(arg0: &0x2::clock::Clock, arg1: &0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveAppAccessCapability, arg2: &0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveManager, arg3: &mut HiveDaoGovernor, arg4: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveProfile, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        assert!(arg3.module_version == 0, 9017);
        let (v0, v1, v2, v3) = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::get_profile_meta_info(arg4);
        assert!(v2 || v3 == 0x2::tx_context::sender(arg7), 9020);
        let v4 = 0x2::linked_table::borrow_mut<u64, GovernorBuzz>(&mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg3.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes"))).governor_buzzes, arg5);
        assert!(!0x2::linked_table::contains<address, bool>(&v4.likes, v0), 9021);
        0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::consume_entropy_of_profile(arg0, arg1, arg2, arg4, arg6, arg7);
        let v5 = UserLikedHiveDaoBuzz{
            user_profile_addr : v0,
            username          : v1,
            buzz_index        : arg5,
        };
        0x2::event::emit<UserLikedHiveDaoBuzz>(v5);
        0x2::linked_table::push_back<address, bool>(&mut v4.likes, v0, true);
    }

    fun make_new_governor_buzz(arg0: &mut HiveGovernorBuzzes, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.count;
        let v1 = GovernorBuzz{
            buzz           : arg1,
            likes          : 0x2::linked_table::new<address, bool>(arg2),
            profile_buzzes : 0x2::linked_table::new<address, Dialogues>(arg2),
        };
        0x2::linked_table::push_back<u64, GovernorBuzz>(&mut arg0.governor_buzzes, v0, v1);
        arg0.count = arg0.count + 1;
        let v2 = NewHiveGovernanceBuzz{
            buzz_index : v0,
            buzz       : arg1,
        };
        0x2::event::emit<NewHiveGovernanceBuzz>(v2);
    }

    public fun make_proposal_add_precision_for_coins_transition(arg0: &mut HiveDaoGovernor, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>, arg5: vector<0x1::string::String>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::tx_context::epoch(arg7);
        assert!(arg0.module_version == 0, 9017);
        let v2 = 0x2::coin::into_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(arg4);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&v2), 9019);
        let v3 = init_proposal(v1, arg0.next_proposal_id, v0, 0x2::balance::split<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&mut v2, arg0.vote_config.proposal_required_deposit), arg1, arg2, arg3, &arg0.vote_config, 0, arg7);
        let v4 = AddPrecisionForCoinsTransition{
            coin_identifiers : arg5,
            decimals         : arg6,
        };
        v3.config_add_coins_transition = 0x1::option::some<AddPrecisionForCoinsTransition>(v4);
        v3.proposal_type = 0;
        let v5 = 0x1::string::to_ascii(0x1::string::utf8(b"ADD_PRECISION_FOR_COINS_TRANSITION"));
        let v6 = 0x1::string::utf8(b"");
        if (0x2::linked_table::contains<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v5)) {
            0x1::string::append(&mut v6, 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v5).buzz);
        };
        let v7 = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")));
        make_new_governor_buzz(v7, make_proposal_buzz(v6, &v3), arg7);
        let v8 = AddPrecisionForCoinsProposalKrafted{
            proposal_id      : v3.proposal_id,
            coin_identifiers : arg5,
            decimals         : arg6,
        };
        0x2::event::emit<AddPrecisionForCoinsProposalKrafted>(v8);
        0x2::linked_table::push_back<u64, Proposal>(&mut arg0.proposal_list, v3.proposal_id, v3);
        arg0.next_proposal_id = arg0.next_proposal_id + 1;
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(v2, v0, arg7);
    }

    public fun make_proposal_amm_fee_transition<T0>(arg0: &mut HiveDaoGovernor, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::tx_context::epoch(arg7);
        assert!(arg0.module_version == 0, 9017);
        let v2 = 0x2::coin::into_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(arg4);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&v2), 9019);
        let v3 = init_proposal(v1, arg0.next_proposal_id, v0, 0x2::balance::split<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&mut v2, arg0.vote_config.proposal_required_deposit), arg1, arg2, arg3, &arg0.vote_config, 2, arg7);
        if (arg5 > 0) {
            assert!(arg5 >= 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::min_swap_fee() && arg5 <= 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::max_swap_fee(), 9016);
        };
        if (arg6 > 0) {
            assert!(arg6 >= 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::min_hive_fee() && arg6 <= 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::max_hive_fee(), 9016);
        };
        let v4 = DefaultAmmFeeTransition{
            curve_type       : 0x1::type_name::get<T0>(),
            total_fee_bps    : arg5,
            hive_fee_percent : arg6,
        };
        v3.amm_default_fee_transition = 0x1::option::some<DefaultAmmFeeTransition>(v4);
        v3.proposal_type = 2;
        let v5 = 0x1::string::to_ascii(0x1::string::utf8(b"DEFAULT_AMM_FEE_TRANSITION"));
        let v6 = 0x1::string::utf8(b"");
        if (0x2::linked_table::contains<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v5)) {
            0x1::string::append(&mut v6, 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v5).buzz);
        };
        let v7 = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")));
        make_new_governor_buzz(v7, make_proposal_buzz(v6, &v3), arg7);
        let v8 = DefaultAmmFeeTransitionProposalKrafted{
            proposal_id      : v3.proposal_id,
            curve_type       : 0x1::type_name::get<T0>(),
            total_fee_bps    : arg5,
            hive_fee_percent : arg6,
        };
        0x2::event::emit<DefaultAmmFeeTransitionProposalKrafted>(v8);
        0x2::linked_table::push_back<u64, Proposal>(&mut arg0.proposal_list, v3.proposal_id, v3);
        arg0.next_proposal_id = arg0.next_proposal_id + 1;
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(v2, v0, arg7);
    }

    public fun make_proposal_amm_transition_params(arg0: &mut HiveDaoGovernor, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>, arg5: u64, arg6: bool, arg7: bool, arg8: bool, arg9: 0x1::option::Option<address>, arg10: 0x1::option::Option<address>, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg13);
        let v1 = 0x2::tx_context::epoch(arg13);
        assert!(arg0.module_version == 0, 9017);
        let v2 = 0x2::coin::into_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(arg4);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&v2), 9019);
        let v3 = init_proposal(v1, arg0.next_proposal_id, v0, 0x2::balance::split<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&mut v2, arg0.vote_config.proposal_required_deposit), arg1, arg2, arg3, &arg0.vote_config, 4, arg13);
        let v4 = AmmTransition{
            new_fee                : arg5,
            for_2_amm              : arg6,
            for_3_amm              : arg7,
            to_update_oracle       : arg8,
            new_sui_hive_pool_addr : arg9,
            new_usdc_sui_pool_addr : arg10,
            new_window_size        : arg11,
            new_tolerance          : arg12,
        };
        v3.amm_transition_params = 0x1::option::some<AmmTransition>(v4);
        v3.proposal_type = 4;
        let v5 = 0x1::string::to_ascii(0x1::string::utf8(b"AMM_ORACLE_TRANSITION"));
        let v6 = 0x1::string::utf8(b"");
        if (0x2::linked_table::contains<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v5)) {
            0x1::string::append(&mut v6, 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v5).buzz);
        };
        let v7 = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")));
        make_new_governor_buzz(v7, make_proposal_buzz(v6, &v3), arg13);
        let v8 = AmmTransitionProposalKrafted{
            proposal_id            : v3.proposal_id,
            new_fee                : arg5,
            for_2_amm              : arg6,
            for_3_amm              : arg7,
            to_update_oracle       : arg8,
            new_sui_hive_pool_addr : arg9,
            new_usdc_sui_pool_addr : arg10,
            new_window_size        : arg11,
            new_tolerance          : arg12,
        };
        0x2::event::emit<AmmTransitionProposalKrafted>(v8);
        0x2::linked_table::push_back<u64, Proposal>(&mut arg0.proposal_list, v3.proposal_id, v3);
        arg0.next_proposal_id = arg0.next_proposal_id + 1;
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(v2, v0, arg13);
    }

    fun make_proposal_buzz(arg0: 0x1::string::String, arg1: &Proposal) : 0x1::string::String {
        0x1::string::append(&mut arg0, 0x1::string::utf8(b"Proposal ID: "));
        0x1::string::append(&mut arg0, 0x1::string::utf8(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::u64_to_ascii(arg1.proposal_id)));
        0x1::string::append(&mut arg0, 0x1::string::utf8(x"0a5469746c653a20"));
        0x1::string::append(&mut arg0, arg1.title);
        0x1::string::append(&mut arg0, 0x1::string::utf8(x"0a4465736372697074696f6e3a20"));
        0x1::string::append(&mut arg0, arg1.description);
        0x1::string::append(&mut arg0, 0x1::string::utf8(x"0a4c696e6b3a20"));
        0x1::string::append(&mut arg0, arg1.link);
        arg0
    }

    public fun make_proposal_install_app(arg0: &mut HiveDaoGovernor, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>, arg5: address, arg6: 0x1::ascii::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: bool, arg10: bool, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 9017);
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = 0x2::tx_context::epoch(arg12);
        let v2 = 0x2::coin::into_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(arg4);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&v2), 9019);
        let v3 = init_proposal(v1, arg0.next_proposal_id, v0, 0x2::balance::split<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&mut v2, arg0.vote_config.proposal_required_deposit), arg1, arg2, arg3, &arg0.vote_config, 9, arg12);
        let v4 = KraftCapForNewHiveApp{
            name                      : arg6,
            url                       : arg7,
            description               : arg8,
            only_owner_can_add_app    : arg9,
            only_owner_can_access_app : arg10,
            only_owner_can_remove_app : arg11,
            recepient                 : arg5,
        };
        v3.add_app_to_hive_store = 0x1::option::some<KraftCapForNewHiveApp>(v4);
        v3.proposal_type = 9;
        let v5 = 0x1::string::to_ascii(0x1::string::utf8(b"INSTALL_APP_TO_HIVE_PROFILE"));
        let v6 = 0x1::string::utf8(b"");
        if (0x2::linked_table::contains<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v5)) {
            0x1::string::append(&mut v6, 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v5).buzz);
        };
        let v7 = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")));
        make_new_governor_buzz(v7, make_proposal_buzz(v6, &v3), arg12);
        let v8 = NewHiveAppAddedToDegenHive{
            proposal_id               : v3.proposal_id,
            recepient                 : arg5,
            app_name                  : arg6,
            url                       : arg7,
            description               : arg8,
            only_owner_can_add_app    : arg9,
            only_owner_can_access_app : arg10,
            only_owner_can_remove_app : arg11,
        };
        0x2::event::emit<NewHiveAppAddedToDegenHive>(v8);
        0x2::linked_table::push_back<u64, Proposal>(&mut arg0.proposal_list, v3.proposal_id, v3);
        arg0.next_proposal_id = arg0.next_proposal_id + 1;
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(v2, v0, arg12);
    }

    public fun make_proposal_lsd_module_transition(arg0: &mut HiveDaoGovernor, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>, arg5: vector<address>, arg6: bool, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = 0x2::tx_context::epoch(arg12);
        assert!(arg0.module_version == 0, 9017);
        let v2 = 0x2::coin::into_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(arg4);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&v2), 9019);
        let v3 = init_proposal(v1, arg0.next_proposal_id, v0, 0x2::balance::split<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&mut v2, arg0.vote_config.proposal_required_deposit), arg1, arg2, arg3, &arg0.vote_config, 8, arg12);
        let v4 = DSuiVaultConfigTransition{
            validators_list             : arg5,
            to_add                      : arg6,
            protocol_fee_percent        : arg7,
            service_fee_percent         : arg8,
            treasury_percent            : arg9,
            execute_emergency_operation : arg10,
            pause_stake                 : arg11,
        };
        v3.dsui_vault_config_transition = 0x1::option::some<DSuiVaultConfigTransition>(v4);
        v3.proposal_type = 8;
        let v5 = 0x1::string::to_ascii(0x1::string::utf8(b"DSUI_VAULT_TRANSITION"));
        let v6 = 0x1::string::utf8(b"");
        if (0x2::linked_table::contains<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v5)) {
            0x1::string::append(&mut v6, 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v5).buzz);
        };
        let v7 = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")));
        make_new_governor_buzz(v7, make_proposal_buzz(v6, &v3), arg12);
        let v8 = DSuiVaultTransitionProposalKrafted{
            validators_list             : arg5,
            to_add                      : arg6,
            protocol_fee_percent        : arg7,
            service_fee_percent         : arg8,
            treasury_percent            : arg9,
            execute_emergency_operation : arg10,
            pause_stake                 : arg11,
        };
        0x2::event::emit<DSuiVaultTransitionProposalKrafted>(v8);
        0x2::linked_table::push_back<u64, Proposal>(&mut arg0.proposal_list, v3.proposal_id, v3);
        arg0.next_proposal_id = arg0.next_proposal_id + 1;
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(v2, v0, arg12);
    }

    public fun make_proposal_pol_transition_params(arg0: &mut HiveDaoGovernor, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>, arg5: 0x1::option::Option<address>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::tx_context::epoch(arg8);
        assert!(arg0.module_version == 0, 9017);
        let v2 = 0x2::coin::into_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(arg4);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&v2), 9019);
        let v3 = init_proposal(v1, arg0.next_proposal_id, v0, 0x2::balance::split<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&mut v2, arg0.vote_config.proposal_required_deposit), arg1, arg2, arg3, &arg0.vote_config, 5, arg8);
        let v4 = PolParamTransition{
            third_pool_addr       : arg5,
            sui_for_hive_pool_pct : arg6,
            sui_for_bee_pool_pct  : arg7,
        };
        v3.pol_transition_params = 0x1::option::some<PolParamTransition>(v4);
        v3.proposal_type = 5;
        let v5 = 0x1::string::to_ascii(0x1::string::utf8(b"POL_PARAM_TRANSITION"));
        let v6 = 0x1::string::utf8(b"");
        if (0x2::linked_table::contains<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v5)) {
            0x1::string::append(&mut v6, 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v5).buzz);
        };
        let v7 = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")));
        make_new_governor_buzz(v7, make_proposal_buzz(v6, &v3), arg8);
        let v8 = PolParamTransitionProposalKrafted{
            proposal_id           : v3.proposal_id,
            third_pool_addr       : arg5,
            sui_for_hive_pool_pct : arg6,
            sui_for_bee_pool_pct  : arg7,
        };
        0x2::event::emit<PolParamTransitionProposalKrafted>(v8);
        0x2::linked_table::push_back<u64, Proposal>(&mut arg0.proposal_list, v3.proposal_id, v3);
        arg0.next_proposal_id = arg0.next_proposal_id + 1;
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(v2, v0, arg8);
    }

    public fun make_proposal_pools_governor_transition(arg0: &mut HiveDaoGovernor, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>, arg5: vector<u64>, arg6: u64, arg7: bool, arg8: u64, arg9: u64, arg10: vector<address>, arg11: vector<u64>, arg12: vector<u64>, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg13);
        let v1 = 0x2::tx_context::epoch(arg13);
        assert!(arg0.module_version == 0, 9017);
        let v2 = 0x2::coin::into_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(arg4);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&v2), 9019);
        let v3 = init_proposal(v1, arg0.next_proposal_id, v0, 0x2::balance::split<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&mut v2, arg0.vote_config.proposal_required_deposit), arg1, arg2, arg3, &arg0.vote_config, 6, arg13);
        if (0x1::vector::length<u64>(&arg11) > 0) {
            assert!(0x1::vector::length<address>(&arg10) == 0x1::vector::length<u64>(&arg11), 9032);
        };
        if (0x1::vector::length<u64>(&arg12) > 0) {
            assert!(0x1::vector::length<address>(&arg10) == 0x1::vector::length<u64>(&arg12), 9032);
        };
        let v4 = PoolsGovernorTransition{
            new_params                 : arg5,
            bees_to_deposit            : arg6,
            pool_hive_addrs            : arg10,
            hive_points_for_pool_hives : arg12,
            bee_points_for_pool_hives  : arg11,
            to_update_per_epoch_points : arg7,
            new_hive_per_epoch         : arg9,
            new_bee_per_epoch          : arg8,
        };
        v3.pools_governor_transition = 0x1::option::some<PoolsGovernorTransition>(v4);
        v3.proposal_type = 6;
        let v5 = 0x1::string::to_ascii(0x1::string::utf8(b"POOLS_GOVERNOR_TRANSITION"));
        let v6 = 0x1::string::utf8(b"");
        if (0x2::linked_table::contains<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v5)) {
            0x1::string::append(&mut v6, 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v5).buzz);
        };
        let v7 = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")));
        make_new_governor_buzz(v7, make_proposal_buzz(v6, &v3), arg13);
        let v8 = PoolsGovernorTransitionProposalKrafted{
            proposal_id                : v3.proposal_id,
            new_params                 : arg5,
            bees_to_deposit            : arg6,
            pool_hive_addrs            : arg10,
            hive_points_for_pool_hives : arg12,
            bee_points_for_pool_hives  : arg11,
            to_update_per_epoch_points : arg7,
            new_hive_per_epoch         : arg9,
            new_bee_per_epoch          : arg8,
        };
        0x2::event::emit<PoolsGovernorTransitionProposalKrafted>(v8);
        0x2::linked_table::push_back<u64, Proposal>(&mut arg0.proposal_list, v3.proposal_id, v3);
        arg0.next_proposal_id = arg0.next_proposal_id + 1;
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(v2, v0, arg13);
    }

    public fun make_proposal_stable_identifier_transition<T0>(arg0: &mut HiveDaoGovernor, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::tx_context::epoch(arg6);
        let v2 = 0x1::type_name::get<T0>();
        assert!(arg0.module_version == 0, 9017);
        let v3 = 0x2::coin::into_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(arg4);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&v3), 9019);
        let v4 = init_proposal(v1, arg0.next_proposal_id, v0, 0x2::balance::split<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&mut v3, arg0.vote_config.proposal_required_deposit), arg1, arg2, arg3, &arg0.vote_config, 1, arg6);
        let v5 = AddStableIdentifierTransition{
            identifier_type_name : v2,
            to_add               : arg5,
        };
        v4.config_stable_identifier_transition = 0x1::option::some<AddStableIdentifierTransition>(v5);
        v4.proposal_type = 1;
        let v6 = 0x1::string::to_ascii(0x1::string::utf8(b"ADD_STABLE_IDENTIFIER_TRANSITION"));
        let v7 = 0x1::string::utf8(b"");
        if (0x2::linked_table::contains<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v6)) {
            0x1::string::append(&mut v7, 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v6).buzz);
        };
        let v8 = 0x1::string::utf8(b"");
        if (0x2::linked_table::contains<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v6)) {
            0x1::string::append(&mut v8, 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v6).buzz);
        };
        let v9 = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")));
        make_new_governor_buzz(v9, make_proposal_buzz(v8, &v4), arg6);
        let v10 = IdentifierTransitionProposalKrafted{
            proposal_id          : v4.proposal_id,
            identifier_type_name : v2,
            to_add               : arg5,
        };
        0x2::event::emit<IdentifierTransitionProposalKrafted>(v10);
        0x2::linked_table::push_back<u64, Proposal>(&mut arg0.proposal_list, v4.proposal_id, v4);
        arg0.next_proposal_id = arg0.next_proposal_id + 1;
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(v3, v0, arg6);
    }

    public fun make_proposal_treasury_transition(arg0: &mut HiveDaoGovernor, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::tx_context::epoch(arg10);
        assert!(arg0.module_version == 0, 9017);
        if (arg5 > 0) {
            assert!(arg5 >= 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::min_treasury_fee() && arg5 <= 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::max_treasury_fee(), 9015);
        };
        let v2 = 0x2::coin::into_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(arg4);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&v2), 9019);
        let v3 = init_proposal(v1, arg0.next_proposal_id, v0, 0x2::balance::split<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&mut v2, arg0.vote_config.proposal_required_deposit), arg1, arg2, arg3, &arg0.vote_config, 3, arg10);
        let v4 = AccessTreasuryOrBeesUpdate{
            new_treasury_percent : arg5,
            to_distribute_dsui   : arg6,
            to_distribute_bees   : arg7,
            new_bees_per_epoch   : arg8,
            recepient            : arg9,
        };
        v3.treasury_transition = 0x1::option::some<AccessTreasuryOrBeesUpdate>(v4);
        v3.proposal_type = 3;
        let v5 = 0x1::string::to_ascii(0x1::string::utf8(b"DSUI_TREASURY_OR_BEES_TRANSITION"));
        let v6 = 0x1::string::utf8(b"");
        if (0x2::linked_table::contains<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v5)) {
            0x1::string::append(&mut v6, 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v5).buzz);
        };
        let v7 = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")));
        make_new_governor_buzz(v7, make_proposal_buzz(v6, &v3), arg10);
        let v8 = TreasuryTransitionProposalKrafted{
            proposal_id          : v3.proposal_id,
            new_treasury_percent : arg5,
            to_distribute_dsui   : arg6,
            to_distribute_bees   : arg7,
            new_bees_per_epoch   : arg8,
            recepient            : arg9,
        };
        0x2::event::emit<TreasuryTransitionProposalKrafted>(v8);
        0x2::linked_table::push_back<u64, Proposal>(&mut arg0.proposal_list, v3.proposal_id, v3);
        arg0.next_proposal_id = arg0.next_proposal_id + 1;
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(v2, v0, arg10);
    }

    public fun make_proposal_update_profile_config_transition(arg0: &mut HiveDaoGovernor, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg19);
        let v1 = 0x2::tx_context::epoch(arg19);
        assert!(arg0.module_version == 0, 9017);
        let v2 = 0x2::coin::into_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(arg4);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&v2), 9019);
        let v3 = init_proposal(v1, arg0.next_proposal_id, v0, 0x2::balance::split<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&mut v2, arg0.vote_config.proposal_required_deposit), arg1, arg2, arg3, &arg0.vote_config, 7, arg19);
        let v4 = ProfileConfigTransition{
            new_max_bids                : arg5,
            new_min_bid                 : arg6,
            new_profile_kraft_fee       : arg7,
            social_fee_gems             : arg8,
            social_multiplier_for_gems  : arg9,
            social_multiplier_for_power : arg10,
            royalty_num                 : arg11,
            royalty_denom               : arg12,
            assets_dispersal_percent    : arg13,
            creators_royalty_percent    : arg14,
            gems_royalty_num            : arg15,
            gems_royalty_denom          : arg16,
            gems_treasury_percent       : arg17,
            gems_burn_percent           : arg18,
        };
        v3.profile_config_transition = 0x1::option::some<ProfileConfigTransition>(v4);
        v3.proposal_type = 7;
        let v5 = 0x1::string::to_ascii(0x1::string::utf8(b"HIVE_MANAGER_TRANSITION"));
        let v6 = 0x1::string::utf8(b"");
        if (0x2::linked_table::contains<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v5)) {
            0x1::string::append(&mut v6, 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v5).buzz);
        };
        let v7 = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")));
        make_new_governor_buzz(v7, make_proposal_buzz(v6, &v3), arg19);
        let v8 = ProfileConfigTransitionProposalKrafted{
            proposal_id                 : v3.proposal_id,
            new_max_bids                : arg5,
            new_min_bid                 : arg6,
            new_profile_kraft_fee       : arg7,
            social_fee_gems             : arg8,
            social_multiplier_for_gems  : arg9,
            social_multiplier_for_power : arg10,
            royalty_num                 : arg11,
            royalty_denom               : arg12,
            assets_dispersal_percent    : arg13,
            creators_royalty_percent    : arg14,
            gems_royalty_num            : arg15,
            gems_royalty_denom          : arg16,
            gems_treasury_percent       : arg17,
            gems_burn_percent           : arg18,
        };
        0x2::event::emit<ProfileConfigTransitionProposalKrafted>(v8);
        0x2::linked_table::push_back<u64, Proposal>(&mut arg0.proposal_list, v3.proposal_id, v3);
        arg0.next_proposal_id = arg0.next_proposal_id + 1;
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(v2, v0, arg19);
    }

    public fun make_proposal_update_streamer_buzzes(arg0: &mut HiveDaoGovernor, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: address, arg18: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 9017);
        let v0 = 0x2::tx_context::sender(arg18);
        let v1 = 0x2::tx_context::epoch(arg18);
        let v2 = 0x2::coin::into_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(arg4);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&v2), 9019);
        let v3 = init_proposal(v1, arg0.next_proposal_id, v0, 0x2::balance::split<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&mut v2, arg0.vote_config.proposal_required_deposit), arg1, arg2, arg3, &arg0.vote_config, 10, arg18);
        let v4 = HiveTransition{
            to_update_config         : arg5,
            new_live_status          : arg6,
            new_buzzes_count         : arg7,
            tax_on_bid               : arg8,
            winning_bid_points       : arg9,
            hive_per_ad_slot         : arg10,
            bees_per_ad_slot         : arg11,
            first_rank_assets_limit  : arg12,
            second_rank_assets_limit : arg13,
            third_rank_assets_limit  : arg14,
            max_streams_to_store     : arg15,
            hive_to_spend            : arg16,
            recepient_addr           : arg17,
        };
        v3.hive_transition = 0x1::option::some<HiveTransition>(v4);
        v3.proposal_type = 10;
        let v5 = 0x1::string::to_ascii(0x1::string::utf8(b"HIVE_TRANSITION"));
        let v6 = 0x1::string::utf8(b"");
        if (0x2::linked_table::contains<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v5)) {
            0x1::string::append(&mut v6, 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v5).buzz);
        };
        let v7 = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")));
        make_new_governor_buzz(v7, make_proposal_buzz(v6, &v3), arg18);
        let v8 = HiveTransitionProposalKrafted{
            proposal_id              : v3.proposal_id,
            to_update_config         : arg5,
            new_live_status          : arg6,
            new_buzzes_count         : arg7,
            tax_on_bid               : arg8,
            winning_bid_points       : arg9,
            hive_per_ad_slot         : arg10,
            bees_per_ad_slot         : arg11,
            first_rank_assets_limit  : arg12,
            second_rank_assets_limit : arg13,
            third_rank_assets_limit  : arg14,
            max_streams_to_store     : arg15,
            hive_to_spend            : arg16,
            recepient_addr           : arg17,
        };
        0x2::event::emit<HiveTransitionProposalKrafted>(v8);
        0x2::linked_table::push_back<u64, Proposal>(&mut arg0.proposal_list, v3.proposal_id, v3);
        arg0.next_proposal_id = arg0.next_proposal_id + 1;
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(v2, v0, arg18);
    }

    public fun port_gems_to_app_via_asset(arg0: &0x2::clock::Clock, arg1: &mut HiveDaoGovernor, arg2: &0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveAppAccessCapability, arg3: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveManager, arg4: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg5: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveDisperser, arg6: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveProfile, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGems {
        assert!(arg1.module_version == 0, 9017);
        let v0 = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::get_hive_app_name(arg2);
        assert!(0x2::linked_table::contains<0x1::ascii::String, HiveApp>(&arg1.supported_apps, v0), 9003);
        let v1 = 0x2::linked_table::borrow_mut<0x1::ascii::String, HiveApp>(&mut arg1.supported_apps, v0);
        v1.total_hive_gems_ported = v1.total_hive_gems_ported + arg8;
        0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::port_gems_to_app_via_asset(&arg1.dao_cap, arg2, arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public entry fun removeExpiredProposal(arg0: &mut HiveDaoGovernor, arg1: &mut 0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HiveVault, arg2: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveDisperser, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg3), 9005);
        let v0 = 0x2::linked_table::remove<u64, Proposal>(&mut arg0.proposal_list, arg3);
        assert!(0x2::tx_context::epoch(arg4) > v0.execution_end_epoch || v0.proposal_status == 4 || v0.proposal_status == 5, 9008);
        let (v1, v2, v3, v4) = destroy_proposal(v0);
        let v5 = v2;
        if (0x2::balance::value<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(&v5) > 0) {
            0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::deposit_gems_for_hive(arg2, 0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::burn_hive_and_return_gems(arg1, v5, 0x2::tx_context::sender(arg4), arg4));
        } else {
            0x2::balance::destroy_zero<0x77b79a0e447f6e499909fff5593845f069f12bd85ec1452923a1a2afbbfcb73c::hive::HIVE>(v5);
        };
        let v6 = ProposalDeleted{
            proposal_id     : v1,
            proposal_type   : v3,
            proposal_status : v4,
        };
        0x2::event::emit<ProposalDeleted>(v6);
    }

    public fun update_system_buzz(arg0: &mut HiveDaoGovernor, arg1: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::DegenHiveDeployerCap, arg2: 0x1::ascii::String, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        if (!0x2::linked_table::contains<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, arg2)) {
            let v0 = SystemBuzz{buzz: arg3};
            0x2::linked_table::push_back<0x1::ascii::String, SystemBuzz>(&mut arg0.managed_buzzes, arg2, v0);
        } else {
            0x2::linked_table::borrow_mut<0x1::ascii::String, SystemBuzz>(&mut arg0.managed_buzzes, arg2).buzz = arg3;
        };
    }

    public fun update_vesting_power(arg0: &VestingVoteCap, arg1: &mut HiveDaoGovernor, arg2: u64, arg3: u64) {
        assert!(arg1.module_version == 0, 9017);
        arg1.vesting_power = arg1.vesting_power + (arg2 as u128) - (arg3 as u128);
        let v0 = TotalHiveDaoPowerUpdated{
            power_to_add      : arg2,
            power_to_subtract : arg3,
            vesting_power     : arg1.vesting_power,
        };
        0x2::event::emit<TotalHiveDaoPowerUpdated>(v0);
    }

    public entry fun upvote_dialogue_on_buzz(arg0: &0x2::clock::Clock, arg1: &0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveAppAccessCapability, arg2: &0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveManager, arg3: &mut HiveDaoGovernor, arg4: &mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::HiveProfile, arg5: u64, arg6: address, arg7: u64, arg8: u64, arg9: &0x2::tx_context::TxContext) {
        assert!(arg3.module_version == 0, 9017);
        let (v0, v1, v2, v3) = 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::get_profile_meta_info(arg4);
        assert!(v2 || v3 == 0x2::tx_context::sender(arg9), 9020);
        let v4 = 0x2::linked_table::borrow_mut<u64, GovernorBuzz>(&mut 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg3.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes"))).governor_buzzes, arg5);
        assert!(0x2::linked_table::contains<address, Dialogues>(&v4.profile_buzzes, arg6), 9025);
        let v5 = 0x2::linked_table::borrow_mut<address, Dialogues>(&mut v4.profile_buzzes, arg6);
        assert!(0x2::linked_table::contains<u64, Dialogue>(&v5.dialogues, arg7), 9029);
        let v6 = 0x2::linked_table::borrow_mut<u64, Dialogue>(&mut v5.dialogues, arg7);
        assert!(!0x2::linked_table::contains<address, bool>(&v6.upvotes, v0), 9024);
        0x2::linked_table::push_back<address, bool>(&mut v6.upvotes, v0, true);
        0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile::consume_entropy_of_profile(arg0, arg1, arg2, arg4, arg8, arg9);
        let v7 = UserUpvotedHiveGovernanceBuzz{
            user_profile_addr     : v0,
            username              : v1,
            governance_buzz_index : arg5,
            user_buzz_by_profile  : arg6,
            dialogue_index        : arg7,
        };
        0x2::event::emit<UserUpvotedHiveGovernanceBuzz>(v7);
    }

    // decompiled from Move bytecode v6
}

