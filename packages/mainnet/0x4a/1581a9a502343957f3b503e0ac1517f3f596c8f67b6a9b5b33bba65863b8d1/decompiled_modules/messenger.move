module 0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::messenger {
    entry fun create_chat(arg0: &mut 0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::chat::ChatRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::chat::share_chat(0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::chat::create_chat(arg0, arg1, arg2));
    }

    entry fun mark_as_read(arg0: &mut 0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::message::Message, arg1: &mut 0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::chat::Chat, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::message::recipient(arg0) == v0, 1);
        assert!(!0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::message::is_read(arg0), 3);
        0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::message::mark_as_read(arg0);
        0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::chat::mark_as_read(arg1, arg3);
        0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::events::emit_message_read_simple(0x2::object::uid_to_inner(0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::message::id(arg0)), v0, 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    fun internal_send_message(arg0: &mut 0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::chat::Chat, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5) / 1000;
        assert!(0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::chat::is_participant(arg0, v0), 2);
        0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::chat::mark_as_read(arg0, arg6);
        0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::chat::increment_unread(arg0, arg1);
        let v2 = 0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::message::new_message(v0, arg1, 0x1::string::utf8(arg2), arg4, v1, arg6);
        0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::events::emit_message_sent(0x2::object::id<0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::message::Message>(&v2), v0, arg1, 0x1::string::utf8(arg2), arg3, v1);
        0x2::transfer::public_transfer<0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::message::Message>(v2, arg1);
    }

    public fun seal_approve_receiver(arg0: vector<u8>, arg1: &0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::chat::Chat, arg2: &0x2::tx_context::TxContext) {
        assert!(0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::chat::is_participant(arg1, 0x2::tx_context::sender(arg2)), 2);
    }

    public fun seal_approve_sender(arg0: vector<u8>, arg1: &0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::chat::Chat, arg2: &0x2::tx_context::TxContext) {
        assert!(0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::chat::is_participant(arg1, 0x2::tx_context::sender(arg2)), 2);
    }

    entry fun send_message(arg0: &mut 0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::chat::Chat, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        internal_send_message(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

