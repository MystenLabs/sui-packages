module 0x27a2ffa098a68cfb53d468f287e80895bb692b0b1d66f43efa5b8a062d39ddd::blast {
    struct BLAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAST>(arg0, 6, b"Blast", b"Blastoise", b"Blast is more than just an adorable mascot it is a culture coin that is a symbol of innovation in the crypto space. Blast is a signal. A shell shocked, shade wearing surge toward a new frontier.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicwxnqak5zevreus6ghd6hpn4ikybhcjn72lqtbxeeygl4syttsmu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLAST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

