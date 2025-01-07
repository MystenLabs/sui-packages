module 0x79ad6e1589e59d4a96a7d446c87c93bbc2e7bb3645e0a98d075e420213e4849e::penglyn {
    struct PENGLYN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGLYN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGLYN>(arg0, 6, b"PENGLYN", b"Penglyn", b"The cutest coin now on crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/penglyn_b642af3bdc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGLYN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGLYN>>(v1);
    }

    // decompiled from Move bytecode v6
}

