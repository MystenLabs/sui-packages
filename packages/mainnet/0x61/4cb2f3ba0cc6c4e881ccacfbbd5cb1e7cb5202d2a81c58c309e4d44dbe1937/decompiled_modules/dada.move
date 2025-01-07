module 0x614cb2f3ba0cc6c4e881ccacfbbd5cb1e7cb5202d2a81c58c309e4d44dbe1937::dada {
    struct DADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DADA>(arg0, 9, b"DADA", b"DADA", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DADA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DADA>>(v1);
    }

    // decompiled from Move bytecode v6
}

