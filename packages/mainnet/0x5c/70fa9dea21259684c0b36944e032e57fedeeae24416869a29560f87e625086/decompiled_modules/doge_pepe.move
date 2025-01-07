module 0x5c70fa9dea21259684c0b36944e032e57fedeeae24416869a29560f87e625086::doge_pepe {
    struct DOGE_PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE_PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE_PEPE>(arg0, 6, b"DOGE_PEPE", b"DOGE AND PEPE", b"Born from inspiration of DOGE and PEPE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733925901277.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE_PEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE_PEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

