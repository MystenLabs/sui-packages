module 0x322c8858d09706a07715e0bc6ba2b8fdc1676ad1e9ef339b5897c3c04993d6af::nine1elon {
    struct NINE1ELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: NINE1ELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NINE1ELON>(arg0, 6, b"Nine1elon", b"9/1elon", b"https://x.com/elonmusk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731884486571.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NINE1ELON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NINE1ELON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

