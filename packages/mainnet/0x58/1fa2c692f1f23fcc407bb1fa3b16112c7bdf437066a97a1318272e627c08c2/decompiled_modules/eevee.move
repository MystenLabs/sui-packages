module 0x581fa2c692f1f23fcc407bb1fa3b16112c7bdf437066a97a1318272e627c08c2::eevee {
    struct EEVEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEVEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEVEE>(arg0, 6, b"Eevee", b"EEVEE SUI", b"$EEVEE  - Memes evolve . So do we", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicr4iu66hr66cza4qzpq4ntewafjw3nx3xk3cwbuiyws6ma2amm74")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEVEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EEVEE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

