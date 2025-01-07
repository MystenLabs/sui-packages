module 0xc92f9c877a340ad2e87a502c5cfabce54603f9c95f1ab717524137cea551f8c0::lesson1 {
    struct TranscriptObject has store, key {
        id: 0x2::object::UID,
        history: u8,
        math: u8,
        lit: u8,
    }

    struct TransWrapper has key {
        id: 0x2::object::UID,
        trans: TranscriptObject,
        intended_address: address,
    }

    public fun create_trans_object(arg0: u8, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = TranscriptObject{
            id      : 0x2::object::new(arg3),
            history : arg0,
            math    : arg1,
            lit     : arg2,
        };
        0x2::transfer::transfer<TranscriptObject>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun unwrap_transcript(arg0: TransWrapper, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.intended_address == 0x2::tx_context::sender(arg1), 0);
        let TransWrapper {
            id               : v0,
            trans            : v1,
            intended_address : _,
        } = arg0;
        0x2::transfer::transfer<TranscriptObject>(v1, 0x2::tx_context::sender(arg1));
        0x2::object::delete(v0);
    }

    public fun wrap_transcript(arg0: TranscriptObject, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = TransWrapper{
            id               : 0x2::object::new(arg2),
            trans            : arg0,
            intended_address : arg1,
        };
        0x2::transfer::transfer<TransWrapper>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

