module 0x464995c7f33bc1afa46b4161f053a54c299db0be9fa0f31549ddb4810966dbf0::explore {
    struct Event has copy, drop {
        v: vector<u8>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 1);
        0x1::vector::push_back<u8>(&mut v0, 2);
        let v1 = Event{v: v0};
        0x2::event::emit<Event>(v1);
    }

    // decompiled from Move bytecode v6
}

