module 0x2531675061c8f07589220582240bcb08ae98518e5ff007fd71cf9b1715c85075::stitch {
    struct STITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: STITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STITCH>(arg0, 6, b"STITCH", b"Lieutenant Stitchie", b"Lieutenant Stitchie the Jamaican  Kat ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/st_5cb5651194.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STITCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STITCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

