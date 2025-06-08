module 0x411fc6c87de0ffc92541868ce6e9291ab3b0c5986c9bfd00decbca04cedea73b::sdd {
    struct SDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDD>(arg0, 6, b"SDD", b"sdfsd", b"sdfsd sdfsd sdfsd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifcyt2vkt2565dbpgtrarfclgk44ohfs3nqlb7c6a2g6dsoq4ause")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SDD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

