module 0x9dc1fbf5ecc0c11a4ee43ffe4b803e3dd94d4cf72c41fb01bbc20587224045ae::gloog {
    struct GLOOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOOG>(arg0, 6, b"GLOOG", b"Gloog Cat", b"Gloog is the name of Elisabeth's beloved cat, and now she is looking for a partner because she is lonely in every sleep, will you accompany her?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042470_af662cba06.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLOOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

