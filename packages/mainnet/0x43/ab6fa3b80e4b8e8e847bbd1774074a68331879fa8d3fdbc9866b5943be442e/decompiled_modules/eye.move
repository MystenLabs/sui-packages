module 0x43ab6fa3b80e4b8e8e847bbd1774074a68331879fa8d3fdbc9866b5943be442e::eye {
    struct EYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EYE>(arg0, 6, b"EYE", b"SUILLUMINATI", b"IYKYK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8g7_ZXRW_9_400x400_fc5fc99096.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

