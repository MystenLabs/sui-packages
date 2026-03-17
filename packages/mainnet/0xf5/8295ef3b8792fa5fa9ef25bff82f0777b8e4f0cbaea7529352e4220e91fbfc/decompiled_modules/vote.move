module 0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::vote {
    public fun vote<T0>(arg0: &mut 0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::Proposal, arg1: &0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::DaoConfig, arg2: &0x2::coin::Coin<T0>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = cast_vote<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::VoteReceipt>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun cast_vote<T0>(arg0: &mut 0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::Proposal, arg1: &0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::DaoConfig, arg2: &0x2::coin::Coin<T0>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::VoteReceipt {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::proposal_uid_mut(arg0);
        assert!(!0x2::dynamic_field::exists_<address>(v1, v0), 100);
        0x2::dynamic_field::add<address, bool>(v1, v0, true);
        0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::tally_vote(arg0, 0x2::coin::value<T0>(arg2), arg3, arg4, arg5)
    }

    public fun result(arg0: &0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::Proposal, arg1: &0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::DaoConfig, arg2: &0x2::clock::Clock) : (bool, bool) {
        assert!(0x2::clock::timestamp_ms(arg2) >= 0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::end_ms(arg0), 101);
        let v0 = 0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::votes_for(arg0) + 0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::votes_against(arg0);
        let v1 = v0 >= 0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::total_supply(arg1) * 0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::quorum_bps() / 10000;
        let v2 = if (v1) {
            if (v0 > 0) {
                0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::votes_for(arg0) * 10000 / v0 >= 0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::pass_threshold_bps()
            } else {
                false
            }
        } else {
            false
        };
        (v2, v1)
    }

    public fun snapshot_vote(arg0: &mut 0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::Proposal, arg1: &0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::snapshot::SnapshotRegistry, arg2: &0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::DaoConfig, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::snapshot::proposal_id(arg1) == 0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::proposal_id(arg0), 102);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::proposal_uid_mut(arg0);
        assert!(!0x2::dynamic_field::exists_<address>(v1, v0), 100);
        0x2::dynamic_field::add<address, bool>(v1, v0, true);
        0x2::transfer::public_transfer<0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::VoteReceipt>(0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::tally_vote(arg0, 0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::snapshot::registered_power(arg1, v0, arg4), arg3, arg4, arg5), v0);
    }

    // decompiled from Move bytecode v6
}

