module 0xe1745f2ff49860686d38d828653d382c09cbb7b87366e1022a54b8d51fb0ed68::campaign {
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

    struct Project has drop, store {
        project_name: 0x1::string::String,
        github_repo: 0x1::string::String,
        live_link: 0x1::option::Option<0x1::string::String>,
        participants: vector<Participant>,
        winner: bool,
        position: u64,
        prizes: 0x1::option::Option<vector<0x1::string::String>>,
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
        cap_id: 0x2::object::ID,
    }

    struct ProjectRemoved has copy, drop {
        campaign_obj_id: 0x2::object::ID,
        project_name: 0x1::string::String,
        cap_id: 0x2::object::ID,
    }

    struct ProjectUpdated has copy, drop {
        campaign_obj_id: 0x2::object::ID,
        project_name: 0x1::string::String,
        new_github_repo: 0x1::string::String,
        new_live_link: 0x1::string::String,
        cap_id: 0x2::object::ID,
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
        cap_id: 0x2::object::ID,
    }

    struct ParticipantRemoved has copy, drop {
        campaign_obj_id: 0x2::object::ID,
        project_name: 0x1::string::String,
        wallet: address,
        cap_id: 0x2::object::ID,
    }

    struct ParticipantUpdated has copy, drop {
        campaign_obj_id: 0x2::object::ID,
        project_name: 0x1::string::String,
        wallet: address,
        new_name: 0x1::string::String,
        new_email: 0x1::string::String,
        new_github: 0x1::string::String,
        cap_id: 0x2::object::ID,
    }

    struct OrganizerCapIssued has copy, drop {
        campaign_obj_id: 0x2::object::ID,
        to: address,
        cap_id: 0x2::object::ID,
    }

    public fun add_participant_to_project(arg0: &mut Campaign, arg1: 0x1::string::String, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &OrganizerCap, arg7: &0x2::clock::Clock) {
        if (arg6.campaign != 0x2::object::uid_to_inner(&arg0.id)) {
            return
        };
        assert_active(arg0, arg7);
        let v0 = ensure_projects(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Project>(v0)) {
            let v2 = 0x1::vector::borrow_mut<Project>(v0, v1);
            if (v2.project_name == arg1) {
                let v3 = 0;
                while (v3 < 0x1::vector::length<Participant>(&v2.participants)) {
                    if (0x1::vector::borrow<Participant>(&v2.participants, v3).wallet == arg2) {
                        return
                    };
                    v3 = v3 + 1;
                };
                let v4 = Participant{
                    wallet : arg2,
                    name   : arg3,
                    email  : arg4,
                    github : arg5,
                };
                0x1::vector::push_back<Participant>(&mut v2.participants, v4);
                let v5 = ParticipantAdded{
                    campaign_obj_id : 0x2::object::uid_to_inner(&arg0.id),
                    project_name    : arg1,
                    wallet          : arg2,
                    name            : arg3,
                    email           : arg4,
                    github          : arg5,
                    cap_id          : 0x2::object::uid_to_inner(&arg6.id),
                };
                0x2::event::emit<ParticipantAdded>(v5);
                return
            };
            v1 = v1 + 1;
        };
    }

    public fun add_project(arg0: &mut Campaign, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &OrganizerCap, arg5: &0x2::clock::Clock) {
        if (arg4.campaign != 0x2::object::uid_to_inner(&arg0.id)) {
            return
        };
        assert_active(arg0, arg5);
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
        let v3 = Project{
            project_name : arg1,
            github_repo  : arg2,
            live_link    : v2,
            participants : 0x1::vector::empty<Participant>(),
            winner       : false,
            position     : 0,
            prizes       : 0x1::option::none<vector<0x1::string::String>>(),
        };
        0x1::vector::push_back<Project>(v0, v3);
        let v4 = ProjectAdded{
            campaign_obj_id : 0x2::object::uid_to_inner(&arg0.id),
            project_name    : arg1,
            github_repo     : arg2,
            live_link       : arg3,
            cap_id          : 0x2::object::uid_to_inner(&arg4.id),
        };
        0x2::event::emit<ProjectAdded>(v4);
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

    public fun create_campaign(arg0: u64, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = Organizers{
            name    : arg6,
            website : arg7,
            email   : arg8,
            social  : arg9,
        };
        let v1 = if (0x1::string::length(&arg5) > 0) {
            0x1::option::some<0x1::string::String>(arg5)
        } else {
            0x1::option::none<0x1::string::String>()
        };
        let v2 = Campaign{
            id          : 0x2::object::new(arg12),
            campaign_id : arg0,
            PrizeUnits  : arg1,
            prize_type  : arg2,
            name        : arg3,
            description : arg4,
            url         : v1,
            projects    : 0x1::option::none<vector<Project>>(),
            organizers  : v0,
            begin       : arg10,
            end         : arg11,
            archived    : false,
        };
        let v3 = OrganizerCap{
            id       : 0x2::object::new(arg12),
            campaign : 0x2::object::uid_to_inner(&v2.id),
        };
        let v4 = CampaignCreated{
            campaign_obj_id : 0x2::object::uid_to_inner(&v2.id),
            campaign_id     : arg0,
            prize_units     : arg1,
            prize_type      : arg2,
            name            : arg3,
            begin           : arg10,
            end             : arg11,
            creator         : 0x2::tx_context::sender(arg12),
        };
        0x2::event::emit<CampaignCreated>(v4);
        0x2::transfer::transfer<OrganizerCap>(v3, 0x2::tx_context::sender(arg12));
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

    public fun remove_participant_from_project(arg0: &mut Campaign, arg1: 0x1::string::String, arg2: address, arg3: &OrganizerCap, arg4: &0x2::clock::Clock) {
        if (arg3.campaign != 0x2::object::uid_to_inner(&arg0.id)) {
            return
        };
        assert_active(arg0, arg4);
        let v0 = ensure_projects(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Project>(v0)) {
            let v2 = 0x1::vector::borrow_mut<Project>(v0, v1);
            if (v2.project_name == arg1) {
                let v3 = 0;
                while (v3 < 0x1::vector::length<Participant>(&v2.participants)) {
                    if (0x1::vector::borrow<Participant>(&v2.participants, v3).wallet == arg2) {
                        0x1::vector::remove<Participant>(&mut v2.participants, v3);
                        let v4 = ParticipantRemoved{
                            campaign_obj_id : 0x2::object::uid_to_inner(&arg0.id),
                            project_name    : arg1,
                            wallet          : arg2,
                            cap_id          : 0x2::object::uid_to_inner(&arg3.id),
                        };
                        0x2::event::emit<ParticipantRemoved>(v4);
                        return
                    };
                    v3 = v3 + 1;
                };
                return
            };
            v1 = v1 + 1;
        };
    }

    public fun remove_project(arg0: &mut Campaign, arg1: 0x1::string::String, arg2: &OrganizerCap, arg3: &0x2::clock::Clock) {
        if (arg2.campaign != 0x2::object::uid_to_inner(&arg0.id)) {
            return
        };
        assert_active(arg0, arg3);
        let v0 = ensure_projects(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Project>(v0)) {
            if (0x1::vector::borrow<Project>(v0, v1).project_name == arg1) {
                0x1::vector::remove<Project>(v0, v1);
                let v2 = ProjectRemoved{
                    campaign_obj_id : 0x2::object::uid_to_inner(&arg0.id),
                    project_name    : arg1,
                    cap_id          : 0x2::object::uid_to_inner(&arg2.id),
                };
                0x2::event::emit<ProjectRemoved>(v2);
                return
            };
            v1 = v1 + 1;
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

    public fun update_participant(arg0: &mut Campaign, arg1: 0x1::string::String, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &OrganizerCap, arg7: &0x2::clock::Clock) {
        if (arg6.campaign != 0x2::object::uid_to_inner(&arg0.id)) {
            return
        };
        assert_active(arg0, arg7);
        let v0 = ensure_projects(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Project>(v0)) {
            let v2 = 0x1::vector::borrow_mut<Project>(v0, v1);
            if (v2.project_name == arg1) {
                let v3 = 0;
                while (v3 < 0x1::vector::length<Participant>(&v2.participants)) {
                    let v4 = 0x1::vector::borrow_mut<Participant>(&mut v2.participants, v3);
                    if (v4.wallet == arg2) {
                        v4.name = arg3;
                        v4.email = arg4;
                        v4.github = arg5;
                        let v5 = ParticipantUpdated{
                            campaign_obj_id : 0x2::object::uid_to_inner(&arg0.id),
                            project_name    : arg1,
                            wallet          : arg2,
                            new_name        : arg3,
                            new_email       : arg4,
                            new_github      : arg5,
                            cap_id          : 0x2::object::uid_to_inner(&arg6.id),
                        };
                        0x2::event::emit<ParticipantUpdated>(v5);
                        return
                    };
                    v3 = v3 + 1;
                };
                return
            };
            v1 = v1 + 1;
        };
    }

    public fun update_project(arg0: &mut Campaign, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &OrganizerCap, arg5: &0x2::clock::Clock) {
        if (arg4.campaign != 0x2::object::uid_to_inner(&arg0.id)) {
            return
        };
        assert_active(arg0, arg5);
        let v0 = ensure_projects(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Project>(v0)) {
            let v2 = 0x1::vector::borrow_mut<Project>(v0, v1);
            if (v2.project_name == arg1) {
                v2.github_repo = arg2;
                let v3 = if (0x1::string::length(&arg3) > 0) {
                    0x1::option::some<0x1::string::String>(arg3)
                } else {
                    0x1::option::none<0x1::string::String>()
                };
                v2.live_link = v3;
                let v4 = ProjectUpdated{
                    campaign_obj_id : 0x2::object::uid_to_inner(&arg0.id),
                    project_name    : arg1,
                    new_github_repo : arg2,
                    new_live_link   : arg3,
                    cap_id          : 0x2::object::uid_to_inner(&arg4.id),
                };
                0x2::event::emit<ProjectUpdated>(v4);
                return
            };
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

