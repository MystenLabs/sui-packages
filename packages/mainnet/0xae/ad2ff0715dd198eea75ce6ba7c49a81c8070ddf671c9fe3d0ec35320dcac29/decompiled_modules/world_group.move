module 0xaead2ff0715dd198eea75ce6ba7c49a81c8070ddf671c9fe3d0ec35320dcac29::world_group {
    struct WORLD_GROUP has drop {
        dummy_field: bool,
    }

    struct WorldGroupAdminCap has key {
        id: 0x2::object::UID,
    }

    struct WorldGroup has store, key {
        id: 0x2::object::UID,
        admin: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        created_at_ms: u64,
        paused: bool,
        member_count: u64,
        message_count: u64,
        members: 0x2::table::Table<address, Member>,
        messages: 0x2::table::Table<u64, WorldMessage>,
    }

    struct Member has copy, drop, store {
        joined_at_ms: u64,
        message_count: u64,
    }

    struct WorldMessage has copy, drop, store {
        sequence: u64,
        sender: address,
        content: 0x1::string::String,
        sent_at_ms: u64,
    }

    struct WorldGroupCreated has copy, drop {
        group_id: 0x2::object::ID,
        admin: address,
        name: 0x1::string::String,
        created_at_ms: u64,
    }

    struct MemberJoined has copy, drop {
        group_id: 0x2::object::ID,
        member: address,
        joined_at_ms: u64,
        member_count: u64,
    }

    struct WorldMessageSent has copy, drop {
        group_id: 0x2::object::ID,
        sequence: u64,
        sender: address,
        content: 0x1::string::String,
        sent_at_ms: u64,
    }

    struct WorldGroupMessageCountSynced has copy, drop {
        group_id: 0x2::object::ID,
        admin: address,
        message_count: u64,
        synced_at_ms: u64,
    }

    struct WorldGroupPaused has copy, drop {
        group_id: 0x2::object::ID,
        admin: address,
        paused: bool,
    }

    struct WorldGroupMetadataUpdated has copy, drop {
        group_id: 0x2::object::ID,
        admin: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    public fun admin(arg0: &WorldGroup) : address {
        arg0.admin
    }

    fun assert_admin(arg0: &WorldGroup, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
    }

    entry fun create_and_share_world_group(arg0: &WorldGroupAdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<WorldGroup>(create_world_group(arg0, arg1, arg2, arg3, arg4));
    }

    public fun create_world_group(arg0: &WorldGroupAdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : WorldGroup {
        validate_metadata(&arg1, &arg2);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = WorldGroup{
            id            : 0x2::object::new(arg4),
            admin         : v0,
            name          : arg1,
            description   : arg2,
            created_at_ms : 0x2::clock::timestamp_ms(arg3),
            paused        : false,
            member_count  : 0,
            message_count : 0,
            members       : 0x2::table::new<address, Member>(arg4),
            messages      : 0x2::table::new<u64, WorldMessage>(arg4),
        };
        let v2 = WorldGroupCreated{
            group_id      : 0x2::object::id<WorldGroup>(&v1),
            admin         : v0,
            name          : v1.name,
            created_at_ms : v1.created_at_ms,
        };
        0x2::event::emit<WorldGroupCreated>(v2);
        v1
    }

    public fun created_at_ms(arg0: &WorldGroup) : u64 {
        arg0.created_at_ms
    }

    public fun description(arg0: &WorldGroup) : 0x1::string::String {
        arg0.description
    }

    fun init(arg0: WORLD_GROUP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = WorldGroupAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<WorldGroupAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_member(arg0: &WorldGroup, arg1: address) : bool {
        0x2::table::contains<address, Member>(&arg0.members, arg1)
    }

    public fun is_paused(arg0: &WorldGroup) : bool {
        arg0.paused
    }

    entry fun join_world_group(arg0: &mut WorldGroup, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        join_world_group_internal(arg0, arg1, arg2);
    }

    fun join_world_group_internal(arg0: &mut WorldGroup, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, Member>(&arg0.members, v0), 2);
        let v1 = Member{
            joined_at_ms  : 0x2::clock::timestamp_ms(arg1),
            message_count : 0,
        };
        0x2::table::add<address, Member>(&mut arg0.members, v0, v1);
        arg0.member_count = arg0.member_count + 1;
        let v2 = MemberJoined{
            group_id     : 0x2::object::id<WorldGroup>(arg0),
            member       : v0,
            joined_at_ms : 0x2::clock::timestamp_ms(arg1),
            member_count : arg0.member_count,
        };
        0x2::event::emit<MemberJoined>(v2);
    }

    public fun member_count(arg0: &WorldGroup) : u64 {
        arg0.member_count
    }

    public fun member_joined_at_ms(arg0: &WorldGroup, arg1: address) : u64 {
        assert!(0x2::table::contains<address, Member>(&arg0.members, arg1), 3);
        0x2::table::borrow<address, Member>(&arg0.members, arg1).joined_at_ms
    }

    public fun member_message_count(arg0: &WorldGroup, arg1: address) : u64 {
        assert!(0x2::table::contains<address, Member>(&arg0.members, arg1), 3);
        0x2::table::borrow<address, Member>(&arg0.members, arg1).message_count
    }

    public fun message_content(arg0: &WorldGroup, arg1: u64) : 0x1::string::String {
        0x2::table::borrow<u64, WorldMessage>(&arg0.messages, arg1).content
    }

    public fun message_count(arg0: &WorldGroup) : u64 {
        arg0.message_count
    }

    public fun message_sender(arg0: &WorldGroup, arg1: u64) : address {
        0x2::table::borrow<u64, WorldMessage>(&arg0.messages, arg1).sender
    }

    public fun message_sent_at_ms(arg0: &WorldGroup, arg1: u64) : u64 {
        0x2::table::borrow<u64, WorldMessage>(&arg0.messages, arg1).sent_at_ms
    }

    public fun name(arg0: &WorldGroup) : 0x1::string::String {
        arg0.name
    }

    entry fun set_world_group_message_count(arg0: &mut WorldGroup, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        arg0.message_count = arg1;
        let v0 = WorldGroupMessageCountSynced{
            group_id      : 0x2::object::id<WorldGroup>(arg0),
            admin         : 0x2::tx_context::sender(arg3),
            message_count : arg1,
            synced_at_ms  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<WorldGroupMessageCountSynced>(v0);
    }

    entry fun set_world_group_metadata(arg0: &WorldGroupAdminCap, arg1: &mut WorldGroup, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg4);
        validate_metadata(&arg2, &arg3);
        arg1.name = arg2;
        arg1.description = arg3;
        let v0 = WorldGroupMetadataUpdated{
            group_id    : 0x2::object::id<WorldGroup>(arg1),
            admin       : 0x2::tx_context::sender(arg4),
            name        : arg1.name,
            description : arg1.description,
        };
        0x2::event::emit<WorldGroupMetadataUpdated>(v0);
    }

    entry fun set_world_group_paused(arg0: &WorldGroupAdminCap, arg1: &mut WorldGroup, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg3);
        arg1.paused = arg2;
        let v0 = WorldGroupPaused{
            group_id : 0x2::object::id<WorldGroup>(arg1),
            admin    : 0x2::tx_context::sender(arg3),
            paused   : arg2,
        };
        0x2::event::emit<WorldGroupPaused>(v0);
    }

    fun validate_metadata(arg0: &0x1::string::String, arg1: &0x1::string::String) {
        assert!(0x1::string::length(arg0) > 0, 6);
        assert!(0x1::string::length(arg0) <= 128, 7);
        assert!(0x1::string::length(arg1) <= 1000, 8);
    }

    // decompiled from Move bytecode v7
}

