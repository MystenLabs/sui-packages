module 0x4055b565ea27bba89fb63007d80179a7ee3f1d2adc27338594f373246bce94d9::joker {
    struct JOKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKER>(arg0, 6, b"JOKER", b"Joker Coin", b"It's the new sensation in the cryptocurrency market, bringing the madness and fun of DC Comics to the blockchain. Inspired by the chaotic and passionate relationship between the Joker and Harley Quinn, this digital currency promises to provide its holders with a unique and exciting experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gemini_Generated_Image_tjx52atjx52atjx5_32c66d7174.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

