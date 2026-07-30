module 0x7668dfda754919d31b3b1bb240034bbe9c20b4b75587d0e6c334ad04f1f40a5c::global_chat {
    struct GLOBAL_CHAT has drop {
        dummy_field: bool,
    }

    struct GlobalChatAdminCap has key {
        id: 0x2::object::UID,
    }

    struct GlobalChatRegistry has key {
        id: 0x2::object::UID,
        global_chat_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct GlobalChatGroup has key {
        id: 0x2::object::UID,
        admin: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        paused: bool,
        member_count: u64,
        message_count: u64,
        members: 0x2::table::Table<address, Member>,
        created_at_ms: u64,
    }

    struct Member has copy, drop, store {
        joined_at_ms: u64,
    }

    struct GlobalChatCreated has copy, drop {
        registry_id: 0x2::object::ID,
        global_chat_id: 0x2::object::ID,
        admin: address,
        created_at_ms: u64,
    }

    struct GlobalChatMemberJoined has copy, drop {
        global_chat_id: 0x2::object::ID,
        member: address,
        member_count: u64,
        joined_at_ms: u64,
    }

    struct GlobalChatPausedChanged has copy, drop {
        global_chat_id: 0x2::object::ID,
        admin: address,
        paused: bool,
    }

    struct GlobalChatMetadataUpdated has copy, drop {
        global_chat_id: 0x2::object::ID,
        admin: address,
    }

    struct GlobalChatMessageCountSynced has copy, drop {
        global_chat_id: 0x2::object::ID,
        admin: address,
        message_count: u64,
        synced_at_ms: u64,
    }

    struct GlobalChatLegacyMembersImported has copy, drop {
        global_chat_id: 0x2::object::ID,
        admin: address,
        source_network: u8,
        source_package_id: address,
        source_group_id: address,
        source_object_version: u64,
        source_object_digest: vector<u8>,
        source_snapshot_sha256: vector<u8>,
        source_member_count: u64,
        requested_count: u64,
        imported_count: u64,
        member_count: u64,
    }

    public fun admin(arg0: &GlobalChatGroup) : address {
        arg0.admin
    }

    fun assert_admin(arg0: &GlobalChatGroup, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
    }

    public fun configured_global_chat_id(arg0: &GlobalChatRegistry) : 0x1::option::Option<0x2::object::ID> {
        arg0.global_chat_id
    }

    public fun create_global_chat_group(arg0: &mut GlobalChatRegistry, arg1: &GlobalChatAdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.global_chat_id), 1);
        validate_metadata(&arg2, &arg3);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = 0x2::derived_object::claim<vector<u8>>(&mut arg0.id, b"loqua-global-chat-v1");
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = 0x2::table::new<address, Member>(arg5);
        let v5 = Member{joined_at_ms: v1};
        0x2::table::add<address, Member>(&mut v4, v0, v5);
        arg0.global_chat_id = 0x1::option::some<0x2::object::ID>(v3);
        let v6 = GlobalChatCreated{
            registry_id    : 0x2::object::id<GlobalChatRegistry>(arg0),
            global_chat_id : v3,
            admin          : v0,
            created_at_ms  : v1,
        };
        0x2::event::emit<GlobalChatCreated>(v6);
        let v7 = GlobalChatGroup{
            id            : v2,
            admin         : v0,
            name          : arg2,
            description   : arg3,
            paused        : false,
            member_count  : 1,
            message_count : 0,
            members       : v4,
            created_at_ms : v1,
        };
        0x2::transfer::share_object<GlobalChatGroup>(v7);
        v3
    }

    public fun created_at_ms(arg0: &GlobalChatGroup) : u64 {
        arg0.created_at_ms
    }

    public fun derive_global_chat_id(arg0: &GlobalChatRegistry) : 0x2::object::ID {
        0x2::object::id_from_address(0x2::derived_object::derive_address<vector<u8>>(0x2::object::id<GlobalChatRegistry>(arg0), b"loqua-global-chat-v1"))
    }

    public fun description(arg0: &GlobalChatGroup) : &0x1::string::String {
        &arg0.description
    }

    entry fun import_legacy_testnet_members(arg0: &mut GlobalChatGroup, arg1: &GlobalChatAdminCap, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: vector<address>, arg7: vector<u64>, arg8: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg8);
        let v0 = 0x1::vector::length<address>(&arg6);
        let v1 = if (v0 > 0) {
            if (v0 <= 250) {
                if (v0 == 0x1::vector::length<u64>(&arg7)) {
                    if (v0 <= arg5) {
                        if (arg2 > 0) {
                            if (!0x1::vector::is_empty<u8>(&arg3)) {
                                0x1::vector::length<u8>(&arg4) == 32
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 10);
        let v2 = 0;
        while (!0x1::vector::is_empty<address>(&arg6)) {
            let v3 = 0x1::vector::pop_back<address>(&mut arg6);
            let v4 = 0x1::vector::pop_back<u64>(&mut arg7);
            assert!(v4 > 0, 10);
            if (!0x2::table::contains<address, Member>(&arg0.members, v3)) {
                let v5 = Member{joined_at_ms: v4};
                0x2::table::add<address, Member>(&mut arg0.members, v3, v5);
                v2 = v2 + 1;
            };
        };
        arg0.member_count = arg0.member_count + v2;
        let v6 = GlobalChatLegacyMembersImported{
            global_chat_id         : 0x2::object::id<GlobalChatGroup>(arg0),
            admin                  : 0x2::tx_context::sender(arg8),
            source_network         : 1,
            source_package_id      : @0x6b479e1753ea6148875f4e1daa1b9d16b45b323fabebc2a2996e895163b57008,
            source_group_id        : @0xb433abcddd8e998e8e52624dc36a6334f72939f1d56c24d382199f7cc8bb3b91,
            source_object_version  : arg2,
            source_object_digest   : arg3,
            source_snapshot_sha256 : arg4,
            source_member_count    : arg5,
            requested_count        : v0,
            imported_count         : v2,
            member_count           : arg0.member_count,
        };
        0x2::event::emit<GlobalChatLegacyMembersImported>(v6);
    }

    fun init(arg0: GLOBAL_CHAT, arg1: &mut 0x2::tx_context::TxContext) {
        initialize(arg1);
    }

    fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalChatAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<GlobalChatAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GlobalChatRegistry{
            id             : 0x2::object::new(arg0),
            global_chat_id : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<GlobalChatRegistry>(v1);
    }

    public fun is_member(arg0: &GlobalChatGroup, arg1: address) : bool {
        0x2::table::contains<address, Member>(&arg0.members, arg1)
    }

    entry fun join_group_by_global_chat_id(arg0: &mut GlobalChatGroup, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, Member>(&arg0.members, v0), 4);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = Member{joined_at_ms: v1};
        0x2::table::add<address, Member>(&mut arg0.members, v0, v2);
        arg0.member_count = arg0.member_count + 1;
        let v3 = GlobalChatMemberJoined{
            global_chat_id : 0x2::object::id<GlobalChatGroup>(arg0),
            member         : v0,
            member_count   : arg0.member_count,
            joined_at_ms   : v1,
        };
        0x2::event::emit<GlobalChatMemberJoined>(v3);
    }

    public fun member_count(arg0: &GlobalChatGroup) : u64 {
        arg0.member_count
    }

    public fun member_joined_at_ms(arg0: &GlobalChatGroup, arg1: address) : u64 {
        0x2::table::borrow<address, Member>(&arg0.members, arg1).joined_at_ms
    }

    public fun message_count(arg0: &GlobalChatGroup) : u64 {
        arg0.message_count
    }

    public fun name(arg0: &GlobalChatGroup) : &0x1::string::String {
        &arg0.name
    }

    public fun paused(arg0: &GlobalChatGroup) : bool {
        arg0.paused
    }

    entry fun set_message_count(arg0: &mut GlobalChatGroup, arg1: &GlobalChatAdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg4);
        assert!(arg2 >= arg0.message_count, 9);
        arg0.message_count = arg2;
        let v0 = GlobalChatMessageCountSynced{
            global_chat_id : 0x2::object::id<GlobalChatGroup>(arg0),
            admin          : 0x2::tx_context::sender(arg4),
            message_count  : arg2,
            synced_at_ms   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<GlobalChatMessageCountSynced>(v0);
    }

    entry fun set_metadata(arg0: &mut GlobalChatGroup, arg1: &GlobalChatAdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg4);
        validate_metadata(&arg2, &arg3);
        arg0.name = arg2;
        arg0.description = arg3;
        let v0 = GlobalChatMetadataUpdated{
            global_chat_id : 0x2::object::id<GlobalChatGroup>(arg0),
            admin          : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<GlobalChatMetadataUpdated>(v0);
    }

    entry fun set_paused(arg0: &mut GlobalChatGroup, arg1: &GlobalChatAdminCap, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        arg0.paused = arg2;
        let v0 = GlobalChatPausedChanged{
            global_chat_id : 0x2::object::id<GlobalChatGroup>(arg0),
            admin          : 0x2::tx_context::sender(arg3),
            paused         : arg2,
        };
        0x2::event::emit<GlobalChatPausedChanged>(v0);
    }

    fun validate_metadata(arg0: &0x1::string::String, arg1: &0x1::string::String) {
        let v0 = 0x1::vector::length<u8>(0x1::string::as_bytes(arg0));
        let v1 = if (v0 > 0) {
            if (v0 <= 128) {
                0x1::vector::length<u8>(0x1::string::as_bytes(arg1)) <= 1000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 8);
    }

    // decompiled from Move bytecode v7
}

