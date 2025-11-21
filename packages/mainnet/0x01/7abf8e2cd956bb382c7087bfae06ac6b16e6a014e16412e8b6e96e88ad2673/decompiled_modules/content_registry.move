module 0x17abf8e2cd956bb382c7087bfae06ac6b16e6a014e16412e8b6e96e88ad2673::content_registry {
    struct ContentHandle has store, key {
        id: 0x2::object::UID,
        creator: address,
        title: 0x1::string::String,
        description: 0x1::string::String,
        tier_id: 0x2::object::ID,
        walrus_cid: 0x1::string::String,
        seal_policy_id: 0x1::string::String,
        content_type: u8,
        file_size: u64,
        file_name: 0x1::string::String,
        created_at: u64,
        views: u64,
    }

    struct ContentPublished has copy, drop {
        content_id: 0x2::object::ID,
        creator: address,
        title: 0x1::string::String,
        tier_id: 0x2::object::ID,
        content_type: u8,
        walrus_cid: 0x1::string::String,
        file_size: u64,
        file_name: 0x1::string::String,
        timestamp: u64,
    }

    struct ContentUpdated has copy, drop {
        content_id: 0x2::object::ID,
        creator: address,
        timestamp: u64,
    }

    struct ContentViewed has copy, drop {
        content_id: 0x2::object::ID,
        viewer: address,
        timestamp: u64,
    }

    public fun get_content_type(arg0: &ContentHandle) : u8 {
        arg0.content_type
    }

    public fun get_created_at(arg0: &ContentHandle) : u64 {
        arg0.created_at
    }

    public fun get_creator(arg0: &ContentHandle) : address {
        arg0.creator
    }

    public fun get_description(arg0: &ContentHandle) : 0x1::string::String {
        arg0.description
    }

    public fun get_file_name(arg0: &ContentHandle) : 0x1::string::String {
        arg0.file_name
    }

    public fun get_file_size(arg0: &ContentHandle) : u64 {
        arg0.file_size
    }

    public fun get_seal_policy_id(arg0: &ContentHandle) : 0x1::string::String {
        arg0.seal_policy_id
    }

    public fun get_tier_id(arg0: &ContentHandle) : 0x2::object::ID {
        arg0.tier_id
    }

    public fun get_title(arg0: &ContentHandle) : 0x1::string::String {
        arg0.title
    }

    public fun get_views(arg0: &ContentHandle) : u64 {
        arg0.views
    }

    public fun get_walrus_cid(arg0: &ContentHandle) : 0x1::string::String {
        arg0.walrus_cid
    }

    public fun increment_views(arg0: &mut ContentHandle, arg1: address, arg2: &0x2::clock::Clock) {
        arg0.views = arg0.views + 1;
        let v0 = ContentViewed{
            content_id : 0x2::object::id<ContentHandle>(arg0),
            viewer     : arg1,
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ContentViewed>(v0);
    }

    public entry fun register_content(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u8, arg6: u64, arg7: 0x1::string::String, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        let v2 = if (arg5 == 0) {
            true
        } else if (arg5 == 1) {
            true
        } else if (arg5 == 2) {
            true
        } else if (arg5 == 3) {
            true
        } else {
            arg5 == 4
        };
        assert!(v2, 2);
        assert!(0x1::string::length(&arg3) > 0, 3);
        let v3 = ContentHandle{
            id             : 0x2::object::new(arg9),
            creator        : v0,
            title          : arg0,
            description    : arg1,
            tier_id        : arg2,
            walrus_cid     : arg3,
            seal_policy_id : arg4,
            content_type   : arg5,
            file_size      : arg6,
            file_name      : arg7,
            created_at     : v1,
            views          : 0,
        };
        let v4 = ContentPublished{
            content_id   : 0x2::object::id<ContentHandle>(&v3),
            creator      : v0,
            title        : v3.title,
            tier_id      : arg2,
            content_type : arg5,
            walrus_cid   : v3.walrus_cid,
            file_size    : arg6,
            file_name    : v3.file_name,
            timestamp    : v1,
        };
        0x2::event::emit<ContentPublished>(v4);
        0x2::transfer::public_share_object<ContentHandle>(v3);
    }

    public entry fun update_content_metadata(arg0: &mut ContentHandle, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.creator == v0, 1);
        arg0.title = arg1;
        arg0.description = arg2;
        let v1 = ContentUpdated{
            content_id : 0x2::object::id<ContentHandle>(arg0),
            creator    : v0,
            timestamp  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ContentUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

