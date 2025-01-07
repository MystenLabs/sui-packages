module 0x3d721533e55d953dbd4d0aa42556fdb6f1e08712d1810f4b737755e33fecdb8::EarsofaGroundlandCub {
    struct EARSOFAGROUNDLANDCUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: EARSOFAGROUNDLANDCUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EARSOFAGROUNDLANDCUB>(arg0, 0, b"COS", b"Ears of a Groundland Cub", b"The Bears mean us no harm... they are as confused as you are.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Ears_of_a_Groundland_Cub.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EARSOFAGROUNDLANDCUB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EARSOFAGROUNDLANDCUB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

