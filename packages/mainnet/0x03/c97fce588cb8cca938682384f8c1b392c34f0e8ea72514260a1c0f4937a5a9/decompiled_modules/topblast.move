module 0x3c97fce588cb8cca938682384f8c1b392c34f0e8ea72514260a1c0f4937a5a9::topblast {
    struct TOPBLAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOPBLAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOPBLAST>(arg0, 6, b"TopBlast", b"Top Blast", b"blasted the fuckin top who wit me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4356_551597c834.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOPBLAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOPBLAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

