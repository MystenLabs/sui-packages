module 0xfff0d5346a43ee1aafa0bf1a25fe79de7e76ccb4bd4e4574a43ca14b95b91a9b::morud {
    struct MORUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORUD>(arg0, 6, b"Morud", b"Murad Meme jezus", b"Morud the memecoin jesus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3064_b092f7ecad.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MORUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

