module 0x36be421446b7c5457b1afc209ed5f21fe20e438fe50a0ae2aca3074b8ee5d730::hive_dao {
    struct HIVE_DAO has drop {
        dummy_field: bool,
    }

    struct HiveDaoGovernor has key {
        id: 0x2::object::UID,
        dao_cap: 0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::config::HiveDaoCapability,
        governor_profile: 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveProfile,
        managed_buzzes: 0x2::linked_table::LinkedTable<0x1::ascii::String, SystemBuzz>,
        total_power: u128,
        next_proposal_id: u64,
        proposal_list: 0x2::linked_table::LinkedTable<u64, Proposal>,
        supported_skins: 0x2::linked_table::LinkedTable<0x1::string::String, HiveSkin>,
        vote_config: VoteConfig,
        module_version: u64,
    }

    struct SystemBuzz has store {
        buzz: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
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
        gen_ai: 0x1::option::Option<0x1::string::String>,
        likes: 0x2::linked_table::LinkedTable<address, bool>,
        profile_buzzes: 0x2::linked_table::LinkedTable<address, Dialogue>,
    }

    struct Dialogue has store {
        buzz: 0x1::string::String,
        upvotes: 0x2::linked_table::LinkedTable<address, bool>,
    }

    struct HiveProfileDoFAccessCap has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        only_profile_owner: bool,
        module_version: u64,
    }

    struct HiveSkinKraftCap has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        module_version: u64,
    }

    struct HiveSkin has store {
        cap_id: 0x2::object::ID,
        name: 0x1::string::String,
        url: 0x1::string::String,
        description: 0x1::string::String,
        supported_asset_types: 0x2::table::Table<0x1::string::String, vector<0x1::string::String>>,
        max_skins_per_asset: u64,
        only_subscribers_allowed: bool,
        subscribers_discount: u64,
        public_skin_kraft_enabled: bool,
        royalty_fee_percent: u64,
        base_price: u64,
        total_assets_krafted: u64,
        total_hive_gems_ported: u64,
    }

    struct Proposal has store {
        proposal_id: u64,
        proposer: address,
        deposit: 0x2::balance::Balance<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>,
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
        kraft_dof_for_new_hive_app: 0x1::option::Option<KraftDofForNewHiveApp>,
        config_add_coins_transition: 0x1::option::Option<AddPrecisionForCoinsTransition>,
        config_stable_identifier_transition: 0x1::option::Option<AddStableIdentifierTransition>,
        curve_fee_transition: 0x1::option::Option<DefaultFeeTransition>,
        treasury_transition: 0x1::option::Option<AccessTreasury>,
        hsui_vault_config_transition: 0x1::option::Option<HSuiVaultConfigTransition>,
        pool_kraft_fee_transition: 0x1::option::Option<PoolKraftFeeTransition>,
        pools_governor_transition: 0x1::option::Option<PoolsGovernorTransition>,
        pool_hivepoints_transition: 0x1::option::Option<PoolHivePointsTransition>,
        profile_config_transition: 0x1::option::Option<ProfileConfigTransition>,
        add_new_skin_transition: 0x1::option::Option<AddNewSkinTransition>,
    }

    struct Vote has drop, store {
        power: u64,
        vote: bool,
    }

    struct KraftDofForNewHiveApp has drop, store {
        name: 0x1::string::String,
        only_profile_owner: bool,
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

    struct DefaultFeeTransition has drop, store {
        curve_type: 0x1::type_name::TypeName,
        total_fee_bps: u64,
        hive_fee_percent: u64,
    }

    struct AccessTreasury has drop, store {
        new_treasury_percent: u64,
        to_distribute: u64,
        recepient: address,
    }

    struct PoolKraftFeeTransition has drop, store {
        new_fee: u64,
        for_2_amm: bool,
        for_3_amm: bool,
        to_update_oracle: bool,
        new_sui_hive_pool_addr: 0x1::option::Option<address>,
        new_usdc_sui_pool_addr: 0x1::option::Option<address>,
    }

    struct PoolsGovernorTransition has drop, store {
        new_params: vector<u64>,
    }

    struct PoolHivePointsTransition has drop, store {
        pool_hive_addrs: vector<address>,
        points_for_pool_hives: vector<u64>,
        to_update_hive_per_epoch: bool,
        new_hive_per_epoch: u64,
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

    struct AddNewSkinTransition has store {
        name: 0x1::string::String,
        url: 0x1::string::String,
        description: 0x1::string::String,
        supported_asset_types: 0x2::table::Table<0x1::string::String, vector<0x1::string::String>>,
        max_skins_per_asset: u64,
        only_subscribers_allowed: bool,
        subscribers_discount: u64,
        public_skin_kraft_enabled: bool,
        royalty_fee_percent: u64,
        base_price: u64,
        cap_recepient: address,
    }

    struct HSuiVaultConfigTransition has drop, store {
        validators_list: vector<address>,
        to_add: bool,
        protocol_fee_percent: u64,
        service_fee_percent: u64,
        treasury_percent: u64,
        execute_emergency_operation: bool,
        pause_stake: bool,
    }

    struct NewProposalCreated has copy, drop {
        proposal_id: u64,
        proposer: address,
        title: 0x1::string::String,
        description: 0x1::string::String,
        link: 0x1::string::String,
        voting_start_epoch: u64,
        voting_end_epoch: u64,
        execution_start_epoch: u64,
        execution_end_epoch: u64,
    }

    struct VoteCasted has copy, drop {
        proposal_id: u64,
        voter: address,
        vote: bool,
        yes_votes: u64,
        no_votes: u64,
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
        app_name: 0x1::string::String,
        only_profile_owner: bool,
    }

    struct IdentifierTransitionProposalKrafted has copy, drop {
        proposal_id: u64,
        identifier_type_name: 0x1::type_name::TypeName,
        to_add: bool,
    }

    struct DefaultFeeTransitionProposalKrafted has copy, drop {
        proposal_id: u64,
        curve_type: 0x1::type_name::TypeName,
        total_fee_bps: u64,
        hive_fee_percent: u64,
    }

    struct TreasuryTransitionProposalKrafted has copy, drop {
        proposal_id: u64,
        new_treasury_percent: u64,
        to_distribute: u64,
        recepient: address,
    }

    struct PoolKraftFeeTransitionProposalKrafted has copy, drop {
        proposal_id: u64,
        new_fee: u64,
        for_2_amm: bool,
        for_3_amm: bool,
        to_update_oracle: bool,
        new_sui_hive_pool_addr: 0x1::option::Option<address>,
        new_usdc_sui_pool_addr: 0x1::option::Option<address>,
    }

    struct PoolsGovernorTransitionProposalKrafted has copy, drop {
        proposal_id: u64,
        new_params: vector<u64>,
    }

    struct PoolHivePointsTransitionProposalKrafted has copy, drop {
        proposal_id: u64,
        pool_hive_addrs: vector<address>,
        points_for_pool_hives: vector<u64>,
        to_update_hive_per_epoch: bool,
        new_hive_per_epoch: u64,
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

    struct AddNewSkinTransitionProposalKrafted has copy, drop {
        proposal_id: u64,
        name: 0x1::string::String,
        url: 0x1::string::String,
        description: 0x1::string::String,
        max_skins_per_asset: u64,
        only_subscribers_allowed: bool,
        subscribers_discount: u64,
        public_skin_kraft_enabled: bool,
        royalty_fee_percent: u64,
        base_price: u64,
        cap_recepient: address,
    }

    struct HSuiVaultTransitionProposalKrafted has copy, drop {
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

    struct AddNewSkinTransitionStructDestroyed has copy, drop {
        name: 0x1::string::String,
        url: 0x1::string::String,
        description: 0x1::string::String,
        max_skins_per_asset: u64,
        only_subscribers_allowed: bool,
        subscribers_discount: u64,
        public_skin_kraft_enabled: bool,
        royalty_fee_percent: u64,
        base_price: u64,
        cap_recepient: address,
    }

    struct UserLikedHiveDaoBuzz has copy, drop {
        user_profile_addr: address,
        username: 0x1::string::String,
        buzz_index: u64,
    }

    struct UserUnLikedHiveDaoBuzz has copy, drop {
        user_profile_addr: address,
        username: 0x1::string::String,
        buzz_index: u64,
    }

    struct NewUserBuzzOnHiveDaoBuzzDetected has copy, drop {
        user_profile_addr: address,
        buzz_index: u64,
        username: 0x1::string::String,
        user_buzz: 0x1::string::String,
    }

    struct NewHiveGovernanceBuzz has copy, drop {
        buzz_index: u64,
        buzz: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
    }

    struct UserUpvotedGovernanceBuzz has copy, drop {
        user_profile_addr: address,
        buzz_index: u64,
        username: 0x1::string::String,
        user_buzz_by_profile: address,
    }

    public fun castVote(arg0: &0x2::clock::Clock, arg1: &mut HiveDaoGovernor, arg2: u64, arg3: &0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveProfile, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 9017);
        let v0 = 0x2::tx_context::epoch(arg5);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::get_profile_owner(arg3) == v1, 9004);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg1.proposal_list, arg2), 9005);
        let v2 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg1.proposal_list, arg2);
        assert!(v0 >= v2.voting_start_epoch && v0 <= v2.voting_end_epoch, 9006);
        if (v2.proposal_status == 0) {
            v2.proposal_status = 1;
        };
        let v3 = 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::get_voting_power_for_profile(arg0, arg3);
        if (0x2::table::contains<address, Vote>(&v2.votes, v1)) {
            let v4 = 0x2::table::remove<address, Vote>(&mut v2.votes, v1);
            if (v4.vote) {
                v2.yes_votes = v2.yes_votes - v4.power;
            } else {
                v2.no_votes = v2.no_votes - v4.power;
            };
            let (_, _) = destroy_vote(v4);
        };
        if (arg4) {
            v2.yes_votes = v2.yes_votes + v3;
        } else {
            v2.no_votes = v2.no_votes + v3;
        };
        let v7 = Vote{
            power : v3,
            vote  : arg4,
        };
        0x2::table::add<address, Vote>(&mut v2.votes, v1, v7);
        let v8 = VoteCasted{
            proposal_id : v2.proposal_id,
            voter       : v1,
            vote        : arg4,
            yes_votes   : v2.yes_votes,
            no_votes    : v2.no_votes,
        };
        0x2::event::emit<VoteCasted>(v8);
    }

    public entry fun claim_collected_hsui_fees(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut HiveDaoGovernor, arg2: &mut 0xb696209dc96651350162267ee1ce5dfb28af84f19872d97898de083c73676a66::hsui_vault::HSuiVault, arg3: &mut 0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::config::Treasury<0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::hsui::HSUI>, arg4: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HSuiDisperser<0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::hsui::HSUI>, arg5: &mut 0x2::tx_context::TxContext) {
        0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::deposit_hsui_for_hive<0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::hsui::HSUI>(arg4, 0xb696209dc96651350162267ee1ce5dfb28af84f19872d97898de083c73676a66::hsui_vault::stake_sui_request(arg0, arg2, 0xb696209dc96651350162267ee1ce5dfb28af84f19872d97898de083c73676a66::hsui_vault::claim_collected_fees(&arg1.dao_cap, arg0, arg2, arg3, arg5), 0x1::option::none<address>(), arg5));
    }

    public fun deposit_hive_with_governor(arg0: &mut HiveDaoGovernor, arg1: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HiveVault, arg2: 0x2::coin::Coin<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::burn_hive_for_gems(arg1, &mut arg0.governor_profile, arg2, arg3, arg4);
    }

    fun destroy_proposal(arg0: Proposal) : (u64, address, 0x2::balance::Balance<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64, u64, u64, u64, u64, u64, u64, 0x1::option::Option<KraftDofForNewHiveApp>, 0x1::option::Option<AddPrecisionForCoinsTransition>, 0x1::option::Option<AddStableIdentifierTransition>, 0x1::option::Option<DefaultFeeTransition>, 0x1::option::Option<AccessTreasury>, 0x1::option::Option<HSuiVaultConfigTransition>, 0x1::option::Option<PoolKraftFeeTransition>, 0x1::option::Option<PoolsGovernorTransition>, 0x1::option::Option<PoolHivePointsTransition>, 0x1::option::Option<ProfileConfigTransition>) {
        let Proposal {
            proposal_id                         : v0,
            proposer                            : v1,
            deposit                             : v2,
            title                               : v3,
            description                         : v4,
            link                                : v5,
            proposal_type                       : v6,
            voting_start_epoch                  : v7,
            voting_end_epoch                    : v8,
            execution_start_epoch               : v9,
            execution_end_epoch                 : v10,
            proposal_status                     : v11,
            yes_votes                           : v12,
            no_votes                            : v13,
            votes                               : v14,
            kraft_dof_for_new_hive_app          : v15,
            config_add_coins_transition         : v16,
            config_stable_identifier_transition : v17,
            curve_fee_transition                : v18,
            treasury_transition                 : v19,
            hsui_vault_config_transition        : v20,
            pool_kraft_fee_transition           : v21,
            pools_governor_transition           : v22,
            pool_hivepoints_transition          : v23,
            profile_config_transition           : v24,
            add_new_skin_transition             : v25,
        } = arg0;
        let v26 = v25;
        0x2::table::drop<address, Vote>(v14);
        if (0x1::option::is_some<AddNewSkinTransition>(&v26)) {
            let AddNewSkinTransition {
                name                      : v27,
                url                       : v28,
                description               : v29,
                supported_asset_types     : v30,
                max_skins_per_asset       : v31,
                only_subscribers_allowed  : v32,
                subscribers_discount      : v33,
                public_skin_kraft_enabled : v34,
                royalty_fee_percent       : v35,
                base_price                : v36,
                cap_recepient             : v37,
            } = 0x1::option::destroy_some<AddNewSkinTransition>(v26);
            let v38 = AddNewSkinTransitionStructDestroyed{
                name                      : v27,
                url                       : v28,
                description               : v29,
                max_skins_per_asset       : v31,
                only_subscribers_allowed  : v32,
                subscribers_discount      : v33,
                public_skin_kraft_enabled : v34,
                royalty_fee_percent       : v35,
                base_price                : v36,
                cap_recepient             : v37,
            };
            0x2::event::emit<AddNewSkinTransitionStructDestroyed>(v38);
            0x2::table::drop<0x1::string::String, vector<0x1::string::String>>(v30);
        } else {
            0x1::option::destroy_none<AddNewSkinTransition>(v26);
        };
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24)
    }

    fun destroy_vote(arg0: Vote) : (u64, bool) {
        let Vote {
            power : v0,
            vote  : v1,
        } = arg0;
        (v0, v1)
    }

    public entry fun evaluateProposal(arg0: &mut HiveDaoGovernor, arg1: u64, arg2: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HiveVault, arg3: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveDisperser, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg1), 9005);
        let v0 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg1);
        assert!(0x2::tx_context::epoch(arg4) > v0.voting_end_epoch && v0.proposal_status <= 1, 9007);
        let v1 = v0.yes_votes + v0.no_votes;
        let v2 = arg0.total_power;
        let v3 = if (v2 == 0) {
            0
        } else {
            0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::math::mul_div_u128((1000000 as u128), (v1 as u128), v2)
        };
        let v4 = 0;
        let v5 = if (arg0.vote_config.proposal_required_quorum > v3) {
            v0.proposal_status = 5;
            0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::deposit_gems_for_hive(arg3, 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::burn_hive_and_return_gems(arg2, 0x2::balance::withdraw_all<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(&mut v0.deposit), v0.proposer, arg4));
            0x1::string::to_ascii(0x1::string::utf8(b"PROPOSAL_STATUS_CANCELLED"))
        } else {
            let v6 = 0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::math::mul_div_u128((1000000 as u128), (v0.yes_votes as u128), (v1 as u128));
            v4 = v6;
            let v5 = if (v6 > arg0.vote_config.proposal_approval_threshold) {
                v0.proposal_status = 3;
                0x1::string::to_ascii(0x1::string::utf8(b"PROPOSAL_STATUS_PASSED"))
            } else {
                v0.proposal_status = 4;
                0x1::string::to_ascii(0x1::string::utf8(b"PROPOSAL_STATUS_REJECTED"))
            };
            0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::coin_helper::destroy_or_transfer_balance<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(0x2::balance::withdraw_all<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(&mut v0.deposit), v0.proposer, arg4);
            v5
        };
        let v7 = 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v5);
        let v8 = v7.buzz;
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a0a"));
        0x1::string::append(&mut v8, 0x1::string::utf8(b"Proposal ID: "));
        0x1::string::append(&mut v8, 0x1::string::utf8(0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::coin_helper::u64_to_ascii(v0.proposal_id)));
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v8, 0x1::string::utf8(b"Title: "));
        0x1::string::append(&mut v8, v0.title);
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a566f74696e672073746174697374696373203a3a200a"));
        0x1::string::append(&mut v8, 0x1::string::utf8(b"Total votes casted: "));
        0x1::string::append(&mut v8, 0x1::string::utf8(0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::coin_helper::u64_to_ascii(v1)));
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v8, 0x1::string::utf8(b"% participation: "));
        0x1::string::append(&mut v8, 0x1::string::utf8(0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::coin_helper::u64_to_ascii(v3 * 100 / 1000000)));
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v8, 0x1::string::utf8(b"Yes votes: "));
        0x1::string::append(&mut v8, 0x1::string::utf8(0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::coin_helper::u64_to_ascii(v0.yes_votes)));
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v8, 0x1::string::utf8(b"No votes: "));
        0x1::string::append(&mut v8, 0x1::string::utf8(0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::coin_helper::u64_to_ascii(v0.no_votes)));
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v8, 0x1::string::utf8(b"Yes votes threshold: "));
        0x1::string::append(&mut v8, 0x1::string::utf8(0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::coin_helper::u64_to_ascii(v4)));
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a"));
        let v9 = 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::entry_borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")));
        make_new_governor_buzz(v9, v8, v7.gen_ai, arg4);
        let v10 = ProposalEvaluated{
            proposal_id          : v0.proposal_id,
            proposal_status      : v0.proposal_status,
            yes_votes            : v0.yes_votes,
            no_votes             : v0.no_votes,
            total_possible_votes : v2,
            votes_quorum         : v3,
            yes_votes_threshold  : v4,
        };
        0x2::event::emit<ProposalEvaluated>(v10);
    }

    public entry fun executeProposal_addSkin(arg0: &mut HiveDaoGovernor, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        assert!(arg0.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg1), 9005);
        let v1 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg1);
        assert!(v1.proposal_type == 8 && v1.proposal_status == 3 && v0 >= v1.execution_start_epoch && v0 <= v1.execution_end_epoch, 9009);
        let AddNewSkinTransition {
            name                      : v2,
            url                       : v3,
            description               : v4,
            supported_asset_types     : v5,
            max_skins_per_asset       : v6,
            only_subscribers_allowed  : v7,
            subscribers_discount      : v8,
            public_skin_kraft_enabled : v9,
            royalty_fee_percent       : v10,
            base_price                : v11,
            cap_recepient             : v12,
        } = 0x1::option::extract<AddNewSkinTransition>(&mut v1.add_new_skin_transition);
        let v13 = 0x2::object::new(arg2);
        let v14 = HiveSkin{
            cap_id                    : 0x2::object::uid_to_inner(&v13),
            name                      : v2,
            url                       : v3,
            description               : v4,
            supported_asset_types     : v5,
            max_skins_per_asset       : v6,
            only_subscribers_allowed  : v7,
            subscribers_discount      : v8,
            public_skin_kraft_enabled : v9,
            royalty_fee_percent       : v10,
            base_price                : v11,
            total_assets_krafted      : 0,
            total_hive_gems_ported    : 0,
        };
        0x2::linked_table::push_back<0x1::string::String, HiveSkin>(&mut arg0.supported_skins, v2, v14);
        let v15 = HiveSkinKraftCap{
            id             : v13,
            name           : v2,
            module_version : 0,
        };
        0x2::transfer::transfer<HiveSkinKraftCap>(v15, v12);
        let v16 = ProposalExecuted{
            proposal_id   : v1.proposal_id,
            proposal_type : v1.proposal_type,
            yes_votes     : v1.yes_votes,
            no_votes      : v1.no_votes,
        };
        0x2::event::emit<ProposalExecuted>(v16);
    }

    public entry fun executeProposal_add_coins_transition(arg0: &mut HiveDaoGovernor, arg1: &mut 0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::config::Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg3);
        assert!(arg0.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg2), 9005);
        let v1 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg2);
        assert!(v1.proposal_type == 0 && v1.proposal_status == 3 && v0 >= v1.execution_start_epoch && v0 <= v1.execution_end_epoch, 9009);
        let v2 = 0x1::option::extract<AddPrecisionForCoinsTransition>(&mut v1.config_add_coins_transition);
        0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::config::whitelist_decimal_precisions(arg1, &arg0.dao_cap, v2.coin_identifiers, v2.decimals);
        let v3 = ProposalExecuted{
            proposal_id   : v1.proposal_id,
            proposal_type : v1.proposal_type,
            yes_votes     : v1.yes_votes,
            no_votes      : v1.no_votes,
        };
        0x2::event::emit<ProposalExecuted>(v3);
    }

    public entry fun executeProposal_curve_fee_transition<T0>(arg0: &mut HiveDaoGovernor, arg1: &mut 0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::config::Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg3);
        assert!(arg0.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg2), 9005);
        let v1 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg2);
        assert!(v1.proposal_type == 2 && v1.proposal_status == 3 && v0 >= v1.execution_start_epoch && v0 <= v1.execution_end_epoch, 9009);
        let v2 = 0x1::option::extract<DefaultFeeTransition>(&mut v1.curve_fee_transition);
        0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::config::update_default_fee_for_curve<T0>(arg1, &arg0.dao_cap, v2.total_fee_bps, v2.hive_fee_percent);
        let v3 = ProposalExecuted{
            proposal_id   : v1.proposal_id,
            proposal_type : v1.proposal_type,
            yes_votes     : v1.yes_votes,
            no_votes      : v1.no_votes,
        };
        0x2::event::emit<ProposalExecuted>(v3);
    }

    public entry fun executeProposal_hSuiVault_transition(arg0: &mut HiveDaoGovernor, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xb696209dc96651350162267ee1ce5dfb28af84f19872d97898de083c73676a66::hsui_vault::HSuiVault, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg4);
        assert!(arg0.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg3), 9005);
        let v1 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg3);
        assert!(v1.proposal_type == 9 && v1.proposal_status == 3 && v0 >= v1.execution_start_epoch && v0 <= v1.execution_end_epoch, 9009);
        let v2 = 0x1::option::extract<HSuiVaultConfigTransition>(&mut v1.hsui_vault_config_transition);
        if (0x1::vector::length<address>(&v2.validators_list) > 0) {
            0xb696209dc96651350162267ee1ce5dfb28af84f19872d97898de083c73676a66::hsui_vault::update_validator_list(&arg0.dao_cap, arg1, arg2, v2.validators_list, v2.to_add);
        };
        if (v2.protocol_fee_percent > 0 || v2.service_fee_percent > 0) {
            0xb696209dc96651350162267ee1ce5dfb28af84f19872d97898de083c73676a66::hsui_vault::update_global_fee_config(&arg0.dao_cap, arg2, v2.protocol_fee_percent, v2.service_fee_percent, v2.treasury_percent);
        };
        if (v2.execute_emergency_operation) {
            0xb696209dc96651350162267ee1ce5dfb28af84f19872d97898de083c73676a66::hsui_vault::emergency_pause_update(&arg0.dao_cap, arg2, v2.pause_stake);
        };
        let v3 = ProposalExecuted{
            proposal_id   : v1.proposal_id,
            proposal_type : v1.proposal_type,
            yes_votes     : v1.yes_votes,
            no_votes      : v1.no_votes,
        };
        0x2::event::emit<ProposalExecuted>(v3);
    }

    public entry fun executeProposal_kraft_dof_for_new_hive_app(arg0: &mut HiveDaoGovernor, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        assert!(arg0.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg1), 9005);
        let v1 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg1);
        assert!(v1.proposal_type == 10 && v1.proposal_status == 3 && v0 >= v1.execution_start_epoch && v0 <= v1.execution_end_epoch, 9009);
        let v2 = 0x1::option::extract<KraftDofForNewHiveApp>(&mut v1.kraft_dof_for_new_hive_app);
        let v3 = HiveProfileDoFAccessCap{
            id                 : 0x2::object::new(arg2),
            name               : v2.name,
            only_profile_owner : v2.only_profile_owner,
            module_version     : 0,
        };
        0x2::transfer::public_transfer<HiveProfileDoFAccessCap>(v3, v2.recepient);
        let v4 = ProposalExecuted{
            proposal_id   : v1.proposal_id,
            proposal_type : v1.proposal_type,
            yes_votes     : v1.yes_votes,
            no_votes      : v1.no_votes,
        };
        0x2::event::emit<ProposalExecuted>(v4);
    }

    public entry fun executeProposal_pool_kraft_fee_transition(arg0: &mut HiveDaoGovernor, arg1: u64, arg2: &mut 0x633cdde221900399bce986ed3478b993bb1461a5c8712c9f47178b464e94c6ee::oracle::HiveOracle, arg3: &mut 0x633cdde221900399bce986ed3478b993bb1461a5c8712c9f47178b464e94c6ee::two_pool::PoolRegistry, arg4: &mut 0xe353ed42406acd60e126437b2b3d11d758aa335fe57d81ff56d9b1391549ffea::three_pool::PoolRegistry, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg5);
        assert!(arg0.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg1), 9005);
        let v1 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg1);
        assert!(v1.proposal_type == 4 && v1.proposal_status == 3 && v0 >= v1.execution_start_epoch && v0 <= v1.execution_end_epoch, 9009);
        let v2 = 0x1::option::extract<PoolKraftFeeTransition>(&mut v1.pool_kraft_fee_transition);
        if (v2.for_2_amm) {
            0x633cdde221900399bce986ed3478b993bb1461a5c8712c9f47178b464e94c6ee::two_pool::update_pool_kraft_fee(arg3, &arg0.dao_cap, v2.new_fee);
        };
        if (v2.to_update_oracle) {
            0x633cdde221900399bce986ed3478b993bb1461a5c8712c9f47178b464e94c6ee::oracle::update_hive_oracle(&arg0.dao_cap, arg2, v2.new_sui_hive_pool_addr, v2.new_usdc_sui_pool_addr, arg5);
        };
        if (v2.for_3_amm) {
            0xe353ed42406acd60e126437b2b3d11d758aa335fe57d81ff56d9b1391549ffea::three_pool::update_pool_kraft_fee(arg4, &arg0.dao_cap, v2.new_fee);
        };
        let v3 = ProposalExecuted{
            proposal_id   : v1.proposal_id,
            proposal_type : v1.proposal_type,
            yes_votes     : v1.yes_votes,
            no_votes      : v1.no_votes,
        };
        0x2::event::emit<ProposalExecuted>(v3);
    }

    public entry fun executeProposal_pools_governor_transition(arg0: &mut HiveDaoGovernor, arg1: &mut 0x5a2a29930f7c79778cebecd347035b12c0ca2bf14c00bb8c5b9b3c502ff3ca75::dex_dao::PoolsGovernor, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg3);
        assert!(arg0.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg2), 9005);
        let v1 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg2);
        assert!(v1.proposal_type == 5 && v1.proposal_status == 3 && v0 >= v1.execution_start_epoch && v0 <= v1.execution_end_epoch, 9009);
        let v2 = 0x1::option::extract<PoolsGovernorTransition>(&mut v1.pools_governor_transition);
        0x5a2a29930f7c79778cebecd347035b12c0ca2bf14c00bb8c5b9b3c502ff3ca75::dex_dao::update_pools_governance_params(arg1, &arg0.dao_cap, v2.new_params);
        let v3 = ProposalExecuted{
            proposal_id   : v1.proposal_id,
            proposal_type : v1.proposal_type,
            yes_votes     : v1.yes_votes,
            no_votes      : v1.no_votes,
        };
        0x2::event::emit<ProposalExecuted>(v3);
    }

    public entry fun executeProposal_stable_update_identifier(arg0: &mut HiveDaoGovernor, arg1: &mut 0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::config::Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg3);
        assert!(arg0.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg2), 9005);
        let v1 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg2);
        assert!(v1.proposal_type == 1 && v1.proposal_status == 3 && v0 >= v1.execution_start_epoch && v0 <= v1.execution_end_epoch, 9009);
        let v2 = 0x1::option::extract<AddStableIdentifierTransition>(&mut v1.config_stable_identifier_transition);
        if (v2.to_add) {
            0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::config::add_stable_identifier(arg1, &arg0.dao_cap, 0x1::type_name::into_string(v2.identifier_type_name));
        } else {
            0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::config::remove_stable_identifier(arg1, &arg0.dao_cap, 0x1::type_name::into_string(v2.identifier_type_name));
        };
        let v3 = ProposalExecuted{
            proposal_id   : v1.proposal_id,
            proposal_type : v1.proposal_type,
            yes_votes     : v1.yes_votes,
            no_votes      : v1.no_votes,
        };
        0x2::event::emit<ProposalExecuted>(v3);
    }

    public entry fun executeProposal_treasury_transition<T0>(arg0: &mut HiveDaoGovernor, arg1: &mut 0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::config::Config, arg2: u64, arg3: &mut 0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::config::Treasury<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg4);
        assert!(arg0.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg2), 9005);
        let v1 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg2);
        assert!(v1.proposal_type == 3 && v1.proposal_status == 3 && v0 >= v1.execution_start_epoch && v0 <= v1.execution_end_epoch, 9009);
        let v2 = 0x1::option::extract<AccessTreasury>(&mut v1.treasury_transition);
        if (v2.new_treasury_percent > 0) {
            0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::config::update_treasury_percent(arg1, &arg0.dao_cap, v2.new_treasury_percent);
        };
        if (v2.to_distribute > 0) {
            0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::config::distribute_treasury_resources<T0>(&arg0.dao_cap, arg3, v2.to_distribute, v2.recepient, arg4);
        };
        let v3 = ProposalExecuted{
            proposal_id   : v1.proposal_id,
            proposal_type : v1.proposal_type,
            yes_votes     : v1.yes_votes,
            no_votes      : v1.no_votes,
        };
        0x2::event::emit<ProposalExecuted>(v3);
    }

    public entry fun executeProposal_update_hivepoints_transition(arg0: &mut HiveDaoGovernor, arg1: &mut 0x5a2a29930f7c79778cebecd347035b12c0ca2bf14c00bb8c5b9b3c502ff3ca75::dex_dao::PoolsGovernor, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg3);
        assert!(arg0.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg2), 9005);
        let v1 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg2);
        assert!(v1.proposal_type == 6 && v1.proposal_status == 3 && v0 >= v1.execution_start_epoch && v0 <= v1.execution_end_epoch, 9009);
        let v2 = 0x1::option::extract<PoolHivePointsTransition>(&mut v1.pool_hivepoints_transition);
        let v3 = 0x1::vector::empty<address>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(&v2.pool_hive_addrs)) {
            0x1::vector::push_back<address>(&mut v3, *0x1::vector::borrow<address>(&v2.pool_hive_addrs, v4));
            v4 = v4 + 1;
        };
        if (v2.to_update_hive_per_epoch) {
            0x5a2a29930f7c79778cebecd347035b12c0ca2bf14c00bb8c5b9b3c502ff3ca75::dex_dao::update_gems_per_epoch(arg1, &arg0.dao_cap, v2.new_hive_per_epoch);
        };
        0x5a2a29930f7c79778cebecd347035b12c0ca2bf14c00bb8c5b9b3c502ff3ca75::dex_dao::update_pool_hive_points(arg1, &arg0.dao_cap, v3, v2.points_for_pool_hives);
        let v5 = ProposalExecuted{
            proposal_id   : v1.proposal_id,
            proposal_type : v1.proposal_type,
            yes_votes     : v1.yes_votes,
            no_votes      : v1.no_votes,
        };
        0x2::event::emit<ProposalExecuted>(v5);
    }

    public entry fun executeProposal_update_profile_config_transition(arg0: &mut HiveDaoGovernor, arg1: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg3);
        assert!(arg0.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg2), 9005);
        let v1 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg2);
        assert!(v1.proposal_type == 7 && v1.proposal_status == 3 && v0 >= v1.execution_start_epoch && v0 <= v1.execution_end_epoch, 9009);
        let v2 = 0x1::option::extract<ProfileConfigTransition>(&mut v1.profile_config_transition);
        if (v2.new_max_bids > 0 || v2.new_min_bid > 0 || v2.new_profile_kraft_fee > 0) {
            0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::update_profile_config_params(&arg0.dao_cap, arg1, v2.new_max_bids, v2.new_min_bid, v2.new_profile_kraft_fee, v2.social_fee_gems, v2.social_multiplier_for_gems, v2.social_multiplier_for_power);
        };
        if (v2.royalty_num > 0 || v2.royalty_denom > 0 || v2.assets_dispersal_percent > 0 || v2.creators_royalty_percent > 0) {
            0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::update_royalty(&arg0.dao_cap, arg1, v2.royalty_num, v2.royalty_denom, v2.assets_dispersal_percent, v2.creators_royalty_percent, v2.gems_royalty_num, v2.gems_royalty_denom, v2.gems_treasury_percent, v2.gems_burn_percent);
        };
        let v3 = ProposalExecuted{
            proposal_id   : v1.proposal_id,
            proposal_type : v1.proposal_type,
            yes_votes     : v1.yes_votes,
            no_votes      : v1.no_votes,
        };
        0x2::event::emit<ProposalExecuted>(v3);
    }

    public entry fun increment_hive_governor(arg0: &mut HiveDaoGovernor) {
        assert!(arg0.module_version < 0, 9018);
        arg0.module_version = 0;
    }

    public entry fun increment_hive_skin_kraft_cap(arg0: &mut HiveSkinKraftCap) {
        assert!(arg0.module_version < 0, 9018);
        arg0.module_version = 0;
    }

    public entry fun infuse_gems_into_asset(arg0: &0x2::clock::Clock, arg1: &mut HiveDaoGovernor, arg2: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveManager, arg3: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HSuiDisperser<0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::hsui::HSUI>, arg4: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveDisperser, arg5: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveProfile, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 9017);
        let (v0, v1) = 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::infuse_gems_into_asset(arg0, &arg1.dao_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        arg1.total_power = arg1.total_power + (v0 as u128) - (v1 as u128);
    }

    fun init(arg0: HIVE_DAO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"HIVE DAO ::init() FUNCTION -::- ");
        0x1::debug::print<0x1::string::String>(&v0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Overview"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"DegenHive - Skin"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        let v5 = 0x2::package::claim<HIVE_DAO>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<HiveSkinKraftCap>(&v5, v1, v3, arg1);
        0x2::display::update_version<HiveSkinKraftCap>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<HiveSkinKraftCap>>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun init_hive_dao(arg0: &0x2::clock::Clock, arg1: 0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::config::HiveDaoCapability, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xb696209dc96651350162267ee1ce5dfb28af84f19872d97898de083c73676a66::hsui_vault::HSuiVault, arg4: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveProfileMappingStore, arg5: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveManager, arg6: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HSuiDisperser<0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::hsui::HSUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"HIVE DAO ::init_hive_dao() FUNCTION -::- ");
        0x1::debug::print<0x1::string::String>(&v0);
        let (v1, v2) = 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::kraft_owned_hive_profile(arg0, arg2, arg3, arg4, arg5, arg6, arg7, 0x1::string::utf8(b"HiveGovernor"), 0x1::string::utf8(b"Whoever controls the HiveGovernor, controls the HiveDAO!"), arg15);
        let v3 = v1;
        let v4 = HiveGovernorBuzzes{
            id              : 0x2::object::new(arg15),
            governor_buzzes : 0x2::linked_table::new<u64, GovernorBuzz>(arg15),
            count           : 0,
        };
        0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::entry_add_to_composable_profile<HiveGovernorBuzzes>(&mut v3, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")), v4);
        let v5 = VoteConfig{
            proposal_required_deposit   : arg8,
            voting_start_delay          : arg9,
            voting_period_length        : arg10,
            execution_delay             : arg11,
            execution_period_length     : arg12,
            proposal_required_quorum    : 0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::math::mul_div(1000000, arg13, 100),
            proposal_approval_threshold : 0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::math::mul_div(1000000, arg14, 100),
        };
        let v6 = HiveDaoGovernor{
            id               : 0x2::object::new(arg15),
            dao_cap          : arg1,
            governor_profile : v3,
            managed_buzzes   : 0x2::linked_table::new<0x1::ascii::String, SystemBuzz>(arg15),
            total_power      : 0,
            next_proposal_id : 1,
            proposal_list    : 0x2::linked_table::new<u64, Proposal>(arg15),
            supported_skins  : 0x2::linked_table::new<0x1::string::String, HiveSkin>(arg15),
            vote_config      : v5,
            module_version   : 0,
        };
        0x2::transfer::share_object<HiveDaoGovernor>(v6);
        0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v2, 0x2::tx_context::sender(arg15), arg15);
    }

    fun init_proposal(arg0: u64, arg1: u64, arg2: address, arg3: 0x2::balance::Balance<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &VoteConfig, arg8: &mut 0x2::tx_context::TxContext) : Proposal {
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
            votes                               : 0x2::table::new<address, Vote>(arg8),
            kraft_dof_for_new_hive_app          : 0x1::option::none<KraftDofForNewHiveApp>(),
            config_add_coins_transition         : 0x1::option::none<AddPrecisionForCoinsTransition>(),
            config_stable_identifier_transition : 0x1::option::none<AddStableIdentifierTransition>(),
            curve_fee_transition                : 0x1::option::none<DefaultFeeTransition>(),
            treasury_transition                 : 0x1::option::none<AccessTreasury>(),
            hsui_vault_config_transition        : 0x1::option::none<HSuiVaultConfigTransition>(),
            pool_kraft_fee_transition           : 0x1::option::none<PoolKraftFeeTransition>(),
            pools_governor_transition           : 0x1::option::none<PoolsGovernorTransition>(),
            pool_hivepoints_transition          : 0x1::option::none<PoolHivePointsTransition>(),
            profile_config_transition           : 0x1::option::none<ProfileConfigTransition>(),
            add_new_skin_transition             : 0x1::option::none<AddNewSkinTransition>(),
        };
        let v1 = NewProposalCreated{
            proposal_id           : v0.proposal_id,
            proposer              : v0.proposer,
            title                 : v0.title,
            description           : v0.description,
            link                  : v0.link,
            voting_start_epoch    : v0.voting_start_epoch,
            voting_end_epoch      : v0.voting_end_epoch,
            execution_start_epoch : v0.execution_start_epoch,
            execution_end_epoch   : v0.execution_end_epoch,
        };
        0x2::event::emit<NewProposalCreated>(v1);
        v0
    }

    public fun initialize_skin_for_asset(arg0: &mut HiveDaoGovernor, arg1: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveProfile, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<0x1::string::String, HiveSkin>(&arg0.supported_skins, arg2), 9003);
        let v0 = 0x2::linked_table::borrow_mut<0x1::string::String, HiveSkin>(&mut arg0.supported_skins, arg2);
        0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::initialize_skin_for_asset(&arg0.dao_cap, arg1, arg3, arg2, v0.public_skin_kraft_enabled, v0.only_subscribers_allowed, v0.subscribers_discount, v0.royalty_fee_percent, arg4);
    }

    public entry fun interact_with_governance_buzz(arg0: &mut HiveDaoGovernor, arg1: &0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveProfile, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::get_profile_meta_info(arg1);
        assert!(v2 || v3 == 0x2::tx_context::sender(arg4), 9020);
        let v4 = 0x2::linked_table::borrow_mut<u64, GovernorBuzz>(&mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::entry_borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes"))).governor_buzzes, arg2);
        if (0x2::linked_table::contains<address, Dialogue>(&v4.profile_buzzes, v0)) {
            0x2::linked_table::borrow_mut<address, Dialogue>(&mut v4.profile_buzzes, v0).buzz = arg3;
        } else {
            let v5 = Dialogue{
                buzz    : arg3,
                upvotes : 0x2::linked_table::new<address, bool>(arg4),
            };
            0x2::linked_table::push_back<address, Dialogue>(&mut v4.profile_buzzes, v0, v5);
        };
        let v6 = NewUserBuzzOnHiveDaoBuzzDetected{
            user_profile_addr : v0,
            buzz_index        : arg2,
            username          : v1,
            user_buzz         : arg3,
        };
        0x2::event::emit<NewUserBuzzOnHiveDaoBuzzDetected>(v6);
    }

    public fun kraft_new_skin(arg0: &mut HiveDaoGovernor, arg1: &0x2::clock::Clock, arg2: &HiveSkinKraftCap, arg3: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveDisperser, arg4: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveManager, arg5: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveProfile, arg6: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveProfile, arg7: 0x1::string::String, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (u64, 0x1::string::String, 0x1::string::String, vector<0x1::string::String>, vector<0x1::string::String>, 0x1::string::String, 0x1::string::String, u64) {
        assert!(arg0.module_version == 0 && arg2.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<0x1::string::String, HiveSkin>(&arg0.supported_skins, arg7), 9003);
        assert!(arg2.name == arg7, 9002);
        let v0 = 0x2::linked_table::borrow_mut<0x1::string::String, HiveSkin>(&mut arg0.supported_skins, arg7);
        let (v1, v2, v3, v4, v5, v6, v7, v8) = 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::kraft_new_skin_for_asset(&arg0.dao_cap, arg1, arg4, arg3, arg5, arg6, arg8, arg7, v0.max_skins_per_asset, v0.base_price, arg9);
        v0.total_assets_krafted = v0.total_assets_krafted + 1;
        (v3, v4, v5, v6, v7, v1, v2, v8)
    }

    public fun like_governor_buzz(arg0: &mut HiveDaoGovernor, arg1: &0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveProfile, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::get_profile_meta_info(arg1);
        assert!(v2 || v3 == 0x2::tx_context::sender(arg3), 9020);
        let v4 = 0x2::linked_table::borrow_mut<u64, GovernorBuzz>(&mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::entry_borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes"))).governor_buzzes, arg2);
        assert!(!0x2::linked_table::contains<address, bool>(&v4.likes, v0), 9021);
        let v5 = UserLikedHiveDaoBuzz{
            user_profile_addr : v0,
            username          : v1,
            buzz_index        : arg2,
        };
        0x2::event::emit<UserLikedHiveDaoBuzz>(v5);
        0x2::linked_table::push_back<address, bool>(&mut v4.likes, v0, true);
    }

    public entry fun lock_hive_asset(arg0: &0x2::clock::Clock, arg1: &mut HiveDaoGovernor, arg2: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveManager, arg3: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HSuiDisperser<0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::hsui::HSUI>, arg4: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveDisperser, arg5: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveProfile, arg6: u64, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 9017);
        arg1.total_power = arg1.total_power + (0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::lock_hive_asset(arg0, &arg1.dao_cap, arg2, arg3, arg4, arg5, arg6, arg7, arg8) as u128);
    }

    fun make_new_governor_buzz(arg0: &mut HiveGovernorBuzzes, arg1: 0x1::string::String, arg2: 0x1::option::Option<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg1) < 2400, 9023);
        let v0 = arg0.count;
        let v1 = GovernorBuzz{
            buzz           : arg1,
            gen_ai         : arg2,
            likes          : 0x2::linked_table::new<address, bool>(arg3),
            profile_buzzes : 0x2::linked_table::new<address, Dialogue>(arg3),
        };
        0x2::linked_table::push_back<u64, GovernorBuzz>(&mut arg0.governor_buzzes, v0, v1);
        arg0.count = arg0.count + 1;
        let v2 = NewHiveGovernanceBuzz{
            buzz_index : v0,
            buzz       : arg1,
            gen_ai     : arg2,
        };
        0x2::event::emit<NewHiveGovernanceBuzz>(v2);
    }

    public fun make_proposal_add_precision_for_coins_transition(arg0: &mut HiveDaoGovernor, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>, arg5: vector<0x1::string::String>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::tx_context::epoch(arg7);
        assert!(arg0.module_version == 0, 9017);
        let v2 = 0x2::coin::into_balance<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(arg4);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(&v2), 9019);
        let v3 = init_proposal(v1, arg0.next_proposal_id, v0, 0x2::balance::split<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(&mut v2, arg0.vote_config.proposal_required_deposit), arg1, arg2, arg3, &arg0.vote_config, arg7);
        let v4 = AddPrecisionForCoinsTransition{
            coin_identifiers : arg5,
            decimals         : arg6,
        };
        v3.config_add_coins_transition = 0x1::option::some<AddPrecisionForCoinsTransition>(v4);
        v3.proposal_type = 0;
        let v5 = 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, 0x1::string::to_ascii(0x1::string::utf8(b"ADD_PRECISION_FOR_COINS_TRANSITION")));
        let v6 = make_propsoal_buzz(v5.buzz, &v3);
        let v7 = 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::entry_borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")));
        make_new_governor_buzz(v7, v6, v5.gen_ai, arg7);
        let v8 = AddPrecisionForCoinsProposalKrafted{
            proposal_id      : v3.proposal_id,
            coin_identifiers : arg5,
            decimals         : arg6,
        };
        0x2::event::emit<AddPrecisionForCoinsProposalKrafted>(v8);
        0x2::linked_table::push_back<u64, Proposal>(&mut arg0.proposal_list, v3.proposal_id, v3);
        arg0.next_proposal_id = arg0.next_proposal_id + 1;
        0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::coin_helper::destroy_or_transfer_balance<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(v2, v0, arg7);
    }

    public fun make_proposal_add_skin_transition(arg0: &mut HiveDaoGovernor, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x2::table::Table<0x1::string::String, vector<0x1::string::String>>, arg9: u64, arg10: bool, arg11: u64, arg12: u64, arg13: bool, arg14: u64, arg15: address, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg16);
        let v1 = 0x2::tx_context::epoch(arg16);
        assert!(arg0.module_version == 0, 9017);
        assert!(!0x2::linked_table::contains<0x1::string::String, HiveSkin>(&arg0.supported_skins, arg5), 9012);
        let v2 = 0x2::coin::into_balance<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(arg4);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(&v2), 9019);
        let v3 = init_proposal(v1, arg0.next_proposal_id, v0, 0x2::balance::split<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(&mut v2, arg0.vote_config.proposal_required_deposit), arg1, arg2, arg3, &arg0.vote_config, arg16);
        let v4 = AddNewSkinTransition{
            name                      : arg5,
            url                       : arg6,
            description               : arg7,
            supported_asset_types     : arg8,
            max_skins_per_asset       : arg9,
            only_subscribers_allowed  : arg10,
            subscribers_discount      : arg11,
            public_skin_kraft_enabled : arg13,
            royalty_fee_percent       : arg14,
            base_price                : arg12,
            cap_recepient             : arg15,
        };
        0x1::option::fill<AddNewSkinTransition>(&mut v3.add_new_skin_transition, v4);
        v3.proposal_type = 8;
        let v5 = 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, 0x1::string::to_ascii(0x1::string::utf8(b"ADD_NEW_SKIN_TRANSITION")));
        let v6 = make_propsoal_buzz(v5.buzz, &v3);
        let v7 = 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::entry_borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")));
        make_new_governor_buzz(v7, v6, v5.gen_ai, arg16);
        let v8 = AddNewSkinTransitionProposalKrafted{
            proposal_id               : v3.proposal_id,
            name                      : arg5,
            url                       : arg6,
            description               : arg7,
            max_skins_per_asset       : arg9,
            only_subscribers_allowed  : arg10,
            subscribers_discount      : arg11,
            public_skin_kraft_enabled : arg13,
            royalty_fee_percent       : arg14,
            base_price                : arg12,
            cap_recepient             : arg15,
        };
        0x2::event::emit<AddNewSkinTransitionProposalKrafted>(v8);
        0x2::linked_table::push_back<u64, Proposal>(&mut arg0.proposal_list, v3.proposal_id, v3);
        arg0.next_proposal_id = arg0.next_proposal_id + 1;
        0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::coin_helper::destroy_or_transfer_balance<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(v2, v0, arg16);
    }

    public fun make_proposal_curve_fee_transition<T0>(arg0: &mut HiveDaoGovernor, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::tx_context::epoch(arg7);
        assert!(arg0.module_version == 0, 9017);
        let v2 = 0x2::coin::into_balance<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(arg4);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(&v2), 9019);
        let v3 = init_proposal(v1, arg0.next_proposal_id, v0, 0x2::balance::split<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(&mut v2, arg0.vote_config.proposal_required_deposit), arg1, arg2, arg3, &arg0.vote_config, arg7);
        if (arg5 > 0) {
            assert!(arg5 >= 1 && arg5 <= 100, 9016);
        };
        if (arg6 > 0) {
            assert!(arg6 >= 30 && arg6 <= 50, 9016);
        };
        let v4 = DefaultFeeTransition{
            curve_type       : 0x1::type_name::get<T0>(),
            total_fee_bps    : arg5,
            hive_fee_percent : arg6,
        };
        v3.curve_fee_transition = 0x1::option::some<DefaultFeeTransition>(v4);
        v3.proposal_type = 2;
        let v5 = 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, 0x1::string::to_ascii(0x1::string::utf8(b"CURVE_FEE_TRANSITION")));
        let v6 = make_propsoal_buzz(v5.buzz, &v3);
        let v7 = 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::entry_borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")));
        make_new_governor_buzz(v7, v6, v5.gen_ai, arg7);
        let v8 = DefaultFeeTransitionProposalKrafted{
            proposal_id      : v3.proposal_id,
            curve_type       : 0x1::type_name::get<T0>(),
            total_fee_bps    : arg5,
            hive_fee_percent : arg6,
        };
        0x2::event::emit<DefaultFeeTransitionProposalKrafted>(v8);
        0x2::linked_table::push_back<u64, Proposal>(&mut arg0.proposal_list, v3.proposal_id, v3);
        arg0.next_proposal_id = arg0.next_proposal_id + 1;
        0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::coin_helper::destroy_or_transfer_balance<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(v2, v0, arg7);
    }

    public fun make_proposal_install_app(arg0: &mut HiveDaoGovernor, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>, arg5: address, arg6: 0x1::string::String, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 9017);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::tx_context::epoch(arg8);
        let v2 = 0x2::coin::into_balance<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(arg4);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(&v2), 9019);
        let v3 = init_proposal(v1, arg0.next_proposal_id, v0, 0x2::balance::split<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(&mut v2, arg0.vote_config.proposal_required_deposit), arg1, arg2, arg3, &arg0.vote_config, arg8);
        let v4 = KraftDofForNewHiveApp{
            name               : arg6,
            only_profile_owner : arg7,
            recepient          : arg5,
        };
        v3.kraft_dof_for_new_hive_app = 0x1::option::some<KraftDofForNewHiveApp>(v4);
        v3.proposal_type = 10;
        let v5 = 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, 0x1::string::to_ascii(0x1::string::utf8(b"INSTALL_APP_TO_HIVE_PROFILE")));
        let v6 = make_propsoal_buzz(v5.buzz, &v3);
        let v7 = 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::entry_borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")));
        make_new_governor_buzz(v7, v6, v5.gen_ai, arg8);
        let v8 = NewHiveAppAddedToDegenHive{
            proposal_id        : v3.proposal_id,
            recepient          : arg5,
            app_name           : arg6,
            only_profile_owner : arg7,
        };
        0x2::event::emit<NewHiveAppAddedToDegenHive>(v8);
        0x2::linked_table::push_back<u64, Proposal>(&mut arg0.proposal_list, v3.proposal_id, v3);
        arg0.next_proposal_id = arg0.next_proposal_id + 1;
        0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::coin_helper::destroy_or_transfer_balance<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(v2, v0, arg8);
    }

    public fun make_proposal_lsd_module_transition(arg0: &mut HiveDaoGovernor, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>, arg5: vector<address>, arg6: bool, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = 0x2::tx_context::epoch(arg12);
        assert!(arg0.module_version == 0, 9017);
        let v2 = 0x2::coin::into_balance<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(arg4);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(&v2), 9019);
        let v3 = init_proposal(v1, arg0.next_proposal_id, v0, 0x2::balance::split<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(&mut v2, arg0.vote_config.proposal_required_deposit), arg1, arg2, arg3, &arg0.vote_config, arg12);
        let v4 = HSuiVaultConfigTransition{
            validators_list             : arg5,
            to_add                      : arg6,
            protocol_fee_percent        : arg7,
            service_fee_percent         : arg8,
            treasury_percent            : arg9,
            execute_emergency_operation : arg10,
            pause_stake                 : arg11,
        };
        v3.hsui_vault_config_transition = 0x1::option::some<HSuiVaultConfigTransition>(v4);
        v3.proposal_type = 9;
        let v5 = 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, 0x1::string::to_ascii(0x1::string::utf8(b"HSUI_VAULT_CONFIG_TRANSITION")));
        let v6 = make_propsoal_buzz(v5.buzz, &v3);
        let v7 = 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::entry_borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")));
        make_new_governor_buzz(v7, v6, v5.gen_ai, arg12);
        let v8 = HSuiVaultTransitionProposalKrafted{
            validators_list             : arg5,
            to_add                      : arg6,
            protocol_fee_percent        : arg7,
            service_fee_percent         : arg8,
            treasury_percent            : arg9,
            execute_emergency_operation : arg10,
            pause_stake                 : arg11,
        };
        0x2::event::emit<HSuiVaultTransitionProposalKrafted>(v8);
        0x2::linked_table::push_back<u64, Proposal>(&mut arg0.proposal_list, v3.proposal_id, v3);
        arg0.next_proposal_id = arg0.next_proposal_id + 1;
        0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::coin_helper::destroy_or_transfer_balance<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(v2, v0, arg12);
    }

    public fun make_proposal_pool_kraft_fee_transition(arg0: &mut HiveDaoGovernor, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>, arg5: u64, arg6: bool, arg7: bool, arg8: bool, arg9: 0x1::option::Option<address>, arg10: 0x1::option::Option<address>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x2::tx_context::epoch(arg11);
        assert!(arg0.module_version == 0, 9017);
        let v2 = 0x2::coin::into_balance<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(arg4);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(&v2), 9019);
        let v3 = init_proposal(v1, arg0.next_proposal_id, v0, 0x2::balance::split<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(&mut v2, arg0.vote_config.proposal_required_deposit), arg1, arg2, arg3, &arg0.vote_config, arg11);
        let v4 = PoolKraftFeeTransition{
            new_fee                : arg5,
            for_2_amm              : arg6,
            for_3_amm              : arg7,
            to_update_oracle       : arg8,
            new_sui_hive_pool_addr : arg9,
            new_usdc_sui_pool_addr : arg9,
        };
        v3.pool_kraft_fee_transition = 0x1::option::some<PoolKraftFeeTransition>(v4);
        v3.proposal_type = 4;
        let v5 = 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, 0x1::string::to_ascii(0x1::string::utf8(b"POOL_KRAFT_FEE_TRANSITION")));
        let v6 = make_propsoal_buzz(v5.buzz, &v3);
        let v7 = 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::entry_borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")));
        make_new_governor_buzz(v7, v6, v5.gen_ai, arg11);
        let v8 = PoolKraftFeeTransitionProposalKrafted{
            proposal_id            : v3.proposal_id,
            new_fee                : arg5,
            for_2_amm              : arg6,
            for_3_amm              : arg7,
            to_update_oracle       : arg8,
            new_sui_hive_pool_addr : arg9,
            new_usdc_sui_pool_addr : arg10,
        };
        0x2::event::emit<PoolKraftFeeTransitionProposalKrafted>(v8);
        0x2::linked_table::push_back<u64, Proposal>(&mut arg0.proposal_list, v3.proposal_id, v3);
        arg0.next_proposal_id = arg0.next_proposal_id + 1;
        0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::coin_helper::destroy_or_transfer_balance<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(v2, v0, arg11);
    }

    public fun make_proposal_pools_governor_transition(arg0: &mut HiveDaoGovernor, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>, arg5: vector<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::tx_context::epoch(arg6);
        assert!(arg0.module_version == 0, 9017);
        assert!(0x1::vector::length<u64>(&arg5) == 8, 9014);
        let v2 = 0x2::coin::into_balance<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(arg4);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(&v2), 9019);
        let v3 = init_proposal(v1, arg0.next_proposal_id, v0, 0x2::balance::split<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(&mut v2, arg0.vote_config.proposal_required_deposit), arg1, arg2, arg3, &arg0.vote_config, arg6);
        let v4 = PoolsGovernorTransition{new_params: arg5};
        v3.pools_governor_transition = 0x1::option::some<PoolsGovernorTransition>(v4);
        v3.proposal_type = 5;
        let v5 = 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, 0x1::string::to_ascii(0x1::string::utf8(b"POOLS_GOVERNOR_TRANSITION")));
        let v6 = make_propsoal_buzz(v5.buzz, &v3);
        let v7 = 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::entry_borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")));
        make_new_governor_buzz(v7, v6, v5.gen_ai, arg6);
        let v8 = PoolsGovernorTransitionProposalKrafted{
            proposal_id : v3.proposal_id,
            new_params  : arg5,
        };
        0x2::event::emit<PoolsGovernorTransitionProposalKrafted>(v8);
        0x2::linked_table::push_back<u64, Proposal>(&mut arg0.proposal_list, v3.proposal_id, v3);
        arg0.next_proposal_id = arg0.next_proposal_id + 1;
        0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::coin_helper::destroy_or_transfer_balance<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(v2, v0, arg6);
    }

    public fun make_proposal_stable_identifier_transition<T0>(arg0: &mut HiveDaoGovernor, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::tx_context::epoch(arg6);
        let v2 = 0x1::type_name::get<T0>();
        assert!(arg0.module_version == 0, 9017);
        let v3 = 0x2::coin::into_balance<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(arg4);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(&v3), 9019);
        let v4 = init_proposal(v1, arg0.next_proposal_id, v0, 0x2::balance::split<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(&mut v3, arg0.vote_config.proposal_required_deposit), arg1, arg2, arg3, &arg0.vote_config, arg6);
        let v5 = AddStableIdentifierTransition{
            identifier_type_name : v2,
            to_add               : arg5,
        };
        v4.config_stable_identifier_transition = 0x1::option::some<AddStableIdentifierTransition>(v5);
        v4.proposal_type = 1;
        let v6 = 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, 0x1::string::to_ascii(0x1::string::utf8(b"ADD_STABLE_IDENTIFIER_TRANSITION")));
        let v7 = make_propsoal_buzz(v6.buzz, &v4);
        let v8 = 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::entry_borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")));
        make_new_governor_buzz(v8, v7, v6.gen_ai, arg6);
        let v9 = IdentifierTransitionProposalKrafted{
            proposal_id          : v4.proposal_id,
            identifier_type_name : v2,
            to_add               : arg5,
        };
        0x2::event::emit<IdentifierTransitionProposalKrafted>(v9);
        0x2::linked_table::push_back<u64, Proposal>(&mut arg0.proposal_list, v4.proposal_id, v4);
        arg0.next_proposal_id = arg0.next_proposal_id + 1;
        0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::coin_helper::destroy_or_transfer_balance<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(v3, v0, arg6);
    }

    public fun make_proposal_treasury_transition(arg0: &mut HiveDaoGovernor, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>, arg5: u64, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::tx_context::epoch(arg8);
        assert!(arg0.module_version == 0, 9017);
        if (arg5 > 0) {
            assert!(arg5 >= 5 && arg5 <= 25, 9015);
        };
        let v2 = 0x2::coin::into_balance<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(arg4);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(&v2), 9019);
        let v3 = init_proposal(v1, arg0.next_proposal_id, v0, 0x2::balance::split<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(&mut v2, arg0.vote_config.proposal_required_deposit), arg1, arg2, arg3, &arg0.vote_config, arg8);
        let v4 = AccessTreasury{
            new_treasury_percent : arg5,
            to_distribute        : arg6,
            recepient            : arg7,
        };
        v3.treasury_transition = 0x1::option::some<AccessTreasury>(v4);
        v3.proposal_type = 3;
        let v5 = 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, 0x1::string::to_ascii(0x1::string::utf8(b"TREASURY_TRANSITION")));
        let v6 = make_propsoal_buzz(v5.buzz, &v3);
        let v7 = 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::entry_borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")));
        make_new_governor_buzz(v7, v6, v5.gen_ai, arg8);
        let v8 = TreasuryTransitionProposalKrafted{
            proposal_id          : v3.proposal_id,
            new_treasury_percent : arg5,
            to_distribute        : arg6,
            recepient            : arg7,
        };
        0x2::event::emit<TreasuryTransitionProposalKrafted>(v8);
        0x2::linked_table::push_back<u64, Proposal>(&mut arg0.proposal_list, v3.proposal_id, v3);
        arg0.next_proposal_id = arg0.next_proposal_id + 1;
        0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::coin_helper::destroy_or_transfer_balance<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(v2, v0, arg8);
    }

    public fun make_proposal_update_hivepoints_transition(arg0: &mut HiveDaoGovernor, arg1: &0x5a2a29930f7c79778cebecd347035b12c0ca2bf14c00bb8c5b9b3c502ff3ca75::dex_dao::PoolsGovernor, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x2::coin::Coin<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>, arg6: vector<address>, arg7: vector<u64>, arg8: bool, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::tx_context::epoch(arg10);
        assert!(arg0.module_version == 0, 9017);
        assert!(0x1::vector::length<address>(&arg6) == 0x1::vector::length<u64>(&arg7), 9011);
        assert!(0x5a2a29930f7c79778cebecd347035b12c0ca2bf14c00bb8c5b9b3c502ff3ca75::dex_dao::check_if_all_are_hives(arg1, arg6), 9013);
        let v2 = 0x2::coin::into_balance<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(arg5);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(&v2), 9019);
        let v3 = init_proposal(v1, arg0.next_proposal_id, v0, 0x2::balance::split<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(&mut v2, arg0.vote_config.proposal_required_deposit), arg2, arg3, arg4, &arg0.vote_config, arg10);
        let v4 = PoolHivePointsTransition{
            pool_hive_addrs          : arg6,
            points_for_pool_hives    : arg7,
            to_update_hive_per_epoch : arg8,
            new_hive_per_epoch       : arg9,
        };
        v3.pool_hivepoints_transition = 0x1::option::some<PoolHivePointsTransition>(v4);
        v3.proposal_type = 6;
        let v5 = 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, 0x1::string::to_ascii(0x1::string::utf8(b"POOL_HIVEPOINTS_TRANSITION")));
        let v6 = make_propsoal_buzz(v5.buzz, &v3);
        let v7 = 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::entry_borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")));
        make_new_governor_buzz(v7, v6, v5.gen_ai, arg10);
        let v8 = PoolHivePointsTransitionProposalKrafted{
            proposal_id              : v3.proposal_id,
            pool_hive_addrs          : arg6,
            points_for_pool_hives    : arg7,
            to_update_hive_per_epoch : arg8,
            new_hive_per_epoch       : arg9,
        };
        0x2::event::emit<PoolHivePointsTransitionProposalKrafted>(v8);
        0x2::linked_table::push_back<u64, Proposal>(&mut arg0.proposal_list, v3.proposal_id, v3);
        arg0.next_proposal_id = arg0.next_proposal_id + 1;
        0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::coin_helper::destroy_or_transfer_balance<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(v2, v0, arg10);
    }

    public fun make_proposal_update_profile_config_transition(arg0: &mut HiveDaoGovernor, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg19);
        let v1 = 0x2::tx_context::epoch(arg19);
        assert!(arg0.module_version == 0, 9017);
        let v2 = 0x2::coin::into_balance<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(arg4);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(&v2), 9019);
        let v3 = init_proposal(v1, arg0.next_proposal_id, v0, 0x2::balance::split<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(&mut v2, arg0.vote_config.proposal_required_deposit), arg1, arg2, arg3, &arg0.vote_config, arg19);
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
        let v5 = 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, 0x1::string::to_ascii(0x1::string::utf8(b"HIVE_MANAGER_TRANSITION")));
        let v6 = make_propsoal_buzz(v5.buzz, &v3);
        let v7 = 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::entry_borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes")));
        make_new_governor_buzz(v7, v6, v5.gen_ai, arg19);
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
        0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::coin_helper::destroy_or_transfer_balance<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(v2, v0, arg19);
    }

    fun make_propsoal_buzz(arg0: 0x1::string::String, arg1: &Proposal) : 0x1::string::String {
        0x1::string::append(&mut arg0, 0x1::string::utf8(x"0a0a"));
        0x1::string::append(&mut arg0, 0x1::string::utf8(b"Proposal ID: "));
        0x1::string::append(&mut arg0, 0x1::string::utf8(0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::coin_helper::u64_to_ascii(arg1.proposal_id)));
        0x1::string::append(&mut arg0, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut arg0, 0x1::string::utf8(b"Title: "));
        0x1::string::append(&mut arg0, arg1.title);
        0x1::string::append(&mut arg0, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut arg0, 0x1::string::utf8(b"Description: "));
        0x1::string::append(&mut arg0, arg1.description);
        0x1::string::append(&mut arg0, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut arg0, 0x1::string::utf8(b"Link: "));
        0x1::string::append(&mut arg0, arg1.link);
        0x1::string::append(&mut arg0, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut arg0, 0x1::string::utf8(b"Voting Start Epoch: "));
        0x1::string::append(&mut arg0, 0x1::string::utf8(0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::coin_helper::u64_to_ascii(arg1.voting_start_epoch)));
        0x1::string::append(&mut arg0, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut arg0, 0x1::string::utf8(b"Voting End Epoch: "));
        0x1::string::append(&mut arg0, 0x1::string::utf8(0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::coin_helper::u64_to_ascii(arg1.voting_end_epoch)));
        0x1::string::append(&mut arg0, 0x1::string::utf8(x"0a"));
        arg0
    }

    public fun port_gems_for_skin(arg0: &0x2::clock::Clock, arg1: &mut HiveDaoGovernor, arg2: &HiveSkinKraftCap, arg3: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveManager, arg4: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HSuiDisperser<0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::hsui::HSUI>, arg5: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveDisperser, arg6: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveProfile, arg7: 0x1::string::String, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::hive_gems::HiveGems {
        assert!(arg1.module_version == 0 && arg2.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<0x1::string::String, HiveSkin>(&arg1.supported_skins, arg7), 9003);
        assert!(arg2.name == arg7, 9002);
        let v0 = 0x2::linked_table::borrow_mut<0x1::string::String, HiveSkin>(&mut arg1.supported_skins, arg7);
        let (v1, v2) = 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::port_gems_via_asset(&arg1.dao_cap, arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        arg1.total_power = arg1.total_power - (v1 as u128);
        v0.total_hive_gems_ported = v0.total_hive_gems_ported + arg9;
        v2
    }

    public entry fun removeExpiredProposal(arg0: &mut HiveDaoGovernor, arg1: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HiveVault, arg2: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveDisperser, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg3), 9005);
        let v0 = 0x2::linked_table::remove<u64, Proposal>(&mut arg0.proposal_list, arg3);
        assert!(0x2::tx_context::epoch(arg4) > v0.execution_end_epoch, 9008);
        let (v1, _, v3, _, _, _, v7, _, _, _, _, v12, _, _, _, _, _, _, _, _, _, _, _, _) = destroy_proposal(v0);
        let v25 = v3;
        if (0x2::balance::value<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(&v25) > 0) {
            0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::deposit_gems_for_hive(arg2, 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::burn_hive_and_return_gems(arg1, v25, 0x2::tx_context::sender(arg4), arg4));
        } else {
            0x2::balance::destroy_zero<0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive::HIVE>(v25);
        };
        let v26 = ProposalDeleted{
            proposal_id     : v1,
            proposal_type   : v7,
            proposal_status : v12,
        };
        0x2::event::emit<ProposalDeleted>(v26);
    }

    public fun unlike_governor_buzz(arg0: &mut HiveDaoGovernor, arg1: &0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveProfile, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::get_profile_meta_info(arg1);
        assert!(v2 || v3 == 0x2::tx_context::sender(arg3), 9020);
        let v4 = 0x2::linked_table::borrow_mut<u64, GovernorBuzz>(&mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::entry_borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes"))).governor_buzzes, arg2);
        assert!(0x2::linked_table::contains<address, bool>(&v4.likes, v0), 9022);
        let v5 = UserUnLikedHiveDaoBuzz{
            user_profile_addr : v0,
            username          : v1,
            buzz_index        : arg2,
        };
        0x2::event::emit<UserUnLikedHiveDaoBuzz>(v5);
        0x2::linked_table::remove<address, bool>(&mut v4.likes, v0);
    }

    public entry fun unlock_hive_asset(arg0: &0x2::clock::Clock, arg1: &mut HiveDaoGovernor, arg2: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveManager, arg3: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HSuiDisperser<0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::hsui::HSUI>, arg4: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveDisperser, arg5: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveProfile, arg6: u64) {
        assert!(arg1.module_version == 0, 9017);
        arg1.total_power = arg1.total_power - (0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::unlock_hive_asset(arg0, &arg1.dao_cap, arg2, arg3, arg4, arg5, arg6) as u128);
    }

    public fun update_config_for_skin_kraft(arg0: &mut HiveDaoGovernor, arg1: &HiveSkinKraftCap, arg2: &mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveProfile, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: bool, arg7: bool, arg8: u64, arg9: bool, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 9017);
        assert!(0x2::linked_table::contains<0x1::string::String, HiveSkin>(&arg0.supported_skins, arg3), 9003);
        0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::update_config_for_skin_kraft(&arg0.dao_cap, arg2, arg4, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun update_system_buzz(arg0: &mut HiveDaoGovernor, arg1: &0x335aa86c2a66f385c3ceb5f5a5f4bf6cead2dfe6bb75c8a1a9435f235a7776b9::config::DegenHiveDeployerCap, arg2: 0x1::ascii::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x1::string::String>, arg5: &0x2::tx_context::TxContext) {
        if (!0x2::linked_table::contains<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, arg2)) {
            let v0 = SystemBuzz{
                buzz   : arg3,
                gen_ai : arg4,
            };
            0x2::linked_table::push_back<0x1::ascii::String, SystemBuzz>(&mut arg0.managed_buzzes, arg2, v0);
        } else {
            let v1 = 0x2::linked_table::borrow_mut<0x1::ascii::String, SystemBuzz>(&mut arg0.managed_buzzes, arg2);
            v1.buzz = arg3;
            v1.gen_ai = arg4;
        };
    }

    public entry fun upvote_dialogue_on_buzz(arg0: &mut HiveDaoGovernor, arg1: &0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::HiveProfile, arg2: u64, arg3: address, arg4: &0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::get_profile_meta_info(arg1);
        assert!(v2 || v3 == 0x2::tx_context::sender(arg4), 9020);
        let v4 = 0x2::linked_table::borrow_mut<u64, GovernorBuzz>(&mut 0x9778c0d86d894b5c6bac942aef20a70453b793142b119b75fa04adc07718fa15::hive_profile::entry_borrow_mut_from_composable_profile<HiveGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"hive_governor_buzzes"))).governor_buzzes, arg2);
        assert!(0x2::linked_table::contains<address, Dialogue>(&v4.profile_buzzes, arg3), 9025);
        let v5 = 0x2::linked_table::borrow_mut<address, Dialogue>(&mut v4.profile_buzzes, arg3);
        assert!(!0x2::linked_table::contains<address, bool>(&v5.upvotes, v0), 9024);
        0x2::linked_table::push_back<address, bool>(&mut v5.upvotes, v0, true);
        let v6 = UserUpvotedGovernanceBuzz{
            user_profile_addr    : v0,
            buzz_index           : arg2,
            username             : v1,
            user_buzz_by_profile : arg3,
        };
        0x2::event::emit<UserUpvotedGovernanceBuzz>(v6);
    }

    // decompiled from Move bytecode v6
}

