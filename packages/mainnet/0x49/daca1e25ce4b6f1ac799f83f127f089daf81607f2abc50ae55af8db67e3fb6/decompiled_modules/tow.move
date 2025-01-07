module 0x49daca1e25ce4b6f1ac799f83f127f089daf81607f2abc50ae55af8db67e3fb6::tow {
    struct TOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TOW>(arg0, 6, b"TOW", b"Row", b"da", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/meme_trung_quoc_hai_ly_co_len_1_eee4ce1984.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOW>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOW>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

