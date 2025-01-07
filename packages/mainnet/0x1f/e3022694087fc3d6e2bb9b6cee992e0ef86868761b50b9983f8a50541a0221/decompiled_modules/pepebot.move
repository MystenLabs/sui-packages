module 0x1fe3022694087fc3d6e2bb9b6cee992e0ef86868761b50b9983f8a50541a0221::pepebot {
    struct PEPEBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEBOT>(arg0, 6, b"Pepebot", b"PepeRobot", x"7065706520726f626f74207375690a0a68747470733a2f2f7777772e70657065626f742e6c6976652f50657065626f742f696e6465782e68746d6c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3621_1f14583c1e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

