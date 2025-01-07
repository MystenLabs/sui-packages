module 0x85cfb414c8248aac148b649c9dd5e09dd266057a0b5a57c698f58dfe49917889::events {
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

