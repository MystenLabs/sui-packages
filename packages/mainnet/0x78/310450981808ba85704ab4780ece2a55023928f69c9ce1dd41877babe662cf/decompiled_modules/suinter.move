module 0x78310450981808ba85704ab4780ece2a55023928f69c9ce1dd41877babe662cf::suinter {
    struct SUINTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINTER>(arg0, 6, b"SUINTER", b"Suinter Arc", b"Lock in.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735388818003.com")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINTER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINTER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

