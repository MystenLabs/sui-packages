module 0x31b00136463533b0fca43f3947d8b59d6ffa8f050084258ed69c14a2b43404d0::suiamese {
    struct SUIAMESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAMESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAMESE>(arg0, 6, b"SUIAMESE", b"SIAMESE CAT", x"4d65657420746865206b696e67206361742c20546865205355492d70657273746172206f662053554920436861696e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0491_754be4680b_8c428728a7_7f2093f873.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAMESE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAMESE>>(v1);
    }

    // decompiled from Move bytecode v6
}

