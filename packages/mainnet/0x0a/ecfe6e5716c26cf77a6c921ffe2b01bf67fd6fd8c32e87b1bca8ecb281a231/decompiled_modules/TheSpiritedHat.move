module 0xaecfe6e5716c26cf77a6c921ffe2b01bf67fd6fd8c32e87b1bca8ecb281a231::TheSpiritedHat {
    struct THESPIRITEDHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: THESPIRITEDHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THESPIRITEDHAT>(arg0, 0, b"COS", b"The Spirited Hat", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_The_Spirited_Hat.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THESPIRITEDHAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THESPIRITEDHAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

