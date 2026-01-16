module 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::channel {
    struct Channel has key {
        id: 0x2::object::UID,
        version: u64,
        auth: 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::auth::Auth,
        messages: 0x2::table_vec::TableVec<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::message::Message>,
        messages_count: u64,
        last_message: 0x1::option::Option<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::message::Message>,
        created_at_ms: u64,
        updated_at_ms: u64,
        encryption_key_history: 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::encryption_key_history::EncryptionKeyHistory,
    }

    struct SimpleMessenger has drop {
        dummy_field: bool,
    }

    public fun new(arg0: 0x1::option::Option<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::config::Config>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (Channel, 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::creator_cap::CreatorCap, 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::member_cap::MemberCap) {
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::member_cap::mint(0x2::object::uid_to_inner(&v0), arg2);
        let v2 = 0x2::object::id<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::member_cap::MemberCap>(&v1);
        let v3 = 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::auth::new(0x2::object::id<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::member_cap::MemberCap>(&v1), arg0, arg2);
        0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::auth::grant_permission<SimpleMessenger>(&mut v3, v2, v2);
        0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::auth::grant_permission<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::encryption_key_history::EditEncryptionKey>(&mut v3, v2, v2);
        0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::auth::grant_permission<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::config::EditConfig>(&mut v3, v2, v2);
        let v4 = Channel{
            id                     : v0,
            version                : 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::admin::version(),
            auth                   : v3,
            messages               : 0x2::table_vec::empty<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::message::Message>(arg2),
            messages_count         : 0,
            last_message           : 0x1::option::none<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::message::Message>(),
            created_at_ms          : 0x2::clock::timestamp_ms(arg1),
            updated_at_ms          : 0x2::clock::timestamp_ms(arg1),
            encryption_key_history : 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::encryption_key_history::empty(arg2),
        };
        (v4, 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::creator_cap::mint(0x2::object::uid_to_inner(&v0), arg2), v1)
    }

    public(friend) fun version(arg0: &Channel) : u64 {
        arg0.version
    }

    public fun add_encrypted_key(arg0: &mut Channel, arg1: &0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::member_cap::MemberCap, arg2: vector<u8>) {
        assert!(is_member(arg0, arg1), 1);
        0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::encryption_key_history::rotate_key(&mut arg0.encryption_key_history, &arg0.auth, 0x2::object::id<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::member_cap::MemberCap>(arg1), arg2);
    }

    public fun add_members(arg0: &mut Channel, arg1: &0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::member_cap::MemberCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : vector<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::member_cap::MemberCap> {
        assert!(is_member(arg0, arg1), 1);
        assert!(arg2 < 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::config::config_max_channel_members(0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::auth::config(&arg0.auth)), 2);
        let v0 = 0x1::vector::empty<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::member_cap::MemberCap>();
        let v1 = 0;
        while (v1 < arg2) {
            let v2 = 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::member_cap::mint(0x2::object::id<Channel>(arg0), arg4);
            0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::auth::grant_permission<SimpleMessenger>(&mut arg0.auth, 0x2::object::id<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::member_cap::MemberCap>(arg1), 0x2::object::id<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::member_cap::MemberCap>(&v2));
            0x1::vector::push_back<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::member_cap::MemberCap>(&mut v0, v2);
            v1 = v1 + 1;
        };
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
        v0
    }

    public(friend) fun is_creator(arg0: &Channel, arg1: &0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::creator_cap::CreatorCap) : bool {
        0x2::object::uid_to_inner(&arg0.id) == 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::creator_cap::channel_id(arg1)
    }

    public(friend) fun is_member(arg0: &Channel, arg1: &0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::member_cap::MemberCap) : bool {
        0x2::object::id<Channel>(arg0) == 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::member_cap::channel_id(arg1) && 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::auth::has_permission<SimpleMessenger>(&arg0.auth, 0x2::object::id<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::member_cap::MemberCap>(arg1))
    }

    public(friend) fun latest_encryption_key(arg0: &Channel) : vector<u8> {
        0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::encryption_key_history::latest_key(&arg0.encryption_key_history)
    }

    public(friend) fun latest_encryption_key_version(arg0: &Channel) : u32 {
        0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::encryption_key_history::latest_key_version(&arg0.encryption_key_history)
    }

    public(friend) fun messages_count(arg0: &Channel) : u64 {
        arg0.messages_count
    }

    public fun namespace(arg0: &Channel) : vector<u8> {
        0x2::object::uid_to_bytes(&arg0.id)
    }

    public fun remove_members(arg0: &mut Channel, arg1: &0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::member_cap::MemberCap, arg2: vector<0x2::object::ID>, arg3: &0x2::clock::Clock) {
        assert!(is_member(arg0, arg1), 1);
        assert!(0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::encryption_key_history::has_encryption_key(&arg0.encryption_key_history), 3);
        0x1::vector::reverse<0x2::object::ID>(&mut arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::auth::remove_member_entry(&mut arg0.auth, 0x2::object::id<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::member_cap::MemberCap>(arg1), 0x1::vector::pop_back<0x2::object::ID>(&mut arg2));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg2);
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
    }

    public fun send_message(arg0: &mut Channel, arg1: &0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::member_cap::MemberCap, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::attachment::Attachment>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(is_member(arg0, arg1), 1);
        assert!(0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::encryption_key_history::has_encryption_key(&arg0.encryption_key_history), 3);
        assert!(0x1::vector::length<u8>(&arg2) <= 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::config::config_max_message_text_chars(0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::auth::config(&arg0.auth)), 4);
        assert!(0x1::vector::length<u8>(&arg3) <= 12, 6);
        assert!(0x1::vector::length<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::attachment::Attachment>(&arg4) <= 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::config::config_max_message_attachments(0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::auth::config(&arg0.auth)), 5);
        let v0 = 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::encryption_key_history::latest_key_version(&arg0.encryption_key_history);
        let v1 = 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::message::new(0x2::tx_context::sender(arg6), arg2, arg3, v0, arg4, arg5);
        arg0.messages_count = arg0.messages_count + 1;
        if (0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::config::config_emit_events(0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::auth::config(&arg0.auth))) {
            0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::message::emit_event(&v1, 0x2::object::uid_to_inner(&arg0.id), arg0.messages_count - 1);
        };
        0x2::table_vec::push_back<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::message::Message>(&mut arg0.messages, v1);
        arg0.last_message = 0x1::option::some<0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::message::Message>(0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::message::new(0x2::tx_context::sender(arg6), arg2, arg3, v0, arg4, arg5));
    }

    public fun share(arg0: Channel, arg1: &0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::creator_cap::CreatorCap) {
        assert!(is_creator(&arg0, arg1), 0);
        0x2::transfer::share_object<Channel>(arg0);
    }

    // decompiled from Move bytecode v6
}

