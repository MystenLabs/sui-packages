module 0x5737d43c4589360a824617dea348e798cbe08e000ca2c7716b58ef2775fbbe88::apsc {
    struct APSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: APSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APSC>(arg0, 9, b"apsc", b"apsc", b"fdv", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<APSC>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APSC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

