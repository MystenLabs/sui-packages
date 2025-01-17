module 0xaa880c5e993f6378dacb273d8c75e4c2534e16373f317afebea953547e7dcf19::heliosgram {
    struct HELIOSGRAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELIOSGRAM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HELIOSGRAM>(arg0, 6, b"HELIOSGRAM", b"Heliosgram by SuiAI", x"546865206e6578742d67656e2074726164696e6720626f74206275696c74206f6e2053756920f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Cf_S_Ya_Zjv_400x400_0abba1174b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HELIOSGRAM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELIOSGRAM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

