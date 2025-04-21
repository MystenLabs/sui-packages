module 0xec9c0b8b2bc17a1ed486f792e2f99875652d058a5e47c85cbd1faabfe6bb4dc3::SKIBIDI {
    struct SKIBIDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKIBIDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKIBIDI>(arg0, 6, b"SKIBIDI", b"skibidi toilet", b"your so skibidi, your so fanum tax, i just wanna be your sigma", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/Qmc2nbn1JUdMjUsRAMMU8rU36BD5q3GmqkzWv5eEr1VvfL")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKIBIDI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKIBIDI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

