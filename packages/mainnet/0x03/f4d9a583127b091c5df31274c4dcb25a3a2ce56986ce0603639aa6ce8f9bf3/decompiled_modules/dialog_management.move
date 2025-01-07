module 0x3f4d9a583127b091c5df31274c4dcb25a3a2ce56986ce0603639aa6ce8f9bf3::dialog_management {
    struct Message has copy, drop, store {
        sender: address,
        recipient: address,
        content: vector<u8>,
        timestamp: u64,
    }

    struct DialogData has copy, drop, store {
        dialog_hash: vector<u8>,
        recipient: vector<u8>,
        timestamp: u64,
        last_message: vector<u8>,
    }

    struct DialogsData has key {
        id: 0x2::object::UID,
        dialogs_data: 0x2::table::Table<vector<u8>, DialogData>,
    }

    struct Dialogs has key {
        id: 0x2::object::UID,
        dialogs: 0x2::table::Table<vector<u8>, 0x2::table::Table<u64, Message>>,
    }

    struct ChatsCounts has key {
        id: 0x2::object::UID,
        counts: 0x2::table::Table<address, u64>,
    }

    struct MessagesEvent has copy, drop {
        dialog_hash: vector<u8>,
        messages: vector<Message>,
    }

    struct ChatsCountEvent has copy, drop {
        address: address,
        count: u64,
    }

    struct DialogsDataEvent has copy, drop {
        sender: vector<u8>,
        dialog_data: DialogData,
    }

    public entry fun add_dialog_data(arg0: &mut DialogsData, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<vector<u8>, DialogData>(&arg0.dialogs_data, arg1)) {
            let v0 = DialogData{
                dialog_hash  : arg3,
                recipient    : arg2,
                timestamp    : arg5,
                last_message : arg4,
            };
            0x2::table::add<vector<u8>, DialogData>(&mut arg0.dialogs_data, arg1, v0);
        };
    }

    public fun get_chats_count(arg0: &ChatsCounts, arg1: address) {
        let v0 = if (0x2::table::contains<address, u64>(&arg0.counts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.counts, arg1)
        } else {
            0
        };
        let v1 = ChatsCountEvent{
            address : arg1,
            count   : v0,
        };
        0x2::event::emit<ChatsCountEvent>(v1);
    }

    public entry fun get_last_n_messages(arg0: &Dialogs, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
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
        let v0 = Dialogs{
            id      : 0x2::object::new(arg0),
            dialogs : 0x2::table::new<vector<u8>, 0x2::table::Table<u64, Message>>(arg0),
        };
        0x2::transfer::share_object<Dialogs>(v0);
        let v1 = ChatsCounts{
            id     : 0x2::object::new(arg0),
            counts : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<ChatsCounts>(v1);
        let v2 = DialogsData{
            id           : 0x2::object::new(arg0),
            dialogs_data : 0x2::table::new<vector<u8>, DialogData>(arg0),
        };
        0x2::transfer::share_object<DialogsData>(v2);
    }

    public entry fun read_dialog_data(arg0: &DialogsData, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<vector<u8>, DialogData>(&arg0.dialogs_data, arg1)) {
            let v0 = DialogsDataEvent{
                sender      : arg1,
                dialog_data : *0x2::table::borrow<vector<u8>, DialogData>(&arg0.dialogs_data, arg1),
            };
            0x2::event::emit<DialogsDataEvent>(v0);
        };
    }

    public entry fun send_message(arg0: &mut Dialogs, arg1: &mut DialogsData, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<vector<u8>, 0x2::table::Table<u64, Message>>(&arg0.dialogs, arg2)) {
            0x2::table::add<vector<u8>, 0x2::table::Table<u64, Message>>(&mut arg0.dialogs, arg2, 0x2::table::new<u64, Message>(arg7));
        };
        if (0x2::table::contains<vector<u8>, DialogData>(&arg1.dialogs_data, arg3)) {
            let v0 = 0x2::table::borrow_mut<vector<u8>, DialogData>(&mut arg1.dialogs_data, arg3);
            v0.timestamp = arg6;
            v0.last_message = arg5;
        };
        let v1 = 0x2::table::borrow_mut<vector<u8>, 0x2::table::Table<u64, Message>>(&mut arg0.dialogs, arg2);
        let v2 = Message{
            sender    : 0x2::tx_context::sender(arg7),
            recipient : arg4,
            content   : arg5,
            timestamp : arg6,
        };
        0x2::table::add<u64, Message>(v1, 0x2::table::length<u64, Message>(v1), v2);
    }

    public entry fun update_chats_count(arg0: &mut ChatsCounts, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, u64>(&arg0.counts, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.counts, arg1);
            *v0 = *v0 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.counts, arg1, 1);
        };
        let v1 = ChatsCountEvent{
            address : arg1,
            count   : *0x2::table::borrow<address, u64>(&arg0.counts, arg1),
        };
        0x2::event::emit<ChatsCountEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

