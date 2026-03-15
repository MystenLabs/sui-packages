module 0xee4903335b7c90d375a2dec24fc360a67da87af3003429d797d51e85ba0184e8::registry {
    struct ActionRegistered has copy, drop {
        action_name: vector<u8>,
    }

    public fun register(arg0: vector<u8>) {
        let v0 = ActionRegistered{action_name: arg0};
        0x2::event::emit<ActionRegistered>(v0);
    }

    // decompiled from Move bytecode v6
}

