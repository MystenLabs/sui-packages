module 0x391deed95250a8623eba9f2a772bf03c7cc77f967f3b41b98058391b30913199::mama {
    struct MAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAMA>(arg0, 6, b"MaMa", b"Blessings to everyon", b"I want to bring blessings to everyone. \"MaMa\" is the first meaningful word I say, please wait for the next one to come.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731579983482.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

