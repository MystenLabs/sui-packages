module 0x778fc15562ff6fdaa2e0f35173cf78336fa7ad3d4b0759b4149ad1e1bd6d3dd7::sn {
    struct SN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SN>(arg0, 6, b"SN", b"Satoshi Nakamoto", b"Everyone's Satoshi Nakamoto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_18_03_22_c2258dffd1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SN>>(v1);
    }

    // decompiled from Move bytecode v6
}

