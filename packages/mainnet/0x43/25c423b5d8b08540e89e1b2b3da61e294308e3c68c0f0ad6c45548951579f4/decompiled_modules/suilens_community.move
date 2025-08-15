module 0x4325c423b5d8b08540e89e1b2b3da61e294308e3c68c0f0ad6c45548951579f4::suilens_community {
    struct Community has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        region: 0x1::string::String,
        category: 0x1::string::String,
        admin: address,
        moderators: 0x2::vec_set::VecSet<address>,
        members: 0x2::vec_set::VecSet<address>,
        events: 0x2::vec_set::VecSet<0x2::object::ID>,
        announcements: 0x2::vec_set::VecSet<0x2::object::ID>,
        is_active: bool,
        is_private: bool,
        join_requests: 0x2::vec_set::VecSet<address>,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        created_at: u64,
        updated_at: u64,
    }

    struct Announcement has store, key {
        id: 0x2::object::UID,
        community_id: 0x2::object::ID,
        author: address,
        title: 0x1::string::String,
        content: 0x1::string::String,
        created_at: u64,
    }

    struct CommunityRegistry has key {
        id: 0x2::object::UID,
        communities: 0x2::table::Table<0x2::object::ID, Community>,
        regional_communities: 0x2::table::Table<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>,
        category_communities: 0x2::table::Table<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>,
        user_communities: 0x2::table::Table<address, 0x2::vec_set::VecSet<0x2::object::ID>>,
        total_communities: u64,
    }

    struct CommunityCreated has copy, drop {
        community_id: 0x2::object::ID,
        name: 0x1::string::String,
        region: 0x1::string::String,
        category: 0x1::string::String,
        admin: address,
    }

    struct MemberJoined has copy, drop {
        community_id: 0x2::object::ID,
        member: address,
        member_count: u64,
    }

    struct MemberLeft has copy, drop {
        community_id: 0x2::object::ID,
        member: address,
        member_count: u64,
    }

    struct AnnouncementPosted has copy, drop {
        announcement_id: 0x2::object::ID,
        community_id: 0x2::object::ID,
        author: address,
        title: 0x1::string::String,
    }

    public fun add_community_event(arg0: &mut CommunityRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<0x2::object::ID, Community>(&arg0.communities, arg1), 1);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Community>(&mut arg0.communities, arg1);
        assert!(v1.admin == v0 || 0x2::vec_set::contains<address>(&v1.moderators, &v0), 0);
        0x2::vec_set::insert<0x2::object::ID>(&mut v1.events, arg2);
    }

    public fun add_moderator(arg0: &mut CommunityRegistry, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Community>(&arg0.communities, arg1), 1);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Community>(&mut arg0.communities, arg1);
        assert!(v0.admin == 0x2::tx_context::sender(arg3), 0);
        assert!(0x2::vec_set::contains<address>(&v0.members, &arg2), 3);
        0x2::vec_set::insert<address>(&mut v0.moderators, arg2);
    }

    public fun approve_join_request(arg0: &mut CommunityRegistry, arg1: &mut 0x4325c423b5d8b08540e89e1b2b3da61e294308e3c68c0f0ad6c45548951579f4::suilens_core::GlobalRegistry, arg2: 0x2::object::ID, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<0x2::object::ID, Community>(&arg0.communities, arg2), 1);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Community>(&mut arg0.communities, arg2);
        assert!(v1.admin == v0 || 0x2::vec_set::contains<address>(&v1.moderators, &v0), 0);
        assert!(0x2::vec_set::contains<address>(&v1.join_requests, &arg3), 3);
        0x2::vec_set::remove<address>(&mut v1.join_requests, &arg3);
        0x2::vec_set::insert<address>(&mut v1.members, arg3);
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.user_communities, arg3)) {
            0x2::table::add<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.user_communities, arg3, 0x2::vec_set::empty<0x2::object::ID>());
        };
        0x2::vec_set::insert<0x2::object::ID>(0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.user_communities, arg3), arg2);
        0x4325c423b5d8b08540e89e1b2b3da61e294308e3c68c0f0ad6c45548951579f4::suilens_core::add_user_community(arg1, arg3, arg2);
        let v2 = MemberJoined{
            community_id : arg2,
            member       : arg3,
            member_count : 0x2::vec_set::size<address>(&v1.members),
        };
        0x2::event::emit<MemberJoined>(v2);
    }

    public fun create_community(arg0: &mut CommunityRegistry, arg1: &0x4325c423b5d8b08540e89e1b2b3da61e294308e3c68c0f0ad6c45548951579f4::suilens_core::GlobalRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0x4325c423b5d8b08540e89e1b2b3da61e294308e3c68c0f0ad6c45548951579f4::suilens_core::has_user_profile(arg1, v0), 6);
        let v1 = if (arg6 == 0x1::string::utf8(b"regional")) {
            true
        } else if (arg6 == 0x1::string::utf8(b"gaming")) {
            true
        } else if (arg6 == 0x1::string::utf8(b"development")) {
            true
        } else {
            arg6 == 0x1::string::utf8(b"general")
        };
        assert!(v1, 5);
        let v2 = 0x2::object::new(arg9);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = 0x2::clock::timestamp_ms(arg8);
        let v5 = Community{
            id            : v2,
            name          : arg2,
            description   : arg3,
            image_url     : arg4,
            region        : arg5,
            category      : arg6,
            admin         : v0,
            moderators    : 0x2::vec_set::empty<address>(),
            members       : 0x2::vec_set::singleton<address>(v0),
            events        : 0x2::vec_set::empty<0x2::object::ID>(),
            announcements : 0x2::vec_set::empty<0x2::object::ID>(),
            is_active     : true,
            is_private    : arg7,
            join_requests : 0x2::vec_set::empty<address>(),
            metadata      : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            created_at    : v4,
            updated_at    : v4,
        };
        if (!0x2::table::contains<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.regional_communities, arg5)) {
            0x2::table::add<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.regional_communities, arg5, 0x2::vec_set::empty<0x2::object::ID>());
        };
        0x2::vec_set::insert<0x2::object::ID>(0x2::table::borrow_mut<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.regional_communities, arg5), v3);
        if (!0x2::table::contains<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.category_communities, arg6)) {
            0x2::table::add<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.category_communities, arg6, 0x2::vec_set::empty<0x2::object::ID>());
        };
        0x2::vec_set::insert<0x2::object::ID>(0x2::table::borrow_mut<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.category_communities, arg6), v3);
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.user_communities, v0)) {
            0x2::table::add<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.user_communities, v0, 0x2::vec_set::empty<0x2::object::ID>());
        };
        0x2::vec_set::insert<0x2::object::ID>(0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.user_communities, v0), v3);
        let v6 = CommunityCreated{
            community_id : v3,
            name         : v5.name,
            region       : v5.region,
            category     : v5.category,
            admin        : v0,
        };
        0x2::event::emit<CommunityCreated>(v6);
        0x2::table::add<0x2::object::ID, Community>(&mut arg0.communities, v3, v5);
        arg0.total_communities = arg0.total_communities + 1;
    }

    public fun get_category_communities(arg0: &CommunityRegistry, arg1: 0x1::string::String) : 0x2::vec_set::VecSet<0x2::object::ID> {
        if (0x2::table::contains<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.category_communities, arg1)) {
            *0x2::table::borrow<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.category_communities, arg1)
        } else {
            0x2::vec_set::empty<0x2::object::ID>()
        }
    }

    public fun get_community(arg0: &CommunityRegistry, arg1: 0x2::object::ID) : &Community {
        0x2::table::borrow<0x2::object::ID, Community>(&arg0.communities, arg1)
    }

    public fun get_member_count(arg0: &CommunityRegistry, arg1: 0x2::object::ID) : u64 {
        0x2::vec_set::size<address>(&0x2::table::borrow<0x2::object::ID, Community>(&arg0.communities, arg1).members)
    }

    public fun get_regional_communities(arg0: &CommunityRegistry, arg1: 0x1::string::String) : 0x2::vec_set::VecSet<0x2::object::ID> {
        if (0x2::table::contains<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.regional_communities, arg1)) {
            *0x2::table::borrow<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.regional_communities, arg1)
        } else {
            0x2::vec_set::empty<0x2::object::ID>()
        }
    }

    public fun get_user_communities(arg0: &CommunityRegistry, arg1: address) : 0x2::vec_set::VecSet<0x2::object::ID> {
        if (0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.user_communities, arg1)) {
            *0x2::table::borrow<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.user_communities, arg1)
        } else {
            0x2::vec_set::empty<0x2::object::ID>()
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CommunityRegistry{
            id                   : 0x2::object::new(arg0),
            communities          : 0x2::table::new<0x2::object::ID, Community>(arg0),
            regional_communities : 0x2::table::new<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(arg0),
            category_communities : 0x2::table::new<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(arg0),
            user_communities     : 0x2::table::new<address, 0x2::vec_set::VecSet<0x2::object::ID>>(arg0),
            total_communities    : 0,
        };
        0x2::transfer::share_object<CommunityRegistry>(v0);
    }

    public fun is_member(arg0: &CommunityRegistry, arg1: 0x2::object::ID, arg2: address) : bool {
        if (!0x2::table::contains<0x2::object::ID, Community>(&arg0.communities, arg1)) {
            return false
        };
        0x2::vec_set::contains<address>(&0x2::table::borrow<0x2::object::ID, Community>(&arg0.communities, arg1).members, &arg2)
    }

    public fun join_community(arg0: &mut CommunityRegistry, arg1: &mut 0x4325c423b5d8b08540e89e1b2b3da61e294308e3c68c0f0ad6c45548951579f4::suilens_core::GlobalRegistry, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x4325c423b5d8b08540e89e1b2b3da61e294308e3c68c0f0ad6c45548951579f4::suilens_core::has_user_profile(arg1, v0), 6);
        assert!(0x2::table::contains<0x2::object::ID, Community>(&arg0.communities, arg2), 1);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Community>(&mut arg0.communities, arg2);
        assert!(!0x2::vec_set::contains<address>(&v1.members, &v0), 2);
        if (v1.is_private) {
            0x2::vec_set::insert<address>(&mut v1.join_requests, v0);
        } else {
            0x2::vec_set::insert<address>(&mut v1.members, v0);
            if (!0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.user_communities, v0)) {
                0x2::table::add<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.user_communities, v0, 0x2::vec_set::empty<0x2::object::ID>());
            };
            0x2::vec_set::insert<0x2::object::ID>(0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.user_communities, v0), arg2);
            0x4325c423b5d8b08540e89e1b2b3da61e294308e3c68c0f0ad6c45548951579f4::suilens_core::add_user_community(arg1, v0, arg2);
            let v2 = MemberJoined{
                community_id : arg2,
                member       : v0,
                member_count : 0x2::vec_set::size<address>(&v1.members),
            };
            0x2::event::emit<MemberJoined>(v2);
        };
    }

    public fun leave_community(arg0: &mut CommunityRegistry, arg1: &mut 0x4325c423b5d8b08540e89e1b2b3da61e294308e3c68c0f0ad6c45548951579f4::suilens_core::GlobalRegistry, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<0x2::object::ID, Community>(&arg0.communities, arg2), 1);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Community>(&mut arg0.communities, arg2);
        assert!(0x2::vec_set::contains<address>(&v1.members, &v0), 3);
        assert!(v1.admin != v0, 0);
        0x2::vec_set::remove<address>(&mut v1.members, &v0);
        if (0x2::vec_set::contains<address>(&v1.moderators, &v0)) {
            0x2::vec_set::remove<address>(&mut v1.moderators, &v0);
        };
        0x2::vec_set::remove<0x2::object::ID>(0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.user_communities, v0), &arg2);
        0x4325c423b5d8b08540e89e1b2b3da61e294308e3c68c0f0ad6c45548951579f4::suilens_core::remove_user_community(arg1, v0, arg2);
        let v2 = MemberLeft{
            community_id : arg2,
            member       : v0,
            member_count : 0x2::vec_set::size<address>(&v1.members),
        };
        0x2::event::emit<MemberLeft>(v2);
    }

    public fun post_announcement(arg0: &mut CommunityRegistry, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<0x2::object::ID, Community>(&arg0.communities, arg1), 1);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Community>(&mut arg0.communities, arg1);
        assert!(v1.admin == v0 || 0x2::vec_set::contains<address>(&v1.moderators, &v0), 0);
        let v2 = 0x2::object::new(arg5);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = Announcement{
            id           : v2,
            community_id : arg1,
            author       : v0,
            title        : arg2,
            content      : arg3,
            created_at   : 0x2::clock::timestamp_ms(arg4),
        };
        let v5 = AnnouncementPosted{
            announcement_id : v3,
            community_id    : arg1,
            author          : v0,
            title           : v4.title,
        };
        0x2::event::emit<AnnouncementPosted>(v5);
        0x2::vec_set::insert<0x2::object::ID>(&mut v1.announcements, v3);
        0x2::transfer::share_object<Announcement>(v4);
    }

    public fun update_community(arg0: &mut CommunityRegistry, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Community>(&arg0.communities, arg1), 1);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Community>(&mut arg0.communities, arg1);
        assert!(v0.admin == 0x2::tx_context::sender(arg6), 0);
        v0.name = arg2;
        v0.description = arg3;
        v0.image_url = arg4;
        v0.updated_at = 0x2::clock::timestamp_ms(arg5);
    }

    // decompiled from Move bytecode v6
}

