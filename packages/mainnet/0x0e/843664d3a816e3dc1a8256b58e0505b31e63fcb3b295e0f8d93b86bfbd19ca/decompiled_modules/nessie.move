module 0xe843664d3a816e3dc1a8256b58e0505b31e63fcb3b295e0f8d93b86bfbd19ca::nessie {
    struct NESSIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NESSIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NESSIE>(arg0, 6, b"NESSIE", b"SUI NESSIE", b"The legendary SUIper awesome Lochness monster reveals itself on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_00_28_06_4fc951df4f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NESSIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NESSIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

