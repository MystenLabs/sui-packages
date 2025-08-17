module 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::vote {
    public(friend) fun add_votes(arg0: &mut 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge_globals::GaugeGlobals, arg1: &0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::vote_power::VotePowerConfig, arg2: &0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::epoch::EpochConfig, arg3: &mut 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::voting_escrow::VotingEscrow, arg4: u64, arg5: &vector<0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::voting_escrow::UserVote>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::voting_escrow::UserVote>(arg5)) {
            let v1 = *0x1::vector::borrow<0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::voting_escrow::UserVote>(arg5, v0);
            let v2 = 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::voting_escrow::gauge_id(&v1);
            0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::voting_escrow::add_vote(arg3, 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge_globals::get_gauge_not_paused(arg0, &v2), arg1, arg2, arg4, 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::voting_escrow::weight(&v1));
            v0 = v0 + 1;
        };
    }

    public fun add_votes_batch(arg0: &mut 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::ve_mmt::VeMMT, arg1: &mut 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::voting_escrow::VotingEscrow, arg2: vector<address>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::ve_mmt::assert_supported_version(arg0);
        0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge_globals::assert_not_paused(0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::ve_mmt::gauge_globals(arg0));
        let (v0, v1, v2, _) = 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::ve_mmt::gauge_fields(arg0);
        0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::assert::assert_vote_allowed_for_user(v2, v1, arg4, arg5);
        let v4 = 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::voting_escrow::user_votes_from_vectors(arg2, arg3);
        add_votes(v2, v0, v1, arg1, 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::epoch::epoch_id(v1, 0x2::clock::timestamp_ms(arg4)), &v4);
    }

    public fun change_votes_batch(arg0: &mut 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::ve_mmt::VeMMT, arg1: &mut 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::voting_escrow::VotingEscrow, arg2: vector<address>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::ve_mmt::assert_supported_version(arg0);
        0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge_globals::assert_not_paused(0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::ve_mmt::gauge_globals(arg0));
        let (v0, v1, v2, _) = 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::ve_mmt::gauge_fields(arg0);
        0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::assert::assert_vote_allowed_for_user(v2, v1, arg4, arg5);
        let v4 = 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::epoch::epoch_id(v1, 0x2::clock::timestamp_ms(arg4));
        remove_votes(v2, v0, v1, arg1, v4);
        let v5 = 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::voting_escrow::user_votes_from_vectors(arg2, arg3);
        add_votes(v2, v0, v1, arg1, v4, &v5);
    }

    public(friend) fun remove_votes(arg0: &mut 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge_globals::GaugeGlobals, arg1: &0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::vote_power::VotePowerConfig, arg2: &0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::epoch::EpochConfig, arg3: &mut 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::voting_escrow::VotingEscrow, arg4: u64) : vector<0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::voting_escrow::UserVote> {
        let v0 = 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::voting_escrow::user_votes(arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::voting_escrow::UserVote>(&v0)) {
            let v2 = 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::voting_escrow::gauge_id(0x1::vector::borrow<0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::voting_escrow::UserVote>(&v0, v1));
            0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::assert::assert_vote_claimed_for_gauge(arg0, arg3, &v2, arg4);
            0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::voting_escrow::remove_vote(arg3, 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge_globals::get_gauge_not_paused(arg0, &v2), arg1, arg2, arg4);
            v1 = v1 + 1;
        };
        v0
    }

    public fun remove_votes_batch(arg0: &mut 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::ve_mmt::VeMMT, arg1: &mut 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::voting_escrow::VotingEscrow, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::ve_mmt::assert_supported_version(arg0);
        0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge_globals::assert_not_paused(0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::ve_mmt::gauge_globals(arg0));
        let (v0, v1, v2, _) = 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::ve_mmt::gauge_fields(arg0);
        0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::assert::assert_vote_allowed_for_user(v2, v1, arg2, arg3);
        remove_votes(v2, v0, v1, arg1, 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::epoch::epoch_id(v1, 0x2::clock::timestamp_ms(arg2)));
    }

    // decompiled from Move bytecode v6
}

