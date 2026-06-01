module 0x391fc852ab7eb69bc3a6c328067b55f25a6411fa859ccfd4679aedfb9e1a909c::blobcast_dm {
    struct Conversation has store, key {
        id: 0x2::object::UID,
        participant1: address,
        participant2: address,
    }

    public entry fun create_conversation(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Conversation{
            id           : 0x2::object::new(arg1),
            participant1 : 0x2::tx_context::sender(arg1),
            participant2 : arg0,
        };
        0x2::transfer::share_object<Conversation>(v0);
    }

    public entry fun seal_approve(arg0: vector<u8>, arg1: &Conversation, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.participant1 || v0 == arg1.participant2, 1);
    }

    // decompiled from Move bytecode v7
}

