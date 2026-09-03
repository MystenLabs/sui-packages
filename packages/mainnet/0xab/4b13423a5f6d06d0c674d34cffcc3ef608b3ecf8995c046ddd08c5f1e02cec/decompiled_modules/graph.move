module 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::graph {
    struct FollowOp {
        dummy_field: bool,
    }

    struct Follow has drop, store {
        since_ms: u64,
    }

    struct Graph has key {
        id: 0x2::object::UID,
        version: u64,
        metadata_uri: 0x1::string::String,
        graph_rules: 0x2::object::ID,
        following: 0x2::table::Table<address, 0x2::table::Table<address, Follow>>,
        followers_count: 0x2::table::Table<address, u64>,
        following_count: 0x2::table::Table<address, u64>,
        account_rules: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct GraphAdminCap has store, key {
        id: 0x2::object::UID,
        graph: 0x2::object::ID,
    }

    struct FollowTicket {
        graph: 0x2::object::ID,
        key: address,
        follower: address,
        target: address,
    }

    struct GraphCreated has copy, drop {
        graph: 0x2::object::ID,
    }

    struct Followed has copy, drop {
        graph: 0x2::object::ID,
        follower: address,
        target: address,
    }

    struct Unfollowed has copy, drop {
        graph: 0x2::object::ID,
        follower: address,
        target: address,
    }

    struct FollowRulesRegistered has copy, drop {
        graph: 0x2::object::ID,
        account: address,
        set: 0x2::object::ID,
    }

    struct FollowRulesUnregistered has copy, drop {
        graph: 0x2::object::ID,
        account: address,
    }

    fun assert_version(arg0: &Graph) {
        assert!(arg0.version == 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(), 11);
    }

    public fun create(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : (GraphAdminCap, 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSetCap) {
        let (v0, v1) = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::new<FollowOp>(arg1);
        let v2 = v0;
        let v3 = Graph{
            id              : 0x2::object::new(arg1),
            version         : 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(),
            metadata_uri    : arg0,
            graph_rules     : 0x2::object::id<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<FollowOp>>(&v2),
            following       : 0x2::table::new<address, 0x2::table::Table<address, Follow>>(arg1),
            followers_count : 0x2::table::new<address, u64>(arg1),
            following_count : 0x2::table::new<address, u64>(arg1),
            account_rules   : 0x2::table::new<address, 0x2::object::ID>(arg1),
        };
        let v4 = GraphAdminCap{
            id    : 0x2::object::new(arg1),
            graph : 0x2::object::id<Graph>(&v3),
        };
        let v5 = GraphCreated{graph: 0x2::object::id<Graph>(&v3)};
        0x2::event::emit<GraphCreated>(v5);
        0x2::transfer::public_share_object<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<FollowOp>>(v2);
        0x2::transfer::share_object<Graph>(v3);
        (v4, v1)
    }

    public fun create_my_follow_rules(arg0: &mut Graph, arg1: &mut 0x2::tx_context::TxContext) : 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSetCap {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.account_rules, v0), 9);
        let (v1, v2) = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::new<FollowOp>(arg1);
        let v3 = v1;
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.account_rules, v0, 0x2::object::id<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<FollowOp>>(&v3));
        let v4 = FollowRulesRegistered{
            graph   : 0x2::object::id<Graph>(arg0),
            account : v0,
            set     : 0x2::object::id<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<FollowOp>>(&v3),
        };
        0x2::event::emit<FollowRulesRegistered>(v4);
        0x2::transfer::public_share_object<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<FollowOp>>(v3);
        v2
    }

    fun decrement(arg0: &mut 0x2::table::Table<address, u64>, arg1: address) {
        let v0 = 0x2::table::borrow_mut<address, u64>(arg0, arg1);
        *v0 = *v0 - 1;
    }

    public fun execute_follow(arg0: &mut Graph, arg1: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<FollowOp>, arg2: FollowTicket, arg3: 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::Request<FollowOp>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let FollowTicket {
            graph    : v0,
            key      : v1,
            follower : v2,
            target   : v3,
        } = arg2;
        assert!(v0 == 0x2::object::id<Graph>(arg0), 3);
        assert!(0x2::object::id<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<FollowOp>>(arg1) == arg0.graph_rules, 4);
        assert!(v1 == 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::request_key<FollowOp>(&arg3), 5);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.account_rules, v3), 6);
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::confirm<FollowOp>(arg1, arg3);
        insert_follow(arg0, v2, v3, arg4, arg5);
    }

    public fun execute_follow_gated(arg0: &mut Graph, arg1: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<FollowOp>, arg2: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<FollowOp>, arg3: FollowTicket, arg4: 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::Request<FollowOp>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let FollowTicket {
            graph    : v0,
            key      : v1,
            follower : v2,
            target   : v3,
        } = arg3;
        assert!(v0 == 0x2::object::id<Graph>(arg0), 3);
        assert!(0x2::object::id<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<FollowOp>>(arg1) == arg0.graph_rules, 4);
        assert!(v1 == 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::request_key<FollowOp>(&arg4), 5);
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg0.account_rules, v3), 7);
        assert!(*0x2::table::borrow<address, 0x2::object::ID>(&arg0.account_rules, v3) == 0x2::object::id<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<FollowOp>>(arg2), 4);
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::check<FollowOp>(arg1, &arg4);
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::check<FollowOp>(arg2, &arg4);
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::destroy<FollowOp>(arg4);
        insert_follow(arg0, v2, v3, arg5, arg6);
    }

    public fun follow_rules_of(arg0: &Graph, arg1: address) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.account_rules, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<address, 0x2::object::ID>(&arg0.account_rules, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun followers_count_of(arg0: &Graph, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.followers_count, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.followers_count, arg1)
        } else {
            0
        }
    }

    public fun following_count_of(arg0: &Graph, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.following_count, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.following_count, arg1)
        } else {
            0
        }
    }

    public fun graph_rules_id(arg0: &Graph) : 0x2::object::ID {
        arg0.graph_rules
    }

    fun increment(arg0: &mut 0x2::table::Table<address, u64>, arg1: address) {
        if (!0x2::table::contains<address, u64>(arg0, arg1)) {
            0x2::table::add<address, u64>(arg0, arg1, 0);
        };
        let v0 = 0x2::table::borrow_mut<address, u64>(arg0, arg1);
        *v0 = *v0 + 1;
    }

    fun insert_follow(arg0: &mut Graph, arg1: address, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, 0x2::table::Table<address, Follow>>(&arg0.following, arg1)) {
            0x2::table::add<address, 0x2::table::Table<address, Follow>>(&mut arg0.following, arg1, 0x2::table::new<address, Follow>(arg4));
        };
        let v0 = Follow{since_ms: 0x2::clock::timestamp_ms(arg3)};
        0x2::table::add<address, Follow>(0x2::table::borrow_mut<address, 0x2::table::Table<address, Follow>>(&mut arg0.following, arg1), arg2, v0);
        let v1 = &mut arg0.followers_count;
        increment(v1, arg2);
        let v2 = &mut arg0.following_count;
        increment(v2, arg1);
        let v3 = Followed{
            graph    : 0x2::object::id<Graph>(arg0),
            follower : arg1,
            target   : arg2,
        };
        0x2::event::emit<Followed>(v3);
    }

    public fun is_following(arg0: &Graph, arg1: address, arg2: address) : bool {
        0x2::table::contains<address, 0x2::table::Table<address, Follow>>(&arg0.following, arg1) && 0x2::table::contains<address, Follow>(0x2::table::borrow<address, 0x2::table::Table<address, Follow>>(&arg0.following, arg1), arg2)
    }

    public fun migrate(arg0: &mut Graph, arg1: &GraphAdminCap) {
        assert!(arg1.graph == 0x2::object::id<Graph>(arg0), 8);
        assert!(arg0.version < 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(), 12);
        arg0.version = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version();
    }

    public fun remove_my_follow_rules(arg0: &mut Graph, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg0.account_rules, v0), 10);
        0x2::table::remove<address, 0x2::object::ID>(&mut arg0.account_rules, v0);
        let v1 = FollowRulesUnregistered{
            graph   : 0x2::object::id<Graph>(arg0),
            account : v0,
        };
        0x2::event::emit<FollowRulesUnregistered>(v1);
    }

    public fun request_follow(arg0: &Graph, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (FollowTicket, 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::Request<FollowOp>) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 != arg1, 0);
        assert!(!is_following(arg0, v0, arg1), 1);
        let v1 = 0x2::tx_context::fresh_object_address(arg2);
        let v2 = FollowTicket{
            graph    : 0x2::object::id<Graph>(arg0),
            key      : v1,
            follower : v0,
            target   : arg1,
        };
        (v2, 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::new_request<FollowOp>(v1, v0))
    }

    public fun set_metadata_uri(arg0: &mut Graph, arg1: &GraphAdminCap, arg2: 0x1::string::String) {
        assert_version(arg0);
        assert!(arg1.graph == 0x2::object::id<Graph>(arg0), 8);
        arg0.metadata_uri = arg2;
    }

    public fun ticket_follower(arg0: &FollowTicket) : address {
        arg0.follower
    }

    public fun ticket_key(arg0: &FollowTicket) : address {
        arg0.key
    }

    public fun ticket_target(arg0: &FollowTicket) : address {
        arg0.target
    }

    public fun unfollow(arg0: &mut Graph, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_following(arg0, v0, arg1), 2);
        0x2::table::remove<address, Follow>(0x2::table::borrow_mut<address, 0x2::table::Table<address, Follow>>(&mut arg0.following, v0), arg1);
        let v1 = &mut arg0.followers_count;
        decrement(v1, arg1);
        let v2 = &mut arg0.following_count;
        decrement(v2, v0);
        let v3 = Unfollowed{
            graph    : 0x2::object::id<Graph>(arg0),
            follower : v0,
            target   : arg1,
        };
        0x2::event::emit<Unfollowed>(v3);
    }

    public fun version(arg0: &Graph) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

