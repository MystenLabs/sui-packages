module 0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::events {
    struct MessageSent has copy, drop {
        message_id: 0x2::object::ID,
        sender: address,
        recipient: address,
        walrus_blob_id: 0x1::string::String,
        content_hash: vector<u8>,
        timestamp: u64,
    }

    struct MessageReadSimple has copy, drop {
        message_id: 0x2::object::ID,
        reader: address,
        timestamp: u64,
    }

    struct GroupCreated has copy, drop {
        group_id: 0x2::object::ID,
        admin: address,
        member_count: u64,
        timestamp: u64,
    }

    struct GroupMessageSent has copy, drop {
        group_id: 0x2::object::ID,
        sender: address,
        timestamp: u64,
    }

    public(friend) fun emit_group_created(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = GroupCreated{
            group_id     : arg0,
            admin        : arg1,
            member_count : arg2,
            timestamp    : arg3,
        };
        0x2::event::emit<GroupCreated>(v0);
    }

    public(friend) fun emit_group_message_sent(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = GroupMessageSent{
            group_id  : arg0,
            sender    : arg1,
            timestamp : arg2,
        };
        0x2::event::emit<GroupMessageSent>(v0);
    }

    public(friend) fun emit_message_read_simple(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = MessageReadSimple{
            message_id : arg0,
            reader     : arg1,
            timestamp  : arg2,
        };
        0x2::event::emit<MessageReadSimple>(v0);
    }

    public(friend) fun emit_message_sent(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: 0x1::string::String, arg4: vector<u8>, arg5: u64) {
        let v0 = MessageSent{
            message_id     : arg0,
            sender         : arg1,
            recipient      : arg2,
            walrus_blob_id : arg3,
            content_hash   : arg4,
            timestamp      : arg5,
        };
        0x2::event::emit<MessageSent>(v0);
    }

    // decompiled from Move bytecode v6
}

