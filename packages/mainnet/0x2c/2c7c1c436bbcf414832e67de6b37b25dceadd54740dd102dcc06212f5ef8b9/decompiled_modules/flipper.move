module 0x2c2c7c1c436bbcf414832e67de6b37b25dceadd54740dd102dcc06212f5ef8b9::flipper {
    struct FLIPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIPPER>(arg0, 6, b"Flipper", b"Flipper Zero", b"Flipper (FLIP) is the ultimate meme token for tech enthusiasts and hacking aficionados inspired by the beloved Flipper Zero device! Built on Sui, FLIP unites a community of cyber rebels, gadget lovers, and meme fanatics who live for the thrill of ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731196224218.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLIPPER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIPPER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

