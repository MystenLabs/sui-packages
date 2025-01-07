module 0x3ef16341342470cc47dfabca3c2bc37bed8fe4f44a5973e08d388481e9adee41::messenger {
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

    struct FinalEvent has copy, drop {
        id: vector<u8>,
    }

    struct MessagesEvent has copy, drop {
        messages: vector<Message>,
    }

    fun compare_vectors(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        let v3 = 0;
        while (v3 < v2) {
            let v4 = *0x1::vector::borrow<u8>(arg0, v3);
            let v5 = *0x1::vector::borrow<u8>(arg1, v3);
            if (v4 < v5) {
                return true
            };
            if (v4 > v5) {
                return false
            };
            v3 = v3 + 1;
        };
        v0 < v1
    }

    fun compute_final_dialog_id(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x2::hash::blake2b256(&v0)
    }

    public fun get_last_n_messages(arg0: &DialogStore, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) : vector<Message> {
        let v0 = compute_final_dialog_id(arg1, arg2);
        let v1 = FinalEvent{id: v0};
        0x2::event::emit<FinalEvent>(v1);
        assert!(0x2::table::contains<vector<u8>, Dialog>(&arg0.dialogs, v0), 0);
        let v2 = &0x2::table::borrow<vector<u8>, Dialog>(&arg0.dialogs, v0).messages;
        let v3 = 0x1::vector::length<Message>(v2);
        let v4 = if (v3 > arg3) {
            v3 - arg3
        } else {
            0
        };
        let v5 = 0x1::vector::empty<Message>();
        let v6 = v4;
        while (v6 < v3) {
            0x1::vector::push_back<Message>(&mut v5, *0x1::vector::borrow<Message>(v2, v6));
            v6 = v6 + 1;
        };
        let v7 = MessagesEvent{messages: v5};
        0x2::event::emit<MessagesEvent>(v7);
        v5
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
        let v1 = FinalEvent{id: v0};
        0x2::event::emit<FinalEvent>(v1);
        if (!0x2::table::contains<vector<u8>, Dialog>(&arg0.dialogs, v0)) {
            let v2 = Dialog{messages: 0x1::vector::empty<Message>()};
            0x2::table::add<vector<u8>, Dialog>(&mut arg0.dialogs, v0, v2);
        };
        let v3 = Message{
            sender    : 0x2::tx_context::sender(arg4),
            content   : arg3,
            timestamp : 0x2::tx_context::epoch(arg4),
        };
        0x1::vector::push_back<Message>(&mut 0x2::table::borrow_mut<vector<u8>, Dialog>(&mut arg0.dialogs, v0).messages, v3);
    }

    // decompiled from Move bytecode v6
}

