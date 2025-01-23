module 0xe7519af9abe0b9121b9c239851ea39a561b51762b7f4c2dc8a57bcf08e8b7e36::seag {
    struct SEAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAG>(arg0, 6, b"SEAG", b"Seal Agent", b"The Artic Seal Agent, only available on turbos! Ready to meme the sky?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737655663083.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEAG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

