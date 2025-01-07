module 0xe7c337904a4c84bc709bd302d121147f19b7af26386b3c3fd34243b8602b4372::suim {
    struct SUIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIM>(arg0, 6, b"SUIM", b"SUIMATIC", b"Lets matic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/unfair_0cb9603251.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

