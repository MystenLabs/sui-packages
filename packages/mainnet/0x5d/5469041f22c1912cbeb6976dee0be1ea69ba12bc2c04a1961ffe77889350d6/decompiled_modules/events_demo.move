module 0x5d5469041f22c1912cbeb6976dee0be1ea69ba12bc2c04a1961ffe77889350d6::events_demo {
    struct MessageSent has copy, drop {
        from: address,
        message: 0x1::string::String,
    }

    struct MassageSentV2 has copy, drop {
        from: address,
        message: 0x1::string::String,
    }

    struct MessageBox has key {
        id: 0x2::object::UID,
        sent_count: u64,
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MessageBox{
            id         : 0x2::object::new(arg0),
            sent_count : 0,
        };
        0x2::transfer::share_object<MessageBox>(v0);
    }

    public fun send_message(arg0: &mut MessageBox, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        arg0.sent_count = arg0.sent_count + 1;
        let v0 = MessageSent{
            from    : 0x2::tx_context::sender(arg2),
            message : arg1,
        };
        0x2::event::emit<MessageSent>(v0);
    }

    public fun sent_count(arg0: &MessageBox) : u64 {
        arg0.sent_count
    }

    // decompiled from Move bytecode v6
}

