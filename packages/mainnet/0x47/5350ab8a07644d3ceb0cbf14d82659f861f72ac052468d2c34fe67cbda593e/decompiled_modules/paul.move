module 0x475350ab8a07644d3ceb0cbf14d82659f861f72ac052468d2c34fe67cbda593e::paul {
    struct PAUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAUL>(arg0, 9, b"CAT", b"Cat", b"11111", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"222.jpg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PAUL>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

