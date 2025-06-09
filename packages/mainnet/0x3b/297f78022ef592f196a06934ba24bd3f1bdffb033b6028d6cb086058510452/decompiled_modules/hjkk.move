module 0x3b297f78022ef592f196a06934ba24bd3f1bdffb033b6028d6cb086058510452::hjkk {
    struct HJKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HJKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HJKK>(arg0, 6, b"HJKK", b"hiksd", b"ewrererere", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeielw2733keksizbh6mf7mjs3k33ljxfchv73nushbfxjrqbdje7iu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HJKK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HJKK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

