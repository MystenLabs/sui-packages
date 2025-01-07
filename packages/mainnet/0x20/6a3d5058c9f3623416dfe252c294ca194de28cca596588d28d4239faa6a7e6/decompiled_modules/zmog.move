module 0x206a3d5058c9f3623416dfe252c294ca194de28cca596588d28d4239faa6a7e6::zmog {
    struct ZMOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZMOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZMOG>(arg0, 6, b"ZMOG", b"Zmog By Matt Furie", b"Zmog is a meme and an 80s vibe smoker from the ZOGZ collection made by Matt Furie in May 2023 and mentioned as well as tweeted by the main Matt Furie's X account in May 2023.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731035013530.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZMOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZMOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

