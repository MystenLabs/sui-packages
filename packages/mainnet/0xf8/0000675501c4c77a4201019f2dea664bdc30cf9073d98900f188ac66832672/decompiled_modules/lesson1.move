module 0xf80000675501c4c77a4201019f2dea664bdc30cf9073d98900f188ac66832672::lesson1 {
    struct LessonObject has store, key {
        id: 0x2::object::UID,
        text: 0x1::string::String,
    }

    public fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LessonObject{
            id   : 0x2::object::new(arg0),
            text : 0x1::string::utf8(b"Suck my cock!"),
        };
        0x2::transfer::public_transfer<LessonObject>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

