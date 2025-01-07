module 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_send {
    struct SendEvent has copy, drop {
        sender: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        receiver: address,
    }

    public(friend) fun emit_send_event(arg0: address, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: address) {
        let v0 = SendEvent{
            sender    : arg0,
            coin_type : arg1,
            amount    : arg2,
            receiver  : arg3,
        };
        0x2::event::emit<SendEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

