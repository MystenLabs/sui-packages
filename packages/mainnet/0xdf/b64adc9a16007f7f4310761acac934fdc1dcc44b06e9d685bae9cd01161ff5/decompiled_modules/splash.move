module 0xdfb64adc9a16007f7f4310761acac934fdc1dcc44b06e9d685bae9cd01161ff5::splash {
    struct SPLASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLASH>(arg0, 9, b"SPLASH", b"Splash", b"The first fair launch platform on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1923408120094588928/_FSg1WEs_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPLASH>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLASH>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPLASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

