module 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::replace_voter {
    struct ReplaceVoter has drop, store {
        new_voter: address,
        old_voter: address,
    }

    public fun execute(arg0: 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::proposal::Proposal<ReplaceVoter>, arg1: &mut 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::QuorumUpgrade) {
        let ReplaceVoter {
            new_voter : v0,
            old_voter : v1,
        } = 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::proposal::execute<ReplaceVoter>(arg0, arg1);
        0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::replace_voter(arg1, v1, v0);
    }

    public fun assert_valid_proposal(arg0: &ReplaceVoter, arg1: &0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::QuorumUpgrade) {
        let v0 = arg0.new_voter;
        let v1 = arg0.old_voter;
        assert!(0x2::vec_set::contains<address>(0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::voters(arg1), &v1), 13906834354732138499);
        assert!(!0x2::vec_set::contains<address>(0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::voters(arg1), &v0), 13906834359026974721);
    }

    public fun new(arg0: &0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::QuorumUpgrade, arg1: address, arg2: address) : ReplaceVoter {
        let v0 = ReplaceVoter{
            new_voter : arg1,
            old_voter : arg2,
        };
        assert_valid_proposal(&v0, arg0);
        v0
    }

    // decompiled from Move bytecode v6
}

