module 0xd28f4665dd604639f02d36d5aa022082a6794428be9ad42781750a3d1a18457f::GroundlandsGreenEyeofLysfael {
    struct GROUNDLANDSGREENEYEOFLYSFAEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROUNDLANDSGREENEYEOFLYSFAEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROUNDLANDSGREENEYEOFLYSFAEL>(arg0, 0, b"COS", b"Groundlands GreenEye of Lysfael", b"These woods show everything... all you need to see...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Eyes_Groundlands_GreenEye_of_Lysfael.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GROUNDLANDSGREENEYEOFLYSFAEL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROUNDLANDSGREENEYEOFLYSFAEL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

