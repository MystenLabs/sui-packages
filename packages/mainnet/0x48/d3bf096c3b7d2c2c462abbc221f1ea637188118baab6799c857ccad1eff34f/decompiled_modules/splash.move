module 0x48d3bf096c3b7d2c2c462abbc221f1ea637188118baab6799c857ccad1eff34f::splash {
    struct SPLASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLASH>(arg0, 6, b"SPLASH", b"Splash", b"The cutest dog to make a SPLASH on SUI and on you <3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Splash_Dog_da6e2fb837.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPLASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

