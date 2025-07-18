module 0x74a86120c74dd9f1fe2a33a87461bd701ffd53e87dfdc0abf09bc3fc1cb197cb::suiacc {
    struct SUIACC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIACC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIACC>(arg0, 6, b"SUIACC", b"SuiAccelator", b"Just attract the community don't buy it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_3214_0fc48c49c2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIACC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIACC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

