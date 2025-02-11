module 0xfa145ae7478bc4ffb1990de57339c61681fa54d37c2c8517de59470ecb2e80d3::bcd {
    struct BCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BCD>(arg0, 6, b"BCD", b"BCD by SuiAI", b"BCD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/download_3b99e846fe.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BCD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

