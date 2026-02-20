module 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::next_term_registry {
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

    public fun close_current_club(arg0: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockRegistry, arg1: &mut 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockClub, arg2: ClosingCurrentClubVoteRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg2.president_vote) {
            if (arg2.vice_president_vote) {
                arg2.treasurer_vote
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13906834616725012479);
        0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::set_inactive(arg1);
        mint_role_badges(arg1, arg3);
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
            current_term : 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::current_term(arg0),
            club_id      : 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::current_club(arg0),
        };
        0x2::event::emit<ClosingCurrentClubVoteRegistryDeleted>(v7);
        0x2::object::delete(v6);
    }

    fun collect_general_members(arg0: &vector<address>, arg1: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockClub, arg2: &mut vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            let v1 = 0x1::vector::borrow<address>(arg0, v0);
            if (is_general_member(*v1, arg1) && !0x1::vector::contains<address>(arg2, v1)) {
                0x1::vector::push_back<address>(arg2, *v1);
            };
            v0 = v0 + 1;
        };
    }

    public fun create_and_share_closing_current_club_vote_registry(arg0: 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::PresidentWitness, arg1: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ClosingCurrentClubVoteRegistry{
            id                  : 0x2::object::new(arg2),
            club_id             : 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::current_club(arg1),
            president_vote      : false,
            vice_president_vote : false,
            treasurer_vote      : false,
        };
        let v1 = ClosingCurrentClubVoteRegistryCreated{
            registry_id  : 0x2::object::id<ClosingCurrentClubVoteRegistry>(&v0),
            current_term : 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::current_term(arg1),
            club_id      : 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::current_club(arg1),
        };
        0x2::event::emit<ClosingCurrentClubVoteRegistryCreated>(v1);
        0x2::transfer::share_object<ClosingCurrentClubVoteRegistry>(v0);
    }

    public fun create_and_share_next_term_registry(arg0: 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::PresidentWitness, arg1: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockClub, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::is_active(arg1) == false, 13906835213725466623);
        let v0 = NextTermRegistry{
            id                  : 0x2::object::new(arg3),
            club_id             : 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::id(arg1),
            next_president      : arg2,
            president_vote      : false,
            vice_president_vote : false,
            treasurer_vote      : false,
        };
        let v1 = NextTermRegistryCreated{
            registry_id  : 0x2::object::id<NextTermRegistry>(&v0),
            current_term : 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::term(arg1),
            club_id      : 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::id(arg1),
        };
        0x2::event::emit<NextTermRegistryCreated>(v1);
        0x2::transfer::share_object<NextTermRegistry>(v0);
    }

    fun is_general_member(arg0: address, arg1: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockClub) : bool {
        let v0 = if (arg0 == 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::president(arg1)) {
            true
        } else if (arg0 == 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::vice_president(arg1)) {
            true
        } else {
            arg0 == 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::treasurer(arg1)
        };
        if (v0) {
            return false
        };
        let v1 = if (0x1::vector::contains<address>(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::borrow_planning_team(arg1), &arg0)) {
            true
        } else if (0x1::vector::contains<address>(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::borrow_marketing_team(arg1), &arg0)) {
            true
        } else {
            0x1::vector::contains<address>(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::borrow_project_leaders(arg1), &arg0)
        };
        if (v1) {
            return false
        };
        true
    }

    fun mint_role_badges(arg0: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockClub, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::id(arg0);
        let v1 = 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::term(arg0);
        0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::role_badge::mint_president_badge(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::president(arg0), v0, v1, arg1);
        0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::role_badge::mint_vice_president_badge(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::vice_president(arg0), v0, v1, arg1);
        0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::role_badge::mint_treasurer_badge(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::treasurer(arg0), v0, v1, arg1);
        let v2 = 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::borrow_planning_team(arg0);
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(v2)) {
            0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::role_badge::mint_planning_team_badge(*0x1::vector::borrow<address>(v2, v3), v0, v1, arg1);
            v3 = v3 + 1;
        };
        let v4 = 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::borrow_marketing_team(arg0);
        let v5 = 0;
        while (v5 < 0x1::vector::length<address>(v4)) {
            0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::role_badge::mint_marketing_team_badge(*0x1::vector::borrow<address>(v4, v5), v0, v1, arg1);
            v5 = v5 + 1;
        };
        let v6 = 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::borrow_project_leaders(arg0);
        let v7 = 0;
        while (v7 < 0x1::vector::length<address>(v6)) {
            0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::role_badge::mint_project_leader_badge(*0x1::vector::borrow<address>(v6, v7), v0, v1, arg1);
            v7 = v7 + 1;
        };
        let v8 = 0x1::vector::empty<address>();
        let v9 = &mut v8;
        collect_general_members(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::borrow_senior_members(arg0), arg0, v9);
        let v10 = &v8;
        let v11 = 0;
        while (v11 < 0x1::vector::length<address>(v10)) {
            0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::role_badge::mint_general_member_senior_badge(*0x1::vector::borrow<address>(v10, v11), v0, v1, arg1);
            v11 = v11 + 1;
        };
        let v12 = 0x1::vector::empty<address>();
        let v13 = &mut v12;
        collect_general_members(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::borrow_junior_members(arg0), arg0, v13);
        let v14 = &v12;
        let v15 = 0;
        while (v15 < 0x1::vector::length<address>(v14)) {
            0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::role_badge::mint_general_member_junior_badge(*0x1::vector::borrow<address>(v14, v15), v0, v1, arg1);
            v15 = v15 + 1;
        };
    }

    public fun transit_to_next_term_and_share_next_club(arg0: 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::PresidentWitness, arg1: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockYonsei, arg2: &mut 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockRegistry, arg3: NextTermRegistry, arg4: &mut 0x2::tx_context::TxContext) {
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
            current_term : 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::current_term(arg2),
            club_id      : 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::current_club(arg2),
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
        let v8 = 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::create_blockblockclub(arg1, 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::current_term(arg2) + 1, v4, arg4);
        0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::update_blockblock_registry_with_next_club(arg2, &v8, v4);
        0x2::transfer::public_share_object<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockClub>(v8);
    }

    public fun vote_to_closing_club_registry(arg0: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockRegistry, arg1: &mut 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockClub, arg2: &mut ClosingCurrentClubVoteRegistry, arg3: &0x2::tx_context::TxContext) {
        0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::assert_current_club(arg0, arg1);
        let v0 = if (0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::president(arg1) == 0x2::tx_context::sender(arg3)) {
            true
        } else if (0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::vice_president(arg1) == 0x2::tx_context::sender(arg3)) {
            true
        } else {
            0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::treasurer(arg1) == 0x2::tx_context::sender(arg3)
        };
        assert!(v0, 13906834543710568447);
        if (!arg2.president_vote && 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::president(arg1) == 0x2::tx_context::sender(arg3)) {
            arg2.president_vote = true;
        } else if (!arg2.vice_president_vote && 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::vice_president(arg1) == 0x2::tx_context::sender(arg3)) {
            arg2.vice_president_vote = true;
        } else if (!arg2.treasurer_vote && 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::treasurer(arg1) == 0x2::tx_context::sender(arg3)) {
            arg2.treasurer_vote = true;
        };
    }

    public fun vote_to_next_term_registry(arg0: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockRegistry, arg1: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockClub, arg2: &mut NextTermRegistry, arg3: &0x2::tx_context::TxContext) {
        0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::assert_current_club(arg0, arg1);
        let v0 = if (0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::president(arg1) == 0x2::tx_context::sender(arg3)) {
            true
        } else if (0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::vice_president(arg1) == 0x2::tx_context::sender(arg3)) {
            true
        } else {
            0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::treasurer(arg1) == 0x2::tx_context::sender(arg3)
        };
        assert!(v0, 13906835321099649023);
        if (!arg2.president_vote && 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::president(arg1) == 0x2::tx_context::sender(arg3)) {
            arg2.president_vote = true;
        } else if (!arg2.vice_president_vote && 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::vice_president(arg1) == 0x2::tx_context::sender(arg3)) {
            arg2.vice_president_vote = true;
        } else if (!arg2.treasurer_vote && 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::treasurer(arg1) == 0x2::tx_context::sender(arg3)) {
            arg2.treasurer_vote = true;
        };
    }

    // decompiled from Move bytecode v6
}

