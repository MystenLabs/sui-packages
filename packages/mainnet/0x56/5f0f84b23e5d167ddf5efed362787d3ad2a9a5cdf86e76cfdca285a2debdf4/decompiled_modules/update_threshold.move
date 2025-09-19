module 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::update_threshold {
    struct UpdateThreshold has drop, store {
        new_required_votes: u64,
    }

    public fun execute(arg0: 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::proposal::Proposal<UpdateThreshold>, arg1: &mut 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::QuorumUpgrade) {
        let UpdateThreshold { new_required_votes: v0 } = 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::proposal::execute<UpdateThreshold>(arg0, arg1);
        0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::update_threshold(arg1, v0);
    }

    public fun assert_valid_proposal(arg0: &UpdateThreshold, arg1: &0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::QuorumUpgrade) {
        let v0 = arg0.new_required_votes;
        assert!(v0 > 0, 13906834324667236353);
        assert!(v0 <= (0x2::vec_set::length<address>(0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::voters(arg1)) as u64), 13906834328962334723);
    }

    public fun new(arg0: &0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::QuorumUpgrade, arg1: u64) : UpdateThreshold {
        let v0 = UpdateThreshold{new_required_votes: arg1};
        assert_valid_proposal(&v0, arg0);
        v0
    }

    // decompiled from Move bytecode v6
}

