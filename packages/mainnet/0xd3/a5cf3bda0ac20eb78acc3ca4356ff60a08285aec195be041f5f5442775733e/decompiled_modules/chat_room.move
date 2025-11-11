module 0xd3a5cf3bda0ac20eb78acc3ca4356ff60a08285aec195be041f5f5442775733e::chat_room {
    struct ChatRoomRegistry has key {
        id: 0x2::object::UID,
        rooms: vector<0x2::object::ID>,
    }

    struct ChatRoomAdminCap has store, key {
        id: 0x2::object::UID,
        room_id: 0x2::object::ID,
    }

    struct ChatRoom has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        owner: address,
        created_at: u64,
        message_count: u64,
        current_block_number: u64,
        image_url: 0x1::string::String,
        banned_users: vector<address>,
        moderators: vector<address>,
    }

    struct MessageBlock has store, key {
        id: 0x2::object::UID,
        room_id: 0x2::object::ID,
        block_number: u64,
        message_ids: vector<0x2::object::ID>,
        created_at: u64,
    }

    struct MessageBlockEvent has copy, drop {
        event_type: 0x1::string::String,
        room_id: 0x2::object::ID,
        block_number: u64,
    }

    struct Message has store, key {
        id: 0x2::object::UID,
        room_id: 0x2::object::ID,
        block_number: u64,
        message_number: u64,
        sender: address,
        content: 0x1::string::String,
        created_at: u64,
        reply_to: 0x1::option::Option<0x2::object::ID>,
        edited: bool,
        edit_capability_id: 0x2::object::ID,
    }

    struct MessageEditCap has store, key {
        id: 0x2::object::UID,
        message_id: 0x2::object::ID,
    }

    struct MessageCreatedEvent has copy, drop {
        message_id: 0x2::object::ID,
        room_id: 0x2::object::ID,
        sender: address,
    }

    struct MessageUpdatedEvent has copy, drop {
        message_id: 0x2::object::ID,
        room_id: 0x2::object::ID,
        sender: address,
    }

    struct MessageDeletedEvent has copy, drop {
        message_id: 0x2::object::ID,
        room_id: 0x2::object::ID,
        sender: address,
    }

    struct ChatRoomCreatedEvent has copy, drop {
        room_id: 0x2::object::ID,
        owner: address,
    }

    struct UserBannedEvent has copy, drop {
        room_id: 0x2::object::ID,
        user: address,
    }

    struct UserUnbannedEvent has copy, drop {
        room_id: 0x2::object::ID,
        user: address,
    }

    public fun add_moderator(arg0: &ChatRoomAdminCap, arg1: &mut ChatRoom, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 2);
        if (!0x1::vector::contains<address>(&arg1.moderators, &arg2)) {
            0x1::vector::push_back<address>(&mut arg1.moderators, arg2);
        };
    }

    public fun ban_user(arg0: &mut ChatRoom, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.owner == v0 || 0x1::vector::contains<address>(&arg0.moderators, &v0), 2);
        if (!0x1::vector::contains<address>(&arg0.banned_users, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.banned_users, arg1);
            let v1 = UserBannedEvent{
                room_id : 0x2::object::uid_to_inner(&arg0.id),
                user    : arg1,
            };
            0x2::event::emit<UserBannedEvent>(v1);
        };
    }

    public fun create_room(arg0: &mut 0xd3a5cf3bda0ac20eb78acc3ca4356ff60a08285aec195be041f5f5442775733e::user_profile::UserProfile, arg1: &mut ChatRoomRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg5);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let v3 = 0x2::tx_context::sender(arg5);
        let v4 = ChatRoom{
            id                   : v0,
            name                 : arg2,
            owner                : v3,
            created_at           : v2,
            message_count        : 0,
            current_block_number : 0,
            image_url            : arg3,
            banned_users         : 0x1::vector::empty<address>(),
            moderators           : 0x1::vector::empty<address>(),
        };
        let v5 = MessageBlock{
            id           : 0x2::object::new(arg5),
            room_id      : v1,
            block_number : 0,
            message_ids  : 0x1::vector::empty<0x2::object::ID>(),
            created_at   : v2,
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.rooms, v1);
        let v6 = ChatRoomAdminCap{
            id      : 0x2::object::new(arg5),
            room_id : v1,
        };
        0x2::dynamic_field::add<u64, MessageBlock>(&mut v4.id, 0, v5);
        0xd3a5cf3bda0ac20eb78acc3ca4356ff60a08285aec195be041f5f5442775733e::user_profile::add_user_profile_rooms_joined(arg0, v1);
        0x2::transfer::share_object<ChatRoom>(v4);
        0x2::transfer::transfer<ChatRoomAdminCap>(v6, v3);
        let v7 = ChatRoomCreatedEvent{
            room_id : v1,
            owner   : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<ChatRoomCreatedEvent>(v7);
    }

    public fun delete_message(arg0: &ChatRoom, arg1: Message, arg2: MessageEditCap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (arg1.sender == v0) {
            true
        } else if (arg0.owner == v0) {
            true
        } else {
            0x1::vector::contains<address>(&arg0.moderators, &v0)
        };
        assert!(v1, 2);
        let Message {
            id                 : v2,
            room_id            : _,
            block_number       : _,
            message_number     : _,
            sender             : _,
            content            : _,
            created_at         : _,
            reply_to           : _,
            edited             : _,
            edit_capability_id : _,
        } = arg1;
        0x2::object::delete(v2);
        let MessageEditCap {
            id         : v12,
            message_id : _,
        } = arg2;
        0x2::object::delete(v12);
        let v14 = MessageDeletedEvent{
            message_id : 0x2::object::uid_to_inner(&arg1.id),
            room_id    : arg1.room_id,
            sender     : v0,
        };
        0x2::event::emit<MessageDeletedEvent>(v14);
    }

    public fun edit_message(arg0: &MessageEditCap, arg1: &mut Message, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::string::is_empty(&arg2), 3);
        arg1.content = arg2;
        arg1.edited = true;
        let v0 = MessageUpdatedEvent{
            message_id : 0x2::object::uid_to_inner(&arg1.id),
            room_id    : arg1.room_id,
            sender     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<MessageUpdatedEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ChatRoomRegistry{
            id    : 0x2::object::new(arg0),
            rooms : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<ChatRoomRegistry>(v0);
    }

    public fun send_message(arg0: &mut 0xd3a5cf3bda0ac20eb78acc3ca4356ff60a08285aec195be041f5f5442775733e::user_profile::UserProfile, arg1: &mut ChatRoom, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x2::object::ID>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!0x1::vector::contains<address>(&arg1.banned_users, &v0), 1);
        assert!(!0x1::string::is_empty(&arg2), 3);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = 0x2::object::uid_to_inner(&arg1.id);
        let v3 = arg1.current_block_number;
        let v4 = 0x2::dynamic_field::borrow_mut<u64, MessageBlock>(&mut arg1.id, v3);
        let v5 = v4;
        if (0x1::vector::length<0x2::object::ID>(&v4.message_ids) >= 100) {
            let v6 = v3 + 1;
            let v7 = MessageBlock{
                id           : 0x2::object::new(arg5),
                room_id      : v2,
                block_number : v6,
                message_ids  : 0x1::vector::empty<0x2::object::ID>(),
                created_at   : v1,
            };
            0x2::dynamic_field::add<u64, MessageBlock>(&mut arg1.id, v6, v7);
            arg1.current_block_number = v6;
            let v8 = MessageBlockEvent{
                event_type   : 0x1::string::utf8(b"created"),
                room_id      : v2,
                block_number : v6,
            };
            0x2::event::emit<MessageBlockEvent>(v8);
            v5 = 0x2::dynamic_field::borrow_mut<u64, MessageBlock>(&mut arg1.id, v6);
        };
        let v9 = 0x2::object::new(arg5);
        let v10 = 0x2::object::uid_to_inner(&v9);
        let v11 = 0x2::object::new(arg5);
        let v12 = MessageEditCap{
            id         : v11,
            message_id : v10,
        };
        let v13 = Message{
            id                 : v9,
            room_id            : v2,
            block_number       : v5.block_number,
            message_number     : arg1.message_count,
            sender             : v0,
            content            : arg2,
            created_at         : v1,
            reply_to           : arg3,
            edited             : false,
            edit_capability_id : 0x2::object::uid_to_inner(&v11),
        };
        0x1::vector::push_back<0x2::object::ID>(&mut v5.message_ids, v10);
        arg1.message_count = arg1.message_count + 1;
        0xd3a5cf3bda0ac20eb78acc3ca4356ff60a08285aec195be041f5f5442775733e::user_profile::add_user_profile_rooms_joined(arg0, v2);
        let v14 = MessageCreatedEvent{
            message_id : v10,
            room_id    : v2,
            sender     : v0,
        };
        0x2::event::emit<MessageCreatedEvent>(v14);
        0x2::transfer::share_object<Message>(v13);
        0x2::transfer::transfer<MessageEditCap>(v12, v0);
    }

    public fun unban_user(arg0: &ChatRoomAdminCap, arg1: &mut ChatRoom, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 2);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.banned_users, &arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg1.banned_users, v1);
            let v2 = UserUnbannedEvent{
                room_id : 0x2::object::uid_to_inner(&arg1.id),
                user    : arg2,
            };
            0x2::event::emit<UserUnbannedEvent>(v2);
        };
    }

    // decompiled from Move bytecode v6
}

