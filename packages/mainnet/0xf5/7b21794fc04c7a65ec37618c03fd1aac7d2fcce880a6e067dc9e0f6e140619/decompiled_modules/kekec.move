module 0xf57b21794fc04c7a65ec37618c03fd1aac7d2fcce880a6e067dc9e0f6e140619::kekec {
    struct KEKEC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKEC>(arg0, 6, b"KEKEC", b"BLKN DWRF", b"MY H RKJ B WH Y.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gwaf_5000549132.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKEC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEKEC>>(v1);
    }

    // decompiled from Move bytecode v6
}

