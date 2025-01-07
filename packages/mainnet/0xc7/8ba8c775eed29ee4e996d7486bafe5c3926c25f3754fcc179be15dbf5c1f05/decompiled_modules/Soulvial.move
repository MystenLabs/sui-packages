module 0xc78ba8c775eed29ee4e996d7486bafe5c3926c25f3754fcc179be15dbf5c1f05::Soulvial {
    struct SOULVIAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOULVIAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOULVIAL>(arg0, 0, b"COS", b"Soulvial", b"Hold on to your soul... for it wants out of this place... But is it foolish? Is it there?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Soulvial.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOULVIAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOULVIAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

