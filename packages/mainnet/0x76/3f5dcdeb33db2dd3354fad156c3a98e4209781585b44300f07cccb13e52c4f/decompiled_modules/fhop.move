module 0x763f5dcdeb33db2dd3354fad156c3a98e4209781585b44300f07cccb13e52c4f::fhop {
    struct FHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FHOP>(arg0, 6, b"FHOP", b"FakHop", b"You gave us a bad time, hopfun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730984217202.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FHOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FHOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

