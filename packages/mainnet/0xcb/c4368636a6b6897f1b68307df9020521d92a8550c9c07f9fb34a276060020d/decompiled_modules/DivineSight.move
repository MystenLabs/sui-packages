module 0xcbc4368636a6b6897f1b68307df9020521d92a8550c9c07f9fb34a276060020d::DivineSight {
    struct DIVINESIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIVINESIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIVINESIGHT>(arg0, 0, b"COS", b"Divine Sight", b"The sky, the sky... Why have we tricked ourselves?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Eyes_Divine_Sight.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIVINESIGHT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIVINESIGHT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

