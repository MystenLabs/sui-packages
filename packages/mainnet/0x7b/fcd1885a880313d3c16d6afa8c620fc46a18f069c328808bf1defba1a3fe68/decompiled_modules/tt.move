module 0x7bfcd1885a880313d3c16d6afa8c620fc46a18f069c328808bf1defba1a3fe68::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TT>(arg0, 6, b"TT", b"TEST", b"ATATAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750639895522.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

