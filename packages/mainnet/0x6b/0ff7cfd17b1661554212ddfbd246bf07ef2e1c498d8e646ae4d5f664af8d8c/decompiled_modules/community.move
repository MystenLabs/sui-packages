module 0x6b0ff7cfd17b1661554212ddfbd246bf07ef2e1c498d8e646ae4d5f664af8d8c::community {
    struct ManageCommunitys has store, key {
        id: 0x2::object::UID,
        community_id: 0x2::object::ID,
        status: u8,
        is_verify: u8,
        feedback: 0x1::string::String,
        create_date: u64,
        update_date: u64,
        creater: address,
        updater: address,
    }

    struct ListSlugProjectEvent has copy, drop, store {
        code: 0x1::string::String,
        community_id: 0x2::object::ID,
    }

    struct InitData has store, key {
        id: 0x2::object::UID,
        list_commmunity: 0x2::vec_map::VecMap<0x1::string::String, ListSlugProjectEvent>,
    }

    struct TrackingUsersJoin has store, key {
        id: 0x2::object::UID,
        account: address,
        totalDrops: u64,
        join_date: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        obj_id: 0x2::object::ID,
    }

    struct AdminConfig has store, key {
        id: 0x2::object::UID,
        permissions: vector<address>,
        owner: address,
    }

    struct AccountInfo has store {
        source: address,
    }

    struct Follower has drop, store {
        account: address,
        create_date: u64,
    }

    struct Task has drop, store {
        idTemplate: address,
        url: 0x1::string::String,
        status: u8,
    }

    struct User has drop, store {
        account: address,
        taskId: u8,
    }

    struct UserNew has drop, store {
        account: address,
        taskId: u8,
    }

    struct Template has store, key {
        id: 0x2::object::UID,
        logo: 0x1::string::String,
        title: 0x1::string::String,
        description: 0x1::string::String,
        type: u8,
        group: 0x1::string::String,
        creator: address,
    }

    struct TotalToken has store, key {
        id: 0x2::object::UID,
        totalsToken: u64,
    }

    struct CommunityCreatedEvent has copy, drop {
        manage_id: 0x2::object::ID,
        community_id: 0x2::object::ID,
    }

    struct Community has store, key {
        id: 0x2::object::UID,
        banner: 0x1::string::String,
        thumbnail: 0x1::string::String,
        nameProject: 0x1::string::String,
        name_project_slug: 0x1::string::String,
        category: vector<0x1::string::String>,
        short_desc: 0x1::string::String,
        description: 0x1::string::String,
        socials: vector<0x1::string::String>,
        tracking_users_join: 0x2::vec_map::VecMap<address, TrackingUsersJoin>,
        list_comment: vector<0x2::object::ID>,
        status: u8,
        isReview: u8,
        isLaunchpad: u8,
        owner: address,
        total_reviews: u64,
        total_comments: u64,
        total_child_comments: u64,
        followers: 0x2::vec_map::VecMap<address, Follower>,
        ratings: vector<address>,
        qandas: vector<address>,
        total_point_rating: u64,
        total_ratinger: u64,
        total_missions: u64,
        total_campaigns: u64,
        create_date: u64,
        update_date: u64,
        is_verify: u8,
        sprint_id: 0x2::object::ID,
    }

    public entry fun add_permission(arg0: &mut AdminConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 135289670007);
        0x1::vector::push_back<address>(&mut arg0.permissions, arg1);
    }

    public entry fun create_community(arg0: &mut InitData, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<0x1::string::String>, arg6: vector<u8>, arg7: vector<u8>, arg8: u8, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::epoch_timestamp_ms(arg11);
        let v0 = 0x2::object::new(arg11);
        0x2::object::uid_to_inner(&v0);
        let v1 = Community{
            id                   : v0,
            banner               : 0x1::string::utf8(arg1),
            thumbnail            : 0x1::string::utf8(arg2),
            nameProject          : 0x1::string::utf8(arg3),
            name_project_slug    : 0x1::string::utf8(arg4),
            category             : arg5,
            short_desc           : 0x1::string::utf8(arg6),
            description          : 0x1::string::utf8(arg7),
            socials              : 0x1::vector::empty<0x1::string::String>(),
            tracking_users_join  : 0x2::vec_map::empty<address, TrackingUsersJoin>(),
            list_comment         : 0x1::vector::empty<0x2::object::ID>(),
            status               : arg8,
            isReview             : 0,
            isLaunchpad          : 0,
            owner                : 0x2::tx_context::sender(arg11),
            total_reviews        : 0,
            total_comments       : 0,
            total_child_comments : 0,
            followers            : 0x2::vec_map::empty<address, Follower>(),
            ratings              : 0x1::vector::empty<address>(),
            qandas               : 0x1::vector::empty<address>(),
            total_point_rating   : 0,
            total_ratinger       : 0,
            total_missions       : 0,
            total_campaigns      : 0,
            create_date          : 0x2::clock::timestamp_ms(arg10),
            update_date          : 0,
            is_verify            : 0,
            sprint_id            : 0x2::object::id_from_address(@0x7b),
        };
        let v2 = ManageCommunitys{
            id           : 0x2::object::new(arg11),
            community_id : 0x2::object::id<Community>(&v1),
            status       : 0,
            is_verify    : 0,
            feedback     : 0x1::string::utf8(b""),
            create_date  : 0x2::clock::timestamp_ms(arg10),
            update_date  : 0,
            creater      : @0x0,
            updater      : @0x0,
        };
        let v3 = ListSlugProjectEvent{
            code         : 0x1::string::utf8(arg4),
            community_id : 0x2::object::id<Community>(&v1),
        };
        0x2::vec_map::insert<0x1::string::String, ListSlugProjectEvent>(&mut arg0.list_commmunity, 0x1::string::utf8(arg4), v3);
        0x2::event::emit<ListSlugProjectEvent>(v3);
        let v4 = CommunityCreatedEvent{
            manage_id    : 0x2::object::id<ManageCommunitys>(&v2),
            community_id : 0x2::object::id<Community>(&v1),
        };
        0x2::event::emit<CommunityCreatedEvent>(v4);
        0x2::transfer::share_object<Community>(v1);
        0x2::transfer::share_object<ManageCommunitys>(v2);
    }

    public entry fun delete_permission(arg0: &mut AdminConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 135289670007);
        let (_, v1) = 0x1::vector::index_of<address>(&mut arg0.permissions, &arg1);
        0x1::vector::remove<address>(&mut arg0.permissions, v1);
    }

    public entry fun follow(arg0: &mut Community, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = Follower{
            account     : v0,
            create_date : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::vec_map::insert<address, Follower>(&mut arg0.followers, v0, v1);
    }

    public fun get_address_admin() : address {
        @0x790169f7b248c93f249432509b73e36d83ba9f1e9da1127dcd58181916663e3c
    }

    public fun get_community(arg0: &mut InitData, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x2::tx_context::sender(arg2);
        0x2::vec_map::get_mut<0x1::string::String, ListSlugProjectEvent>(&mut arg0.list_commmunity, &arg1).community_id
    }

    public entry fun get_follower(arg0: &mut Community, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::vec_map::get_mut<address, Follower>(&mut arg0.followers, &v0).account == v0
    }

    public entry fun get_id(arg0: &mut Community) : 0x2::object::ID {
        0x2::object::id<Community>(arg0)
    }

    public entry fun get_qanda(arg0: &mut Community, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg1);
        0x1::vector::contains<address>(&arg0.qandas, &v0)
    }

    public entry fun get_rating(arg0: &mut Community, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg1);
        0x1::vector::contains<address>(&arg0.ratings, &v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminConfig{
            id          : 0x2::object::new(arg0),
            permissions : 0x1::vector::empty<address>(),
            owner       : @0x790169f7b248c93f249432509b73e36d83ba9f1e9da1127dcd58181916663e3c,
        };
        0x2::transfer::share_object<AdminConfig>(v0);
        let v1 = InitData{
            id              : 0x2::object::new(arg0),
            list_commmunity : 0x2::vec_map::empty<0x1::string::String, ListSlugProjectEvent>(),
        };
        0x2::transfer::share_object<InitData>(v1);
    }

    public entry fun submit_review(arg0: &mut Community, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 135289670003);
        arg0.isReview = 1;
    }

    public(friend) fun tracking_users_join(arg0: &mut Community, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (!0x2::vec_map::contains<address, TrackingUsersJoin>(&arg0.tracking_users_join, &v0)) {
            let v1 = TrackingUsersJoin{
                id         : 0x2::object::new(arg3),
                account    : v0,
                totalDrops : arg1,
                join_date  : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::vec_map::insert<address, TrackingUsersJoin>(&mut arg0.tracking_users_join, v0, v1);
        } else {
            let v2 = 0x2::vec_map::get_mut<address, TrackingUsersJoin>(&mut arg0.tracking_users_join, &v0);
            v2.totalDrops = v2.totalDrops + arg1;
        };
    }

    public entry fun tranfer_community(arg0: &mut Community, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 135289670003);
        arg0.owner = arg1;
    }

    public entry fun unfollow(arg0: &mut Community, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::vec_map::get_mut<address, Follower>(&mut arg0.followers, &v0);
        let (_, _) = 0x2::vec_map::remove<address, Follower>(&mut arg0.followers, &v0);
    }

    public entry fun update_community(arg0: &mut Community, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<0x1::string::String>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<0x1::string::String>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg9) == arg0.owner, 135289670003);
        arg0.banner = 0x1::string::utf8(arg1);
        arg0.thumbnail = 0x1::string::utf8(arg2);
        arg0.nameProject = 0x1::string::utf8(arg3);
        arg0.category = arg4;
        arg0.short_desc = 0x1::string::utf8(arg5);
        arg0.description = 0x1::string::utf8(arg6);
        arg0.socials = arg7;
        arg0.update_date = 0x2::clock::timestamp_ms(arg8);
    }

    public(friend) fun update_list_comments(arg0: &mut Community, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.list_comment, arg1);
    }

    public(friend) fun update_qandas(arg0: &mut Community, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (0x1::vector::contains<address>(&arg0.qandas, &v0) == false) {
            0x1::vector::push_back<address>(&mut arg0.qandas, v0);
        };
    }

    public(friend) fun update_rating(arg0: &mut Community, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        arg0.total_point_rating = arg0.total_point_rating + arg1;
        arg0.total_ratinger = arg0.total_ratinger + 1;
        if (0x1::vector::contains<address>(&arg0.ratings, &v0) == false) {
            0x1::vector::push_back<address>(&mut arg0.ratings, v0);
        };
    }

    public(friend) fun update_sprint_id(arg0: &mut Community, arg1: 0x2::object::ID) {
        arg0.sprint_id = arg1;
    }

    public entry fun update_status_community(arg0: &mut AdminConfig, arg1: &mut ManageCommunitys, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x1::vector::contains<address>(&arg0.permissions, &v0) == true, 135289670007);
        arg1.status = arg2;
        arg1.update_date = 0x2::clock::timestamp_ms(arg3);
        arg1.updater = v0;
    }

    public(friend) fun update_total_child_comments(arg0: &mut Community, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg1);
        arg0.total_child_comments = arg0.total_child_comments + 1;
    }

    public(friend) fun update_total_comments(arg0: &mut Community, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg1);
        arg0.total_comments = arg0.total_comments + 1;
    }

    public(friend) fun update_total_missions(arg0: &mut Community) {
        arg0.total_missions = arg0.total_missions + 1;
    }

    public(friend) fun validate_owner_community(arg0: &mut Community, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 135289670003);
        0x2::object::id<Community>(arg0);
    }

    public entry fun verify_community(arg0: &mut AdminConfig, arg1: &mut ManageCommunitys, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.permissions, &v0) == true, 135289670007);
        arg1.is_verify = 1;
        arg1.update_date = 0x2::clock::timestamp_ms(arg2);
        arg1.updater = v0;
    }

    // decompiled from Move bytecode v6
}

