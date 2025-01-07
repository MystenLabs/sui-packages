module 0x68ff9b34eb7a36f0b629a465717e016cf126b68f37fb51d94e5b7814119cb541::LamentingSeraphWings {
    struct LAMENTINGSERAPHWINGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMENTINGSERAPHWINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMENTINGSERAPHWINGS>(arg0, 0, b"COS", b"Lamenting Seraph Wings", b"What becomes of such monstrosity? Where do they go?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Lamenting_Seraph_Wings.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAMENTINGSERAPHWINGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMENTINGSERAPHWINGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

