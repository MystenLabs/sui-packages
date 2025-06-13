module 0xacfe95b0fa32da05777f31f30fb405d8774d80c2911b0328cad70bf51d92b079::taxguy {
    struct TAXGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAXGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAXGUY>(arg0, 6, b"TAXGUY", b"tax guy", b"HE GONNA TAX YOUR ASS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibrx5vav3gkpuiovmp3ohnbgaau32yve7z3xl6yv5iqpe7i2vicbu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAXGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TAXGUY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

