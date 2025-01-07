module 0x764bc886149c610c5be669fd18c6ee39f0333f6894ec26f383d9911e5c628a60::suibtc {
    struct SUIBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBTC>(arg0, 6, b"SuiBTC", b"SBTC", b"SBTC will rule the MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bitcoin_svg_9d4c19179f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

