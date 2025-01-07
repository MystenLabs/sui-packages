module 0x17e737cbf381e571cc5ccc82feec0fef9f6baf7367070e46d0eea76dfa219003::HueoftheGentleCurse {
    struct HUEOFTHEGENTLECURSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUEOFTHEGENTLECURSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUEOFTHEGENTLECURSE>(arg0, 0, b"COS", b"Hue of the Gentle Curse", b"How it glows through the darkest depths... yet remains unseen...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Hue_of_the_Gentle_Curse.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUEOFTHEGENTLECURSE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUEOFTHEGENTLECURSE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

