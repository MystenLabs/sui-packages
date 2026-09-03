module 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::group {
    struct JoinGroupOp {
        dummy_field: bool,
    }

    struct Membership has drop, store {
        member_id: u64,
        joined_ms: u64,
    }

    struct Group has key {
        id: 0x2::object::UID,
        version: u64,
        metadata_uri: 0x1::string::String,
        join_rules: 0x2::object::ID,
        members: 0x2::table::Table<address, Membership>,
        member_count: u64,
        last_member_id: u64,
        banned: 0x2::table::Table<address, bool>,
    }

    struct GroupAdminCap has store, key {
        id: 0x2::object::UID,
        group: 0x2::object::ID,
    }

    struct JoinTicket {
        group: 0x2::object::ID,
        key: address,
        account: address,
    }

    struct GroupCreated has copy, drop {
        group: 0x2::object::ID,
    }

    struct MemberJoined has copy, drop {
        group: 0x2::object::ID,
        account: address,
        member_id: u64,
    }

    struct MemberLeft has copy, drop {
        group: 0x2::object::ID,
        account: address,
    }

    struct MemberBanned has copy, drop {
        group: 0x2::object::ID,
        account: address,
    }

    struct MemberUnbanned has copy, drop {
        group: 0x2::object::ID,
        account: address,
    }

    public fun admin_add_member(arg0: &mut Group, arg1: &GroupAdminCap, arg2: address, arg3: &0x2::clock::Clock) {
        assert_version(arg0);
        assert_cap(arg0, arg1);
        assert!(!0x2::table::contains<address, Membership>(&arg0.members, arg2), 0);
        assert!(!0x2::table::contains<address, bool>(&arg0.banned, arg2), 2);
        insert_member(arg0, arg2, arg3);
    }

    public fun admin_remove_member(arg0: &mut Group, arg1: &GroupAdminCap, arg2: address) {
        assert_version(arg0);
        assert_cap(arg0, arg1);
        assert!(0x2::table::contains<address, Membership>(&arg0.members, arg2), 1);
        0x2::table::remove<address, Membership>(&mut arg0.members, arg2);
        arg0.member_count = arg0.member_count - 1;
        let v0 = MemberLeft{
            group   : 0x2::object::id<Group>(arg0),
            account : arg2,
        };
        0x2::event::emit<MemberLeft>(v0);
    }

    fun assert_cap(arg0: &Group, arg1: &GroupAdminCap) {
        assert!(arg1.group == 0x2::object::id<Group>(arg0), 6);
    }

    fun assert_version(arg0: &Group) {
        assert!(arg0.version == 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(), 8);
    }

    public fun ban(arg0: &mut Group, arg1: &GroupAdminCap, arg2: address) {
        assert_version(arg0);
        assert_cap(arg0, arg1);
        assert!(!0x2::table::contains<address, bool>(&arg0.banned, arg2), 10);
        if (0x2::table::contains<address, Membership>(&arg0.members, arg2)) {
            0x2::table::remove<address, Membership>(&mut arg0.members, arg2);
            arg0.member_count = arg0.member_count - 1;
            let v0 = MemberLeft{
                group   : 0x2::object::id<Group>(arg0),
                account : arg2,
            };
            0x2::event::emit<MemberLeft>(v0);
        };
        0x2::table::add<address, bool>(&mut arg0.banned, arg2, true);
        let v1 = MemberBanned{
            group   : 0x2::object::id<Group>(arg0),
            account : arg2,
        };
        0x2::event::emit<MemberBanned>(v1);
    }

    public fun create(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : (GroupAdminCap, 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSetCap) {
        let (v0, v1) = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::new<JoinGroupOp>(arg1);
        let v2 = v0;
        let v3 = Group{
            id             : 0x2::object::new(arg1),
            version        : 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(),
            metadata_uri   : arg0,
            join_rules     : 0x2::object::id<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<JoinGroupOp>>(&v2),
            members        : 0x2::table::new<address, Membership>(arg1),
            member_count   : 0,
            last_member_id : 0,
            banned         : 0x2::table::new<address, bool>(arg1),
        };
        let v4 = GroupAdminCap{
            id    : 0x2::object::new(arg1),
            group : 0x2::object::id<Group>(&v3),
        };
        let v5 = GroupCreated{group: 0x2::object::id<Group>(&v3)};
        0x2::event::emit<GroupCreated>(v5);
        0x2::transfer::public_share_object<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<JoinGroupOp>>(v2);
        0x2::transfer::share_object<Group>(v3);
        (v4, v1)
    }

    public fun execute_join(arg0: &mut Group, arg1: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<JoinGroupOp>, arg2: JoinTicket, arg3: 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::Request<JoinGroupOp>, arg4: &0x2::clock::Clock) {
        assert_version(arg0);
        let JoinTicket {
            group   : v0,
            key     : v1,
            account : v2,
        } = arg2;
        assert!(v0 == 0x2::object::id<Group>(arg0), 3);
        assert!(0x2::object::id<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<JoinGroupOp>>(arg1) == arg0.join_rules, 4);
        assert!(v1 == 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::request_key<JoinGroupOp>(&arg3), 5);
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::confirm<JoinGroupOp>(arg1, arg3);
        insert_member(arg0, v2, arg4);
    }

    fun insert_member(arg0: &mut Group, arg1: address, arg2: &0x2::clock::Clock) {
        arg0.last_member_id = arg0.last_member_id + 1;
        arg0.member_count = arg0.member_count + 1;
        let v0 = Membership{
            member_id : arg0.last_member_id,
            joined_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::table::add<address, Membership>(&mut arg0.members, arg1, v0);
        let v1 = MemberJoined{
            group     : 0x2::object::id<Group>(arg0),
            account   : arg1,
            member_id : arg0.last_member_id,
        };
        0x2::event::emit<MemberJoined>(v1);
    }

    public fun is_banned(arg0: &Group, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.banned, arg1)
    }

    public fun is_member(arg0: &Group, arg1: address) : bool {
        0x2::table::contains<address, Membership>(&arg0.members, arg1)
    }

    public fun join_rules_id(arg0: &Group) : 0x2::object::ID {
        arg0.join_rules
    }

    public fun leave(arg0: &mut Group, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, Membership>(&arg0.members, v0), 1);
        0x2::table::remove<address, Membership>(&mut arg0.members, v0);
        arg0.member_count = arg0.member_count - 1;
        let v1 = MemberLeft{
            group   : 0x2::object::id<Group>(arg0),
            account : v0,
        };
        0x2::event::emit<MemberLeft>(v1);
    }

    public fun member_count(arg0: &Group) : u64 {
        arg0.member_count
    }

    public fun membership(arg0: &Group, arg1: address) : (u64, u64) {
        assert!(0x2::table::contains<address, Membership>(&arg0.members, arg1), 1);
        let v0 = 0x2::table::borrow<address, Membership>(&arg0.members, arg1);
        (v0.member_id, v0.joined_ms)
    }

    public fun migrate(arg0: &mut Group, arg1: &GroupAdminCap) {
        assert_cap(arg0, arg1);
        assert!(arg0.version < 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(), 9);
        arg0.version = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version();
    }

    public fun request_join(arg0: &Group, arg1: &mut 0x2::tx_context::TxContext) : (JoinTicket, 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::Request<JoinGroupOp>) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x2::table::contains<address, Membership>(&arg0.members, v0), 0);
        assert!(!0x2::table::contains<address, bool>(&arg0.banned, v0), 2);
        let v1 = 0x2::tx_context::fresh_object_address(arg1);
        let v2 = JoinTicket{
            group   : 0x2::object::id<Group>(arg0),
            key     : v1,
            account : v0,
        };
        (v2, 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::new_request<JoinGroupOp>(v1, v0))
    }

    public fun set_metadata_uri(arg0: &mut Group, arg1: &GroupAdminCap, arg2: 0x1::string::String) {
        assert_version(arg0);
        assert_cap(arg0, arg1);
        arg0.metadata_uri = arg2;
    }

    public fun ticket_account(arg0: &JoinTicket) : address {
        arg0.account
    }

    public fun ticket_key(arg0: &JoinTicket) : address {
        arg0.key
    }

    public fun unban(arg0: &mut Group, arg1: &GroupAdminCap, arg2: address) {
        assert_version(arg0);
        assert_cap(arg0, arg1);
        assert!(0x2::table::contains<address, bool>(&arg0.banned, arg2), 7);
        0x2::table::remove<address, bool>(&mut arg0.banned, arg2);
        let v0 = MemberUnbanned{
            group   : 0x2::object::id<Group>(arg0),
            account : arg2,
        };
        0x2::event::emit<MemberUnbanned>(v0);
    }

    public fun version(arg0: &Group) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

