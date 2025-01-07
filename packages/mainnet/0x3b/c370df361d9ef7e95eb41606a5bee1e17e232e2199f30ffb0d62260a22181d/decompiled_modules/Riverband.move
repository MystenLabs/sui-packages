module 0x3bc370df361d9ef7e95eb41606a5bee1e17e232e2199f30ffb0d62260a22181d::Riverband {
    struct RIVERBAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIVERBAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIVERBAND>(arg0, 0, b"COS", b"Riverband", b"Could have wandered forever.... could have wandered all night...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Riverband.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIVERBAND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIVERBAND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

