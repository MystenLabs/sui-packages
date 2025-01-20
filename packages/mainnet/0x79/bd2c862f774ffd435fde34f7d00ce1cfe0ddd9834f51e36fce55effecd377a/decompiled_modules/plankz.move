module 0x79bd2c862f774ffd435fde34f7d00ce1cfe0ddd9834f51e36fce55effecd377a::plankz {
    struct PLANKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLANKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLANKZ>(arg0, 6, b"PLANKZ", b"PLANKZ ON SUI", b"just the main character", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_16_18_50_05_22322c5cdb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLANKZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLANKZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

