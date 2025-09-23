module 0x9ee8b2fa4a74dffd9c45c0a53f2bcd2f87e1d34c8fa1211fd0cb5b5fb13c8987::migrate_quorum {
    public fun migrate_quorum(arg0: address, arg1: &0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::QuorumUpgrade, arg2: &mut 0x2::tx_context::TxContext) {
        0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::proposal::new<0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::relinquish_quorum::RelinquishQuorum>(arg1, 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::relinquish_quorum::new(arg0), 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(), arg2);
    }

    // decompiled from Move bytecode v6
}

