module 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_fee {
    struct FeeEvent has copy, drop {
        sender: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        event_type: 0x1::type_name::TypeName,
    }

    public(friend) fun emit_fee_event(arg0: address, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: 0x1::type_name::TypeName) {
        let v0 = FeeEvent{
            sender     : arg0,
            coin_type  : arg1,
            amount     : arg2,
            event_type : arg3,
        };
        0x2::event::emit<FeeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

