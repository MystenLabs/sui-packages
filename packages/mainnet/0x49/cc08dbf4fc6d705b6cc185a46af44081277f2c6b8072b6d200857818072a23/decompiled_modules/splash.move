module 0x49cc08dbf4fc6d705b6cc185a46af44081277f2c6b8072b6d200857818072a23::splash {
    struct SPLASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLASH>(arg0, 6, b"SPLASH", b"Splash", b"Lets splash eachother!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/splash_2767904a6c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPLASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

