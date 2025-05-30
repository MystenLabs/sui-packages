module 0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::dao {
    struct VoteCastEvent has copy, drop {
        nft_id: 0x2::object::ID,
        voter: address,
        vote_for: bool,
        vote_amount: u64,
        vote_for_after: u64,
        vote_against_after: u64,
    }

    struct ProposalFinalizedEvent has copy, drop {
        nft_id: 0x2::object::ID,
        is_blacklisted: bool,
    }

    struct Registry has store, key {
        id: 0x2::object::UID,
        proposals: 0x2::table::Table<0x2::object::ID, Proposal>,
        transfer_policy_cap: 0x2::transfer_policy::TransferPolicyCap<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::nft::WWWNFT>,
    }

    struct DAO has drop {
        dummy_field: bool,
    }

    struct Proposal has store {
        vote_for: u64,
        vote_against: u64,
        votes_for_amount: 0x2::table::Table<address, u64>,
        votes_against_amount: 0x2::table::Table<address, u64>,
    }

    public fun finalize_proposal(arg0: &mut Registry, arg1: &mut 0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::config::Config, arg2: &mut 0x2::transfer_policy::TransferPolicy<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::nft::WWWNFT>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<0x2::object::ID, Proposal>(&arg0.proposals, arg3)) {
            new_proposal(arg0, arg3, arg5);
        };
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Proposal>(&mut arg0.proposals, arg3);
        if (v0.vote_for < v0.vote_against) {
            0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::config::finalize_proposal(arg1, arg3, true, 0x2::clock::timestamp_ms(arg4));
            0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::block_transfer::add_to_blacklist<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::nft::WWWNFT>(arg2, &arg0.transfer_policy_cap, arg3);
        } else {
            0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::config::finalize_proposal(arg1, arg3, false, 0x2::clock::timestamp_ms(arg4));
        };
        let v1 = ProposalFinalizedEvent{
            nft_id         : arg3,
            is_blacklisted : v0.vote_for < v0.vote_against,
        };
        0x2::event::emit<ProposalFinalizedEvent>(v1);
    }

    public fun get_proposal_votes(arg0: &Registry, arg1: 0x2::object::ID) : (u64, u64) {
        let v0 = 0x2::table::borrow<0x2::object::ID, Proposal>(&arg0.proposals, arg1);
        (v0.vote_for, v0.vote_against)
    }

    public fun get_vote_amount(arg0: &Registry, arg1: 0x2::object::ID, arg2: address) : (u64, u64) {
        let v0 = 0x2::table::borrow<0x2::object::ID, Proposal>(&arg0.proposals, arg1);
        if (0x2::table::contains<address, u64>(&v0.votes_for_amount, arg2)) {
            (*0x2::table::borrow<address, u64>(&v0.votes_for_amount, arg2), 0)
        } else if (0x2::table::contains<address, u64>(&v0.votes_against_amount, arg2)) {
            (0, *0x2::table::borrow<address, u64>(&v0.votes_against_amount, arg2))
        } else {
            (0, 0)
        }
    }

    fun init(arg0: DAO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<DAO>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::nft::WWWNFT>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::nft::WWWNFT>(&mut v4, &v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::nft::WWWNFT>(&mut v4, &v3, 100, 0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::add<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::nft::WWWNFT>(&mut v4, &v3);
        0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::block_transfer::add<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::nft::WWWNFT>(&mut v4, &v3);
        let v5 = Registry{
            id                  : 0x2::object::new(arg1),
            proposals           : 0x2::table::new<0x2::object::ID, Proposal>(arg1),
            transfer_policy_cap : v3,
        };
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::nft::WWWNFT>>(v4);
        0x2::transfer::share_object<Registry>(v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun new_proposal(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<0x2::object::ID, Proposal>(&arg0.proposals, arg1), 1);
        let v0 = Proposal{
            vote_for             : 0,
            vote_against         : 0,
            votes_for_amount     : 0x2::table::new<address, u64>(arg2),
            votes_against_amount : 0x2::table::new<address, u64>(arg2),
        };
        0x2::table::add<0x2::object::ID, Proposal>(&mut arg0.proposals, arg1, v0);
    }

    public fun vote(arg0: &mut Registry, arg1: &mut 0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::config::Config, arg2: &mut 0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::vote_escrow::System, arg3: 0x2::object::ID, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::config::is_finalized_proposal(arg1, arg3), 0);
        if (!0x2::table::contains<0x2::object::ID, Proposal>(&arg0.proposals, arg3)) {
            new_proposal(arg0, arg3, arg5);
        };
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Proposal>(&mut arg0.proposals, arg3);
        let v1 = 0x2::tx_context::sender(arg5);
        if (0x2::table::contains<address, u64>(&v0.votes_for_amount, v1)) {
            0x2::table::remove<address, u64>(&mut v0.votes_for_amount, v1);
            v0.vote_for = v0.vote_for - *0x2::table::borrow<address, u64>(&v0.votes_for_amount, v1);
        };
        if (0x2::table::contains<address, u64>(&v0.votes_against_amount, v1)) {
            0x2::table::remove<address, u64>(&mut v0.votes_against_amount, v1);
            v0.vote_against = v0.vote_against - *0x2::table::borrow<address, u64>(&v0.votes_against_amount, v1);
        };
        let v2 = 0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::vote_escrow::get_ve_score(arg2, v1);
        if (arg4) {
            v0.vote_for = v0.vote_for + v2;
            0x2::table::add<address, u64>(&mut v0.votes_for_amount, v1, v2);
        } else {
            v0.vote_against = v0.vote_against + v2;
            0x2::table::add<address, u64>(&mut v0.votes_against_amount, v1, v2);
        };
        let v3 = VoteCastEvent{
            nft_id             : arg3,
            voter              : v1,
            vote_for           : arg4,
            vote_amount        : v2,
            vote_for_after     : v0.vote_for,
            vote_against_after : v0.vote_against,
        };
        0x2::event::emit<VoteCastEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

