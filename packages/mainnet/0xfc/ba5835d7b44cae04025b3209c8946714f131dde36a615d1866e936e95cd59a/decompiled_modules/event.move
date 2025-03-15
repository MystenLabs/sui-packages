module 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::event {
    struct ActionRequestEvent<T0: copy + drop> has copy, drop {
        game: 0x2::object::ID,
        player: address,
        new_pos_idx: u64,
        parameter: T0,
    }

    public fun emit_action_request<T0: copy + drop>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: T0) {
        let v0 = ActionRequestEvent<T0>{
            game        : arg0,
            player      : arg1,
            new_pos_idx : arg2,
            parameter   : arg3,
        };
        0x2::event::emit<ActionRequestEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

