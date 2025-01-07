module 0x16c52ec791b90448d32d207cd21bef9965d83abf54e283c6755e8bf981b497c6::goku {
    struct GOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOKU>(arg0, 6, b"GOKU", b"Goku Meme Sui", b"$GOKU embodies the thrill and adventure of Goku, bringing an anime-fueled experience to SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731094099460.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOKU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOKU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

