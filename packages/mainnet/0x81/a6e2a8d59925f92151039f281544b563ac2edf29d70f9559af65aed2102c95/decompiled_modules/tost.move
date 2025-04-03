module 0x81a6e2a8d59925f92151039f281544b563ac2edf29d70f9559af65aed2102c95::tost {
    struct TOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOST>(arg0, 6, b"TOST", b"tost", b"SDASD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e62de698746dfcb09d2d64f85371eed1_2d3de537ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOST>>(v1);
    }

    // decompiled from Move bytecode v6
}

