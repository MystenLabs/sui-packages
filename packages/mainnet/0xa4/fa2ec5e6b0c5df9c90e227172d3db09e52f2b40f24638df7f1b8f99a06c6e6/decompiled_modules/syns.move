module 0xa4fa2ec5e6b0c5df9c90e227172d3db09e52f2b40f24638df7f1b8f99a06c6e6::syns {
    struct SYNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYNS>(arg0, 6, b"SYNS", b"Suiyans", b"Were over 9000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiyan_74361b620f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

