module 0x15ac4efedc639988f18ee0a20ce5ecca5e04d9281e0ef39676f7b33d322166b4::ligon {
    struct LIGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIGON>(arg0, 6, b"LIGON", b"Litch Dragon", b"LIGON is a tiny blue dragon who has magical powers since birth, his natural habitat may be in the sky but he also has abilities in the ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreickxzzxnw2nsyp3rcj6inh6ykav4fuuzxk67qdxcocparhle2c5im")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LIGON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

