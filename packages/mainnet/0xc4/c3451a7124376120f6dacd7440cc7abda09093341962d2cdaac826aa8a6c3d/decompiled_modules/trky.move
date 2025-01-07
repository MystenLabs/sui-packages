module 0xc4c3451a7124376120f6dacd7440cc7abda09093341962d2cdaac826aa8a6c3d::trky {
    struct TRKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRKY>(arg0, 6, b"TRKY", b"BOZKURT", b"Aaaaaauuuuuuuuuuuuuu.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1194_86659035a3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

