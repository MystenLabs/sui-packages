module 0xa359bb3741d52f885dce5576cbac9116b02d249fb5a2fce839ffd5113ac75f32::lesson1 {
    struct LessonObject has store, key {
        id: 0x2::object::UID,
        text: 0x1::string::String,
    }

    struct TranscriptObject has key {
        id: 0x2::object::UID,
        history: u8,
        math: u8,
        lit: u8,
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

    // decompiled from Move bytecode v6
}

