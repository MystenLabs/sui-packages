module 0x5b7ade564a6c658382af19a54ccaeeae889a5273ba53d84a75f775a57a894b5e::dialog_management {
    struct Message has copy, drop, store {
        sender: address,
        content: 0x1::string::String,
        timestamp: u64,
    }

    struct UserDialogs has key {
        id: 0x2::object::UID,
        dialogs: 0x2::table::Table<vector<u8>, 0x2::table::Table<u64, Message>>,
    }

    public fun get_messages_after_time(arg0: &UserDialogs, arg1: vector<u8>, arg2: u64, arg3: u64) : vector<Message> {
        let v0 = 0x1::vector::empty<Message>();
        if (!0x2::table::contains<vector<u8>, 0x2::table::Table<u64, Message>>(&arg0.dialogs, arg1)) {
            return v0
        };
        let v1 = 0x2::table::borrow<vector<u8>, 0x2::table::Table<u64, Message>>(&arg0.dialogs, arg1);
        let v2 = 0;
        let v3 = 0;
        while (v3 < arg3) {
            if (0x2::table::contains<u64, Message>(v1, v2)) {
                let v4 = 0x2::table::borrow<u64, Message>(v1, v2);
                if (v4.timestamp >= arg2) {
                    0x1::vector::push_back<Message>(&mut v0, *v4);
                    v3 = v3 + 1;
                };
            };
            v2 = v2 + 1;
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UserDialogs{
            id      : 0x2::object::new(arg0),
            dialogs : 0x2::table::new<vector<u8>, 0x2::table::Table<u64, Message>>(arg0),
        };
        0x2::transfer::share_object<UserDialogs>(v0);
    }

    public entry fun send_message(arg0: &mut UserDialogs, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<vector<u8>, 0x2::table::Table<u64, Message>>(&arg0.dialogs, arg1)) {
            0x2::table::add<vector<u8>, 0x2::table::Table<u64, Message>>(&mut arg0.dialogs, arg1, 0x2::table::new<u64, Message>(arg3));
        };
        let v0 = 0x2::tx_context::epoch(arg3);
        let v1 = Message{
            sender    : 0x2::tx_context::sender(arg3),
            content   : 0x1::string::utf8(arg2),
            timestamp : v0,
        };
        0x2::table::add<u64, Message>(0x2::table::borrow_mut<vector<u8>, 0x2::table::Table<u64, Message>>(&mut arg0.dialogs, arg1), v0, v1);
    }

    // decompiled from Move bytecode v6
}

