module 0x65c8eb3a3c66c665e5d9ee5b505241b4d926cb35003ebce21f983b83cad53f8d::colorfull {
    struct COLORFULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: COLORFULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COLORFULL>(arg0, 9, b"colorfull", b"colorfull", b"colorfulll", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COLORFULL>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COLORFULL>>(v2, @0xaf8656b47d00df1c2a6ba551c0898419efcb627d5ed9c4b1ed0ab5163cbb940f);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COLORFULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

