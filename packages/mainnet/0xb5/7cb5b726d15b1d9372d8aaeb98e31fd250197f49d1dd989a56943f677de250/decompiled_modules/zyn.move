module 0xb57cb5b726d15b1d9372d8aaeb98e31fd250197f49d1dd989a56943f677de250::zyn {
    struct ZYN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZYN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZYN>(arg0, 6, b"ZYN", b"ZYNN", b"ZYNNERGY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732305290515.01")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZYN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZYN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

