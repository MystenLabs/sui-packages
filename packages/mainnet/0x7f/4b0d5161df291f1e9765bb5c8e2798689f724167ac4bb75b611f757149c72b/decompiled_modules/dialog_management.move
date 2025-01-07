module 0x7f4b0d5161df291f1e9765bb5c8e2798689f724167ac4bb75b611f757149c72b::dialog_management {
    struct Message has copy, drop, store {
        sender: address,
        content: 0x1::string::String,
        timestamp: u64,
    }

    struct UserDialogHashes has key {
        id: 0x2::object::UID,
        dialog_hashes: 0x2::table::Table<address, vector<u8>>,
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

    struct ChatCountEvent has copy, drop {
        address: address,
        count: u64,
    }

    struct UserDialogHashesEvent has copy, drop {
        address: address,
        dialog_hash: vector<u8>,
    }

    public entry fun add_dialog_hash(arg0: &mut UserDialogHashes, arg1: address, arg2: vector<u8>) {
        0x2::table::add<address, vector<u8>>(&mut arg0.dialog_hashes, arg1, arg2);
    }

    public fun get_chat_count(arg0: &ChatCounts, arg1: address) : u64 {
        let v0 = if (0x2::table::contains<address, u64>(&arg0.counts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.counts, arg1)
        } else {
            0
        };
        let v1 = ChatCountEvent{
            address : arg1,
            count   : v0,
        };
        0x2::event::emit<ChatCountEvent>(v1);
        v0
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
        let v2 = UserDialogHashes{
            id            : 0x2::object::new(arg0),
            dialog_hashes : 0x2::table::new<address, vector<u8>>(arg0),
        };
        0x2::transfer::share_object<UserDialogHashes>(v2);
    }

    public entry fun read_user_dialog_hash(arg0: &UserDialogHashes, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, vector<u8>>(&arg0.dialog_hashes, arg1)) {
            let v0 = UserDialogHashesEvent{
                address     : arg1,
                dialog_hash : *0x2::table::borrow<address, vector<u8>>(&arg0.dialog_hashes, arg1),
            };
            0x2::event::emit<UserDialogHashesEvent>(v0);
        };
    }

    public entry fun send_message(arg0: &mut UserDialogs, arg1: &mut UserDialogHashes, arg2: &mut ChatCounts, arg3: address, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        if (!0x2::table::contains<vector<u8>, 0x2::table::Table<u64, Message>>(&arg0.dialogs, arg4)) {
            0x2::table::add<vector<u8>, 0x2::table::Table<u64, Message>>(&mut arg0.dialogs, arg4, 0x2::table::new<u64, Message>(arg6));
            if (0x2::table::contains<address, u64>(&arg2.counts, v0)) {
                let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg2.counts, v0);
                *v1 = *v1 + 1;
            } else {
                0x2::table::add<address, u64>(&mut arg2.counts, v0, 1);
            };
            let v2 = ChatCountEvent{
                address : v0,
                count   : *0x2::table::borrow<address, u64>(&arg2.counts, v0),
            };
            0x2::event::emit<ChatCountEvent>(v2);
        };
        if (!0x2::table::contains<address, vector<u8>>(&arg1.dialog_hashes, v0)) {
            0x2::table::add<address, vector<u8>>(&mut arg1.dialog_hashes, v0, arg4);
        };
        let v3 = 0x2::table::borrow_mut<vector<u8>, 0x2::table::Table<u64, Message>>(&mut arg0.dialogs, arg4);
        let v4 = Message{
            sender    : v0,
            content   : 0x1::string::utf8(arg5),
            timestamp : 0x2::tx_context::epoch(arg6),
        };
        0x2::table::add<u64, Message>(v3, 0x2::table::length<u64, Message>(v3), v4);
    }

    public entry fun update_chat_count(arg0: &mut ChatCounts, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, u64>(&arg0.counts, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.counts, arg1);
            *v0 = *v0 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.counts, arg1, 1);
        };
        let v1 = ChatCountEvent{
            address : arg1,
            count   : *0x2::table::borrow<address, u64>(&arg0.counts, arg1),
        };
        0x2::event::emit<ChatCountEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

