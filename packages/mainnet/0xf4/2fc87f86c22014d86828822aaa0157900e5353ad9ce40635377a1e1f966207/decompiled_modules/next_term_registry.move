module 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::next_term_registry {
    struct ClosingCurrentClubVoteRegistry has key {
        id: 0x2::object::UID,
        club_id: 0x2::object::ID,
        president_vote: bool,
        vice_president_vote: bool,
        treasurer_vote: bool,
    }

    struct ClosingCurrentClubVoteRegistryCreated has copy, drop, store {
        registry_id: 0x2::object::ID,
        current_term: u64,
        club_id: 0x2::object::ID,
    }

    struct ClosingCurrentClubVoteRegistryDeleted has copy, drop, store {
        registry_id: 0x2::object::ID,
        current_term: u64,
        club_id: 0x2::object::ID,
    }

    struct NextTermRegistry has key {
        id: 0x2::object::UID,
        club_id: 0x2::object::ID,
        next_president: address,
        president_vote: bool,
        vice_president_vote: bool,
        treasurer_vote: bool,
    }

    struct NextTermRegistryCreated has copy, drop, store {
        registry_id: 0x2::object::ID,
        current_term: u64,
        club_id: 0x2::object::ID,
    }

    struct NextTermRegistryDeleted has copy, drop, store {
        registry_id: 0x2::object::ID,
        current_term: u64,
        club_id: 0x2::object::ID,
    }

    public fun close_current_club(arg0: &0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::BlockBlockRegistry, arg1: &mut 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::BlockBlockClub, arg2: ClosingCurrentClubVoteRegistry) {
        let v0 = if (arg2.president_vote) {
            if (arg2.vice_president_vote) {
                arg2.treasurer_vote
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13906834608135077887);
        0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::set_inactive(arg1);
        let ClosingCurrentClubVoteRegistry {
            id                  : v1,
            club_id             : _,
            president_vote      : _,
            vice_president_vote : _,
            treasurer_vote      : _,
        } = arg2;
        let v6 = v1;
        let v7 = ClosingCurrentClubVoteRegistryDeleted{
            registry_id  : 0x2::object::uid_to_inner(&v6),
            current_term : 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::current_term(arg0),
            club_id      : 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::current_club(arg0),
        };
        0x2::event::emit<ClosingCurrentClubVoteRegistryDeleted>(v7);
        0x2::object::delete(v6);
    }

    public fun create_and_share_closing_current_club_vote_registry(arg0: 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::PresidentWitness, arg1: &0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::BlockBlockRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ClosingCurrentClubVoteRegistry{
            id                  : 0x2::object::new(arg2),
            club_id             : 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::current_club(arg1),
            president_vote      : false,
            vice_president_vote : false,
            treasurer_vote      : false,
        };
        let v1 = ClosingCurrentClubVoteRegistryCreated{
            registry_id  : 0x2::object::id<ClosingCurrentClubVoteRegistry>(&v0),
            current_term : 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::current_term(arg1),
            club_id      : 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::current_club(arg1),
        };
        0x2::event::emit<ClosingCurrentClubVoteRegistryCreated>(v1);
        0x2::transfer::share_object<ClosingCurrentClubVoteRegistry>(v0);
    }

    public fun create_and_share_next_term_registry(arg0: 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::PresidentWitness, arg1: &0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::BlockBlockClub, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::is_active(arg1) == false, 13906834694034423807);
        let v0 = NextTermRegistry{
            id                  : 0x2::object::new(arg3),
            club_id             : 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::id(arg1),
            next_president      : arg2,
            president_vote      : false,
            vice_president_vote : false,
            treasurer_vote      : false,
        };
        let v1 = NextTermRegistryCreated{
            registry_id  : 0x2::object::id<NextTermRegistry>(&v0),
            current_term : 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::term(arg1),
            club_id      : 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::id(arg1),
        };
        0x2::event::emit<NextTermRegistryCreated>(v1);
        0x2::transfer::share_object<NextTermRegistry>(v0);
    }

    public fun transit_to_next_term_and_share_next_club(arg0: 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::PresidentWitness, arg1: &0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::BlockBlockYonsei, arg2: &mut 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::BlockBlockRegistry, arg3: NextTermRegistry, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg3.president_vote) {
            if (arg3.vice_president_vote) {
                arg3.treasurer_vote
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 10);
        let v1 = NextTermRegistryDeleted{
            registry_id  : 0x2::object::id<NextTermRegistry>(&arg3),
            current_term : 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::current_term(arg2),
            club_id      : 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::current_club(arg2),
        };
        0x2::event::emit<NextTermRegistryDeleted>(v1);
        let NextTermRegistry {
            id                  : v2,
            club_id             : _,
            next_president      : v4,
            president_vote      : _,
            vice_president_vote : _,
            treasurer_vote      : _,
        } = arg3;
        0x2::object::delete(v2);
        let v8 = 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::create_blockblockclub(arg1, 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::current_term(arg2) + 1, v4, arg4);
        0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::update_blockblock_registry_with_next_club(arg2, &v8, v4);
        0x2::transfer::public_share_object<0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::BlockBlockClub>(v8);
    }

    public fun vote_to_closing_club_registry(arg0: &0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::BlockBlockRegistry, arg1: &mut 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::BlockBlockClub, arg2: &mut ClosingCurrentClubVoteRegistry, arg3: &0x2::tx_context::TxContext) {
        0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::assert_current_club(arg0, arg1);
        let v0 = if (0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::president(arg1) == 0x2::tx_context::sender(arg3)) {
            true
        } else if (0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::vice_president(arg1) == 0x2::tx_context::sender(arg3)) {
            true
        } else {
            0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::treasurer(arg1) == 0x2::tx_context::sender(arg3)
        };
        assert!(v0, 13906834539415601151);
        if (!arg2.president_vote && 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::president(arg1) == 0x2::tx_context::sender(arg3)) {
            arg2.president_vote = true;
        } else if (!arg2.vice_president_vote && 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::vice_president(arg1) == 0x2::tx_context::sender(arg3)) {
            arg2.vice_president_vote = true;
        } else if (!arg2.treasurer_vote && 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::treasurer(arg1) == 0x2::tx_context::sender(arg3)) {
            arg2.treasurer_vote = true;
        };
    }

    public fun vote_to_next_term_registry(arg0: &0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::BlockBlockRegistry, arg1: &0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::BlockBlockClub, arg2: &mut NextTermRegistry, arg3: &0x2::tx_context::TxContext) {
        0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::assert_current_club(arg0, arg1);
        let v0 = if (0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::president(arg1) == 0x2::tx_context::sender(arg3)) {
            true
        } else if (0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::vice_president(arg1) == 0x2::tx_context::sender(arg3)) {
            true
        } else {
            0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::treasurer(arg1) == 0x2::tx_context::sender(arg3)
        };
        assert!(v0, 13906834801408606207);
        if (!arg2.president_vote && 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::president(arg1) == 0x2::tx_context::sender(arg3)) {
            arg2.president_vote = true;
        } else if (!arg2.vice_president_vote && 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::vice_president(arg1) == 0x2::tx_context::sender(arg3)) {
            arg2.vice_president_vote = true;
        } else if (!arg2.treasurer_vote && 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::treasurer(arg1) == 0x2::tx_context::sender(arg3)) {
            arg2.treasurer_vote = true;
        };
    }

    // decompiled from Move bytecode v6
}

