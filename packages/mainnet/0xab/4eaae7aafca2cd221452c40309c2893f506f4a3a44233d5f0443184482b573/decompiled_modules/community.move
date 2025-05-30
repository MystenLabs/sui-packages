module 0xab4eaae7aafca2cd221452c40309c2893f506f4a3a44233d5f0443184482b573::community {
    struct DataCommunity has store {
        followers: vector<address>,
    }

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

    struct ListSlugProjectEvent has copy, drop {
        code: 0x1::string::String,
        community_id: 0x2::object::ID,
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

    struct AccountProfiles has store, key {
        id: 0x2::object::UID,
        account: address,
        quest_id: address,
        taskId: u64,
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
        campaigns_verify: 0x2::vec_map::VecMap<address, vector<0x1::string::String>>,
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
        total_ratings: u64,
        average_rating: u64,
        total_missions: u64,
        total_campaigns: u64,
        code_invite: 0x1::string::String,
        create_date: u64,
        update_date: u64,
        is_verify: u8,
        sprint_id: 0x2::object::ID,
    }

    public entry fun add_permission(arg0: &mut AdminConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 135289670007);
        0x1::vector::push_back<address>(&mut arg0.permissions, arg1);
    }

    public entry fun create_community(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<0x1::string::String>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<0x1::string::String>, arg8: u8, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg10);
        let v1 = 0x2::object::new(arg10);
        0x2::object::uid_to_inner(&v1);
        let v2 = Community{
            id                   : v1,
            banner               : 0x1::string::utf8(arg0),
            thumbnail            : 0x1::string::utf8(arg1),
            nameProject          : 0x1::string::utf8(arg2),
            name_project_slug    : 0x1::string::utf8(arg3),
            category             : arg4,
            short_desc           : 0x1::string::utf8(arg5),
            description          : 0x1::string::utf8(arg6),
            socials              : arg7,
            tracking_users_join  : 0x2::vec_map::empty<address, TrackingUsersJoin>(),
            campaigns_verify     : 0x2::vec_map::empty<address, vector<0x1::string::String>>(),
            status               : arg8,
            isReview             : 0,
            isLaunchpad          : 0,
            owner                : 0x2::tx_context::sender(arg10),
            total_reviews        : 0,
            total_comments       : 0,
            total_child_comments : 0,
            followers            : 0x2::vec_map::empty<address, Follower>(),
            ratings              : 0x1::vector::empty<address>(),
            qandas               : 0x1::vector::empty<address>(),
            total_ratings        : 0,
            average_rating       : 0,
            total_missions       : 0,
            total_campaigns      : 0,
            code_invite          : 0x1::string::utf8(arg9),
            create_date          : v0,
            update_date          : 0,
            is_verify            : 0,
            sprint_id            : 0x2::object::id_from_address(@0x7b),
        };
        let v3 = ManageCommunitys{
            id           : 0x2::object::new(arg10),
            community_id : 0x2::object::id<Community>(&v2),
            status       : 0,
            is_verify    : 0,
            feedback     : 0x1::string::utf8(b""),
            create_date  : v0,
            update_date  : 0,
            creater      : @0x0,
            updater      : @0x0,
        };
        let v4 = CommunityCreatedEvent{
            manage_id    : 0x2::object::id<ManageCommunitys>(&v3),
            community_id : 0x2::object::id<Community>(&v2),
        };
        0x2::event::emit<CommunityCreatedEvent>(v4);
        let v5 = ListSlugProjectEvent{
            code         : 0x1::string::utf8(arg3),
            community_id : 0x2::object::id<Community>(&v2),
        };
        0x2::event::emit<ListSlugProjectEvent>(v5);
        0x2::transfer::share_object<Community>(v2);
        0x2::transfer::share_object<ManageCommunitys>(v3);
    }

    public entry fun delete_permission(arg0: &mut AdminConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 135289670007);
        let (_, v1) = 0x1::vector::index_of<address>(&mut arg0.permissions, &arg1);
        0x1::vector::remove<address>(&mut arg0.permissions, v1);
    }

    public entry fun follow(arg0: &mut Community, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Follower{
            account     : v0,
            create_date : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::vec_map::insert<address, Follower>(&mut arg0.followers, v0, v1);
    }

    public fun get_address_admin() : address {
        @0x790169f7b248c93f249432509b73e36d83ba9f1e9da1127dcd58181916663e3c
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
    }

    public entry fun submit_review(arg0: &mut Community, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 135289670003);
        arg0.isReview = 1;
    }

    public(friend) fun tracking_users_join(arg0: &mut Community, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (!0x2::vec_map::contains<address, TrackingUsersJoin>(&arg0.tracking_users_join, &v0)) {
            let v1 = TrackingUsersJoin{
                id         : 0x2::object::new(arg2),
                account    : v0,
                totalDrops : arg1,
                join_date  : 0x2::tx_context::epoch_timestamp_ms(arg2),
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

    public entry fun update_community(arg0: &mut Community, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<0x1::string::String>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<0x1::string::String>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == arg0.owner, 135289670003);
        arg0.banner = 0x1::string::utf8(arg1);
        arg0.thumbnail = 0x1::string::utf8(arg2);
        arg0.nameProject = 0x1::string::utf8(arg3);
        arg0.category = arg4;
        arg0.short_desc = 0x1::string::utf8(arg5);
        arg0.description = 0x1::string::utf8(arg6);
        arg0.socials = arg7;
        arg0.update_date = 0x2::tx_context::epoch_timestamp_ms(arg8);
    }

    public(friend) fun update_qandas(arg0: &mut Community, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (0x1::vector::contains<address>(&arg0.qandas, &v0) == false) {
            0x1::vector::push_back<address>(&mut arg0.qandas, v0);
        };
    }

    public(friend) fun update_sprint_id(arg0: &mut Community, arg1: 0x2::object::ID) {
        arg0.sprint_id = arg1;
    }

    public entry fun update_status_community(arg0: &mut AdminConfig, arg1: &mut ManageCommunitys, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.permissions, &v0) == true, 135289670007);
        arg1.status = arg2;
        arg1.update_date = 0x2::tx_context::epoch_timestamp_ms(arg3);
        arg1.updater = v0;
    }

    public(friend) fun update_total_campaigns(arg0: &mut Community) {
        arg0.total_campaigns = arg0.total_campaigns + 1;
    }

    public(friend) fun update_total_child_comments(arg0: &mut Community, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (0x1::vector::contains<address>(&arg0.ratings, &v0) == false) {
            0x1::vector::push_back<address>(&mut arg0.ratings, v0);
        };
        arg0.total_child_comments = arg0.total_child_comments + 1;
    }

    public(friend) fun update_total_comments(arg0: &mut Community, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (0x1::vector::contains<address>(&arg0.ratings, &v0) == false) {
            0x1::vector::push_back<address>(&mut arg0.ratings, v0);
        };
        arg0.total_comments = arg0.total_comments + 1;
    }

    public(friend) fun update_total_missions(arg0: &mut Community) {
        arg0.total_missions = arg0.total_missions + 1;
    }

    public(friend) fun update_total_reviewers(arg0: &mut Community, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.total_ratings + arg1;
        let v1 = arg0.total_reviews + 1;
        arg0.total_ratings = v0;
        arg0.total_reviews = v1;
        arg0.average_rating = v0 / v1;
    }

    public(friend) fun validate_owner_community(arg0: &mut Community, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 135289670003);
        0x2::object::id<Community>(arg0);
    }

    public entry fun verify_campaigns(arg0: &mut Community, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::vec_map::insert<address, vector<0x1::string::String>>(&mut arg0.campaigns_verify, 0x2::tx_context::sender(arg2), arg1);
    }

    public entry fun verify_community(arg0: &mut AdminConfig, arg1: &mut ManageCommunitys, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.permissions, &v0) == true, 135289670007);
        arg1.is_verify = 1;
        arg1.update_date = 0x2::tx_context::epoch_timestamp_ms(arg2);
        arg1.updater = v0;
    }

    // decompiled from Move bytecode v6
}

