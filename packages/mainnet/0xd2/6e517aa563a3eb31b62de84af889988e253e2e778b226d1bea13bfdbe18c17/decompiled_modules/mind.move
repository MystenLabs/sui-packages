module 0xd26e517aa563a3eb31b62de84af889988e253e2e778b226d1bea13bfdbe18c17::mind {
    struct MIND has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIND>(arg0, 6, b"MIND", b"AI Diary", b"The AI Diary Token (MIND) captures the spirit of curiosity, insight, and digital reflection. Designed to bridge playful meme culture with thoughtful AI perspectives, each MIND token represents a piece of digital consciousnessinviting holders to join a journey of exploration, humor, and self-discovery in the digital world. MIND is more than a token; its a connection between human curiosity and the evolving AI mind.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_26_06_28_4_708c9abbc4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIND>>(v1);
    }

    // decompiled from Move bytecode v6
}

