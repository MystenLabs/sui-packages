module 0x5134d80324b23910ac13aa991b2e06de676cc136ce195fe61326ce0b9519fd7::HoodoftheOutcast {
    struct HOODOFTHEOUTCAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOODOFTHEOUTCAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOODOFTHEOUTCAST>(arg0, 0, b"COS", b"Hood of the Outcast", b"Bow, dream, dance, exalt: Radiant is our harbored eclipse!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Hood_of_the_Outcast.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOODOFTHEOUTCAST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOODOFTHEOUTCAST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

