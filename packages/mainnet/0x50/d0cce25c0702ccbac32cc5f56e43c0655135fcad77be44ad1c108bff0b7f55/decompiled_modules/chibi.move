module 0x50d0cce25c0702ccbac32cc5f56e43c0655135fcad77be44ad1c108bff0b7f55::chibi {
    struct CHIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIBI>(arg0, 6, b"CHIBI", b"CheeBee", b"Chibi Chibi Chibi Chibi Chibi Chibi Chibi Chibi Chibi Chibi Chibi Chibi Chibi Chibi Chibi Chibi Chibi Chibi Chibi Chibi Chibi Chibi Chibi Chibi Chibi Chibi Chib", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic6uuv4p3dvkru2cojjkig5qxs54v54vvo3woehj3swggkmj2rieq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHIBI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

