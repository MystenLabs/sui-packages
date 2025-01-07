module 0xb990fec29ab81b0229637a0ac4c72916a83e0191c01903a628a399688a39d60a::BootswiththeFir {
    struct BOOTSWITHTHEFIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOTSWITHTHEFIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOTSWITHTHEFIR>(arg0, 0, b"COS", b"Boots with the Fir", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Feet_Boots_with_the_Fir.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOTSWITHTHEFIR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOTSWITHTHEFIR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

