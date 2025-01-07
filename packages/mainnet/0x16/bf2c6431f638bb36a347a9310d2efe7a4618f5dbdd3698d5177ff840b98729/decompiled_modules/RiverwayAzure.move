module 0x16bf2c6431f638bb36a347a9310d2efe7a4618f5dbdd3698d5177ff840b98729::RiverwayAzure {
    struct RIVERWAYAZURE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIVERWAYAZURE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIVERWAYAZURE>(arg0, 0, b"COS", b"Riverway Azure", b"Embedded not in water... but a maze... the greatest test of all...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Riverway_Azure.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIVERWAYAZURE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIVERWAYAZURE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

