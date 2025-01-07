module 0x7b34fe44728fc28bb6d7bc59cbf0e8faa7a3bc7fd465a76398df7bb6fa5ab8c5::blerbb {
    struct BLERBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLERBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLERBB>(arg0, 6, b"BLERBB", b"BLERB", b"BLERB ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_23_24_00_b1303c0fdb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLERBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLERBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

