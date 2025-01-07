module 0xe5dd9d76af2a171562e75ba54fc85eb4c8226cf2023787dea419feb119123ef::splash {
    struct SPLASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLASH>(arg0, 6, b"Splash", b"SplashCat", b"SplashCat is the cutest Cat in Crypto, ready to explode on the Sui Network. Just a beautiful cat  Rocking the SUI Chain having fun, Surrounded by friends and poised to create a community that will last", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/splashcatred_a4ddda0bda.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPLASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

