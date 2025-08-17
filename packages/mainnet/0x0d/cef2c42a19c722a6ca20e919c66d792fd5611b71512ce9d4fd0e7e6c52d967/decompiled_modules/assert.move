module 0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::assert {
    public(friend) fun assert_ve_all_claimed(arg0: &0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::gauge_globals::GaugeGlobals, arg1: &0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::voting_escrow::VotingEscrow, arg2: u64) {
        let v0 = 0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::voting_escrow::user_votes(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::voting_escrow::UserVote>(&v0)) {
            let v2 = 0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::voting_escrow::gauge_id(0x1::vector::borrow<0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::voting_escrow::UserVote>(&v0, v1));
            assert_vote_claimed_for_gauge(arg0, arg1, &v2, arg2);
            v1 = v1 + 1;
        };
    }

    public(friend) fun assert_vote_allowed_for_user(arg0: &0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::gauge_globals::GaugeGlobals, arg1: &0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::epoch::EpochConfig, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        if (0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::gauge_globals::is_whitelisted_voter(arg0, 0x2::tx_context::sender(arg3))) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::epoch::epoch_id(arg1, v0);
        assert!(v0 >= 0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::epoch::epoch_main_start(arg1, v1) && v0 <= 0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::epoch::epoch_finale_start(arg1, v1), 1);
    }

    public(friend) fun assert_vote_claimed_for_gauge(arg0: &0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::gauge_globals::GaugeGlobals, arg1: &0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::voting_escrow::VotingEscrow, arg2: &address, arg3: u64) {
        0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::voting_escrow::check_vote_claimed(arg1, 0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::gauge_globals::get_gauge(arg0, arg2), arg3 - 1);
    }

    public(friend) fun assert_vote_removed(arg0: &0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::voting_escrow::VotingEscrow) {
        let v0 = 0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::voting_escrow::user_votes(arg0);
        assert!(0x1::vector::length<0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::voting_escrow::UserVote>(&v0) == 0, 0);
    }

    // decompiled from Move bytecode v6
}

