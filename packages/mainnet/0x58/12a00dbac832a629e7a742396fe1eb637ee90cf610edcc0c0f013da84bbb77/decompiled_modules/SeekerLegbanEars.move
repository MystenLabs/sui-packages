module 0x5812a00dbac832a629e7a742396fe1eb637ee90cf610edcc0c0f013da84bbb77::SeekerLegbanEars {
    struct SEEKERLEGBANEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEEKERLEGBANEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEKERLEGBANEARS>(arg0, 0, b"COS", b"Seeker Legban Ears", b"For What do They search? Is this not paradise?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Seeker_Legban_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEEKERLEGBANEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEKERLEGBANEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

