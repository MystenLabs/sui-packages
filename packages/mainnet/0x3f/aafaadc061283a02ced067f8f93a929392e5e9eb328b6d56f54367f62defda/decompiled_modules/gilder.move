module 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::gilder {
    struct Gilder has store {
        communities: 0x2::object_table::ObjectTable<address, Community>,
    }

    struct CommunityOwnerCap has store, key {
        id: 0x2::object::UID,
        community_address: address,
    }

    struct Community has store, key {
        id: 0x2::object::UID,
        avatar: 0x1::option::Option<0x2::url::Url>,
        cover_image: 0x1::option::Option<0x2::url::Url>,
        visible: bool,
        title: 0x1::string::String,
        description: 0x1::string::String,
        rules: 0x1::string::String,
        links: 0x1::string::String,
        resources: 0x1::string::String,
        created_at: u64,
        members: 0x2::table::Table<address, bool>,
        posts: 0x2::object_table::ObjectTable<address, Post>,
    }

    struct CommunityMutationPass {
        community_address: address,
    }

    struct CommunityEvent has copy, drop {
        id: address,
        avatar: 0x1::option::Option<0x2::url::Url>,
        cover_image: 0x1::option::Option<0x2::url::Url>,
        visible: bool,
        title: 0x1::string::String,
        description: 0x1::string::String,
        rules: 0x1::string::String,
        links: 0x1::string::String,
        resources: 0x1::string::String,
        created_at: u64,
        owner: address,
    }

    struct CommunityJoinEvent has copy, drop {
        community_id: address,
        user_id: address,
        action: 0x1::string::String,
    }

    struct Post has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        content: 0x1::string::String,
        creator: address,
        draft: bool,
        created_at: u64,
        voters: 0x2::table::Table<address, bool>,
        comments: 0x2::object_table::ObjectTable<address, Comment>,
    }

    struct PostMutationPass {
        post_address: address,
    }

    struct PostEvent has copy, drop {
        id: address,
        community_id: address,
        title: 0x1::string::String,
        content: 0x1::string::String,
        creator: address,
        draft: bool,
        created_at: u64,
    }

    struct VoteEvent has copy, drop {
        post_id: address,
        voter_id: address,
        upvote: bool,
    }

    struct Comment has store, key {
        id: 0x2::object::UID,
        creator: address,
        content: 0x1::string::String,
        created_at: u64,
    }

    struct CommentEvent has copy, drop {
        id: address,
        post_id: address,
        parent_id: address,
        creator: address,
        content: 0x1::string::String,
        created_at: u64,
    }

    public fun new(arg0: &0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : Gilder {
        Gilder{communities: 0x2::object_table::new<address, Community>(arg1)}
    }

    public fun check_joined(arg0: &mut 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::GilderApp, arg1: address, arg2: &0x2::tx_context::TxContext) : bool {
        0x2::table::contains<address, bool>(&0x2::object_table::borrow_mut<address, Community>(&mut 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::app_object_mut<0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::version::GilderV1, Gilder>(arg0).communities, arg1).members, 0x2::tx_context::sender(arg2))
    }

    public fun create_comment(arg0: &mut 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::GilderApp, arg1: address, arg2: address, arg3: vector<address>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (address, u64) {
        assert!(!0x1::vector::is_empty<u8>(&arg4), 900);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::object_table::borrow_mut<address, Post>(&mut 0x2::object_table::borrow_mut<address, Community>(&mut 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::app_object_mut<0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::version::GilderV1, Gilder>(arg0).communities, arg1).posts, arg2);
        let v2 = 0x2::object::new(arg6);
        let v3 = 0x2::object::uid_to_address(&v2);
        let v4 = Comment{
            id         : v2,
            creator    : v0,
            content    : 0x1::string::utf8(arg4),
            created_at : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::dynamic_field::add<vector<u8>, 0x2::object_table::ObjectTable<address, Comment>>(&mut v4.id, b"replies", 0x2::object_table::new<address, Comment>(arg6));
        let v5 = 0x2::object::uid_to_address(&v1.id);
        let v6 = &mut v1.comments;
        while (!0x1::vector::is_empty<address>(&arg3)) {
            let v7 = 0x2::object_table::borrow_mut<address, Comment>(v6, 0x1::vector::remove<address>(&mut arg3, 0));
            v5 = 0x2::object::uid_to_address(&v7.id);
            v6 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::object_table::ObjectTable<address, Comment>>(&mut v7.id, b"replies");
        };
        let v8 = CommentEvent{
            id         : v3,
            post_id    : arg2,
            parent_id  : v5,
            creator    : v0,
            content    : v4.content,
            created_at : v4.created_at,
        };
        0x2::event::emit<CommentEvent>(v8);
        0x2::object_table::add<address, Comment>(v6, v3, v4);
        (v3, 0x2::object_table::length<address, Comment>(v6))
    }

    public fun edit_community_avatar(arg0: Community, arg1: vector<u8>) : Community {
        arg0.avatar = 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg1));
        arg0
    }

    public fun edit_community_cover_image(arg0: Community, arg1: vector<u8>) : Community {
        arg0.cover_image = 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg1));
        arg0
    }

    public fun edit_community_description(arg0: Community, arg1: vector<u8>) : Community {
        arg0.description = 0x1::string::utf8(arg1);
        arg0
    }

    public fun edit_community_links(arg0: Community, arg1: vector<u8>) : Community {
        arg0.links = 0x1::string::utf8(arg1);
        arg0
    }

    public fun edit_community_resources(arg0: Community, arg1: vector<u8>) : Community {
        arg0.resources = 0x1::string::utf8(arg1);
        arg0
    }

    public fun edit_community_rules(arg0: Community, arg1: vector<u8>) : Community {
        arg0.rules = 0x1::string::utf8(arg1);
        arg0
    }

    public fun edit_community_title(arg0: Community, arg1: vector<u8>) : Community {
        arg0.title = 0x1::string::utf8(arg1);
        arg0
    }

    public fun edit_community_visible(arg0: Community, arg1: bool) : Community {
        arg0.visible = arg1;
        arg0
    }

    public fun edit_post_content(arg0: Post, arg1: vector<u8>) : Post {
        arg0.content = 0x1::string::utf8(arg1);
        arg0
    }

    public fun edit_post_draft(arg0: Post, arg1: bool) : Post {
        assert!(arg0.draft || !arg1, 202);
        arg0.draft = arg1;
        arg0
    }

    public fun edit_post_title(arg0: Post, arg1: vector<u8>) : Post {
        arg0.title = 0x1::string::utf8(arg1);
        arg0
    }

    public fun join(arg0: &mut 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::GilderApp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object_table::borrow_mut<address, Community>(&mut 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::app_object_mut<0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::version::GilderV1, Gilder>(arg0).communities, arg1);
        if (!0x2::table::contains<address, bool>(&v1.members, v0)) {
            0x2::table::add<address, bool>(&mut v1.members, v0, true);
            let v2 = CommunityJoinEvent{
                community_id : arg1,
                user_id      : v0,
                action       : 0x1::string::utf8(b"join"),
            };
            0x2::event::emit<CommunityJoinEvent>(v2);
        };
        0x2::table::length<address, bool>(&v1.members)
    }

    public fun leave(arg0: &mut 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::GilderApp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object_table::borrow_mut<address, Community>(&mut 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::app_object_mut<0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::version::GilderV1, Gilder>(arg0).communities, arg1);
        0x2::table::remove<address, bool>(&mut v1.members, v0);
        let v2 = CommunityJoinEvent{
            community_id : arg1,
            user_id      : v0,
            action       : 0x1::string::utf8(b"leave"),
        };
        0x2::event::emit<CommunityJoinEvent>(v2);
        0x2::table::length<address, bool>(&v1.members)
    }

    public fun new_community(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) : (Community, CommunityMutationPass, CommunityOwnerCap) {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = 0x1::string::utf8(b"");
        let v3 = 0x2::table::new<address, bool>(arg1);
        0x2::table::add<address, bool>(&mut v3, 0x2::tx_context::sender(arg1), true);
        let v4 = Community{
            id          : v0,
            avatar      : 0x1::option::none<0x2::url::Url>(),
            cover_image : 0x1::option::none<0x2::url::Url>(),
            visible     : true,
            title       : v2,
            description : v2,
            rules       : v2,
            links       : v2,
            resources   : v2,
            created_at  : 0x2::clock::timestamp_ms(arg0),
            members     : v3,
            posts       : 0x2::object_table::new<address, Post>(arg1),
        };
        let v5 = CommunityMutationPass{community_address: v1};
        let v6 = CommunityOwnerCap{
            id                : 0x2::object::new(arg1),
            community_address : v1,
        };
        (v4, v5, v6)
    }

    public fun new_post(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) : (Post, PostMutationPass) {
        let v0 = 0x2::object::new(arg1);
        let v1 = Post{
            id         : v0,
            title      : 0x1::string::utf8(b""),
            content    : 0x1::string::utf8(b""),
            creator    : 0x2::tx_context::sender(arg1),
            draft      : true,
            created_at : 0x2::clock::timestamp_ms(arg0),
            voters     : 0x2::table::new<address, bool>(arg1),
            comments   : 0x2::object_table::new<address, Comment>(arg1),
        };
        let v2 = PostMutationPass{post_address: 0x2::object::uid_to_address(&v0)};
        (v1, v2)
    }

    public fun save_community(arg0: &mut 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::GilderApp, arg1: Community, arg2: CommunityMutationPass, arg3: &mut 0x2::tx_context::TxContext) : address {
        let CommunityMutationPass { community_address: v0 } = arg2;
        assert!(v0 == 0x2::object::uid_to_address(&arg1.id), 102);
        assert!(!0x1::string::is_empty(&arg1.title) && !0x1::string::is_empty(&arg1.description), 900);
        let v1 = CommunityEvent{
            id          : v0,
            avatar      : arg1.avatar,
            cover_image : arg1.cover_image,
            visible     : arg1.visible,
            title       : arg1.title,
            description : arg1.description,
            rules       : arg1.rules,
            links       : arg1.links,
            resources   : arg1.resources,
            created_at  : arg1.created_at,
            owner       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<CommunityEvent>(v1);
        0x2::object_table::add<address, Community>(&mut 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::app_object_mut<0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::version::GilderV1, Gilder>(arg0).communities, v0, arg1);
        v0
    }

    public fun save_post(arg0: &mut 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::GilderApp, arg1: address, arg2: Post, arg3: PostMutationPass, arg4: &mut 0x2::tx_context::TxContext) : address {
        let PostMutationPass { post_address: v0 } = arg3;
        assert!(v0 == 0x2::object::uid_to_address(&arg2.id), 203);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::object_table::borrow_mut<address, Community>(&mut 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::app_object_mut<0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::version::GilderV1, Gilder>(arg0).communities, arg1);
        assert!(arg2.creator == v1, 200);
        assert!(0x2::table::contains<address, bool>(&v2.members, v1), 101);
        assert!(!0x1::string::is_empty(&arg2.title) && !0x1::string::is_empty(&arg2.content), 900);
        let v3 = PostEvent{
            id           : v0,
            community_id : arg1,
            title        : arg2.title,
            content      : arg2.content,
            creator      : arg2.creator,
            draft        : arg2.draft,
            created_at   : arg2.created_at,
        };
        0x2::event::emit<PostEvent>(v3);
        0x2::object_table::add<address, Post>(&mut v2.posts, v0, arg2);
        v0
    }

    public fun take_community(arg0: &CommunityOwnerCap, arg1: &mut 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::GilderApp, arg2: address) : (Community, CommunityMutationPass) {
        assert!(arg0.community_address == arg2, 100);
        let v0 = CommunityMutationPass{community_address: arg2};
        (0x2::object_table::remove<address, Community>(&mut 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::app_object_mut<0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::version::GilderV1, Gilder>(arg1).communities, arg2), v0)
    }

    public fun take_post(arg0: &mut 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::GilderApp, arg1: address, arg2: address) : (Post, PostMutationPass) {
        let v0 = PostMutationPass{post_address: arg2};
        (0x2::object_table::remove<address, Post>(&mut 0x2::object_table::borrow_mut<address, Community>(&mut 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::app_object_mut<0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::version::GilderV1, Gilder>(arg0).communities, arg1).posts, arg2), v0)
    }

    public fun vote(arg0: &mut 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::GilderApp, arg1: address, arg2: address, arg3: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object_table::borrow_mut<address, Community>(&mut 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app::app_object_mut<0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::version::GilderV1, Gilder>(arg0).communities, arg1);
        let v2 = 0x2::object_table::borrow_mut<address, Post>(&mut v1.posts, arg2);
        assert!(v2.creator != v0, 201);
        assert!(0x2::table::contains<address, bool>(&v1.members, v0), 204);
        0x2::table::add<address, bool>(&mut v2.voters, v0, true);
        let v3 = VoteEvent{
            post_id  : arg2,
            voter_id : v0,
            upvote   : true,
        };
        0x2::event::emit<VoteEvent>(v3);
        0x2::table::length<address, bool>(&v2.voters)
    }

    // decompiled from Move bytecode v6
}

