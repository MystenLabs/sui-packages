module 0x38fcf18a6f9e5695c35a82a78afc66221807d5a72a82925790d7b9fedaeaa2ac::chillsnake {
    struct CHILLSNAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLSNAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLSNAKE>(arg0, 6, b"ChillSnake", b"Just Chill Snake", b"Chill Guy is a meme character that embodies a relaxed vibe, known for being calm, casual, and lowkey.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/p_F70_Z_Uzr_400x400_6826bd2f40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLSNAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLSNAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

