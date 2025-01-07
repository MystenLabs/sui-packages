module 0xce8245f6a3fb68f78dafe4d5f7ea7608b31292a6d43b4b7d4825861bd1295320::events {
    struct UpdatedAftermathPkEvent has copy, drop {
        old_aftermath_pk: vector<u8>,
        new_aftermath_pk: vector<u8>,
    }

    public(friend) fun emit_updated_aftermath_pk_event(arg0: vector<u8>, arg1: vector<u8>) {
        let v0 = UpdatedAftermathPkEvent{
            old_aftermath_pk : arg0,
            new_aftermath_pk : arg1,
        };
        0x2::event::emit<UpdatedAftermathPkEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

