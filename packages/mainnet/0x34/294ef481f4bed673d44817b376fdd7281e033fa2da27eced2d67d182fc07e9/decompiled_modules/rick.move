module 0x34294ef481f4bed673d44817b376fdd7281e033fa2da27eced2d67d182fc07e9::rick {
    struct RICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RICK>(arg0, 6, b"RICK", b"rickroll", b"This is rick", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/rick_4147f9bc16.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RICK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

