module 0x6795ed565bf24761d6c1c6951f4ee42941c23bfe258792216403ec8851e0cd98::nessie {
    struct NESSIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NESSIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NESSIE>(arg0, 6, b"NESSIE", b"Nessie", b" The legendary SUIper awesome Lochness monster reveals itself on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_22_30_07_13deda5a79.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NESSIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NESSIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

