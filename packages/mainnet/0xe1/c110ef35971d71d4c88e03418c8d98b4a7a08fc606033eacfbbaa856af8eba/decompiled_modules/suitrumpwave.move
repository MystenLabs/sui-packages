module 0xe1c110ef35971d71d4c88e03418c8d98b4a7a08fc606033eacfbbaa856af8eba::suitrumpwave {
    struct SUITRUMPWAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITRUMPWAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITRUMPWAVE>(arg0, 6, b"SUITRUMPWAVE", b"SUI TRUMP WAVE", b"Surf the SUI wave blockchain with SUITRUMPWAVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000478165_8b5eaed826_b3b5e99e1c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITRUMPWAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITRUMPWAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

