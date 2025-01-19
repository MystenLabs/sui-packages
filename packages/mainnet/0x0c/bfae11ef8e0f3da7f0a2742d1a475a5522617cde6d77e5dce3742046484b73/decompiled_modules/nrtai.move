module 0xcbfae11ef8e0f3da7f0a2742d1a475a5522617cde6d77e5dce3742046484b73::nrtai {
    struct NRTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NRTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NRTAI>(arg0, 6, b"NRTAI", b"NarutoAI by SuiAI", b"Naruto AI is a conversational AI platform that allows users to chat with AI-powered versions of popular characters from the Naruto anime series. 1  It provides a unique and interactive experience for fans to engage with their favorite characters in a personalized way.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/3fafebef8349265f7d82174b1580b90d_6865912c89.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NRTAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NRTAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

