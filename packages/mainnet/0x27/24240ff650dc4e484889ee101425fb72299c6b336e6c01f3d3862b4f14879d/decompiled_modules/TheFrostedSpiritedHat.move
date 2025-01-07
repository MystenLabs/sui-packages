module 0x2724240ff650dc4e484889ee101425fb72299c6b336e6c01f3d3862b4f14879d::TheFrostedSpiritedHat {
    struct THEFROSTEDSPIRITEDHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEFROSTEDSPIRITEDHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEFROSTEDSPIRITEDHAT>(arg0, 0, b"COS", b"The Frosted Spirited Hat", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_The_Frosted_Spirited_Hat.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THEFROSTEDSPIRITEDHAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEFROSTEDSPIRITEDHAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

