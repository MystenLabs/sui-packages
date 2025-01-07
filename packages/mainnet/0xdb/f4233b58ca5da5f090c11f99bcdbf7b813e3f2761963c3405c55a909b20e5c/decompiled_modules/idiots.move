module 0xdbf4233b58ca5da5f090c11f99bcdbf7b813e3f2761963c3405c55a909b20e5c::idiots {
    struct IDIOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDIOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDIOTS>(arg0, 6, b"Idiots", b"Idiot Brothers", b"X: @idiotbrthrs ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/adasfasf_74d46b4568.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDIOTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IDIOTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

