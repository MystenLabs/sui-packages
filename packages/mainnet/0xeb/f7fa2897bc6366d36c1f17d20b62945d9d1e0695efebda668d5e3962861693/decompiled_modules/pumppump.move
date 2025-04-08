module 0xebf7fa2897bc6366d36c1f17d20b62945d9d1e0695efebda668d5e3962861693::pumppump {
    struct PUMPPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPPUMP>(arg0, 6, b"PUMPPUMP", b"PPUMPS", b"welcome to $PPUMPS OFFICIAL ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/24f_S2_LLG_Zq429l_Hu_0bf36c9edb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

