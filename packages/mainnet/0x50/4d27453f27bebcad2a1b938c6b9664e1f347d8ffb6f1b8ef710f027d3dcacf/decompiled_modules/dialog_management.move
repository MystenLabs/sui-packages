module 0x504d27453f27bebcad2a1b938c6b9664e1f347d8ffb6f1b8ef710f027d3dcacf::dialog_management {
    struct Dialog has store {
        creator: address,
        participant: address,
        messages: 0x2::table::Table<u64, Message>,
        pub_key_creator: vector<u8>,
        pub_key_participant: vector<u8>,
    }

    struct Message has copy, drop, store {
        sender: address,
        content: 0x1::string::String,
        timestamp: u64,
    }

    struct UserDialogs has key {
        id: 0x2::object::UID,
    }

    public entry fun create_user_dialogs(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UserDialogs{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<UserDialogs>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun get_messages_after_time(arg0: &UserDialogs, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) : vector<Message> {
        let v0 = 0x1::vector::empty<Message>();
        let v1 = 0x2::dynamic_field::borrow<vector<u8>, Dialog>(&arg0.id, arg1);
        let v2 = 0x2::tx_context::epoch(arg4);
        while (v2 >= arg2 && 0x1::vector::length<Message>(&v0) < arg3) {
            if (0x2::table::contains<u64, Message>(&v1.messages, v2)) {
                0x1::vector::push_back<Message>(&mut v0, *0x2::table::borrow<u64, Message>(&v1.messages, v2));
            };
            if (v2 == 0) {
                break
            };
            v2 = v2 - 1;
        };
        v0
    }

    public entry fun send_message(arg0: &mut UserDialogs, arg1: vector<u8>, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)) {
            let v1 = Dialog{
                creator             : v0,
                participant         : arg2,
                messages            : 0x2::table::new<u64, Message>(arg6),
                pub_key_creator     : arg4,
                pub_key_participant : arg5,
            };
            0x2::dynamic_field::add<vector<u8>, Dialog>(&mut arg0.id, arg1, v1);
        };
        let v2 = 0x2::tx_context::epoch(arg6);
        let v3 = Message{
            sender    : v0,
            content   : 0x1::string::utf8(arg3),
            timestamp : v2,
        };
        0x2::table::add<u64, Message>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, Dialog>(&mut arg0.id, arg1).messages, v2, v3);
    }

    // decompiled from Move bytecode v6
}

