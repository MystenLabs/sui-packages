module 0xddbe067b3e8a229011dba430388d823fc33fecaff779b9cdc21c9eb255448de5::sbradz {
    struct SBRADZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBRADZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBRADZ>(arg0, 6, b"SBRADZ", b"SUI BRADZ", b"Bradz the king frog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250105_WA_0031_028a2f7208.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBRADZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBRADZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

