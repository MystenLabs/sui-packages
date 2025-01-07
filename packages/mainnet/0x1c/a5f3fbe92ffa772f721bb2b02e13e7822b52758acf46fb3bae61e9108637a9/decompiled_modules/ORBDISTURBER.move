module 0x1ca5f3fbe92ffa772f721bb2b02e13e7822b52758acf46fb3bae61e9108637a9::ORBDISTURBER {
    struct ORBDISTURBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORBDISTURBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORBDISTURBER>(arg0, 0, b"COS", b"ORB DISTURBER", b"Limited-edition Aurahma swag from the Exclusive Battle Prototype event held in May 2023-the first playtesting experience for our Founding StarGarden holders-to those who disturbed the orb.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/ORB_DISTURBER.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORBDISTURBER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORBDISTURBER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

