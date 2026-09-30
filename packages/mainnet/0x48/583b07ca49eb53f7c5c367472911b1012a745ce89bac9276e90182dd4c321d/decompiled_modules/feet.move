module 0x48583b07ca49eb53f7c5c367472911b1012a745ce89bac9276e90182dd4c321d::feet {
    struct FEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEET>(arg0, 9, b"FEET", b"FeeTest", b"fee claim test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FEET>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEET>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

