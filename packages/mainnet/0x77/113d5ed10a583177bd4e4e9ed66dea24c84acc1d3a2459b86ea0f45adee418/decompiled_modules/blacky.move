module 0x77113d5ed10a583177bd4e4e9ed66dea24c84acc1d3a2459b86ea0f45adee418::blacky {
    struct BLACKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKY>(arg0, 6, b"BLACKY", b"The Blacky Cat", b"BLACKY is the first black cat that has a combination of strength and agility will become the strongest memecoin on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibfrrjkqdu64gdftebpvdhjdhpjrecqbcjvco3fmluk4ckhyldlp4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLACKY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

