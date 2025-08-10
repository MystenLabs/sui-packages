module 0x3d82c5720a8da6d7169ff6d6f53a0420c95a7553705975208d62ad0b6ef61902::hivemind {
    struct HIVEMIND has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIVEMIND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIVEMIND>(arg0, 9, b"HIVE", b"The Hivemind", b"The $hive is everything he is the god he is the whole cult of humanity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiehhr4gsztjej6ggfrzk4gmrsavfiqewaskqibzanabgiorsxuxuq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HIVEMIND>(&mut v2, 1000000000000000000, @0xb0ed1ff98508d0cd74fb515e595ae0879b652d21a6a93eb94a8e707bde83f73b, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIVEMIND>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIVEMIND>>(v1);
    }

    // decompiled from Move bytecode v6
}

