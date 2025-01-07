module 0x9bccd22304e984ff1e565c2bd7ac8254b0ee2788190373daae33432ace873c18::event_chat {
    struct ChatRoom has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct MessageEvent has copy, drop {
        room: address,
        text: 0x1::string::String,
    }

    public entry fun create_room(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ChatRoom{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
        };
        0x2::transfer::freeze_object<ChatRoom>(v0);
    }

    public entry fun send_message(arg0: &ChatRoom, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MessageEvent{
            room : 0x2::object::id_address<ChatRoom>(arg0),
            text : 0x1::string::utf8(arg1),
        };
        0x2::event::emit<MessageEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

