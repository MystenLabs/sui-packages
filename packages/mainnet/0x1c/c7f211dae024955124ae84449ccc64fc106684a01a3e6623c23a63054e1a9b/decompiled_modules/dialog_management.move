module 0x1cc7f211dae024955124ae84449ccc64fc106684a01a3e6623c23a63054e1a9b::dialog_management {
    struct Message has copy, drop, store {
        sender: address,
        content: 0x1::string::String,
        timestamp: u64,
    }

    struct UserDialogs has key {
        id: 0x2::object::UID,
        dialogs: 0x2::table::Table<vector<u8>, 0x2::table::Table<u64, Message>>,
    }

    struct MessagesEvent has copy, drop {
        dialog_hash: vector<u8>,
        messages: vector<Message>,
    }

    public fun get_messages_after_time(arg0: &UserDialogs, arg1: vector<u8>, arg2: u64) {
        let v0 = 0x1::vector::empty<Message>();
        if (!0x2::table::contains<vector<u8>, 0x2::table::Table<u64, Message>>(&arg0.dialogs, arg1)) {
            let v1 = MessagesEvent{
                dialog_hash : arg1,
                messages    : v0,
            };
            0x2::event::emit<MessagesEvent>(v1);
        };
        let v2 = 0x2::table::borrow<vector<u8>, 0x2::table::Table<u64, Message>>(&arg0.dialogs, arg1);
        let v3 = 0;
        let v4 = 0;
        while (v4 < arg2) {
            if (0x2::table::contains<u64, Message>(v2, v3)) {
                0x1::vector::push_back<Message>(&mut v0, *0x2::table::borrow<u64, Message>(v2, v3));
                v4 = v4 + 1;
            };
            v3 = v3 + 1;
        };
        let v5 = MessagesEvent{
            dialog_hash : arg1,
            messages    : v0,
        };
        0x2::event::emit<MessagesEvent>(v5);
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

