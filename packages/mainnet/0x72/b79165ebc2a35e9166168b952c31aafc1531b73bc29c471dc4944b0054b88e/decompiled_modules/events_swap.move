module 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_swap {
    struct SwapEvent has copy, drop {
        sender: address,
        coin_in_type: 0x1::type_name::TypeName,
        coin_out_type: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
    }

    public(friend) fun emit_swap_event(arg0: address, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64) {
        let v0 = SwapEvent{
            sender        : arg0,
            coin_in_type  : arg1,
            coin_out_type : arg2,
            amount_in     : arg3,
            amount_out    : arg4,
        };
        0x2::event::emit<SwapEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

