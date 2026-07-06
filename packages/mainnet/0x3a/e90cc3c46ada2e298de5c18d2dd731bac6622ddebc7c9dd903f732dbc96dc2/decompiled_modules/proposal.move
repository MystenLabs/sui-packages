module 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::proposal {
    struct ValidatorVote has drop, store {
        vote: 0x1::option::Option<0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption>,
        total_staker_votes: 0x2::vec_map::VecMap<0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption, u64>,
    }

    struct Proposal has key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        description: 0x1::string::String,
        validator_votes: 0x2::vec_map::VecMap<address, ValidatorVote>,
        proposer: address,
        active_data: 0x1::option::Option<ActiveProposalData>,
    }

    struct ActiveProposalData has store {
        result: 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::voting_result::VotingResult,
        end_timestamp_ms: u64,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct ValidatorVoted has copy, drop, store {
        voting_id: 0x2::object::ID,
        validator_address: address,
        vote: 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption,
    }

    public(friend) fun activate(arg0: &mut Proposal, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(is_pre_vote(arg0), 13837029690084950029);
        assert!(arg0.proposer == 0x2::tx_context::sender(arg3), 13837311169356759055);
        let v0 = ActiveProposalData{
            result           : 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::voting_result::pending(),
            end_timestamp_ms : arg2,
            fee              : arg1,
        };
        0x1::option::fill<ActiveProposalData>(&mut arg0.active_data, v0);
    }

    entry fun create_and_share(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::length(&arg0);
        assert!(v0 > 0, 13837873221662277651);
        assert!(v0 <= 128, 13838154700934086677);
        let v1 = Proposal{
            id              : 0x2::object::new(arg2),
            title           : arg0,
            description     : arg1,
            validator_votes : 0x2::vec_map::empty<address, ValidatorVote>(),
            proposer        : 0x2::tx_context::sender(arg2),
            active_data     : 0x1::option::none<ActiveProposalData>(),
        };
        0x2::transfer::share_object<Proposal>(v1);
    }

    public fun finalize(arg0: &mut Proposal, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &0x2::clock::Clock) {
        assert!(!is_pre_vote(arg0), 13836748073374187531);
        assert!(!is_finalized(arg0), 13836185127715471367);
        let v0 = progress(arg0, arg1);
        let v1 = (0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_progress::total_stake(&v0) as u128);
        let v2 = (0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_progress::yes(&v0) as u128) * 3 > v1 * 2;
        let v3 = (0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_progress::no_with_veto(&v0) as u128) * 3 > v1;
        let v4 = 0x1::option::borrow_mut<ActiveProposalData>(&mut arg0.active_data);
        let v5 = if (0x2::clock::timestamp_ms(arg2) >= v4.end_timestamp_ms) {
            true
        } else if (v2) {
            true
        } else if (v3) {
            true
        } else {
            ((0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_progress::no(&v0) + 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_progress::abstain(&v0) + 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_progress::no_with_veto(&v0)) as u128) * 2 > v1
        };
        assert!(v5, 13835903708573204485);
        let v6 = if (v3) {
            0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::voting_result::vetoed()
        } else if (v2) {
            0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::voting_result::passed()
        } else {
            0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::voting_result::not_passed()
        };
        v4.result = v6;
    }

    fun is_finalized(arg0: &Proposal) : bool {
        let v0 = &arg0.active_data;
        0x1::option::is_some<ActiveProposalData>(v0) && 0x1::option::borrow<ActiveProposalData>(v0).result != 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::voting_result::pending()
    }

    fun is_pre_vote(arg0: &Proposal) : bool {
        0x1::option::is_none<ActiveProposalData>(&arg0.active_data)
    }

    fun is_voting_enabled(arg0: &Proposal, arg1: &0x2::clock::Clock) : bool {
        if (0x1::option::is_none<ActiveProposalData>(&arg0.active_data)) {
            true
        } else {
            let v1 = &arg0.active_data;
            if (0x1::option::is_some<ActiveProposalData>(v1)) {
                let v2 = 0x1::option::borrow<ActiveProposalData>(v1);
                v2.result == 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::voting_result::pending() && v2.end_timestamp_ms > 0x2::clock::timestamp_ms(arg1)
            } else {
                false
            }
        }
    }

    public fun progress(arg0: &Proposal, arg1: &mut 0x3::sui_system::SuiSystemState) : 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_progress::VoteProgress {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0x3::sui_system::active_validator_addresses(arg1);
        0x1::vector::reverse<address>(&mut v5);
        let v6 = 0;
        while (v6 < 0x1::vector::length<address>(&v5)) {
            let v7 = 0x1::vector::pop_back<address>(&mut v5);
            let v8 = 0x3::sui_system::active_validator_stake_amount(arg1, v7);
            v4 = v4 + v8;
            if (!0x2::vec_map::contains<address, ValidatorVote>(&arg0.validator_votes, &v7)) {
            } else {
                let v9 = 0x2::vec_map::get<address, ValidatorVote>(&arg0.validator_votes, &v7);
                let (v10, v11) = 0x2::vec_map::into_keys_values<0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption, u64>(v9.total_staker_votes);
                let v12 = 0;
                let v13 = v10;
                let v14 = v11;
                0x1::vector::reverse<u64>(&mut v14);
                assert!(0x1::vector::length<0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption>(&v13) == 0x1::vector::length<u64>(&v14), 13906835076286513151);
                0x1::vector::reverse<0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption>(&mut v13);
                let v15 = 0;
                while (v15 < 0x1::vector::length<0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption>(&v13)) {
                    let v16 = 0x1::vector::pop_back<0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption>(&mut v13);
                    let v17 = 0x1::vector::pop_back<u64>(&mut v14);
                    v12 = v12 + v17;
                    if (0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::is_yes(&v16)) {
                        v0 = v0 + v17;
                    } else if (0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::is_no(&v16)) {
                        v1 = v1 + v17;
                    } else if (0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::is_abstain(&v16)) {
                        v2 = v2 + v17;
                    } else if (0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::is_no_with_veto(&v16)) {
                        v3 = v3 + v17;
                    };
                    v15 = v15 + 1;
                };
                0x1::vector::destroy_empty<0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption>(v13);
                0x1::vector::destroy_empty<u64>(v14);
                if (0x1::option::is_some<0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption>(&v9.vote)) {
                    let v18 = *0x1::option::borrow<0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption>(&v9.vote);
                    if (0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::is_yes(&v18)) {
                        v0 = v0 + v8 - v12;
                    } else if (0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::is_no(&v18)) {
                        v1 = v1 + v8 - v12;
                    } else if (0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::is_abstain(&v18)) {
                        v2 = v2 + v8 - v12;
                    } else if (0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::is_no_with_veto(&v18)) {
                        v3 = v3 + v8 - v12;
                    };
                };
            };
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<address>(v5);
        0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_progress::new(v0, v1, v2, v3, v4)
    }

    public fun proposer(arg0: &Proposal) : address {
        arg0.proposer
    }

    public fun remove_staker_vote(arg0: &mut Proposal, arg1: &mut 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::voting_stake::VotingStake) {
        let v0 = 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::voting_stake::remove_vote(arg1, 0x2::object::uid_to_inner(&arg0.id));
        if (is_finalized(arg0)) {
            return
        };
        let v1 = validator_vote_mut(arg0, 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::voting_stake::validator_address(arg1));
        *0x2::vec_map::get_mut<0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption, u64>(&mut v1.total_staker_votes, &v0) = *0x2::vec_map::get<0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption, u64>(&v1.total_staker_votes, &v0) - 0x3::staking_pool::staked_sui_amount(0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::voting_stake::staked_sui(arg1));
    }

    fun validator_vote_mut(arg0: &mut Proposal, arg1: address) : &mut ValidatorVote {
        if (!0x2::vec_map::contains<address, ValidatorVote>(&arg0.validator_votes, &arg1)) {
            let v0 = ValidatorVote{
                vote               : 0x1::option::none<0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption>(),
                total_staker_votes : 0x2::vec_map::empty<0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption, u64>(),
            };
            0x2::vec_map::insert<address, ValidatorVote>(&mut arg0.validator_votes, arg1, v0);
        };
        0x2::vec_map::get_mut<address, ValidatorVote>(&mut arg0.validator_votes, &arg1)
    }

    public fun vote_as_staker(arg0: &mut Proposal, arg1: &mut 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::voting_stake::VotingStake, arg2: 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_voting_enabled(arg0, arg3), 13835621696725450755);
        0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::voting_stake::add_vote(arg1, 0x2::object::uid_to_inner(&arg0.id), arg2);
        let v0 = validator_vote_mut(arg0, 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::voting_stake::validator_address(arg1));
        if (!0x2::vec_map::contains<0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption, u64>(&v0.total_staker_votes, &arg2)) {
            0x2::vec_map::insert<0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption, u64>(&mut v0.total_staker_votes, arg2, 0x3::staking_pool::staked_sui_amount(0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::voting_stake::staked_sui(arg1)));
        } else {
            let v1 = 0x2::vec_map::get_mut<0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption, u64>(&mut v0.total_staker_votes, &arg2);
            *v1 = *v1 + 0x3::staking_pool::staked_sui_amount(0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::voting_stake::staked_sui(arg1));
        };
    }

    public fun vote_as_validator(arg0: &mut Proposal, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_voting_enabled(arg0, arg3), 13835621567876431875);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x3::sui_system::active_validator_addresses(arg1);
        assert!(0x1::vector::contains<address>(&v1, &v0), 13835340114374426625);
        let v2 = validator_vote_mut(arg0, v0);
        assert!(0x1::option::is_none<0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption>(&v2.vote), 13836466040051597321);
        v2.vote = 0x1::option::some<0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption>(arg2);
        let v3 = ValidatorVoted{
            voting_id         : 0x2::object::uid_to_inner(&arg0.id),
            validator_address : v0,
            vote              : arg2,
        };
        0x2::event::emit<ValidatorVoted>(v3);
    }

    public fun withdraw_fee(arg0: &mut Proposal, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg0.proposer == 0x2::tx_context::sender(arg1), 13837310331838136335);
        let v0 = &arg0.active_data;
        assert!(0x1::option::is_some<ActiveProposalData>(v0) && 0x1::option::borrow<ActiveProposalData>(v0).result == 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::voting_result::passed(), 13837591819699879953);
        0x2::balance::withdraw_all<0x2::sui::SUI>(&mut 0x1::option::borrow_mut<ActiveProposalData>(&mut arg0.active_data).fee)
    }

    // decompiled from Move bytecode v7
}

