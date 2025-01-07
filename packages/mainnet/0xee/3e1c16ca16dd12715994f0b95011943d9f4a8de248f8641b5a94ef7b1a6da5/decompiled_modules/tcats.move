module 0xee3e1c16ca16dd12715994f0b95011943d9f4a8de248f8641b5a94ef7b1a6da5::tcats {
    struct TCATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCATS>(arg0, 6, b"TCATS", b"TURBOCAT", b"This cat not rugger. Only special one. Trust this cat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949850881.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TCATS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCATS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

