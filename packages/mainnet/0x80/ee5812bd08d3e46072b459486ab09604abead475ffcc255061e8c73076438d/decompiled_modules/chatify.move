module 0x80ee5812bd08d3e46072b459486ab09604abead475ffcc255061e8c73076438d::chatify {
    struct Message has key {
        id: 0x2::object::UID,
        sender: address,
        username: 0x1::option::Option<0x1::string::String>,
        content: 0x1::string::String,
    }

    struct MessageCreated has copy, drop {
        message_id: 0x2::object::ID,
        sender: address,
        username: 0x1::option::Option<0x1::string::String>,
        content: 0x1::string::String,
    }

    struct MessageDeleted has copy, drop {
        message_id: 0x2::object::ID,
    }

    public fun delete_message(arg0: Message) {
        let Message {
            id       : v0,
            sender   : _,
            username : _,
            content  : _,
        } = arg0;
        let v4 = v0;
        0x2::object::delete(v4);
        let v5 = MessageDeleted{message_id: 0x2::object::uid_to_inner(&v4)};
        0x2::event::emit<MessageDeleted>(v5);
    }

    public fun send_message(arg0: 0x1::option::Option<0x1::string::String>, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = Message{
            id       : v0,
            sender   : 0x2::tx_context::sender(arg2),
            username : arg0,
            content  : arg1,
        };
        0x2::transfer::transfer<Message>(v1, @0x3ced3b89ceaf83c340da2357d6d0a55e54111d20d4a73cb36d50242674b0e902);
        let v2 = MessageCreated{
            message_id : 0x2::object::uid_to_inner(&v0),
            sender     : 0x2::tx_context::sender(arg2),
            username   : arg0,
            content    : arg1,
        };
        0x2::event::emit<MessageCreated>(v2);
    }

    // decompiled from Move bytecode v6
}

