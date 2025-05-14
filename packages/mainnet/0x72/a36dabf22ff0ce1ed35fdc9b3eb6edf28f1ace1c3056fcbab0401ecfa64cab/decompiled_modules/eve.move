module 0x72a36dabf22ff0ce1ed35fdc9b3eb6edf28f1ace1c3056fcbab0401ecfa64cab::eve {
    struct EVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVE>(arg0, 6, b"EVE", b"Eevee on Sui", b"$EEVEE- Memes evolve. So do we", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicr4iu66hr66cza4qzpq4ntewafjw3nx3xk3cwbuiyws6ma2amm74")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EVE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

