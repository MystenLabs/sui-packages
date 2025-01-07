module 0x66953724b08207b914ee341e890ddcf5a5e83b63eb33bbeb4aff3860db8d7225::teztdrve {
    struct TEZTDRVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEZTDRVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEZTDRVE>(arg0, 9, b"TEZTDRVE", b"TESTDRYVE", b".......", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEZTDRVE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEZTDRVE>>(v2, @0xb43f1a838123ce75344461d91f48695af7d7ca91bc6da65090760e88683a066b);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEZTDRVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

