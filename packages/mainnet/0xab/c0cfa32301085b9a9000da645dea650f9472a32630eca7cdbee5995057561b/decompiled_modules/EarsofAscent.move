module 0xabc0cfa32301085b9a9000da645dea650f9472a32630eca7cdbee5995057561b::EarsofAscent {
    struct EARSOFASCENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EARSOFASCENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EARSOFASCENT>(arg0, 0, b"COS", b"Ears of Ascent", b"Who knows what awaits... beneath the surface... above the world...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Ears_of_Ascent.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EARSOFASCENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EARSOFASCENT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

