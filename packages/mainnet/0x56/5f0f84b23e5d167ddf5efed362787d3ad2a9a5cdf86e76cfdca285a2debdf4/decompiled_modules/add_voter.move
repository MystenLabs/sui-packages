module 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::add_voter {
    struct AddVoter has drop, store {
        voter: address,
        new_required_votes: 0x1::option::Option<u64>,
    }

    public fun assert_valid_proposal(arg0: &AddVoter, arg1: &0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::QuorumUpgrade) {
        let v0 = arg0.voter;
        let v1 = arg0.new_required_votes;
        assert!(!0x2::vec_set::contains<address>(0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::voters(arg1), &v0), 13906834376206843905);
        if (0x1::option::is_some<u64>(&v1)) {
            let v2 = 0x1::option::borrow<u64>(&v1);
            assert!(*v2 > 0, 13906834389091876867);
            assert!(*v2 <= (0x2::vec_set::length<address>(0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::voters(arg1)) as u64), 13906834393386975237);
        };
    }

    public fun execute(arg0: 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::proposal::Proposal<AddVoter>, arg1: &mut 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::QuorumUpgrade) {
        let AddVoter {
            voter              : v0,
            new_required_votes : v1,
        } = 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::proposal::execute<AddVoter>(arg0, arg1);
        let v2 = v1;
        if (0x1::option::is_some<u64>(&v2)) {
            0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::update_threshold(arg1, 0x1::option::extract<u64>(&mut v2));
        };
        0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::add_voter(arg1, v0);
    }

    public fun new(arg0: &0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::QuorumUpgrade, arg1: address, arg2: 0x1::option::Option<u64>) : AddVoter {
        let v0 = AddVoter{
            voter              : arg1,
            new_required_votes : arg2,
        };
        assert_valid_proposal(&v0, arg0);
        v0
    }

    public fun required_votes(arg0: &AddVoter) : 0x1::option::Option<u64> {
        arg0.new_required_votes
    }

    public fun voter(arg0: &AddVoter) : address {
        arg0.voter
    }

    // decompiled from Move bytecode v6
}

