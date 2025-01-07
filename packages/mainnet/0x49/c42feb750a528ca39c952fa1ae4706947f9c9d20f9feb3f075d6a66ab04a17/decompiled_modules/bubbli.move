module 0x49c42feb750a528ca39c952fa1ae4706947f9c9d20f9feb3f075d6a66ab04a17::bubbli {
    struct BUBBLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLI>(arg0, 6, b"Bubbli", b"Bubblisui", b"In a world beyond our own, where magic dwelled in every corner, there existed a tiny, shimmering bubble named Bubblisui. Bubblisui was no ordinary bubble, for she was alive. ......What is Bubblisui? Bubblisui is a fun token that lets you interact with bubbles. Tap them, pop them, and discover surprises!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_cebaec99ac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

