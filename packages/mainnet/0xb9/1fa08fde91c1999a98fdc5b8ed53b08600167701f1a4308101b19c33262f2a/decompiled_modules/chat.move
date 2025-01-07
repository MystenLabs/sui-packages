module 0xb91fa08fde91c1999a98fdc5b8ed53b08600167701f1a4308101b19c33262f2a::chat {
    struct ChatShopCreated has copy, drop {
        id: 0x2::object::ID,
    }

    struct ChatTopMessageCreated has copy, drop {
        id: 0x2::object::ID,
        top_response_id: 0x2::object::ID,
    }

    struct ChatResponseCreated has copy, drop {
        id: 0x2::object::ID,
        top_message_id: 0x2::object::ID,
        seq_n: u64,
    }

    struct ChatOwnerCap has key {
        id: 0x2::object::UID,
    }

    struct ChatShop has key {
        id: 0x2::object::UID,
        price: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct ChatTopMessage has store, key {
        id: 0x2::object::UID,
        chat_shop_id: 0x2::object::ID,
        chat_top_response_id: 0x2::object::ID,
        author: address,
        responses_count: u64,
    }

    struct ChatResponse has store, key {
        id: 0x2::object::UID,
        chat_top_message_id: 0x2::object::ID,
        author: address,
        text: vector<u8>,
        metadata: vector<u8>,
        seq_n: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ChatOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ChatOwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = 0x2::object::new(arg0);
        let v2 = ChatShopCreated{id: 0x2::object::uid_to_inner(&v1)};
        0x2::event::emit<ChatShopCreated>(v2);
        let v3 = ChatShop{
            id      : v1,
            price   : 1000,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<ChatShop>(v3);
    }

    public entry fun post(arg0: &ChatShop, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) <= 512, 0);
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::new(arg3);
        let v2 = ChatTopMessageCreated{
            id              : 0x2::object::uid_to_inner(&v0),
            top_response_id : 0x2::object::uid_to_inner(&v1),
        };
        0x2::event::emit<ChatTopMessageCreated>(v2);
        let v3 = ChatResponseCreated{
            id             : 0x2::object::uid_to_inner(&v1),
            top_message_id : 0x2::object::uid_to_inner(&v0),
            seq_n          : 0,
        };
        0x2::event::emit<ChatResponseCreated>(v3);
        let v4 = ChatTopMessage{
            id                   : v0,
            chat_shop_id         : 0x2::object::id<ChatShop>(arg0),
            chat_top_response_id : 0x2::object::uid_to_inner(&v1),
            author               : 0x2::tx_context::sender(arg3),
            responses_count      : 0,
        };
        let v5 = ChatResponse{
            id                  : v1,
            chat_top_message_id : 0x2::object::id<ChatTopMessage>(&v4),
            author              : 0x2::tx_context::sender(arg3),
            text                : arg1,
            metadata            : arg2,
            seq_n               : 0,
        };
        0x2::dynamic_object_field::add<vector<u8>, ChatResponse>(&mut v4.id, b"as_chat_response", v5);
        0x2::transfer::share_object<ChatTopMessage>(v4);
    }

    public entry fun reply(arg0: &mut ChatTopMessage, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) <= 512, 0);
        if (0x2::dynamic_object_field::exists_<vector<u8>>(&arg0.id, b"as_chat_response")) {
            0x2::transfer::transfer<ChatResponse>(0x2::dynamic_object_field::remove<vector<u8>, ChatResponse>(&mut arg0.id, b"as_chat_response"), arg0.author);
        };
        arg0.responses_count = arg0.responses_count + 1;
        let v0 = 0x2::object::new(arg3);
        let v1 = ChatResponseCreated{
            id             : 0x2::object::uid_to_inner(&v0),
            top_message_id : 0x2::object::uid_to_inner(&arg0.id),
            seq_n          : arg0.responses_count,
        };
        0x2::event::emit<ChatResponseCreated>(v1);
        let v2 = ChatResponse{
            id                  : v0,
            chat_top_message_id : 0x2::object::id<ChatTopMessage>(arg0),
            author              : 0x2::tx_context::sender(arg3),
            text                : arg1,
            metadata            : arg2,
            seq_n               : arg0.responses_count,
        };
        0x2::transfer::transfer<ChatResponse>(v2, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

