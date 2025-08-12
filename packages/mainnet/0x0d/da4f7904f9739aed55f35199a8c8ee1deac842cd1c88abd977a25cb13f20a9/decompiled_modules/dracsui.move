module 0xdda4f7904f9739aed55f35199a8c8ee1deac842cd1c88abd977a25cb13f20a9::dracsui {
    struct DRACSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRACSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRACSUI>(arg0, 9, b"DRASUI", b"Dracsui", b"A sleek, dragonfly-like beast with holographic Sui wings, streaking through meme space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreiadbfhvjb2jvffj5cvrsrvg63q4tjbzkjoii73pri3nirjuygeuhy")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DRACSUI>(&mut v2, 1000000000000000000, @0xb0ed1ff98508d0cd74fb515e595ae0879b652d21a6a93eb94a8e707bde83f73b, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRACSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRACSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

