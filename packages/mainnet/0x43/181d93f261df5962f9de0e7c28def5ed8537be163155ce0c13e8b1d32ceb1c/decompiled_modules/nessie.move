module 0x43181d93f261df5962f9de0e7c28def5ed8537be163155ce0c13e8b1d32ceb1c::nessie {
    struct NESSIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NESSIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NESSIE>(arg0, 6, b"NESSIE", b"NESSIE on SUI", b"The legendary SUIper awesome Lochness monster reveals itself on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_00_17_36_3af8a99e6d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NESSIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NESSIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

