module 0x7b71cdc95035c41bdbadb9da8a08586e81c590a6eb2b026c4cede4323f5ebad3::dialog_management {
    struct Message has copy, drop, store {
        sender: address,
        content: 0x1::string::String,
        timestamp: u64,
    }

    struct UserDialogs has key {
        id: 0x2::object::UID,
        dialogs: 0x2::table::Table<vector<u8>, 0x2::table::Table<u64, Message>>,
    }

    struct ChatCounts has key {
        id: 0x2::object::UID,
        counts: 0x2::table::Table<address, u64>,
    }

    struct MessagesEvent has copy, drop {
        dialog_hash: vector<u8>,
        messages: vector<Message>,
    }

    public fun get_chat_count(arg0: &ChatCounts, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.counts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.counts, arg1)
        } else {
            0
        }
    }

    public entry fun get_last_n_messages(arg0: &UserDialogs, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<Message>();
        if (0x2::table::contains<vector<u8>, 0x2::table::Table<u64, Message>>(&arg0.dialogs, arg1)) {
            let v1 = 0x2::table::borrow<vector<u8>, 0x2::table::Table<u64, Message>>(&arg0.dialogs, arg1);
            let v2 = 0x2::table::length<u64, Message>(v1);
            let v3 = if (v2 > arg2) {
                v2 - arg2
            } else {
                0
            };
            let v4 = v3;
            while (v4 < v2) {
                if (0x2::table::contains<u64, Message>(v1, v4)) {
                    0x1::vector::push_back<Message>(&mut v0, *0x2::table::borrow<u64, Message>(v1, v4));
                };
                v4 = v4 + 1;
            };
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
        let v1 = ChatCounts{
            id     : 0x2::object::new(arg0),
            counts : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<ChatCounts>(v1);
    }

    public entry fun send_message(arg0: &mut UserDialogs, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<vector<u8>, 0x2::table::Table<u64, Message>>(&arg0.dialogs, arg1)) {
            0x2::table::add<vector<u8>, 0x2::table::Table<u64, Message>>(&mut arg0.dialogs, arg1, 0x2::table::new<u64, Message>(arg3));
        };
        let v0 = 0x2::table::borrow_mut<vector<u8>, 0x2::table::Table<u64, Message>>(&mut arg0.dialogs, arg1);
        let v1 = Message{
            sender    : 0x2::tx_context::sender(arg3),
            content   : 0x1::string::utf8(arg2),
            timestamp : 0x2::tx_context::epoch(arg3),
        };
        0x2::table::add<u64, Message>(v0, 0x2::table::length<u64, Message>(v0), v1);
    }

    public entry fun update_chat_count(arg0: &mut ChatCounts, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, u64>(&arg0.counts, arg1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.counts, arg1) = arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.counts, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

