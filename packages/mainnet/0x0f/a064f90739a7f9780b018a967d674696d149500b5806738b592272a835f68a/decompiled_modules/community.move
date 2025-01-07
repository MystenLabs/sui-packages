module 0xfa064f90739a7f9780b018a967d674696d149500b5806738b592272a835f68a::community {
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
        owner: address,
    }

    struct AccountInfo has store {
        source: address,
    }

    struct AccountProfiles has store, key {
        id: 0x2::object::UID,
        account: address,
        quest_id: address,
        taskId: u64,
    }

    struct Follow has drop, store {
        account: address,
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
        community_id: 0x2::object::ID,
    }

    struct Community has key {
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
        followers: vector<Follow>,
        total_ratings: u64,
        average_rating: u64,
        total_missions: u64,
        total_campaigns: u64,
        code_invite: 0x1::string::String,
        create_date: u64,
        update_date: u64,
        is_verify: u8,
    }

    public entry fun create_community(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<0x1::string::String>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<0x1::string::String>, arg8: u8, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::object::new(arg10);
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
            owner                : v0,
            total_reviews        : 0,
            total_comments       : 0,
            total_child_comments : 0,
            followers            : 0x1::vector::empty<Follow>(),
            total_ratings        : 0,
            average_rating       : 0,
            total_missions       : 0,
            total_campaigns      : 0,
            code_invite          : 0x1::string::utf8(arg9),
            create_date          : 0x2::tx_context::epoch_timestamp_ms(arg10),
            update_date          : 0,
            is_verify            : 0,
        };
        let v3 = CommunityCreatedEvent{community_id: 0x2::object::id<Community>(&v2)};
        0x2::event::emit<CommunityCreatedEvent>(v3);
        let v4 = ListSlugProjectEvent{
            code         : 0x1::string::utf8(arg3),
            community_id : 0x2::object::id<Community>(&v2),
        };
        0x2::event::emit<ListSlugProjectEvent>(v4);
        0x2::transfer::share_object<Community>(v2);
        let v5 = AdminCap{
            id     : 0x2::object::new(arg10),
            obj_id : 0x2::object::uid_to_inner(&v1),
        };
        0x2::transfer::transfer<AdminCap>(v5, v0);
    }

    public entry fun follow(arg0: &mut Community, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Follow{account: 0x2::tx_context::sender(arg1)};
        0x1::vector::push_back<Follow>(&mut arg0.followers, v0);
    }

    public fun get_address_admin() : address {
        @0x14369c0c3eba649ae0d0f52546be19e5a191e0adf2d7c955507c1fc131c25738
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminConfig{
            id    : 0x2::object::new(arg0),
            owner : @0x14369c0c3eba649ae0d0f52546be19e5a191e0adf2d7c955507c1fc131c25738,
        };
        0x2::transfer::public_transfer<AdminConfig>(v0, @0x14369c0c3eba649ae0d0f52546be19e5a191e0adf2d7c955507c1fc131c25738);
    }

    public entry fun submit_review(arg0: &mut Community, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 135289670003);
        arg0.isReview = 1;
    }

    public fun tracking_users_join(arg0: &mut Community, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
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

    public entry fun tranfer_admin(arg0: &mut AdminConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 135289670007);
        arg0.owner = arg1;
    }

    public entry fun unfollow(arg0: &mut Community, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<Follow>(&arg0.followers);
        while (v0 > 0) {
            let v1 = v0 - 1;
            v0 = v1;
            if (0x2::tx_context::sender(arg1) == 0x1::vector::borrow_mut<Follow>(&mut arg0.followers, v1).account) {
                0x1::vector::remove<Follow>(&mut arg0.followers, v1);
                return
            };
        };
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

    public entry fun update_dynamicfield(arg0: &mut Community, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TotalToken{
            id          : 0x2::object::new(arg1),
            totalsToken : 100,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, TotalToken>(&mut arg0.id, 0x2::object::id<TotalToken>(&v0), v0);
    }

    public entry fun update_status_community(arg0: &AdminConfig, arg1: &mut Community, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 135289670007);
        arg1.status = arg2;
        arg1.isReview = 0;
    }

    public entry fun update_total_campaigns(arg0: &mut Community) {
        arg0.total_campaigns = arg0.total_campaigns + 1;
    }

    public entry fun update_total_child_comments(arg0: &mut Community, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.total_child_comments = arg0.total_child_comments + 1;
    }

    public entry fun update_total_comments(arg0: &mut Community, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.total_comments = arg0.total_comments + 1;
    }

    public entry fun update_total_missions(arg0: &mut Community) {
        arg0.total_missions = arg0.total_missions + 1;
    }

    public entry fun update_total_reviewers(arg0: &mut Community, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.total_ratings + arg1;
        let v1 = arg0.total_reviews + 1;
        arg0.total_ratings = v0;
        arg0.total_reviews = v1;
        arg0.average_rating = v0 / v1;
    }

    public entry fun verify_campaigns(arg0: &mut Community, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::vec_map::insert<address, vector<0x1::string::String>>(&mut arg0.campaigns_verify, 0x2::tx_context::sender(arg2), arg1);
    }

    public entry fun verify_community(arg0: &AdminConfig, arg1: &mut Community, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 135289670007);
        arg1.is_verify = 1;
    }

    // decompiled from Move bytecode v6
}

