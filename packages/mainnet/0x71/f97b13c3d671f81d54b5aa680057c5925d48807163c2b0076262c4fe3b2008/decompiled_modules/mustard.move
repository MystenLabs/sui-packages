module 0x71f97b13c3d671f81d54b5aa680057c5925d48807163c2b0076262c4fe3b2008::mustard {
    struct MUSTARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSTARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSTARD>(arg0, 6, b"MUSTARD", b"MUSTAAAAARD", b"https://www.complex.com/music/a/backwoodsaltar/kendrick-lamar-mustard-tv-off-memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732424618501.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSTARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSTARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

