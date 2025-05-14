module 0xbbb9309f111105ba5963c5fb8533034d9a39499acca61e1a4358e46311851429::eewee {
    struct EEWEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEWEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEWEE>(arg0, 6, b"EEWEE", b"TER EWE OLEH EEVEE KONTOLS", b"DO NOT APE PROJECT IF DAN SHILLING THAT PROJECT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihbotmtond62nwnhiu43ji6gkm3uuvf3awptobeohsliq32rwt2ty")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEWEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EEWEE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

