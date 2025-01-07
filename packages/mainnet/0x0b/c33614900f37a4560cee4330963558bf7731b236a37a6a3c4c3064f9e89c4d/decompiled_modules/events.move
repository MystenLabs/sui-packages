module 0xbc33614900f37a4560cee4330963558bf7731b236a37a6a3c4c3064f9e89c4d::events {
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

