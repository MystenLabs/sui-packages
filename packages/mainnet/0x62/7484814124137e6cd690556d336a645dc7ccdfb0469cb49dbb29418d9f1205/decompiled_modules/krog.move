module 0x627484814124137e6cd690556d336a645dc7ccdfb0469cb49dbb29418d9f1205::krog {
    struct KROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KROG>(arg0, 6, b"KROG", b"Krog The Caveman", b"Krog Uga Bugga", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifkz4vriuqx6b4z6aelot3ybgwzkdx4mvuxxs5qh4fv4xtmporame")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KROG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

