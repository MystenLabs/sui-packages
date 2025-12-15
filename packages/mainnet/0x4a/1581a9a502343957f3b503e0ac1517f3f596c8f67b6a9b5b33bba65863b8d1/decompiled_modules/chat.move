module 0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::chat {
    struct ChatRegistry has key {
        id: 0x2::object::UID,
        chats: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
    }

    struct Chat has store, key {
        id: 0x2::object::UID,
        participants: vector<address>,
        unread_counts: 0x2::vec_map::VecMap<address, u64>,
        message_count: u64,
    }

    struct ChatCreated has copy, drop {
        id: 0x2::object::ID,
        participants: vector<address>,
    }

    public fun chat_exists(arg0: &ChatRegistry, arg1: address, arg2: address) : bool {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, arg1);
        0x1::vector::push_back<address>(&mut v0, arg2);
        let v1 = &mut v0;
        sort_addresses(v1);
        0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.chats, participants_key(&v0))
    }

    fun compare_address(arg0: address, arg1: address) : u8 {
        let v0 = 0x2::bcs::to_bytes<address>(&arg0);
        let v1 = 0x2::bcs::to_bytes<address>(&arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v0)) {
            let v3 = *0x1::vector::borrow<u8>(&v0, v2);
            let v4 = *0x1::vector::borrow<u8>(&v1, v2);
            if (v3 < v4) {
                return 1
            };
            if (v3 > v4) {
                return 2
            };
            v2 = v2 + 1;
        };
        0
    }

    public fun create_chat(arg0: &mut ChatRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : Chat {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        0x1::vector::push_back<address>(&mut v1, arg1);
        let v2 = &mut v1;
        sort_addresses(v2);
        let v3 = participants_key(&v1);
        assert!(!0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.chats, v3), 0);
        let v4 = 0x2::vec_map::empty<address, u64>();
        0x2::vec_map::insert<address, u64>(&mut v4, v0, 0);
        0x2::vec_map::insert<address, u64>(&mut v4, arg1, 0);
        let v5 = Chat{
            id            : 0x2::object::new(arg2),
            participants  : v1,
            unread_counts : v4,
            message_count : 0,
        };
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg0.chats, v3, 0x2::object::id<Chat>(&v5));
        v5
    }

    public(friend) fun increment_unread(arg0: &mut Chat, arg1: address) {
        arg0.message_count = arg0.message_count + 1;
        if (0x2::vec_map::contains<address, u64>(&arg0.unread_counts, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.unread_counts, &arg1);
            *v0 = *v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ChatRegistry{
            id    : 0x2::object::new(arg0),
            chats : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<ChatRegistry>(v0);
    }

    public fun is_participant(arg0: &Chat, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.participants, &arg1)
    }

    public fun mark_as_read(arg0: &mut Chat, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (0x2::vec_map::contains<address, u64>(&arg0.unread_counts, &v0)) {
            *0x2::vec_map::get_mut<address, u64>(&mut arg0.unread_counts, &v0) = 0;
        };
    }

    fun participants_key(arg0: &vector<address>) : vector<u8> {
        0x2::bcs::to_bytes<vector<address>>(arg0)
    }

    public fun share_chat(arg0: Chat) {
        let v0 = ChatCreated{
            id           : 0x2::object::id<Chat>(&arg0),
            participants : arg0.participants,
        };
        0x2::event::emit<ChatCreated>(v0);
        0x2::transfer::share_object<Chat>(arg0);
    }

    fun sort_addresses(arg0: &mut vector<address>) {
        let v0 = 0x1::vector::length<address>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = v1 + 1;
            while (v2 < v0) {
                if (compare_address(*0x1::vector::borrow<address>(arg0, v1), *0x1::vector::borrow<address>(arg0, v2)) == 2) {
                    0x1::vector::swap<address>(arg0, v1, v2);
                };
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

