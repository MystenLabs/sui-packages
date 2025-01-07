module 0x79bc1a59f5822ab857bfb06afd2746c710b1f234e4901f80bad6a4e55a47da9d::AurahRichEars {
    struct AURAHRICHEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURAHRICHEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURAHRICHEARS>(arg0, 0, b"COS", b"Aurah-Rich Ears", b"Distrust all you hear... follow the sound of fortune, radiant...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Aurah-Rich_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AURAHRICHEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURAHRICHEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

