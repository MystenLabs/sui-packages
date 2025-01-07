module 0x8ef6c7d0a5142d4793a8f02156ef8d80349a4121134b3f42cd4dbf5c6599d52::nyanbrett {
    struct NYANBRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYANBRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYANBRETT>(arg0, 6, b"NYANBRETT", b"NYAN BRETT", b"Adopt an official Nyan Brett on SUI, Don't miss out on this unique opportunity to show your love and join the official fan club today!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_28_03_02_00_50fb46f463.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYANBRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NYANBRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

