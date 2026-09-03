module 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::feed {
    struct CreatePostOp {
        dummy_field: bool,
    }

    struct InteractPostOp {
        dummy_field: bool,
    }

    struct Post has copy, drop, store {
        author: address,
        seq: u64,
        author_seq: u64,
        content_uri: 0x1::string::String,
        root: u64,
        replied_to: 0x1::option::Option<u64>,
        quoted: 0x1::option::Option<u64>,
        reposted: 0x1::option::Option<u64>,
        created_ms: u64,
        updated_ms: u64,
        deleted: bool,
    }

    struct Feed has key {
        id: 0x2::object::UID,
        version: u64,
        metadata_uri: 0x1::string::String,
        feed_rules: 0x2::object::ID,
        posts: 0x2::table::Table<u64, Post>,
        post_count: u64,
        author_post_count: 0x2::table::Table<address, u64>,
        post_rules: 0x2::table::Table<u64, 0x2::object::ID>,
        post_paywalls: 0x2::table::Table<u64, 0x2::object::ID>,
    }

    struct FeedAdminCap has store, key {
        id: 0x2::object::UID,
        feed: 0x2::object::ID,
    }

    struct CreatePostTicket {
        feed: 0x2::object::ID,
        key: address,
        author: address,
        content_uri: 0x1::string::String,
        replied_to: 0x1::option::Option<u64>,
        quoted: 0x1::option::Option<u64>,
        reposted: 0x1::option::Option<u64>,
        parent_author: 0x1::option::Option<address>,
        parent_gated: bool,
    }

    struct FeedCreated has copy, drop {
        feed: 0x2::object::ID,
    }

    struct PostCreated has copy, drop {
        feed: 0x2::object::ID,
        post_id: u64,
        author: address,
        content_uri: 0x1::string::String,
        root: u64,
        replied_to: 0x1::option::Option<u64>,
        quoted: 0x1::option::Option<u64>,
        reposted: 0x1::option::Option<u64>,
    }

    struct PostEdited has copy, drop {
        feed: 0x2::object::ID,
        post_id: u64,
        content_uri: 0x1::string::String,
    }

    struct PostDeleted has copy, drop {
        feed: 0x2::object::ID,
        post_id: u64,
    }

    struct PostRulesCreated has copy, drop {
        feed: 0x2::object::ID,
        post_id: u64,
        set: 0x2::object::ID,
    }

    fun assert_live_post(arg0: &Feed, arg1: u64) {
        assert!(post_exists(arg0, arg1), 0);
    }

    fun assert_version(arg0: &Feed) {
        assert!(arg0.version == 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(), 12);
    }

    fun check_common(arg0: &Feed, arg1: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<CreatePostOp>, arg2: &CreatePostTicket, arg3: address) {
        assert_version(arg0);
        assert!(arg2.feed == 0x2::object::id<Feed>(arg0), 2);
        assert!(0x2::object::id<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<CreatePostOp>>(arg1) == arg0.feed_rules, 3);
        assert!(arg2.key == arg3, 4);
    }

    public fun create(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : (FeedAdminCap, 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSetCap) {
        let (v0, v1) = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::new<CreatePostOp>(arg1);
        let v2 = v0;
        let v3 = Feed{
            id                : 0x2::object::new(arg1),
            version           : 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(),
            metadata_uri      : arg0,
            feed_rules        : 0x2::object::id<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<CreatePostOp>>(&v2),
            posts             : 0x2::table::new<u64, Post>(arg1),
            post_count        : 0,
            author_post_count : 0x2::table::new<address, u64>(arg1),
            post_rules        : 0x2::table::new<u64, 0x2::object::ID>(arg1),
            post_paywalls     : 0x2::table::new<u64, 0x2::object::ID>(arg1),
        };
        let v4 = FeedAdminCap{
            id   : 0x2::object::new(arg1),
            feed : 0x2::object::id<Feed>(&v3),
        };
        let v5 = FeedCreated{feed: 0x2::object::id<Feed>(&v3)};
        0x2::event::emit<FeedCreated>(v5);
        0x2::transfer::public_share_object<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<CreatePostOp>>(v2);
        0x2::transfer::share_object<Feed>(v3);
        (v4, v1)
    }

    public fun create_post_rules(arg0: &mut Feed, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSetCap {
        assert_version(arg0);
        assert_live_post(arg0, arg1);
        assert!(0x2::table::borrow<u64, Post>(&arg0.posts, arg1).author == 0x2::tx_context::sender(arg2), 1);
        assert!(!0x2::table::contains<u64, 0x2::object::ID>(&arg0.post_rules, arg1), 10);
        let (v0, v1) = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::new<InteractPostOp>(arg2);
        let v2 = v0;
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.post_rules, arg1, 0x2::object::id<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<InteractPostOp>>(&v2));
        let v3 = PostRulesCreated{
            feed    : 0x2::object::id<Feed>(arg0),
            post_id : arg1,
            set     : 0x2::object::id<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<InteractPostOp>>(&v2),
        };
        0x2::event::emit<PostRulesCreated>(v3);
        0x2::transfer::public_share_object<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<InteractPostOp>>(v2);
        v1
    }

    public fun delete_post(arg0: &mut Feed, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_live_post(arg0, arg1);
        let v0 = 0x2::table::borrow_mut<u64, Post>(&mut arg0.posts, arg1);
        assert!(v0.author == 0x2::tx_context::sender(arg2), 1);
        v0.deleted = true;
        v0.content_uri = 0x1::string::utf8(b"");
        let v1 = PostDeleted{
            feed    : 0x2::object::id<Feed>(arg0),
            post_id : arg1,
        };
        0x2::event::emit<PostDeleted>(v1);
    }

    public fun edit_post(arg0: &mut Feed, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_live_post(arg0, arg1);
        let v0 = 0x2::table::borrow_mut<u64, Post>(&mut arg0.posts, arg1);
        assert!(v0.author == 0x2::tx_context::sender(arg4), 1);
        assert!(0x1::option::is_none<u64>(&v0.reposted), 9);
        v0.content_uri = arg2;
        v0.updated_ms = 0x2::clock::timestamp_ms(arg3);
        let v1 = PostEdited{
            feed        : 0x2::object::id<Feed>(arg0),
            post_id     : arg1,
            content_uri : arg2,
        };
        0x2::event::emit<PostEdited>(v1);
    }

    public fun execute_create_post(arg0: &mut Feed, arg1: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<CreatePostOp>, arg2: CreatePostTicket, arg3: 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::Request<CreatePostOp>, arg4: &0x2::clock::Clock) : u64 {
        assert!(!arg2.parent_gated, 5);
        check_common(arg0, arg1, &arg2, 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::request_key<CreatePostOp>(&arg3));
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::confirm<CreatePostOp>(arg1, arg3);
        insert_post(arg0, arg2, arg4)
    }

    public fun execute_create_post_gated(arg0: &mut Feed, arg1: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<CreatePostOp>, arg2: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<InteractPostOp>, arg3: CreatePostTicket, arg4: 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::Request<CreatePostOp>, arg5: 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::Request<InteractPostOp>, arg6: &0x2::clock::Clock) : u64 {
        assert!(arg3.parent_gated, 6);
        check_common(arg0, arg1, &arg3, 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::request_key<CreatePostOp>(&arg4));
        assert!(*0x2::table::borrow<u64, 0x2::object::ID>(&arg0.post_rules, *0x1::option::borrow<u64>(&arg3.replied_to)) == 0x2::object::id<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<InteractPostOp>>(arg2), 3);
        assert!(0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::request_key<InteractPostOp>(&arg5) == arg3.key, 4);
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::confirm<CreatePostOp>(arg1, arg4);
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::confirm<InteractPostOp>(arg2, arg5);
        insert_post(arg0, arg3, arg6)
    }

    public fun feed_rules_id(arg0: &Feed) : 0x2::object::ID {
        arg0.feed_rules
    }

    fun insert_post(arg0: &mut Feed, arg1: CreatePostTicket, arg2: &0x2::clock::Clock) : u64 {
        let CreatePostTicket {
            feed          : _,
            key           : _,
            author        : v2,
            content_uri   : v3,
            replied_to    : v4,
            quoted        : v5,
            reposted      : v6,
            parent_author : _,
            parent_gated  : _,
        } = arg1;
        let v9 = v6;
        let v10 = v4;
        let v11 = arg0.post_count + 1;
        arg0.post_count = v11;
        if (!0x2::table::contains<address, u64>(&arg0.author_post_count, v2)) {
            0x2::table::add<address, u64>(&mut arg0.author_post_count, v2, 0);
        };
        let v12 = 0x2::table::borrow_mut<address, u64>(&mut arg0.author_post_count, v2);
        *v12 = *v12 + 1;
        let v13 = v11;
        if (0x1::option::is_some<u64>(&v10)) {
            v13 = 0x2::table::borrow<u64, Post>(&arg0.posts, *0x1::option::borrow<u64>(&v10)).root;
        };
        if (0x1::option::is_some<u64>(&v9)) {
            v13 = 0x2::table::borrow<u64, Post>(&arg0.posts, *0x1::option::borrow<u64>(&v9)).root;
        };
        let v14 = 0x2::clock::timestamp_ms(arg2);
        let v15 = Post{
            author      : v2,
            seq         : v11,
            author_seq  : *v12,
            content_uri : v3,
            root        : v13,
            replied_to  : v10,
            quoted      : v5,
            reposted    : v9,
            created_ms  : v14,
            updated_ms  : v14,
            deleted     : false,
        };
        0x2::table::add<u64, Post>(&mut arg0.posts, v11, v15);
        let v16 = PostCreated{
            feed        : 0x2::object::id<Feed>(arg0),
            post_id     : v11,
            author      : v2,
            content_uri : v3,
            root        : v13,
            replied_to  : v10,
            quoted      : v5,
            reposted    : v9,
        };
        0x2::event::emit<PostCreated>(v16);
        v11
    }

    public fun make_parent_request(arg0: &CreatePostTicket) : 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::Request<InteractPostOp> {
        assert!(arg0.parent_gated, 6);
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::new_request<InteractPostOp>(arg0.key, arg0.author)
    }

    public fun migrate(arg0: &mut Feed, arg1: &FeedAdminCap) {
        assert!(arg1.feed == 0x2::object::id<Feed>(arg0), 11);
        assert!(arg0.version < 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(), 13);
        arg0.version = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version();
    }

    public fun paywall_of(arg0: &Feed, arg1: u64) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<u64, 0x2::object::ID>(&arg0.post_paywalls, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<u64, 0x2::object::ID>(&arg0.post_paywalls, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun post(arg0: &Feed, arg1: u64) : Post {
        assert!(0x2::table::contains<u64, Post>(&arg0.posts, arg1), 0);
        *0x2::table::borrow<u64, Post>(&arg0.posts, arg1)
    }

    public fun post_author(arg0: &Post) : address {
        arg0.author
    }

    public fun post_author_seq(arg0: &Post) : u64 {
        arg0.author_seq
    }

    public fun post_content_uri(arg0: &Post) : 0x1::string::String {
        arg0.content_uri
    }

    public fun post_count(arg0: &Feed) : u64 {
        arg0.post_count
    }

    public fun post_exists(arg0: &Feed, arg1: u64) : bool {
        0x2::table::contains<u64, Post>(&arg0.posts, arg1) && !0x2::table::borrow<u64, Post>(&arg0.posts, arg1).deleted
    }

    public fun post_is_deleted(arg0: &Post) : bool {
        arg0.deleted
    }

    public fun post_quoted(arg0: &Post) : 0x1::option::Option<u64> {
        arg0.quoted
    }

    public fun post_replied_to(arg0: &Post) : 0x1::option::Option<u64> {
        arg0.replied_to
    }

    public fun post_reposted(arg0: &Post) : 0x1::option::Option<u64> {
        arg0.reposted
    }

    public fun post_root(arg0: &Post) : u64 {
        arg0.root
    }

    public fun post_rules_of(arg0: &Feed, arg1: u64) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<u64, 0x2::object::ID>(&arg0.post_rules, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<u64, 0x2::object::ID>(&arg0.post_rules, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public(friend) fun register_paywall(arg0: &mut Feed, arg1: u64, arg2: 0x2::object::ID) {
        assert_version(arg0);
        assert!(!0x2::table::contains<u64, 0x2::object::ID>(&arg0.post_paywalls, arg1), 14);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.post_paywalls, arg1, arg2);
    }

    public fun request_create_post(arg0: &Feed, arg1: 0x1::string::String, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) : (CreatePostTicket, 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::Request<CreatePostOp>) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        if (0x1::option::is_some<u64>(&arg4)) {
            assert!(0x1::string::is_empty(&arg1), 7);
            assert!(0x1::option::is_none<u64>(&arg2) && 0x1::option::is_none<u64>(&arg3), 8);
            assert_live_post(arg0, *0x1::option::borrow<u64>(&arg4));
        };
        if (0x1::option::is_some<u64>(&arg3)) {
            assert_live_post(arg0, *0x1::option::borrow<u64>(&arg3));
        };
        let v1 = 0x1::option::none<address>();
        let v2 = false;
        if (0x1::option::is_some<u64>(&arg2)) {
            let v3 = *0x1::option::borrow<u64>(&arg2);
            assert_live_post(arg0, v3);
            v1 = 0x1::option::some<address>(0x2::table::borrow<u64, Post>(&arg0.posts, v3).author);
            v2 = 0x2::table::contains<u64, 0x2::object::ID>(&arg0.post_rules, v3);
        };
        let v4 = 0x2::tx_context::fresh_object_address(arg5);
        let v5 = CreatePostTicket{
            feed          : 0x2::object::id<Feed>(arg0),
            key           : v4,
            author        : v0,
            content_uri   : arg1,
            replied_to    : arg2,
            quoted        : arg3,
            reposted      : arg4,
            parent_author : v1,
            parent_gated  : v2,
        };
        (v5, 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::new_request<CreatePostOp>(v4, v0))
    }

    public fun set_metadata_uri(arg0: &mut Feed, arg1: &FeedAdminCap, arg2: 0x1::string::String) {
        assert_version(arg0);
        assert!(arg1.feed == 0x2::object::id<Feed>(arg0), 11);
        arg0.metadata_uri = arg2;
    }

    public fun ticket_author(arg0: &CreatePostTicket) : address {
        arg0.author
    }

    public fun ticket_key(arg0: &CreatePostTicket) : address {
        arg0.key
    }

    public fun ticket_parent_author(arg0: &CreatePostTicket) : 0x1::option::Option<address> {
        arg0.parent_author
    }

    public fun ticket_parent_gated(arg0: &CreatePostTicket) : bool {
        arg0.parent_gated
    }

    public fun version(arg0: &Feed) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

