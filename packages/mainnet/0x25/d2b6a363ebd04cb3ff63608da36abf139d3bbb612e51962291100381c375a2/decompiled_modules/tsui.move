module 0x25d2b6a363ebd04cb3ff63608da36abf139d3bbb612e51962291100381c375a2::tsui {
    struct TSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUI>(arg0, 6, b"TSUI", b"SUIMINATOR", b"This is the sign.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1788516636572.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

