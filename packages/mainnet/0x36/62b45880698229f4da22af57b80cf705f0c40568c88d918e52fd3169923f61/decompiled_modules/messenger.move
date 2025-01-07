module 0x3662b45880698229f4da22af57b80cf705f0c40568c88d918e52fd3169923f61::messenger {
    struct Message has copy, drop, store {
        sender: address,
        content: vector<u8>,
        timestamp: u64,
    }

    struct Dialog has store {
        messages: vector<Message>,
    }

    struct DialogStore has key {
        id: 0x2::object::UID,
        dialogs: 0x2::table::Table<vector<u8>, Dialog>,
    }

    struct MessageCountEvent has copy, drop {
        count: u64,
    }

    struct MessagesEvent has copy, drop {
        messages: vector<Message>,
    }

    fun compute_final_dialog_id(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x2::hash::blake2b256(&v0)
    }

    public fun get_last_n_messages(arg0: &DialogStore, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) : vector<Message> {
        let v0 = compute_final_dialog_id(arg1, arg2);
        assert!(0x2::table::contains<vector<u8>, Dialog>(&arg0.dialogs, v0), 0);
        let v1 = &0x2::table::borrow<vector<u8>, Dialog>(&arg0.dialogs, v0).messages;
        let v2 = 0x1::vector::length<Message>(v1);
        let v3 = if (v2 > arg3) {
            v2 - arg3
        } else {
            0
        };
        let v4 = 0x1::vector::empty<Message>();
        let v5 = v3;
        while (v5 < v2) {
            0x1::vector::push_back<Message>(&mut v4, *0x1::vector::borrow<Message>(v1, v5));
            v5 = v5 + 1;
        };
        let v6 = MessagesEvent{messages: v4};
        0x2::event::emit<MessagesEvent>(v6);
        v4
    }

    public fun get_last_n_messages2(arg0: &DialogStore, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) : (vector<address>, vector<vector<u8>>, vector<u64>) {
        let v0 = compute_final_dialog_id(arg1, arg2);
        assert!(0x2::table::contains<vector<u8>, Dialog>(&arg0.dialogs, v0), 0);
        let v1 = &0x2::table::borrow<vector<u8>, Dialog>(&arg0.dialogs, v0).messages;
        let v2 = 0x1::vector::length<Message>(v1);
        let v3 = if (v2 > arg3) {
            v2 - arg3
        } else {
            0
        };
        let v4 = 0x1::vector::empty<address>();
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = v3;
        while (v7 < v2) {
            let v8 = 0x1::vector::borrow<Message>(v1, v7);
            0x1::vector::push_back<address>(&mut v4, v8.sender);
            0x1::vector::push_back<vector<u8>>(&mut v5, v8.content);
            0x1::vector::push_back<u64>(&mut v6, v8.timestamp);
            v7 = v7 + 1;
        };
        (v4, v5, v6)
    }

    public entry fun get_message_count(arg0: &DialogStore, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = compute_final_dialog_id(arg1, arg2);
        if (!0x2::table::contains<vector<u8>, Dialog>(&arg0.dialogs, v0)) {
            let v1 = MessageCountEvent{count: 0};
            0x2::event::emit<MessageCountEvent>(v1);
            return
        };
        let v2 = MessageCountEvent{count: 0x1::vector::length<Message>(&0x2::table::borrow<vector<u8>, Dialog>(&arg0.dialogs, v0).messages)};
        0x2::event::emit<MessageCountEvent>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DialogStore{
            id      : 0x2::object::new(arg0),
            dialogs : 0x2::table::new<vector<u8>, Dialog>(arg0),
        };
        0x2::transfer::share_object<DialogStore>(v0);
    }

    public entry fun send_message(arg0: &mut DialogStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = compute_final_dialog_id(arg1, arg2);
        if (!0x2::table::contains<vector<u8>, Dialog>(&arg0.dialogs, v0)) {
            let v1 = Dialog{messages: 0x1::vector::empty<Message>()};
            0x2::table::add<vector<u8>, Dialog>(&mut arg0.dialogs, v0, v1);
        };
        let v2 = Message{
            sender    : 0x2::tx_context::sender(arg4),
            content   : arg3,
            timestamp : 0x2::tx_context::epoch(arg4),
        };
        0x1::vector::push_back<Message>(&mut 0x2::table::borrow_mut<vector<u8>, Dialog>(&mut arg0.dialogs, v0).messages, v2);
    }

    // decompiled from Move bytecode v6
}

