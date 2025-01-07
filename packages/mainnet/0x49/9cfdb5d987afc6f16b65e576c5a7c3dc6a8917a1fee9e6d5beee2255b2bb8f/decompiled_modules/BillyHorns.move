module 0x499cfdb5d987afc6f16b65e576c5a7c3dc6a8917a1fee9e6d5beee2255b2bb8f::BillyHorns {
    struct BILLYHORNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILLYHORNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILLYHORNS>(arg0, 0, b"COS", b"Billy Horns", b"Stamp away the night... the horrible night...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Billy_Horns.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BILLYHORNS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILLYHORNS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

