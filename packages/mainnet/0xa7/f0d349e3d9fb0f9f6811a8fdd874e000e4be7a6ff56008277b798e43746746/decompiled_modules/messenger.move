module 0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::messenger {
    entry fun create_chat(arg0: &mut 0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::chat::ChatRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::chat::share_chat(0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::chat::create_chat(arg0, arg1, arg2));
    }

    entry fun mark_as_read(arg0: &mut 0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::message::Message, arg1: &mut 0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::chat::Chat, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::message::recipient(arg0) == v0, 1);
        assert!(!0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::message::is_read(arg0), 3);
        0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::message::mark_as_read(arg0);
        0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::chat::mark_as_read(arg1, arg3);
        0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::events::emit_message_read_simple(0x2::object::uid_to_inner(0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::message::id(arg0)), v0, 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    fun internal_send_message(arg0: &mut 0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::chat::Chat, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5) / 1000;
        assert!(0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::chat::is_participant(arg0, v0), 2);
        0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::chat::mark_as_read(arg0, arg6);
        0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::chat::increment_unread(arg0, arg1);
        let v2 = 0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::message::new_message(v0, arg1, 0x1::string::utf8(arg2), arg4, v1, arg6);
        0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::events::emit_message_sent(0x2::object::id<0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::message::Message>(&v2), v0, arg1, 0x1::string::utf8(arg2), arg3, v1);
        0x2::transfer::public_transfer<0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::message::Message>(v2, arg1);
    }

    public fun seal_approve_receiver(arg0: vector<u8>, arg1: &0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::chat::Chat, arg2: &0x2::tx_context::TxContext) {
        assert!(0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::chat::is_participant(arg1, 0x2::tx_context::sender(arg2)), 2);
    }

    public fun seal_approve_sender(arg0: vector<u8>, arg1: &0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::chat::Chat, arg2: &0x2::tx_context::TxContext) {
        assert!(0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::chat::is_participant(arg1, 0x2::tx_context::sender(arg2)), 2);
    }

    entry fun send_message(arg0: &mut 0xa7f0d349e3d9fb0f9f6811a8fdd874e000e4be7a6ff56008277b798e43746746::chat::Chat, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        internal_send_message(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

