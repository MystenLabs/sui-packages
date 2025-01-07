module 0xfcd1fd085ec3767617adf57e93de98ef04b7fc98328add07cf0f6a3f0f065da4::GoldNibbledWings {
    struct GOLDNIBBLEDWINGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDNIBBLEDWINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDNIBBLEDWINGS>(arg0, 0, b"COS", b"Gold-Nibbled Wings", b"What truth lies in our heart-what awe speaks?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Gold-Nibbled_Wings.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOLDNIBBLEDWINGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDNIBBLEDWINGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

