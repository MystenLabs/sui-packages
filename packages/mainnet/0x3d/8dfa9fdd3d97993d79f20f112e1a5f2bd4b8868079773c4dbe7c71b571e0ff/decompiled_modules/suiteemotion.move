module 0x3d8dfa9fdd3d97993d79f20f112e1a5f2bd4b8868079773c4dbe7c71b571e0ff::suiteemotion {
    struct SUITEEMOTION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITEEMOTION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITEEMOTION>(arg0, 6, b"SuiteEmotion", b"SuiteEmoootion", b"Sweet Emotion!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sweet_emotion_image_from_grokb0324de3_f722_4484_b5bd_0fea3cc1cdfb_3ae529d98f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEEMOTION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITEEMOTION>>(v1);
    }

    // decompiled from Move bytecode v6
}

