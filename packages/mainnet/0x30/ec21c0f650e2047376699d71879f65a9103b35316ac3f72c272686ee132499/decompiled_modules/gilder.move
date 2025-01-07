module 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::gilder {
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
        status: 0x1::string::String,
        title: 0x1::string::String,
        description: 0x1::string::String,
        rules: 0x1::string::String,
        links: 0x1::string::String,
        resources: 0x1::string::String,
        created_at: u64,
        updated_at: u64,
        members: 0x2::table::Table<address, bool>,
        posts: 0x2::object_table::ObjectTable<address, Post>,
        logs: 0x2::table::Table<u64, ModificationLog>,
    }

    struct CommunityMutationPass {
        community_address: address,
    }

    struct CommunityEvent has copy, drop {
        id: address,
        avatar: 0x1::option::Option<0x2::url::Url>,
        cover_image: 0x1::option::Option<0x2::url::Url>,
        status: 0x1::string::String,
        title: 0x1::string::String,
        description: 0x1::string::String,
        rules: 0x1::string::String,
        links: 0x1::string::String,
        resources: 0x1::string::String,
        created_at: u64,
        owner: address,
    }

    struct AdminCommunityMutationPass {
        community_address: address,
    }

    struct AdminCommunityEvent has copy, drop {
        id: address,
        avatar: 0x1::option::Option<0x2::url::Url>,
        cover_image: 0x1::option::Option<0x2::url::Url>,
        status: 0x1::string::String,
        title: 0x1::string::String,
        description: 0x1::string::String,
        rules: 0x1::string::String,
        links: 0x1::string::String,
        resources: 0x1::string::String,
        created_at: u64,
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
        updated_at: u64,
        voters: 0x2::table::Table<address, bool>,
        comments: 0x2::object_table::ObjectTable<address, Comment>,
        logs: 0x2::table::Table<u64, ModificationLog>,
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
        updated_at: u64,
        logs: 0x2::table::Table<u64, ModificationLog>,
    }

    struct CommentEvent has copy, drop {
        id: address,
        post_id: address,
        parent_id: address,
        creator: address,
        content: 0x1::string::String,
        created_at: u64,
    }

    struct ModificationLog has store {
        user: address,
        role: 0x1::string::String,
        action: 0x1::string::String,
    }

    public fun new(arg0: &0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : Gilder {
        Gilder{communities: 0x2::object_table::new<address, Community>(arg1)}
    }

    public fun admin_remove_comment(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address, arg2: address, arg3: vector<address>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::assert_is_gilder_admin(arg0, 0x2::tx_context::sender(arg5));
        let (_, v1) = private_remove_comment(arg0, arg1, arg2, arg3);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        v1.updated_at = v2;
        let v3 = &mut v1.logs;
        append_mod_log(v3, v2, 0x2::tx_context::sender(arg5), b"admin", b"remove");
    }

    public fun admin_remove_post(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::assert_is_gilder_admin(arg0, 0x2::tx_context::sender(arg4));
        let v0 = private_remove_post(arg0, arg1, arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        v0.updated_at = v1;
        let v2 = &mut v0.logs;
        append_mod_log(v2, v1, 0x2::tx_context::sender(arg4), b"admin", b"remove");
    }

    public fun admin_save_community(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: Community, arg2: AdminCommunityMutationPass) : address {
        let AdminCommunityMutationPass { community_address: v0 } = arg2;
        assert!(v0 == 0x2::object::uid_to_address(&arg1.id), 102);
        assert!(!0x1::string::is_empty(&arg1.title) && !0x1::string::is_empty(&arg1.description), 900);
        let v1 = AdminCommunityEvent{
            id          : v0,
            avatar      : arg1.avatar,
            cover_image : arg1.cover_image,
            status      : arg1.status,
            title       : arg1.title,
            description : arg1.description,
            rules       : arg1.rules,
            links       : arg1.links,
            resources   : arg1.resources,
            created_at  : arg1.created_at,
        };
        0x2::event::emit<AdminCommunityEvent>(v1);
        0x2::object_table::add<address, Community>(&mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::app_object_mut<0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::version::GilderV1, Gilder>(arg0).communities, v0, arg1);
        v0
    }

    public fun admin_take_community(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : (Community, AdminCommunityMutationPass) {
        0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::assert_is_gilder_admin(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::object_table::remove<address, Community>(&mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::app_object_mut<0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::version::GilderV1, Gilder>(arg0).communities, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        v0.updated_at = v1;
        let v2 = &mut v0.logs;
        append_mod_log(v2, v1, 0x2::tx_context::sender(arg3), b"admin", b"edit");
        let v3 = AdminCommunityMutationPass{community_address: arg1};
        (v0, v3)
    }

    fun append_mod_log(arg0: &mut 0x2::table::Table<u64, ModificationLog>, arg1: u64, arg2: address, arg3: vector<u8>, arg4: vector<u8>) {
        let v0 = ModificationLog{
            user   : arg2,
            role   : 0x1::string::utf8(arg3),
            action : 0x1::string::utf8(arg4),
        };
        0x2::table::add<u64, ModificationLog>(arg0, arg1, v0);
    }

    fun assert_can_interact(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_community_is_modifiable(arg0, arg1);
        0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::blacklist::assert_not_banned_in_community(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    fun assert_community_is_modifiable(arg0: &0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address) {
        let v0 = b"archived";
        assert!(0x1::string::as_bytes(&0x2::object_table::borrow<address, Community>(&0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::object<Gilder>(arg0).communities, arg1).status) != &v0, 103);
    }

    fun assert_valid_community_status(arg0: vector<u8>) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &mut v0;
        0x1::vector::push_back<vector<u8>>(v1, b"public");
        0x1::vector::push_back<vector<u8>>(v1, b"archived");
        assert!(0x1::vector::contains<vector<u8>>(&v0, &arg0), 9223376503620763647);
    }

    public fun check_joined(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address, arg2: &0x2::tx_context::TxContext) : bool {
        0x2::table::contains<address, bool>(&0x2::object_table::borrow_mut<address, Community>(&mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::app_object_mut<0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::version::GilderV1, Gilder>(arg0).communities, arg1).members, 0x2::tx_context::sender(arg2))
    }

    public fun community_owner_ban_user(arg0: &CommunityOwnerCap, arg1: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.community_address == arg2, 100);
        0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::blacklist::assert_not_banned(arg1, 0x2::tx_context::sender(arg4));
        0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::blacklist::ban_user_from_community(arg1, arg2, arg3, arg4);
    }

    public fun community_owner_remove_comment(arg0: &CommunityOwnerCap, arg1: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg2: address, arg3: address, arg4: vector<address>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(arg0.community_address == arg2, 100);
        0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::blacklist::assert_not_banned(arg1, 0x2::tx_context::sender(arg6));
        let (_, v1) = private_remove_comment(arg1, arg2, arg3, arg4);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        v1.updated_at = v2;
        let v3 = &mut v1.logs;
        append_mod_log(v3, v2, 0x2::tx_context::sender(arg6), b"community_owner", b"remove");
    }

    public fun community_owner_remove_post(arg0: &CommunityOwnerCap, arg1: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg2: address, arg3: address, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.community_address == arg2, 100);
        0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::blacklist::assert_not_banned(arg1, 0x2::tx_context::sender(arg5));
        let v0 = private_remove_post(arg1, arg2, arg3);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        v0.updated_at = v1;
        let v2 = &mut v0.logs;
        append_mod_log(v2, v1, 0x2::tx_context::sender(arg5), b"community_owner", b"remove");
    }

    public fun community_owner_unban_user(arg0: &CommunityOwnerCap, arg1: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.community_address == arg2, 100);
        0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::blacklist::assert_not_banned(arg1, 0x2::tx_context::sender(arg4));
        0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::blacklist::unban_user_from_community(arg1, arg2, arg3, arg4);
    }

    public fun create_comment(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address, arg2: address, arg3: vector<address>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (address, u64) {
        assert!(!0x1::vector::is_empty<u8>(&arg4), 900);
        assert_can_interact(arg0, arg1, arg6);
        let (v0, v1) = navigate_to_parent(arg0, arg1, arg2, arg3);
        let v2 = 0x2::tx_context::sender(arg6);
        let v3 = 0x2::object::new(arg6);
        let v4 = 0x2::object::uid_to_address(&v3);
        let v5 = 0x2::clock::timestamp_ms(arg5);
        let v6 = Comment{
            id         : v3,
            creator    : v2,
            content    : 0x1::string::utf8(arg4),
            created_at : v5,
            updated_at : v5,
            logs       : 0x2::table::new<u64, ModificationLog>(arg6),
        };
        0x2::dynamic_field::add<vector<u8>, 0x2::object_table::ObjectTable<address, Comment>>(&mut v6.id, b"replies", 0x2::object_table::new<address, Comment>(arg6));
        let v7 = CommentEvent{
            id         : v4,
            post_id    : arg2,
            parent_id  : v0,
            creator    : v2,
            content    : v6.content,
            created_at : v6.created_at,
        };
        0x2::event::emit<CommentEvent>(v7);
        0x2::object_table::add<address, Comment>(v1, v4, v6);
        (v4, 0x2::object_table::length<address, Comment>(v1))
    }

    public fun edit_comment(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address, arg2: address, arg3: vector<address>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_can_interact(arg0, arg1, arg6);
        let (v0, v1) = navigate_to_comment(arg0, arg1, arg2, arg3);
        let v2 = 0x2::tx_context::sender(arg6);
        assert!(v1.creator == v2, 300);
        v1.content = 0x1::string::utf8(arg4);
        let v3 = 0x2::clock::timestamp_ms(arg5);
        v1.updated_at = v3;
        let v4 = &mut v1.logs;
        append_mod_log(v4, v3, v2, b"comment_creator", b"edit");
        let v5 = CommentEvent{
            id         : 0x2::object::uid_to_address(&v1.id),
            post_id    : arg2,
            parent_id  : v0,
            creator    : v2,
            content    : v1.content,
            created_at : v1.created_at,
        };
        0x2::event::emit<CommentEvent>(v5);
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

    public fun edit_community_status(arg0: Community, arg1: vector<u8>) : Community {
        assert_valid_community_status(arg1);
        arg0.status = 0x1::string::utf8(arg1);
        arg0
    }

    public fun edit_community_title(arg0: Community, arg1: vector<u8>) : Community {
        arg0.title = 0x1::string::utf8(arg1);
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

    public fun join(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert_can_interact(arg0, arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object_table::borrow_mut<address, Community>(&mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::app_object_mut<0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::version::GilderV1, Gilder>(arg0).communities, arg1);
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

    public fun leave(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert_can_interact(arg0, arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object_table::borrow_mut<address, Community>(&mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::app_object_mut<0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::version::GilderV1, Gilder>(arg0).communities, arg1);
        0x2::table::remove<address, bool>(&mut v1.members, v0);
        let v2 = CommunityJoinEvent{
            community_id : arg1,
            user_id      : v0,
            action       : 0x1::string::utf8(b"leave"),
        };
        0x2::event::emit<CommunityJoinEvent>(v2);
        0x2::table::length<address, bool>(&v1.members)
    }

    fun navigate_to_comment(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address, arg2: address, arg3: vector<address>) : (address, &mut Comment) {
        assert!(!0x1::vector::is_empty<address>(&arg3), 900);
        let (v0, v1) = navigate_to_parent(arg0, arg1, arg2, arg3);
        (v0, 0x2::object_table::borrow_mut<address, Comment>(v1, 0x1::vector::pop_back<address>(&mut arg3)))
    }

    fun navigate_to_parent(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address, arg2: address, arg3: vector<address>) : (address, &mut 0x2::object_table::ObjectTable<address, Comment>) {
        let v0 = 0x2::object_table::borrow_mut<address, Post>(&mut 0x2::object_table::borrow_mut<address, Community>(&mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::app_object_mut<0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::version::GilderV1, Gilder>(arg0).communities, arg1).posts, arg2);
        let v1 = 0x2::object::uid_to_address(&v0.id);
        let v2 = &mut v0.comments;
        while (!0x1::vector::is_empty<address>(&arg3)) {
            let v3 = 0x2::object_table::borrow_mut<address, Comment>(v2, 0x1::vector::remove<address>(&mut arg3, 0));
            v1 = 0x2::object::uid_to_address(&v3.id);
            v2 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::object_table::ObjectTable<address, Comment>>(&mut v3.id, b"replies");
        };
        (v1, v2)
    }

    public fun new_community(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) : (Community, CommunityMutationPass, CommunityOwnerCap) {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = 0x2::clock::timestamp_ms(arg0);
        let v3 = 0x1::string::utf8(b"");
        let v4 = 0x2::table::new<address, bool>(arg1);
        0x2::table::add<address, bool>(&mut v4, 0x2::tx_context::sender(arg1), true);
        let v5 = Community{
            id          : v0,
            avatar      : 0x1::option::none<0x2::url::Url>(),
            cover_image : 0x1::option::none<0x2::url::Url>(),
            status      : 0x1::string::utf8(b"public"),
            title       : v3,
            description : v3,
            rules       : v3,
            links       : v3,
            resources   : v3,
            created_at  : v2,
            updated_at  : v2,
            members     : v4,
            posts       : 0x2::object_table::new<address, Post>(arg1),
            logs        : 0x2::table::new<u64, ModificationLog>(arg1),
        };
        let v6 = CommunityMutationPass{community_address: v1};
        let v7 = CommunityOwnerCap{
            id                : 0x2::object::new(arg1),
            community_address : v1,
        };
        (v5, v6, v7)
    }

    public fun new_post(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) : (Post, PostMutationPass) {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::clock::timestamp_ms(arg0);
        let v2 = Post{
            id         : v0,
            title      : 0x1::string::utf8(b""),
            content    : 0x1::string::utf8(b""),
            creator    : 0x2::tx_context::sender(arg1),
            draft      : true,
            created_at : v1,
            updated_at : v1,
            voters     : 0x2::table::new<address, bool>(arg1),
            comments   : 0x2::object_table::new<address, Comment>(arg1),
            logs       : 0x2::table::new<u64, ModificationLog>(arg1),
        };
        let v3 = PostMutationPass{post_address: 0x2::object::uid_to_address(&v0)};
        (v2, v3)
    }

    fun private_remove_comment(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address, arg2: address, arg3: vector<address>) : (address, &mut Comment) {
        let (v0, v1) = navigate_to_comment(arg0, arg1, arg2, arg3);
        v1.creator = @0x0;
        v1.content = 0x1::string::utf8(b"");
        let v2 = CommentEvent{
            id         : 0x2::object::uid_to_address(&v1.id),
            post_id    : arg2,
            parent_id  : v0,
            creator    : v1.creator,
            content    : v1.content,
            created_at : v1.created_at,
        };
        0x2::event::emit<CommentEvent>(v2);
        (v0, v1)
    }

    fun private_remove_post(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address, arg2: address) : &mut Post {
        let v0 = 0x2::object_table::borrow_mut<address, Community>(&mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::app_object_mut<0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::version::GilderV1, Gilder>(arg0).communities, arg1);
        let v1 = 0x2::object_table::borrow_mut<address, Post>(&mut v0.posts, arg2);
        v1.creator = @0x0;
        v1.title = 0x1::string::utf8(b"");
        v1.content = 0x1::string::utf8(b"");
        let v2 = PostEvent{
            id           : 0x2::object::uid_to_address(&v1.id),
            community_id : 0x2::object::uid_to_address(&v0.id),
            title        : v1.title,
            content      : v1.content,
            creator      : v1.creator,
            draft        : v1.draft,
            created_at   : v1.created_at,
        };
        0x2::event::emit<PostEvent>(v2);
        v1
    }

    public fun remove_comment(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address, arg2: address, arg3: vector<address>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_can_interact(arg0, arg1, arg5);
        let (_, v1) = navigate_to_comment(arg0, arg1, arg2, arg3);
        assert!(v1.creator == 0x2::tx_context::sender(arg5), 300);
        let (_, v3) = private_remove_comment(arg0, arg1, arg2, arg3);
        let v4 = 0x2::clock::timestamp_ms(arg4);
        v3.updated_at = v4;
        let v5 = &mut v3.logs;
        append_mod_log(v5, v4, 0x2::tx_context::sender(arg5), b"comment_creator", b"remove");
    }

    public fun remove_post(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : address {
        assert_can_interact(arg0, arg1, arg4);
        assert!(0x2::object_table::borrow<address, Post>(&0x2::object_table::borrow<address, Community>(&0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::object<Gilder>(arg0).communities, arg1).posts, arg2).creator == 0x2::tx_context::sender(arg4), 200);
        let v0 = private_remove_post(arg0, arg1, arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        v0.updated_at = v1;
        let v2 = &mut v0.logs;
        append_mod_log(v2, v1, 0x2::tx_context::sender(arg4), b"post_creator", b"remove");
        0x2::object::uid_to_address(&v0.id)
    }

    public fun save_community(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: Community, arg2: CommunityMutationPass, arg3: &mut 0x2::tx_context::TxContext) : address {
        let CommunityMutationPass { community_address: v0 } = arg2;
        assert!(v0 == 0x2::object::uid_to_address(&arg1.id), 102);
        assert!(!0x1::string::is_empty(&arg1.title) && !0x1::string::is_empty(&arg1.description), 900);
        0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::blacklist::assert_not_banned(arg0, 0x2::tx_context::sender(arg3));
        let v1 = CommunityEvent{
            id          : v0,
            avatar      : arg1.avatar,
            cover_image : arg1.cover_image,
            status      : arg1.status,
            title       : arg1.title,
            description : arg1.description,
            rules       : arg1.rules,
            links       : arg1.links,
            resources   : arg1.resources,
            created_at  : arg1.created_at,
            owner       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<CommunityEvent>(v1);
        0x2::object_table::add<address, Community>(&mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::app_object_mut<0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::version::GilderV1, Gilder>(arg0).communities, v0, arg1);
        v0
    }

    public fun save_post(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address, arg2: Post, arg3: PostMutationPass, arg4: &mut 0x2::tx_context::TxContext) : address {
        let PostMutationPass { post_address: v0 } = arg3;
        assert!(v0 == 0x2::object::uid_to_address(&arg2.id), 203);
        assert_can_interact(arg0, arg1, arg4);
        let v1 = 0x2::object_table::borrow_mut<address, Community>(&mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::app_object_mut<0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::version::GilderV1, Gilder>(arg0).communities, arg1);
        assert!(0x2::table::contains<address, bool>(&v1.members, 0x2::tx_context::sender(arg4)), 101);
        assert!(!0x1::string::is_empty(&arg2.title) && !0x1::string::is_empty(&arg2.content), 900);
        let v2 = PostEvent{
            id           : v0,
            community_id : arg1,
            title        : arg2.title,
            content      : arg2.content,
            creator      : arg2.creator,
            draft        : arg2.draft,
            created_at   : arg2.created_at,
        };
        0x2::event::emit<PostEvent>(v2);
        0x2::object_table::add<address, Post>(&mut v1.posts, v0, arg2);
        v0
    }

    public fun take_community(arg0: &CommunityOwnerCap, arg1: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (Community, CommunityMutationPass) {
        assert!(arg0.community_address == arg2, 100);
        let v0 = 0x2::object_table::remove<address, Community>(&mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::app_object_mut<0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::version::GilderV1, Gilder>(arg1).communities, arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        v0.updated_at = v1;
        let v2 = &mut v0.logs;
        append_mod_log(v2, v1, 0x2::tx_context::sender(arg4), b"community_owner", b"edit");
        let v3 = CommunityMutationPass{community_address: arg2};
        (v0, v3)
    }

    public fun take_post(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (Post, PostMutationPass) {
        let v0 = 0x2::object_table::remove<address, Post>(&mut 0x2::object_table::borrow_mut<address, Community>(&mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::app_object_mut<0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::version::GilderV1, Gilder>(arg0).communities, arg1).posts, arg2);
        assert!(v0.creator == 0x2::tx_context::sender(arg4), 200);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        v0.updated_at = v1;
        let v2 = &mut v0.logs;
        append_mod_log(v2, v1, 0x2::tx_context::sender(arg4), b"post_creator", b"edit");
        let v3 = PostMutationPass{post_address: arg2};
        (v0, v3)
    }

    public fun vote(arg0: &mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::GilderApp, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert_can_interact(arg0, arg1, arg3);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object_table::borrow_mut<address, Community>(&mut 0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::app::app_object_mut<0x30ec21c0f650e2047376699d71879f65a9103b35316ac3f72c272686ee132499::version::GilderV1, Gilder>(arg0).communities, arg1);
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

