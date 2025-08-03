module 0xe5a605feb1bbb3ffe8f44ae84b2a36971039ebda70454cedca82add3cbfc2615::gotchi {
    struct GOTCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOTCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOTCHI>(arg0, 6, b"Gotchi", b"SleepGotchi", b"Sleep. Earn Rewards.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie352k6dkg37timwxsfhazih7bm4phxbr3aotkud4ozlgwwrn7jjy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOTCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GOTCHI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

