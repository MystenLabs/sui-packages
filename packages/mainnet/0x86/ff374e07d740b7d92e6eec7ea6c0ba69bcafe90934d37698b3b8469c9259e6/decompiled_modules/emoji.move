module 0x86ff374e07d740b7d92e6eec7ea6c0ba69bcafe90934d37698b3b8469c9259e6::emoji {
    struct EMOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMOJI>(arg0, 6, b"Emoji", b"Emoji ", b"In the vibrant world of Emojiland, there lived a cheerful emoji on Sui chain $Emoji", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730964463238.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EMOJI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMOJI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

