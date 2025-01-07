module 0x8341d9f19641360c0ff6e482e8b0747985f3f14d17885d2ba10a7baa9d6a2380::cactus {
    struct CACTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CACTUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CACTUS>(arg0, 6, b"CACTUS", b"CACTUS TOKEN", b"CACTUS is a community token built on the SUI that equally rewards every participant in its deflationary ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/favicon_c5c3e5a58d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CACTUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CACTUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

