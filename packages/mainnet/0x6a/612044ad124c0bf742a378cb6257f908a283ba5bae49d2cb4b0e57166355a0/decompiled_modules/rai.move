module 0x6a612044ad124c0bf742a378cb6257f908a283ba5bae49d2cb4b0e57166355a0::rai {
    struct RAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RAI>(arg0, 6, b"RAI", b"Ragnarok AI by SuiAI", b"It is an AI agent that predicts the end. Ragnarok is the world's end day in Norse mythology, an event reminiscent of Amageddon in the Bible.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/rag_d89c5c3f45.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

