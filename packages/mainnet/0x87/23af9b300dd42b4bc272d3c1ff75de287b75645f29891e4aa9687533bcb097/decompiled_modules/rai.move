module 0x8723af9b300dd42b4bc272d3c1ff75de287b75645f29891e4aa9687533bcb097::rai {
    struct RAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RAI>(arg0, 6, b"RAI", b"Ragnarok AI by SuiAI", b"It is the end of the world in Norse mythology, an event reminiscent of Amagedon in the Bible. It is an AI agent that predicts the end of the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/rag_15b003a3a9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

