module 0x7f68421ccc43e0f8e205c3f1d4dc2ed30f8956e35e2d96b13455cd2ff014fb66::hoodguy {
    struct HOODGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOODGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOODGUY>(arg0, 9, b"HOODGUY", b"Just a robinhood guy", b"Just a robinhood guy meme token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmS5Z6ff79Cf1fhq7p1J6zDeae4U9AgxdSLVWSSivipexx")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOODGUY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOODGUY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOODGUY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

