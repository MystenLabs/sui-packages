module 0xc911857e7c4c20c76cae956149762ccaf37eb89e9f907487fa9d6df53ec7a979::ShadeofAscent {
    struct SHADEOFASCENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHADEOFASCENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHADEOFASCENT>(arg0, 0, b"COS", b"Shade of Ascent", b"Drifting further... out of sight...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Shade_of_Ascent.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHADEOFASCENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHADEOFASCENT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

