module 0x55b1aa9568c1c90a89ad1dd5c8de958efef6e356ff77ef7422bed24da68f5625::suika {
    struct SUIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKA>(arg0, 6, b"SUIKA", b"SUIKA BLYAT", b"BLYAAAAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIKA_98defbcaa1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

