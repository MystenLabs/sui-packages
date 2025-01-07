module 0x7ebea4f352ed8f29a55c7e61ac86eb2d399a11f43fea629a696a1e61b3053528::suip {
    struct SUIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIP>(arg0, 6, b"SUIP", b"SuiPaw", b"SuiPaw is an irresistibly adorable cat that captures hearts with its undeniable charm. With fur as soft as clouds and eyes that sparkle like precious gems, SuiPaw radiates warmth and affection. Every step it takes exudes elegance, while its tiny paws leave gentle imprints, as if bringing luck wherever it goes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009078_462d09b647.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

