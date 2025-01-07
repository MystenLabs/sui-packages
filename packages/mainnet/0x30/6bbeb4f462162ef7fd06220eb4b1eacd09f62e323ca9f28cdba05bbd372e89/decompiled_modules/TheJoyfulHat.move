module 0x306bbeb4f462162ef7fd06220eb4b1eacd09f62e323ca9f28cdba05bbd372e89::TheJoyfulHat {
    struct THEJOYFULHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEJOYFULHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEJOYFULHAT>(arg0, 0, b"COS", b"The Joyful Hat", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_The_Joyful_Hat.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THEJOYFULHAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEJOYFULHAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

