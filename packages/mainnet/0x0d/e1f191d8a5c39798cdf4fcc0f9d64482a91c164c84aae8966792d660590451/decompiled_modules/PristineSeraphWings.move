module 0xde1f191d8a5c39798cdf4fcc0f9d64482a91c164c84aae8966792d660590451::PristineSeraphWings {
    struct PRISTINESERAPHWINGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRISTINESERAPHWINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRISTINESERAPHWINGS>(arg0, 0, b"COS", b"Pristine Seraph Wings", b"Heavy to fly... brilliant to fall...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Pristine_Seraph_Wings.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRISTINESERAPHWINGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRISTINESERAPHWINGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

