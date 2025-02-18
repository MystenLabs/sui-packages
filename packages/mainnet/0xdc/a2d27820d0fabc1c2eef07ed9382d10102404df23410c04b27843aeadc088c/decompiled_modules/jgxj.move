module 0xdca2d27820d0fabc1c2eef07ed9382d10102404df23410c04b27843aeadc088c::jgxj {
    struct JGXJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: JGXJ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<JGXJ>(arg0, 6, b"JGXJ", b"Vnxnf by SuiAI", b"Fkfxg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000019902_aeed8205e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JGXJ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JGXJ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

