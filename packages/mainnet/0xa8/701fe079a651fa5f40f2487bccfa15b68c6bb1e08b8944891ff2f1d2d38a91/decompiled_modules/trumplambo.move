module 0xa8701fe079a651fa5f40f2487bccfa15b68c6bb1e08b8944891ff2f1d2d38a91::trumplambo {
    struct TRUMPLAMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPLAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPLAMBO>(arg0, 6, b"TRUMPLAMBO", b"Trump Lambo", b"TRUMP LAMBO IS THE BEST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731425166960.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPLAMBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPLAMBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

