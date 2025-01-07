module 0xc66d78b98cef7defe7885a0c30d04e72a210c77f2b68c43549cd9fc157b2abeb::VolcanicChroma {
    struct VOLCANICCHROMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOLCANICCHROMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOLCANICCHROMA>(arg0, 0, b"COS", b"Volcanic Chroma", b"Glowing with heat... emblazoned with dread... it lingers...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Volcanic_Chroma.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VOLCANICCHROMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOLCANICCHROMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

