module 0xc3b9a9e15c2dab34537026912e8fcdfaf8c9f97d9b0c009677bd0373e91eb63c::chillguy {
    struct CHILLGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHILLGUY>(arg0, 6, b"CHILLGUY", b"chillguy", b"just a chillguy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000130768_bac1996501.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHILLGUY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLGUY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

