module 0xb148ab7c6aa5819db1ceec022d847873b75ff55b2d27a5343989a8e00c221e6f::Fake_Picture {
    struct FAKE_PICTURE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAKE_PICTURE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAKE_PICTURE>(arg0, 9, b"FAKE", b"Fake Picture", b"fake image for media", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzsIPpNWcAA63Jl?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAKE_PICTURE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAKE_PICTURE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

