module 0x67c7651b2c92f1bde025fc60dd4c8d8df29c5b30f15c0f1e6593ceb879f2e311::degenz {
    struct DEGENZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGENZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGENZ>(arg0, 6, b"DEGENZ", b"Degenzilla", b"$DEGENZ is the Godzilla of rugs. Comes loud, leaves louder.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigj3nlzldbrunuqpwo5w3pkdaspbg3boh65cr2hfruhmwqvmtnmdq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGENZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEGENZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

