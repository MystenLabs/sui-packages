module 0x859f42420234d93464a8663fd5659a3c6f4df75e61df215a5e6dd61d7d5b33f4::campaign {
    struct Campaign has key {
        id: 0x2::object::UID,
        campaign_id: u64,
        PrizeUnits: u64,
        prize_type: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::option::Option<0x1::string::String>,
        projects: 0x1::option::Option<vector<Project>>,
        organizers: Organizers,
        begin: u64,
        end: u64,
        archived: bool,
    }

    struct Organizers has drop, store {
        name: 0x1::string::String,
        website: 0x1::string::String,
        email: 0x1::string::String,
        social: 0x1::string::String,
    }

    struct OrganizerCap has key {
        id: 0x2::object::UID,
        campaign: 0x2::object::ID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Project has drop, store {
        project_name: 0x1::string::String,
        github_repo: 0x1::string::String,
        live_link: 0x1::option::Option<0x1::string::String>,
        participants: vector<Participant>,
        winner: bool,
        position: u64,
        prizes: 0x1::option::Option<vector<0x1::string::String>>,
        added_by: address,
    }

    struct Participant has drop, store {
        wallet: address,
        name: 0x1::string::String,
        email: 0x1::string::String,
        github: 0x1::string::String,
    }

    struct CampaignCreated has copy, drop {
        campaign_obj_id: 0x2::object::ID,
        campaign_id: u64,
        prize_units: u64,
        prize_type: 0x1::string::String,
        name: 0x1::string::String,
        begin: u64,
        end: u64,
        creator: address,
    }

    struct CampaignEdited has copy, drop {
        campaign_obj_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        begin: u64,
        end: u64,
        cap_id: 0x2::object::ID,
    }

    struct CampaignDeleted has copy, drop {
        campaign_obj_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    struct ProjectAdded has copy, drop {
        campaign_obj_id: 0x2::object::ID,
        project_name: 0x1::string::String,
        github_repo: 0x1::string::String,
        live_link: 0x1::string::String,
        added_by: address,
    }

    struct ProjectRemoved has copy, drop {
        campaign_obj_id: 0x2::object::ID,
        project_name: 0x1::string::String,
        removed_by: address,
    }

    struct ProjectUpdated has copy, drop {
        campaign_obj_id: 0x2::object::ID,
        project_name: 0x1::string::String,
        new_github_repo: 0x1::string::String,
        new_live_link: 0x1::string::String,
        updated_by: address,
    }

    struct ProjectOutcomeSet has copy, drop {
        campaign_obj_id: 0x2::object::ID,
        project_name: 0x1::string::String,
        winner: bool,
        position: u64,
        prizes: vector<0x1::string::String>,
        cap_id: 0x2::object::ID,
    }

    struct ParticipantAdded has copy, drop {
        campaign_obj_id: 0x2::object::ID,
        project_name: 0x1::string::String,
        wallet: address,
        name: 0x1::string::String,
        email: 0x1::string::String,
        github: 0x1::string::String,
        added_by: address,
    }

    struct ParticipantRemoved has copy, drop {
        campaign_obj_id: 0x2::object::ID,
        project_name: 0x1::string::String,
        wallet: address,
        removed_by: address,
    }

    struct ParticipantUpdated has copy, drop {
        campaign_obj_id: 0x2::object::ID,
        project_name: 0x1::string::String,
        wallet: address,
        new_name: 0x1::string::String,
        new_email: 0x1::string::String,
        new_github: 0x1::string::String,
        updated_by: address,
    }

    struct OrganizerCapIssued has copy, drop {
        campaign_obj_id: 0x2::object::ID,
        to: address,
        cap_id: 0x2::object::ID,
    }

    public fun add_admin(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    public fun add_participant_to_project(arg0: &mut Campaign, arg1: 0x1::string::String, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_active(arg0, arg6);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = ensure_projects(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<Project>(v1)) {
            let v3 = 0x1::vector::borrow_mut<Project>(v1, v2);
            if (v3.project_name == arg1) {
                assert!(v3.added_by == v0, 1);
                let v4 = 0;
                while (v4 < 0x1::vector::length<Participant>(&v3.participants)) {
                    if (0x1::vector::borrow<Participant>(&v3.participants, v4).wallet == arg2) {
                        return
                    };
                    v4 = v4 + 1;
                };
                let v5 = Participant{
                    wallet : arg2,
                    name   : arg3,
                    email  : arg4,
                    github : arg5,
                };
                0x1::vector::push_back<Participant>(&mut v3.participants, v5);
                let v6 = ParticipantAdded{
                    campaign_obj_id : 0x2::object::uid_to_inner(&arg0.id),
                    project_name    : arg1,
                    wallet          : arg2,
                    name            : arg3,
                    email           : arg4,
                    github          : arg5,
                    added_by        : v0,
                };
                0x2::event::emit<ParticipantAdded>(v6);
                return
            };
            v2 = v2 + 1;
        };
    }

    public fun add_project(arg0: &mut Campaign, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_active(arg0, arg4);
        let v0 = ensure_projects(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Project>(v0)) {
            if (0x1::vector::borrow<Project>(v0, v1).project_name == arg1) {
                return
            };
            v1 = v1 + 1;
        };
        let v2 = if (0x1::string::length(&arg3) > 0) {
            0x1::option::some<0x1::string::String>(arg3)
        } else {
            0x1::option::none<0x1::string::String>()
        };
        let v3 = 0x2::tx_context::sender(arg5);
        let v4 = Project{
            project_name : arg1,
            github_repo  : arg2,
            live_link    : v2,
            participants : 0x1::vector::empty<Participant>(),
            winner       : false,
            position     : 0,
            prizes       : 0x1::option::none<vector<0x1::string::String>>(),
            added_by     : v3,
        };
        0x1::vector::push_back<Project>(v0, v4);
        let v5 = ProjectAdded{
            campaign_obj_id : 0x2::object::uid_to_inner(&arg0.id),
            project_name    : arg1,
            github_repo     : arg2,
            live_link       : arg3,
            added_by        : v3,
        };
        0x2::event::emit<ProjectAdded>(v5);
    }

    public fun assert_active(arg0: &Campaign, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = if (arg0.archived == false) {
            if (v0 >= arg0.begin) {
                v0 <= arg0.end
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 2);
    }

    public fun create_campaign(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = Organizers{
            name    : arg7,
            website : arg8,
            email   : arg9,
            social  : arg10,
        };
        let v1 = if (0x1::string::length(&arg6) > 0) {
            0x1::option::some<0x1::string::String>(arg6)
        } else {
            0x1::option::none<0x1::string::String>()
        };
        let v2 = Campaign{
            id          : 0x2::object::new(arg13),
            campaign_id : arg1,
            PrizeUnits  : arg2,
            prize_type  : arg3,
            name        : arg4,
            description : arg5,
            url         : v1,
            projects    : 0x1::option::none<vector<Project>>(),
            organizers  : v0,
            begin       : arg11,
            end         : arg12,
            archived    : false,
        };
        let v3 = OrganizerCap{
            id       : 0x2::object::new(arg13),
            campaign : 0x2::object::uid_to_inner(&v2.id),
        };
        let v4 = CampaignCreated{
            campaign_obj_id : 0x2::object::uid_to_inner(&v2.id),
            campaign_id     : arg1,
            prize_units     : arg2,
            prize_type      : arg3,
            name            : arg4,
            begin           : arg11,
            end             : arg12,
            creator         : 0x2::tx_context::sender(arg13),
        };
        0x2::event::emit<CampaignCreated>(v4);
        0x2::transfer::transfer<OrganizerCap>(v3, 0x2::tx_context::sender(arg13));
        0x2::transfer::share_object<Campaign>(v2);
    }

    public fun delete_campaign(arg0: &mut Campaign, arg1: &OrganizerCap, arg2: &0x2::clock::Clock) {
        if (arg1.campaign != 0x2::object::uid_to_inner(&arg0.id)) {
            return
        };
        assert_active(arg0, arg2);
        arg0.archived = true;
        let v0 = CampaignDeleted{
            campaign_obj_id : 0x2::object::uid_to_inner(&arg0.id),
            cap_id          : 0x2::object::uid_to_inner(&arg1.id),
        };
        0x2::event::emit<CampaignDeleted>(v0);
    }

    public fun edit_campaign(arg0: &mut Campaign, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &OrganizerCap, arg7: &0x2::clock::Clock) {
        assert!(arg6.campaign == 0x2::object::uid_to_inner(&arg0.id), 1);
        assert_active(arg0, arg7);
        arg0.name = arg1;
        arg0.description = arg2;
        let v0 = if (0x1::string::length(&arg3) > 0) {
            0x1::option::some<0x1::string::String>(arg3)
        } else {
            0x1::option::none<0x1::string::String>()
        };
        arg0.url = v0;
        arg0.begin = arg4;
        arg0.end = arg5;
        let v1 = CampaignEdited{
            campaign_obj_id : 0x2::object::uid_to_inner(&arg0.id),
            name            : arg1,
            description     : arg2,
            url             : arg3,
            begin           : arg4,
            end             : arg5,
            cap_id          : 0x2::object::uid_to_inner(&arg6.id),
        };
        0x2::event::emit<CampaignEdited>(v1);
    }

    fun ensure_projects(arg0: &mut Campaign) : &mut vector<Project> {
        if (0x1::option::is_some<vector<Project>>(&arg0.projects)) {
            0x1::option::borrow_mut<vector<Project>>(&mut arg0.projects)
        } else {
            arg0.projects = 0x1::option::some<vector<Project>>(0x1::vector::empty<Project>());
            0x1::option::borrow_mut<vector<Project>>(&mut arg0.projects)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun issue_organizer_cap(arg0: &Campaign, arg1: address, arg2: &OrganizerCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2.campaign != 0x2::object::uid_to_inner(&arg0.id)) {
            return
        };
        assert_active(arg0, arg3);
        let v0 = OrganizerCap{
            id       : 0x2::object::new(arg4),
            campaign : 0x2::object::uid_to_inner(&arg0.id),
        };
        let v1 = OrganizerCapIssued{
            campaign_obj_id : 0x2::object::uid_to_inner(&arg0.id),
            to              : arg1,
            cap_id          : 0x2::object::uid_to_inner(&v0.id),
        };
        0x2::event::emit<OrganizerCapIssued>(v1);
        0x2::transfer::transfer<OrganizerCap>(v0, arg1);
    }

    public fun remove_participant_from_project(arg0: &mut Campaign, arg1: 0x1::string::String, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_active(arg0, arg3);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = ensure_projects(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<Project>(v1)) {
            let v3 = 0x1::vector::borrow_mut<Project>(v1, v2);
            if (v3.project_name == arg1) {
                assert!(v3.added_by == v0 || arg2 == v0, 1);
                let v4 = 0;
                while (v4 < 0x1::vector::length<Participant>(&v3.participants)) {
                    if (0x1::vector::borrow<Participant>(&v3.participants, v4).wallet == arg2) {
                        0x1::vector::remove<Participant>(&mut v3.participants, v4);
                        let v5 = ParticipantRemoved{
                            campaign_obj_id : 0x2::object::uid_to_inner(&arg0.id),
                            project_name    : arg1,
                            wallet          : arg2,
                            removed_by      : v0,
                        };
                        0x2::event::emit<ParticipantRemoved>(v5);
                        return
                    };
                    v4 = v4 + 1;
                };
                return
            };
            v2 = v2 + 1;
        };
    }

    public fun remove_project(arg0: &mut Campaign, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_active(arg0, arg2);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = ensure_projects(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<Project>(v1)) {
            let v3 = 0x1::vector::borrow<Project>(v1, v2);
            if (v3.project_name == arg1) {
                assert!(v3.added_by == v0, 1);
                0x1::vector::remove<Project>(v1, v2);
                let v4 = ProjectRemoved{
                    campaign_obj_id : 0x2::object::uid_to_inner(&arg0.id),
                    project_name    : arg1,
                    removed_by      : v0,
                };
                0x2::event::emit<ProjectRemoved>(v4);
                return
            };
            v2 = v2 + 1;
        };
    }

    public fun set_project_outcome(arg0: &mut Campaign, arg1: 0x1::string::String, arg2: bool, arg3: u64, arg4: vector<0x1::string::String>, arg5: &OrganizerCap, arg6: &0x2::clock::Clock) {
        if (arg5.campaign != 0x2::object::uid_to_inner(&arg0.id)) {
            return
        };
        assert_active(arg0, arg6);
        let v0 = ensure_projects(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Project>(v0)) {
            let v2 = 0x1::vector::borrow_mut<Project>(v0, v1);
            if (v2.project_name == arg1) {
                v2.winner = arg2;
                v2.position = arg3;
                let v3 = if (0x1::vector::length<0x1::string::String>(&arg4) > 0) {
                    0x1::option::some<vector<0x1::string::String>>(arg4)
                } else {
                    0x1::option::none<vector<0x1::string::String>>()
                };
                v2.prizes = v3;
                let v4 = ProjectOutcomeSet{
                    campaign_obj_id : 0x2::object::uid_to_inner(&arg0.id),
                    project_name    : arg1,
                    winner          : arg2,
                    position        : arg3,
                    prizes          : arg4,
                    cap_id          : 0x2::object::uid_to_inner(&arg5.id),
                };
                0x2::event::emit<ProjectOutcomeSet>(v4);
                return
            };
            v1 = v1 + 1;
        };
    }

    public fun update_participant(arg0: &mut Campaign, arg1: 0x1::string::String, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_active(arg0, arg6);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = ensure_projects(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<Project>(v1)) {
            let v3 = 0x1::vector::borrow_mut<Project>(v1, v2);
            if (v3.project_name == arg1) {
                assert!(v3.added_by == v0 || arg2 == v0, 1);
                let v4 = 0;
                while (v4 < 0x1::vector::length<Participant>(&v3.participants)) {
                    let v5 = 0x1::vector::borrow_mut<Participant>(&mut v3.participants, v4);
                    if (v5.wallet == arg2) {
                        v5.name = arg3;
                        v5.email = arg4;
                        v5.github = arg5;
                        let v6 = ParticipantUpdated{
                            campaign_obj_id : 0x2::object::uid_to_inner(&arg0.id),
                            project_name    : arg1,
                            wallet          : arg2,
                            new_name        : arg3,
                            new_email       : arg4,
                            new_github      : arg5,
                            updated_by      : v0,
                        };
                        0x2::event::emit<ParticipantUpdated>(v6);
                        return
                    };
                    v4 = v4 + 1;
                };
                return
            };
            v2 = v2 + 1;
        };
    }

    public fun update_project(arg0: &mut Campaign, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_active(arg0, arg4);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = ensure_projects(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<Project>(v1)) {
            let v3 = 0x1::vector::borrow_mut<Project>(v1, v2);
            if (v3.project_name == arg1) {
                assert!(v3.added_by == v0, 1);
                v3.github_repo = arg2;
                let v4 = if (0x1::string::length(&arg3) > 0) {
                    0x1::option::some<0x1::string::String>(arg3)
                } else {
                    0x1::option::none<0x1::string::String>()
                };
                v3.live_link = v4;
                let v5 = ProjectUpdated{
                    campaign_obj_id : 0x2::object::uid_to_inner(&arg0.id),
                    project_name    : arg1,
                    new_github_repo : arg2,
                    new_live_link   : arg3,
                    updated_by      : v0,
                };
                0x2::event::emit<ProjectUpdated>(v5);
                return
            };
            v2 = v2 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

