module 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::chat {
    struct CHAT has drop {
        dummy_field: bool,
    }

    struct Message has drop, store {
        sender: address,
        content: vector<u8>,
        content_type: u8,
        nonce: vector<u8>,
        timestamp: u64,
    }

    struct MessageEvent has copy, drop {
        conversation_id: 0x1::string::String,
        timestamp: u64,
    }

    struct ChatRegistry has store, key {
        id: 0x2::object::UID,
    }

    struct ConversationStreamInfo has copy, drop, store {
        id: 0x2::object::ID,
        owner: address,
    }

    fun add_stream_to_conversation(arg0: &mut ChatRegistry, arg1: 0x1::string::String, arg2: ConversationStreamInfo) {
        0x2::vec_map::insert<address, 0x2::object::ID>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_map::VecMap<address, 0x2::object::ID>>(&mut arg0.id, arg1), arg2.owner, arg2.id);
    }

    fun assert_content_valid(arg0: &vector<u8>) {
        assert!(!0x1::vector::is_empty<u8>(arg0), 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::errors::EEmptyMessage());
        assert!(0x1::vector::length<u8>(arg0) >= 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::constants::MIN_MESSAGE_LENGTH(), 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::errors::EMessageTooShort());
        assert!(0x1::vector::length<u8>(arg0) <= 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::constants::MAX_MESSAGE_LENGTH(), 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::errors::EMessageTooLong());
    }

    fun conversation_exists(arg0: &ChatRegistry, arg1: 0x1::string::String) : bool {
        0x2::dynamic_field::exists_with_type<0x1::string::String, 0x2::vec_map::VecMap<address, 0x2::object::ID>>(&arg0.id, arg1)
    }

    public fun create_conversation<T0: drop + store>(arg0: &0x2::clock::Clock, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::profile::ProfileRegistry>(arg1);
        assert!(0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::profile::profile_exists(v1, v0), 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::errors::EProfileNotExists());
        assert!(0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::profile::profile_exists(v1, arg2), 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::errors::EProfileNotExists());
        let v2 = generate_conversation_id(v0, arg2);
        let v3 = 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<ChatRegistry>(arg1);
        assert!(!conversation_exists(v3, v2), 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::errors::EConversationAlreadyExists());
        create_empty_conversation(v3, v2);
        let v4 = 0x1::vector::empty<ConversationStreamInfo>();
        let v5 = 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::StreamRegistry>(arg1);
        let v6 = 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::new_stream<T0>(arg0, v5, v0, arg3, arg4);
        let v7 = ConversationStreamInfo{
            id    : 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::get_stream_id<T0>(&v6),
            owner : v0,
        };
        0x1::vector::push_back<ConversationStreamInfo>(&mut v4, v7);
        if (arg2 != v0) {
            let v8 = 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::new_stream<T0>(arg0, v5, arg2, arg3, arg4);
            let v9 = ConversationStreamInfo{
                id    : 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::get_stream_id<T0>(&v8),
                owner : arg2,
            };
            0x1::vector::push_back<ConversationStreamInfo>(&mut v4, v9);
            0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::link_streams<T0>(v5, &mut v6, &mut v8, true);
            0x2::transfer::public_transfer<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::Stream<T0>>(v8, arg2);
        };
        0x2::transfer::public_transfer<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::Stream<T0>>(v6, v0);
        let v10 = 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<ChatRegistry>(arg1);
        let v11 = 0;
        while (v11 < 0x1::vector::length<ConversationStreamInfo>(&v4)) {
            add_stream_to_conversation(v10, v2, *0x1::vector::borrow<ConversationStreamInfo>(&v4, v11));
            v11 = v11 + 1;
        };
    }

    public fun create_conversation_message(arg0: &0x2::clock::Clock, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg2: vector<u8>, arg3: u8, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : Message {
        assert_content_valid(&arg2);
        Message{
            sender       : 0x2::tx_context::sender(arg5),
            content      : arg2,
            content_type : arg3,
            nonce        : arg4,
            timestamp    : 0x2::clock::timestamp_ms(arg0),
        }
    }

    public fun create_conversation_with_message<T0: drop + store>(arg0: &0x2::clock::Clock, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg2: address, arg3: T0, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::profile::ProfileRegistry>(arg1);
        assert!(0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::profile::profile_exists(v1, v0), 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::errors::EProfileNotExists());
        assert!(0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::profile::profile_exists(v1, arg2), 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::errors::EProfileNotExists());
        let v2 = generate_conversation_id(v0, arg2);
        assert!(!conversation_exists(0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<ChatRegistry>(arg1), v2), 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::errors::EConversationAlreadyExists());
        let v3 = 0x1::vector::empty<ConversationStreamInfo>();
        let v4 = 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::StreamRegistry>(arg1);
        let v5 = 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::new_stream<T0>(arg0, v4, v0, arg4, arg5);
        if (arg2 != v0) {
            let v6 = 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::new_stream<T0>(arg0, v4, arg2, arg4, arg5);
            0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::link_streams<T0>(v4, &mut v5, &mut v6, true);
            let v7 = ConversationStreamInfo{
                id    : 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::get_stream_id<T0>(&v6),
                owner : arg2,
            };
            0x1::vector::push_back<ConversationStreamInfo>(&mut v3, v7);
            0x2::transfer::public_transfer<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::Stream<T0>>(v6, arg2);
        };
        0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::add<T0>(v4, &mut v5, arg3, arg5);
        let v8 = ConversationStreamInfo{
            id    : 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::get_stream_id<T0>(&v5),
            owner : v0,
        };
        0x1::vector::push_back<ConversationStreamInfo>(&mut v3, v8);
        0x2::transfer::public_transfer<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::Stream<T0>>(v5, v0);
        let v9 = 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<ChatRegistry>(arg1);
        create_empty_conversation(v9, v2);
        let v10 = 0;
        while (v10 < 0x1::vector::length<ConversationStreamInfo>(&v3)) {
            add_stream_to_conversation(v9, v2, *0x1::vector::borrow<ConversationStreamInfo>(&v3, v10));
            v10 = v10 + 1;
        };
    }

    fun create_empty_conversation(arg0: &mut ChatRegistry, arg1: 0x1::string::String) {
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_map::VecMap<address, 0x2::object::ID>>(&mut arg0.id, arg1, 0x2::vec_map::empty<address, 0x2::object::ID>());
    }

    fun generate_conversation_id(arg0: address, arg1: address) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        if (0x2::address::to_u256(arg0) < 0x2::address::to_u256(arg1)) {
            0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
            0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        } else {
            0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
            0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        };
        0x1::string::utf8(0x2::hex::encode(0x2::hash::blake2b256(&v0)))
    }

    public fun initialize(arg0: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ChatRegistry{id: 0x2::object::new(arg1)};
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::add<ChatRegistry>(arg0, v0);
    }

    public fun send_message<T0: drop + store>(arg0: &0x2::clock::Clock, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg2: &mut 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::Stream<T0>, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::get_stream_owner<T0>(arg2) == v0, 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::errors::EUnauthorized());
        let v1 = 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::get_linked_stream_owner<T0>(arg2);
        let v2 = v0;
        if (0x1::option::is_some<address>(&v1)) {
            v2 = *0x1::option::borrow<address>(&v1);
        };
        let v3 = generate_conversation_id(v0, v2);
        let v4 = 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::profile::ProfileRegistry>(arg1);
        assert!(conversation_exists(0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow<ChatRegistry>(arg1), v3), 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::errors::EInvalidConversation());
        assert!(0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::profile::profile_exists(v4, v0), 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::errors::EProfileNotExists());
        assert!(0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::profile::profile_exists(v4, v2), 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::errors::EProfileNotExists());
        0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::add<T0>(0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream::StreamRegistry>(arg1), arg2, arg3, arg4);
        let v5 = MessageEvent{
            conversation_id : v3,
            timestamp       : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<MessageEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

