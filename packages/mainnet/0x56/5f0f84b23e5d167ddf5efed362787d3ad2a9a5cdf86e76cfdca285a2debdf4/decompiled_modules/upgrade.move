module 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::upgrade {
    struct Upgrade has drop, store {
        digest: vector<u8>,
    }

    public fun execute(arg0: 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::proposal::Proposal<Upgrade>, arg1: &mut 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::QuorumUpgrade) : 0x2::package::UpgradeTicket {
        let Upgrade { digest: v0 } = 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::proposal::execute<Upgrade>(arg0, arg1);
        0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::authorize_upgrade(arg1, v0)
    }

    public fun new(arg0: vector<u8>) : Upgrade {
        Upgrade{digest: arg0}
    }

    // decompiled from Move bytecode v6
}

