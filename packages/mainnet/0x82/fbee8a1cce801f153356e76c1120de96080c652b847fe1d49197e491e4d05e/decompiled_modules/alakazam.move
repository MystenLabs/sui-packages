module 0x82fbee8a1cce801f153356e76c1120de96080c652b847fe1d49197e491e4d05e::alakazam {
    struct ALAKAZAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALAKAZAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALAKAZAM>(arg0, 8, b"ALAKAZAM", b"Alakazam", b"He has an unusual intellectual capacity that allows him to remember everything that has happened from the moment of his birth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.wikia.nocookie.net/ficcion-sin-limites/images/9/95/Alakazam.jpg/revision/latest?cb=20190331001138&path-prefix=es")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ALAKAZAM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALAKAZAM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALAKAZAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

