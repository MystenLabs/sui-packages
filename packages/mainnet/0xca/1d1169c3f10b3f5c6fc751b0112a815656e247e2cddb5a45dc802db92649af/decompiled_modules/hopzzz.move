module 0xca1d1169c3f10b3f5c6fc751b0112a815656e247e2cddb5a45dc802db92649af::hopzzz {
    struct HOPZZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPZZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPZZZ>(arg0, 6, b"HOPZZZ", b"HOP The Sleepy Rabbit", x"484f502069732061207665727920736c65657079207261626269742077686f20646f65736e27742077616e7420746f20676574206869732050554d50206f757420616e6420697320676f696e6720746f2064656c6179206974206f6e636520616761696e2e0a0a4c6f6e67206c69766520484f505a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hopz_7343ac5c41.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPZZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPZZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

