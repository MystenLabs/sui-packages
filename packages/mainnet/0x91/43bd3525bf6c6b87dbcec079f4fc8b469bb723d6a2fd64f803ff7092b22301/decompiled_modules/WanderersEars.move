module 0x9143bd3525bf6c6b87dbcec079f4fc8b469bb723d6a2fd64f803ff7092b22301::WanderersEars {
    struct WANDERERSEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WANDERERSEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WANDERERSEARS>(arg0, 0, b"COS", b"Wanderer's Ears", b"Old Binaria seeks you, little one... or have you sought it?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Wanderer's_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WANDERERSEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WANDERERSEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

