module 0xbcc959a73ed5e97ab61058289983cbe797584d159cbfc314d60d4bb2365561c7::gds {
    struct GDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDS>(arg0, 6, b"GDS", b"Gaidys", b"Gaidys kakarieku", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734116070994.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GDS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

