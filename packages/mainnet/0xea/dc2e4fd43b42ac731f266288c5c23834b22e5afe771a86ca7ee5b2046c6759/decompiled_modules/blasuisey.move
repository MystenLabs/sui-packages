module 0xeadc2e4fd43b42ac731f266288c5c23834b22e5afe771a86ca7ee5b2046c6759::blasuisey {
    struct BLASUISEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLASUISEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLASUISEY>(arg0, 9, b"BLASUI", b"Blasuisey", b"A round, pink nurse monster balancing eggs decorated with the Sui logo, spreading wholesome meme energy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreie5uhllui6hu6ykshffu6dn5f3xo3jvfk7bvckmnkhm3oarx26y2u")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLASUISEY>(&mut v2, 1000000000000000000, @0xb0ed1ff98508d0cd74fb515e595ae0879b652d21a6a93eb94a8e707bde83f73b, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLASUISEY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLASUISEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

