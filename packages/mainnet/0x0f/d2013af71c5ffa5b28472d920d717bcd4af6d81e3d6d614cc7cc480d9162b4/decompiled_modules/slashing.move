module 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::slashing {
    struct SlashingProposal has drop, store {
        epoch: u32,
        node_id: 0x2::object::ID,
        voting_weight: u16,
        voters: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct SlashingManager has key {
        id: 0x2::object::UID,
        slashing_candidates: 0x2::table::Table<0x2::object::ID, SlashingProposal>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SlashingManager{
            id                  : 0x2::object::new(arg0),
            slashing_candidates : 0x2::table::new<0x2::object::ID, SlashingProposal>(arg0),
        };
        0x2::transfer::share_object<SlashingManager>(v0);
    }

    fun add_vote(arg0: &mut SlashingProposal, arg1: 0x2::object::ID, arg2: u16) {
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg0.voters, &arg1), 1);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.voters, arg1);
        arg0.voting_weight = arg0.voting_weight + arg2;
    }

    public fun cleanup_slashing_proposals(arg0: &mut SlashingManager, arg1: &0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::staking::Staking, arg2: vector<0x2::object::ID>) {
        0x1::vector::reverse<0x2::object::ID>(&mut arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v1 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg2);
            if (0x2::table::contains<0x2::object::ID, SlashingProposal>(&arg0.slashing_candidates, v1)) {
                if (0x2::table::borrow<0x2::object::ID, SlashingProposal>(&arg0.slashing_candidates, v1).epoch < 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::staking::epoch(arg1)) {
                    0x2::table::remove<0x2::object::ID, SlashingProposal>(&mut arg0.slashing_candidates, v1);
                };
            };
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg2);
    }

    public fun execute_slashing(arg0: &mut SlashingManager, arg1: &mut 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::staking::Staking, arg2: &mut 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::wal::ProtectedTreasury, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, SlashingProposal>(&arg0.slashing_candidates, arg3), 2);
        let v0 = 0x2::table::remove<0x2::object::ID, SlashingProposal>(&mut arg0.slashing_candidates, arg3);
        assert!(v0.epoch == 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::staking::epoch(arg1), 3);
        assert!(0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::staking::is_quorum(arg1, v0.voting_weight), 4);
        0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::staking::burn_commission(arg1, arg3, arg2, arg4);
    }

    fun fresh_proposal(arg0: u32, arg1: 0x2::object::ID) : SlashingProposal {
        SlashingProposal{
            epoch         : arg0,
            node_id       : arg1,
            voting_weight : 0,
            voters        : 0x2::vec_set::empty<0x2::object::ID>(),
        }
    }

    public fun vote_for_slashing(arg0: &mut SlashingManager, arg1: &0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::staking::Staking, arg2: 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::auth::Authenticated, arg3: 0x2::object::ID, arg4: 0x2::object::ID) {
        assert!(0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::staking::check_governance_authorization(arg1, arg3, arg2), 0);
        let v0 = 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::staking::epoch(arg1);
        let v1 = if (0x2::table::contains<0x2::object::ID, SlashingProposal>(&arg0.slashing_candidates, arg4)) {
            let v2 = 0x2::table::borrow_mut<0x2::object::ID, SlashingProposal>(&mut arg0.slashing_candidates, arg4);
            if (v2.epoch != v0) {
                *v2 = fresh_proposal(v0, arg4);
            };
            v2
        } else {
            0x2::table::add<0x2::object::ID, SlashingProposal>(&mut arg0.slashing_candidates, arg4, fresh_proposal(v0, arg4));
            0x2::table::borrow_mut<0x2::object::ID, SlashingProposal>(&mut arg0.slashing_candidates, arg4)
        };
        add_vote(v1, arg3, 0xfd2013af71c5ffa5b28472d920d717bcd4af6d81e3d6d614cc7cc480d9162b4::staking::get_current_node_weight(arg1, arg3));
    }

    // decompiled from Move bytecode v7
}

