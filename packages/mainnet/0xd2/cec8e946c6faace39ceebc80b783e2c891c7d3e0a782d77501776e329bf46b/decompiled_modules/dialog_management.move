module 0xd2cec8e946c6faace39ceebc80b783e2c891c7d3e0a782d77501776e329bf46b::dialog_management {
    struct Dialog has store, key {
        id: 0x2::object::UID,
        messages: 0x2::table::Table<u64, Message>,
    }

    struct Message has copy, drop, store {
        sender: address,
        content: 0x1::string::String,
        timestamp: u64,
    }

    struct UserDialogs has key {
        id: 0x2::object::UID,
        dialogs: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
    }

    public fun get_messages_after_time(arg0: &Dialog, arg1: u64, arg2: u64) : vector<Message> {
        let v0 = 0x1::vector::empty<Message>();
        let v1 = 0;
        while (v1 < arg2 && 0x2::table::contains<u64, Message>(&arg0.messages, arg1)) {
            0x1::vector::push_back<Message>(&mut v0, *0x2::table::borrow<u64, Message>(&arg0.messages, arg1));
            v1 = v1 + 1;
            arg1 = arg1 + 1;
        };
        v0
    }

    public entry fun send_message(arg0: &mut UserDialogs, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.dialogs, arg1)) {
            let v0 = Dialog{
                id       : 0x2::object::new(arg3),
                messages : 0x2::table::new<u64, Message>(arg3),
            };
            0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg0.dialogs, arg1, 0x2::object::id<Dialog>(&v0));
            0x2::transfer::share_object<Dialog>(v0);
        };
        let v1 = 0x2::tx_context::epoch(arg3);
        let v2 = Message{
            sender    : 0x2::tx_context::sender(arg3),
            content   : 0x1::string::utf8(arg2),
            timestamp : v1,
        };
        0x2::table::add<u64, Message>(&mut 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Dialog>(&mut arg0.id, *0x2::table::borrow<vector<u8>, 0x2::object::ID>(&arg0.dialogs, arg1)).messages, v1, v2);
    }

    // decompiled from Move bytecode v6
}

