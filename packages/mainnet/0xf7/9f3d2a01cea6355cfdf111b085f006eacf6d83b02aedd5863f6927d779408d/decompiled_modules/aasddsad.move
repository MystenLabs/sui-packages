module 0xf79f3d2a01cea6355cfdf111b085f006eacf6d83b02aedd5863f6927d779408d::aasddsad {
    struct AASDDSAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AASDDSAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AASDDSAD>(arg0, 6, b"aasddsad", b"sssssd", b"asdsadsadsa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JBGKQ13Y6FNVNTP0JMBHCN76/01JBGQY7AEYBJ7V7ASWE4BNR8B")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AASDDSAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AASDDSAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

