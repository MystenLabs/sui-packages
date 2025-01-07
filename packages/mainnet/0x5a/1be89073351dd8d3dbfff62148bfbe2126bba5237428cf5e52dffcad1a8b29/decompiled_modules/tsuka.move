module 0x5a1be89073351dd8d3dbfff62148bfbe2126bba5237428cf5e52dffcad1a8b29::tsuka {
    struct TSUKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUKA>(arg0, 6, b"TSUKA", b"DejitaruTsuka", b"DejitaruTsuka Coming Into Sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/koin_naga_min_4dbc2d61db.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSUKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

