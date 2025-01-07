module 0x3bf8dea683e4fb5cac01a133a499ae5993b9fdc1551657e955846484859fe645::splash {
    struct SPLASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLASH>(arg0, 6, b"Splash", b"SplashCat", b"SplashCat is the cutest Cat in Crypto, ready to explode on the Sui Network. Just a beautiful cat Rocking the SUI Chain having fun, Surrounded by friends and poised to create a community that will last", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732423783440.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPLASH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLASH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

