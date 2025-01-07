module 0xd8189a4be7603f682659aafaee31de44ba7e0af7dcef1750ec738aed29281904::ChoiroftheCelebrants {
    struct CHOIROFTHECELEBRANTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOIROFTHECELEBRANTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOIROFTHECELEBRANTS>(arg0, 0, b"COS", b"Choir of the Celebrants", b"Spinning... forever in this joyous rondo... forever this seaside psaltery...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Choir_of_the_Celebrants.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHOIROFTHECELEBRANTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOIROFTHECELEBRANTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

