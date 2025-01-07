module 0xfdf4253739e94c7075addfa04e5d37dcf2cfbb98e8f08a94a79b482dc83e2e5b::global_chat {
    struct ChatRoom has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        max_msg_amount: u64,
        max_msg_length: u64,
        last_index: u64,
        messages: vector<ChatMessage>,
    }

    struct ChatMessage has drop, store {
        timestamp: u64,
        author: address,
        text: 0x1::string::String,
    }

    struct NewMessageEvent has copy, drop {
        room_id: 0x2::object::ID,
        author: address,
        text: 0x1::string::String,
        timestamp: u64,
    }

    public fun add_message(arg0: &mut ChatRoom, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u8>(&arg2);
        assert!(v0 > 0 && v0 <= arg0.max_msg_length, 102);
        let v1 = ChatMessage{
            timestamp : arg1,
            author    : 0x2::tx_context::sender(arg3),
            text      : 0x1::string::utf8(arg2),
        };
        0x1::vector::push_back<ChatMessage>(&mut arg0.messages, v1);
        let v2 = NewMessageEvent{
            room_id   : 0x2::object::uid_to_inner(&arg0.id),
            author    : 0x2::tx_context::sender(arg3),
            text      : 0x1::string::utf8(arg2),
            timestamp : arg1,
        };
        arg0.last_index = (arg0.last_index + 1) % arg0.max_msg_amount;
        if (0x1::vector::length<ChatMessage>(&arg0.messages) > arg0.max_msg_amount) {
            0x1::vector::swap_remove<ChatMessage>(&mut arg0.messages, arg0.last_index);
        };
        0x2::event::emit<NewMessageEvent>(v2);
    }

    public fun create(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ChatRoom{
            id             : 0x2::object::new(arg4),
            name           : 0x1::string::utf8(arg0),
            description    : 0x1::string::utf8(arg1),
            max_msg_amount : arg2,
            max_msg_length : arg3,
            last_index     : arg2 - 1,
            messages       : 0x1::vector::empty<ChatMessage>(),
        };
        0x2::transfer::share_object<ChatRoom>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        create(b"Global", b"Suigar global on-chain chat", 10000, 10000, arg0);
    }

    // decompiled from Move bytecode v6
}

