module 0xb96836547e41067ffd1e52bcf1e46270534b771131df103d6a5bd3ef388a2ba2::strm {
    struct STRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRM>(arg0, 6, b"STRM", b"Stormui", b"SUI has everything to win. It's a good boy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/stormy_47321459b8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

