module 0x3fc6b4c32d3ad6620c15e459699619552d23501086ecd622b81963252bc8effb::bbvr {
    struct BBVR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBVR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBVR>(arg0, 6, b"BBVR", b"BASHFUL BEAVER", b"Quietly building the strongest meme dam in the game. Bashful Beaver is all about steady gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_034909476_cb1304a598.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBVR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBVR>>(v1);
    }

    // decompiled from Move bytecode v6
}

