module 0xe52ecdee40705cefb70cbb2a88068a013825e7a0aec7e9976a2f3c611cf3f391::neinei {
    struct NEINEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEINEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEINEI>(arg0, 6, b"NeiNei", b"neinei", b"I love neinei", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731158316350.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEINEI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEINEI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

