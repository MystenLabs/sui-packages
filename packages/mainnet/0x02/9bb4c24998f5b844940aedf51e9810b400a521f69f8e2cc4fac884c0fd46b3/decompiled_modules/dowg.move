module 0x29bb4c24998f5b844940aedf51e9810b400a521f69f8e2cc4fac884c0fd46b3::dowg {
    struct DOWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOWG>(arg0, 6, b"DOWG", b"THE DYSLEXIC DOG", x"444f574720524f4f4d204f4e20464952450a0a68747470733a2f2f782e636f6d2f692f636f6d6d756e69746965732f31393435353037323039303632303331373430", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih6ebucdwq7kccqzllwo7kw3yk73phzibylxhrntx6tjb73j2i4r4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOWG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOWG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

