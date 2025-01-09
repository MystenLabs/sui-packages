module 0xea17d092f889c0ba903528ce4ec64fe0ebec2fc2b181d6781007493973be4a6b::turbohub {
    struct TURBOHUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOHUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOHUB>(arg0, 6, b"TURBOHUB", b"$TURBO HUB", b"THE BEST NOPOR VIDEOS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5345_8c17abd5cf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOHUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURBOHUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

