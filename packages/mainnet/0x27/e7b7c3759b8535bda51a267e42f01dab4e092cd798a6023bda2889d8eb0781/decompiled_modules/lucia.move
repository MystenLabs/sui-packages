module 0x27e7b7c3759b8535bda51a267e42f01dab4e092cd798a6023bda2889d8eb0781::lucia {
    struct LUCIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LUCIA>(arg0, 6, b"LUCIA", b"Lucia", b"Lucia is featured as one of the more skilled competitors in the game, excelling in various events, from archery to wakeboarding. Her character is known for being a balanced athlete with no major weaknesses, making her a well-rounded opponent or partner for players.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/2018_01_13_286_29_1_bc2a800b1a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LUCIA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCIA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

