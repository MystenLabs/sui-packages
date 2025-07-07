module 0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::events {
    struct NewAttentionBoardEvent<phantom T0> has copy, drop, store {
        board_id: 0x2::object::ID,
        kol: address,
    }

    struct NewMessageBidEvent<phantom T0> has copy, drop, store {
        board_id: 0x2::object::ID,
        message_id: 0x2::object::ID,
        user: address,
        bid: u64,
    }

    struct BumpMessageBidEvent<phantom T0> has copy, drop, store {
        board_id: 0x2::object::ID,
        message_id: 0x2::object::ID,
        user: address,
        bump: u64,
    }

    struct MessageSubmittedEvent<phantom T0> has copy, drop, store {
        board_id: 0x2::object::ID,
        message_id: 0x2::object::ID,
    }

    struct MessageCancelledEvent<phantom T0> has copy, drop, store {
        board_id: 0x2::object::ID,
        message_id: 0x2::object::ID,
    }

    public(friend) fun emit_bump_message_bid<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = BumpMessageBidEvent<T0>{
            board_id   : arg0,
            message_id : arg1,
            user       : arg2,
            bump       : arg3,
        };
        0x2::event::emit<BumpMessageBidEvent<T0>>(v0);
    }

    public(friend) fun emit_message_cancelled<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = MessageCancelledEvent<T0>{
            board_id   : arg0,
            message_id : arg1,
        };
        0x2::event::emit<MessageCancelledEvent<T0>>(v0);
    }

    public(friend) fun emit_message_submitted<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = MessageSubmittedEvent<T0>{
            board_id   : arg0,
            message_id : arg1,
        };
        0x2::event::emit<MessageSubmittedEvent<T0>>(v0);
    }

    public(friend) fun emit_new_attention_board<T0>(arg0: 0x2::object::ID, arg1: address) {
        let v0 = NewAttentionBoardEvent<T0>{
            board_id : arg0,
            kol      : arg1,
        };
        0x2::event::emit<NewAttentionBoardEvent<T0>>(v0);
    }

    public(friend) fun emit_new_message_bid<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = NewMessageBidEvent<T0>{
            board_id   : arg0,
            message_id : arg1,
            user       : arg2,
            bid        : arg3,
        };
        0x2::event::emit<NewMessageBidEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

