module 0x57a3a07e93f169252ba1f64861e101051ae0dac456c0c7acbd7ac305cee5f1be::usdtz_mmxx04w9r3jd {
    struct USDTZ_MMXX04W9R3JD has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDTZ_MMXX04W9R3JD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDTZ_MMXX04W9R3JD>(arg0, 9, b"USDTZ", b"USDT.z", b"USDT.z", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmaMuBJhXLDDcbfZK8jSyZEKhuyzg144NxTFq4CBNKzxWW")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDTZ_MMXX04W9R3JD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDTZ_MMXX04W9R3JD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

