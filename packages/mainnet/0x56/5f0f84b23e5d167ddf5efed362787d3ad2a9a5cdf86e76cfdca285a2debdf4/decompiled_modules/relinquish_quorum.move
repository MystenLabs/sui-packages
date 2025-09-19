module 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::relinquish_quorum {
    struct RelinquishQuorum has drop, store {
        new_owner: address,
    }

    public fun execute(arg0: 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::proposal::Proposal<RelinquishQuorum>, arg1: 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::QuorumUpgrade) {
        let RelinquishQuorum { new_owner: v0 } = 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::proposal::execute<RelinquishQuorum>(arg0, &arg1);
        0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::relinquish_quorum(arg1, v0);
    }

    public fun new(arg0: address) : RelinquishQuorum {
        RelinquishQuorum{new_owner: arg0}
    }

    // decompiled from Move bytecode v6
}

