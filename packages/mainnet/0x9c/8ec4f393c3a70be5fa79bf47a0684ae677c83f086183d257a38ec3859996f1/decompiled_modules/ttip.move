module 0x9c8ec4f393c3a70be5fa79bf47a0684ae677c83f086183d257a38ec3859996f1::ttip {
    struct TTIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTIP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TTIP>(arg0, 6, b"TTIP", b"TTips", b"TTIPS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_4679_min_7e6c7c006e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TTIP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTIP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

