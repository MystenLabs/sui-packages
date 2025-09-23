module 0xff5690b5abf383286720f898e0f32891811f389b55465e73d128f1fee6497151::temp {
    public fun migrate_quorum(arg0: address, arg1: &0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::quorum_upgrade::QuorumUpgrade, arg2: &mut 0x2::tx_context::TxContext) {
        0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::proposal::new<0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::relinquish_quorum::RelinquishQuorum>(arg1, 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::relinquish_quorum::new(arg0), 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(), arg2);
    }

    // decompiled from Move bytecode v6
}

