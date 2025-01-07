module 0x900bb82b0f482e8579404e311cf9fe6005b06577cd9ac8d0826da42ec8558189::dog {
    struct DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG>(arg0, 6, b"DOG", b"DOGONDOG", b"DOGONDOGDOGONDOGDOGONDOGDOGONDOGDOGONDOGDOGONDOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f6ce849ec7c867191d5a9b27ec3ab651_c9cb8f0dcf.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

