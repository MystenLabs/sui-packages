module 0x8ff6c4de228029e48bba019a8b87eb5d0add575a4118d278b9e49d8668b4d942::emoji {
    struct EMOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMOJI>(arg0, 6, b"Emoji", b"Sui Emoji", b"In the vibrant world of Emojiland, there lived a cheerful emoji on Sui chain $Emoji", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/iu0u5_XT_1_400x400_721ad3fbeb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMOJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMOJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

