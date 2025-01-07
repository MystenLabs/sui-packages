module 0xe65cb758a95733a263f679e66b19275b4de7844f3cb66cefe9c5f741b61717::suiler {
    struct SUILER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILER>(arg0, 6, b"SUILER", b"suiler", b"I'AM $suiler ,A small child who is not spoiled, and wants to achieve success together sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000051840_66dfc7d729.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILER>>(v1);
    }

    // decompiled from Move bytecode v6
}

