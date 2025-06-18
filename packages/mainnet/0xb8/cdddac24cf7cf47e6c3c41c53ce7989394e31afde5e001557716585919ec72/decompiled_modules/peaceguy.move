module 0xb8cdddac24cf7cf47e6c3c41c53ce7989394e31afde5e001557716585919ec72::peaceguy {
    struct PEACEGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEACEGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEACEGUY>(arg0, 6, b"PEACEGUY", b"Just A Peace Guy", b"A chill white bear with a relaxed expression, wearing a hoodie and a water drop necklace holding a peaceful dove.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibftestcaejxltpa6uykjt7zeb72scdvfj3gmsjdi37p7ziagvkha")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEACEGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEACEGUY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

