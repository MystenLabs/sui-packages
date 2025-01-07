module 0x9ac286bdfdf9e6604d0911b916c46df8a166d500a18439d9fc91721b0ac38cd8::TheFrostedJoyfulHat {
    struct THEFROSTEDJOYFULHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEFROSTEDJOYFULHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEFROSTEDJOYFULHAT>(arg0, 0, b"COS", b"The Frosted Joyful Hat", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_The_Frosted_Joyful_Hat.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THEFROSTEDJOYFULHAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEFROSTEDJOYFULHAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

