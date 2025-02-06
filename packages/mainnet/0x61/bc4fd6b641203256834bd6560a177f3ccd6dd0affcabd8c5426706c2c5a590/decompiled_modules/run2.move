module 0x61bc4fd6b641203256834bd6560a177f3ccd6dd0affcabd8c5426706c2c5a590::run2 {
    struct RUN2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUN2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUN2>(arg0, 9, b"run2", b"run2", b"run2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"run2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RUN2>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUN2>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RUN2>>(v2);
    }

    // decompiled from Move bytecode v6
}

