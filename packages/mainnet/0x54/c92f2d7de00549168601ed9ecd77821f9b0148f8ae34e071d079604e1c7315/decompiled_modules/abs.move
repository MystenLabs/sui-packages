module 0x54c92f2d7de00549168601ed9ecd77821f9b0148f8ae34e071d079604e1c7315::abs {
    struct ABS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ABS>(arg0, 6, b"ABS", b"Auto Bots SUI by SuiAI", b"The Autobots are a group of protagonist robots in the Transformers series. They come from the planet Cybertron. Their main enemies are the Decepticons. Both Autobots and Decepticons are human-shaped robots that can transform into other objects such as cars, airplanes, animals, and also cassettes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_3862_f0d44222ce.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ABS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

