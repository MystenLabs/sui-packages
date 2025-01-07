module 0x1dabbfe5f4520e77c1316e07cca9175e17d698686ecc03ce23c74af286b92cc::boxo {
    struct BOXO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOXO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOXO>(arg0, 6, b"BOXO", b"Baby Sumatran Tiger", b"Meet two-week old, Boxo, the newest Sumatran tiger cub at animal kingdom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/532e3872c15ef540fbeb8fb8107e745e_c0c5d4c1aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOXO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOXO>>(v1);
    }

    // decompiled from Move bytecode v6
}

