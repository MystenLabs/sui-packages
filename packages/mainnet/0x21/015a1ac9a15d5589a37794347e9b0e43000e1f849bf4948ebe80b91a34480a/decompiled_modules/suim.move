module 0x21015a1ac9a15d5589a37794347e9b0e43000e1f849bf4948ebe80b91a34480a::suim {
    struct SUIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIM>(arg0, 6, b"SUIM", b"SUIMAMA", b"Suimama", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730999201717.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

