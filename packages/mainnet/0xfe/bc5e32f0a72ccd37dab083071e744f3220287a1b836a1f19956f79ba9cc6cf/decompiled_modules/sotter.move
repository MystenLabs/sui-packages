module 0xfebc5e32f0a72ccd37dab083071e744f3220287a1b836a1f19956f79ba9cc6cf::sotter {
    struct SOTTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOTTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOTTER>(arg0, 6, b"SOTTER", b"Sui Otter", x"546865206d6173636f74206f662053756920636861696e2e200a0a24736f7474657220686173206e6f206465762e2049742069732074686520636f6d6d756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sotter_2f80cd51c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOTTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOTTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

