module 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::remove_voter {
    struct RemoveVoter has drop, store {
        voter: address,
        new_required_votes: 0x1::option::Option<u64>,
    }

    public fun execute(arg0: 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::proposal::Proposal<RemoveVoter>, arg1: &mut 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::QuorumUpgrade) {
        let RemoveVoter {
            voter              : v0,
            new_required_votes : v1,
        } = 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::proposal::execute<RemoveVoter>(arg0, arg1);
        let v2 = v1;
        if (0x1::option::is_some<u64>(&v2)) {
            0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::update_threshold(arg1, 0x1::option::extract<u64>(&mut v2));
        };
        0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::remove_voter(arg1, v0);
    }

    public fun assert_valid_proposal(arg0: &RemoveVoter, arg1: &0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::QuorumUpgrade) {
        let v0 = arg0.voter;
        let v1 = arg0.new_required_votes;
        assert!(0x2::vec_set::contains<address>(0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::voters(arg1), &v0), 13906834384796778497);
        if (0x1::option::is_some<u64>(&v1)) {
            let v2 = 0x1::option::borrow<u64>(&v1);
            assert!(*v2 > 0, 13906834397681811459);
            assert!(*v2 <= (0x2::vec_set::length<address>(0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::voters(arg1)) as u64) - 1, 13906834410566844421);
        } else {
            assert!(0x2::vec_set::length<address>(0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::voters(arg1)) - 1 >= 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::required_votes(arg1), 13906834432041680901);
        };
    }

    public fun new(arg0: &0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::QuorumUpgrade, arg1: address, arg2: 0x1::option::Option<u64>) : RemoveVoter {
        let v0 = RemoveVoter{
            voter              : arg1,
            new_required_votes : arg2,
        };
        assert_valid_proposal(&v0, arg0);
        v0
    }

    // decompiled from Move bytecode v6
}

