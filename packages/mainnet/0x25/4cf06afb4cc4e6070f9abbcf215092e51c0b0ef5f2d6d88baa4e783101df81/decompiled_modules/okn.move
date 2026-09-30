module 0x254cf06afb4cc4e6070f9abbcf215092e51c0b0ef5f2d6d88baa4e783101df81::okn {
    struct OKN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OKN>(arg0, 9, b"okn", b"moon", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OKN>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKN>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

