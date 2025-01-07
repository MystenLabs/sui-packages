module 0x10ebfd33e28f2d6e8d3f8e2000b90e82ca43ee775f56feb87f125636630d1b8d::sntr {
    struct SNTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNTR>(arg0, 6, b"SNTR", b"Suinator", b"Every ape strives for domination to be the best!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2147483648_213482_035a7079d7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

