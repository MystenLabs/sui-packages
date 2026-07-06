module 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::voting_stake {
    struct VotingStake has key {
        id: 0x2::object::UID,
        votes: 0x2::vec_map::VecMap<0x2::object::ID, 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption>,
        staked_sui: 0x3::staking_pool::StakedSui,
        validator_address: address,
    }

    public fun new(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: 0x3::staking_pool::StakedSui, arg2: &mut 0x2::tx_context::TxContext) : VotingStake {
        assert!(0x2::tx_context::epoch(arg2) >= 0x3::staking_pool::stake_activation_epoch(&arg1), 13835339727827566596);
        let v0 = 0x3::staking_pool::pool_id(&arg1);
        VotingStake{
            id                : 0x2::object::new(arg2),
            votes             : 0x2::vec_map::empty<0x2::object::ID, 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption>(),
            staked_sui        : arg1,
            validator_address : 0x3::sui_system::validator_address_by_pool_id(arg0, &v0),
        }
    }

    public(friend) fun add_vote(arg0: &mut VotingStake, arg1: 0x2::object::ID, arg2: 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption) {
        assert!(0x2::vec_map::length<0x2::object::ID, 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption>(&arg0.votes) < 100, 13836184298786979850);
        assert!(!0x2::vec_map::contains<0x2::object::ID, 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption>(&arg0.votes, &arg1), 13835621353128263686);
        0x2::vec_map::insert<0x2::object::ID, 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption>(&mut arg0.votes, arg1, arg2);
    }

    public fun destroy(arg0: VotingStake) : 0x3::staking_pool::StakedSui {
        let VotingStake {
            id                : v0,
            votes             : v1,
            staked_sui        : v2,
            validator_address : _,
        } = arg0;
        let v4 = v1;
        0x2::object::delete(v0);
        assert!(0x2::vec_map::is_empty<0x2::object::ID, 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption>(&v4), 13835058338750070786);
        v2
    }

    public fun get_vote_for_proposal(arg0: &VotingStake, arg1: 0x2::object::ID) : 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption {
        assert!(0x2::vec_map::contains<0x2::object::ID, 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption>(&arg0.votes, &arg1), 13835902802335301640);
        *0x2::vec_map::get<0x2::object::ID, 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption>(&arg0.votes, &arg1)
    }

    public fun keep(arg0: VotingStake, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::transfer<VotingStake>(arg0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun remove_vote(arg0: &mut VotingStake, arg1: 0x2::object::ID) : 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption {
        assert!(0x2::vec_map::contains<0x2::object::ID, 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption>(&arg0.votes, &arg1), 13835902849579941896);
        let (_, v1) = 0x2::vec_map::remove<0x2::object::ID, 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_option::VoteOption>(&mut arg0.votes, &arg1);
        v1
    }

    public(friend) fun staked_sui(arg0: &VotingStake) : &0x3::staking_pool::StakedSui {
        &arg0.staked_sui
    }

    public fun validator_address(arg0: &VotingStake) : address {
        arg0.validator_address
    }

    // decompiled from Move bytecode v7
}

