module 0x45809d80b06f4b4ed1d1ed7b3ae64230a883423ccaaed45e956dd9ee385e6197::phase3 {
    struct PHASE3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHASE3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHASE3>(arg0, 6, b"PHASE3", b"Phase3", b"movepump is inevitable ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_02_18_14_38_6f7c33f071.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHASE3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHASE3>>(v1);
    }

    // decompiled from Move bytecode v6
}

