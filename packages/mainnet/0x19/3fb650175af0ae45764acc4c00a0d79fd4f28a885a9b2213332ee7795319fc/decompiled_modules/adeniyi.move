module 0x193fb650175af0ae45764acc4c00a0d79fd4f28a885a9b2213332ee7795319fc::adeniyi {
    struct ADENIYI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADENIYI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADENIYI>(arg0, 6, b"ADENIYI", b"sui dev", b"fan+fun token of man we trust", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738586300537.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADENIYI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADENIYI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

