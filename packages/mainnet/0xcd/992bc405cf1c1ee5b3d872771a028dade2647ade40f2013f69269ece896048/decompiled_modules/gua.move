module 0xcd992bc405cf1c1ee5b3d872771a028dade2647ade40f2013f69269ece896048::gua {
    struct GUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUA>(arg0, 6, b"GUA", b"GUAS", b"GUA DEX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_01_45_10_8b008e2919.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

