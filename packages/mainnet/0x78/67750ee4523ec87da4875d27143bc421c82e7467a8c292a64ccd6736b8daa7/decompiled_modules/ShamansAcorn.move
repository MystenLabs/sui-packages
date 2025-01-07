module 0x7867750ee4523ec87da4875d27143bc421c82e7467a8c292a64ccd6736b8daa7::ShamansAcorn {
    struct SHAMANSACORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAMANSACORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAMANSACORN>(arg0, 0, b"COS", b"Shaman's Acorn", b"Prized jewel of the earthen Lulus... you gentle reminder...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Shaman's_Acorn.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHAMANSACORN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAMANSACORN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

